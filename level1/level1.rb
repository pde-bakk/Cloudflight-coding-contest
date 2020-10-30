# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    level1.rb                                          :+:    :+:             #
#                                                      +:+                     #
#    By: peerdb <peerdb@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/10/30 15:07:55 by peerdb        #+#    #+#                  #
#    Updated: 2020/10/30 15:27:27 by peerdb        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

file = File.open("input/level1_4.in")

file_data = file.readlines.map(&:chomp)
file_data.shift
# puts file_data

answer = file_data.each_with_index.min

File.open("level1_4.txt", "w") do |f|     
	f.write(answer[1])   
end
STDERR.puts answer

file_data.sort!
STDERR.puts "first = #{file_data[0]}"

file.close
