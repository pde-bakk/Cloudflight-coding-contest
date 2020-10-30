# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    level2.rb                                          :+:    :+:             #
#                                                      +:+                     #
#    By: peerdb <peerdb@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/10/30 15:07:55 by peerdb        #+#    #+#                  #
#    Updated: 2020/10/30 17:12:43 by peerdb        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

file = File.open("level2_input/level2_5.in")

file_data = file.readlines.map(&:chomp)
minutesNb = file_data[0]
tasksNb = file_data[file_data[0].to_i + 1]
# STDERR.puts "amount of minutes: #{minutesNb}, amount of task: #{tasksNb} "
minutes = file_data.slice(1, file_data[0].to_i)
tasksarray = file_data[file_data[0].to_i + 2...]
tasks = []
tasksarray.each { |i| tasks.push(i.split(' ')) }
tasks.each { |i| i.push(0); i.push(9999999999999) }
# puts tasks[0]

# STDERR.puts "minutes.length = #{minutes.length} "

minutes.each_with_index do |el, i|
	for t in tasks do
		total = 0
		amount = t[1].to_i
		a = i
		if (minutes.length - a >= t[1].to_i)
			
			while (amount > 0)
				total += minutes[a].to_i
				a += 1
				amount -= 1
			end
			if (total < t[3])
				t[3] = total
				t[2] = i
			end
		end
	end
end

File.open("level2_input/level2_5.out", "w") do |f|
	f.write("#{tasksNb}\n")
	for t in tasks do 
		f.write("#{t[0]} #{t[2]}\n")
	end
end
	
puts ""
for t in tasks do 
	STDERR.puts "id: #{t[0]}, duration: #{t[1]}, start at: #{t[2]}, energy cost: #{t[3]} "
end


file.close
