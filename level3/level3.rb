# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    level3.rb                                          :+:    :+:             #
#                                                      +:+                     #
#    By: peerdb <peerdb@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/10/30 15:07:55 by peerdb        #+#    #+#                  #
#    Updated: 2020/10/30 17:43:43 by peerdb        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

file = File.open("level3_input/level3_5.in")

file_data = file.readlines.map(&:chomp)
N = file_data[0].to_i
M = file_data[N + 1]
STDERR.puts "N: #{N}, M: #{M} "
minutes = file_data.slice(1, N)
STDERR.puts minutes
tasksarray = file_data[N + 2...]
# STDERR.puts "tasks: #{tasksarray}"
tasks = []
tasksarray.each { |i| tasks.push(i.split(' ')) }
tasks.each { |i| i.push(0); i.push(99999999999999999) }
puts tasks[0]

for t in tasks do 
	i = t[2].to_i
	while (i <= t[3].to_i)
		if minutes[i].to_i < t[5].to_i
			t[5] = minutes[i]
			t[4] = i
		end
		i += 1
	end
end

# STDERR.puts "minutes.length = #{minutes.length} "


File.open("level3_input/level3_5.out", "w") do |f|
	f.write("#{M}\n")
	for t in tasks do 
		f.write("#{t[0]} #{t[4]} #{t[1]}\n")
	end
end
	
puts ""
for t in tasks do 
	STDERR.puts "id: #{t[0]}, duration: #{t[1]}, start at: #{t[2]}, energy cost: #{t[3]} "
end


file.close
