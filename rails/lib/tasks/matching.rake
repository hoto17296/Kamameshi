require 'csv'

namespace :matching do

  MAX = 4

  desc '過去チームや部署と被らないようにチームを組む'
  task :run => :environment do
    user_groups = initial_sort Event.recent.first.unassigned.to_a

    # うまくマッチングできなかったチームだけでシャッフルする
    loop do
      teams = match_random(user_groups, MAX)
      ok_teams = []
      ng_teams = []
      100.times do
        ng_teams = []
        teams.each do |team|
          if check_team(team, true)
            ok_teams << team
          else
            ng_teams << team
          end
        end

        # マッチング成功したか、失敗チームが1チームのみだったらループ抜ける
        break if ng_teams.size <= 1

        teams = match_random(ng_teams.flatten.shuffle, MAX)
      end

      # マッチング成功してたら出力
      if ng_teams.size == 0
        print "\n\n"
        print_teams ok_teams
        break
      end

      print '.'
    end
  end

  desc 'CSVを読み込んでマッチングが過去と被ってないかどうかチェックする'
  task :check => :environment do
    CSV.foreach('matched.csv') do |line|
      check_team line.map {|id| UserGroup.find id }
    end
  end

  # マッチングする前にソートする
  # ※ 質問内容に応じてここの処理を変える
  def initial_sort(user_groups)
    user_groups.sort do |a, b|
      b.answers[0] <=> a.answers[0]
    end
  end

  # ランダムにチーム分けする
  def match_random(values, max)
    return values if values.size < max

    # ひとり少ないチームの数
    n = ( max - values.size % max ) % max

    groups = []

    begin_at = 0
    while begin_at < values.size do
      end_at = begin_at + max - 1
      end_at -= 1 if begin_at < n * ( max - 1 )
      groups << values[begin_at..end_at]
      begin_at = end_at + 1
    end

    groups
  end

  # 指定したチームメンバーが
  # ・ 部署が被ってないか
  # ・ 過去のマッチングメンバーと被ってないか
  # をチェックする
  def check_team(team, silent=false)
    puts 'check: ' + ( team.map {|ug| ug.user.name } ).to_s unless silent

    flag = true
    team.combination(2) do |u1, u2|
      if same_team?(u1.user, u2.user)
        puts Rainbow('[SameTeam!] ').red + "#{u1.user.name} and #{u2.user.name}" unless silent
        flag = false
      elsif duplicate?(u1.user, u2.user)
        puts Rainbow('[Duplicate!] ').red + "#{u1.user.name} and #{u2.user.name}" unless silent
        flag = false
      end
    end

    puts Rainbow('OK!').green if flag and not silent
    puts "\n" unless silent

    flag
  end

  # 過去のマッチングと被っているかどうか
  def duplicate?(user1, user2)
    group_ids = [user1, user2].map do |user|
      group_ids = user.user_groups.map {|ug| ug.group_id }
      group_ids.compact
    end
    group_ids.flatten!
    group_ids.size != group_ids.uniq.size
  end

  # 部署が被っているかどうか
  def same_team?(user1, user2)
    user1.post_id == user2.post_id
  end

  # チーム情報を 標準出力 と CSV に出力する
  def print_teams(teams)
    CSV.open("team.csv", "wb", encoding: "SJIS") do |csv|
      header = ['ugid', '名前', '部署', '質問']
      puts header.join("\t")
      csv << header
      teams.each do |team|
        puts '-' * 16
        csv << []
        team.each do |ug|
          row = [ug.id, ug.user.name, ug.user.post, ug.answers[0]]
          puts row.join("\t")
          csv << row
        end
      end
    end
  end

end
