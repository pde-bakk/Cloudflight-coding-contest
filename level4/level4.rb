# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    level4.rb                                          :+:    :+:             #
#                                                      +:+                     #
#    By: peerdb <peerdb@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/10/30 15:07:55 by peerdb        #+#    #+#                  #
#    Updated: 2020/10/30 18:56:47 by peerdb        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

class Task
	def initialize(taskId, power, startInterval, endInterval)
		@taskId = taskId.to_i
		@power = power.to_i
		@startInterval = startInterval.to_i
		@endInterval = endInterval.to_i
		@minutes = []
	end
	def getminutes
		return @minutes
	end
	def gettaskId
		return @taskId
	end
	def print
		STDERR.puts "task #{@taskId}, power: #{@power}, btween: #{@startInterval} & #{@endInterval} "
	end
	def getpower
		return @power
	end
	def addpower(a)
		@power += a
	end
	def newminute(min, usage)
		@minutes.push( [min, usage] )
	end
	def begin
		return @startInterval
	end
	def end
		return @endInterval
	end
end

file = File.open("input/level4_1.in")

file_data = file.readlines.map(&:chomp)
maxPower = file_data[0].to_i
file_data.shift
maxElectricityBill = file_data[0].to_i
file_data.shift
N = file_data[0].to_i
M = file_data[N + 1]
STDERR.puts "maxPower = #{maxPower}, maxElectricityBill: #{maxElectricityBill}, N: #{N}, M: #{M} "
mins = file_data.slice(1, N)
minutes = []
mins.each {|n| minutes.push([n, 5]) }
# STDERR.puts minutes
tasksarray = file_data[N + 2...]
# STDERR.puts "tasks: #{tasksarray}"
tasks = []
tasksarray.each do |i|
	a = i.split(' ')
	tasks.push(Task.new(a[0], a[1], a[2], a[3]))
end
# tasks[0].print
# print tasks
# tasks.each do |i|
# 	i.print
# end
totalenergy = 0

for t in tasks do
	subarr = minutes[t.begin...t.end]
	while (t.getpower > 0)
		# t.print
		# STDERR.puts "subarr: #{subarr}"
		min = subarr.each_with_index.min
		subarr.delete(min[0])
		i = min[1]
		# STDERR.puts "min: #{min}, i = #{i} "
		next if minutes[i][1] == 0
		usage = [ maxPower, t.getpower ].min
		usage = [ usage, minutes[i][1] ].min
		# STDERR.puts "usage: #{usage}"
		minutes[i][1] -= usage
		t.addpower(-usage)
		totalenergy += (usage * min[0][0].to_i)
		# STDERR.puts "task #{t.gettaskId} drains #{usage} power at minute #{min[1]} (cost: #{min[0][0]}) "
		t.newminute(min[1], usage)
	end
		
end

# for t in tasks do 
# 	i = t[2].to_i
# 	while (i <= t[3].to_i)
# 		if minutes[i].to_i < t[5].to_i
# 			t[5] = minutes[i]
# 			t[4] = i
# 		end
# 		i += 1
# 	end
# end

# STDERR.puts "minutes.length = #{minutes.length} "


File.open("input/level4_1.out", "w") do |f|
	f.write("#{M}\n")
	for t in tasks do 
		f.write("#{t.gettaskId} ")
		for m in t.getminutes do 
			f.write("#{m[0]} #{m[1]} ")
		end
		f.write("\n")
		# f.write("#{t.gettaskId} minuteId #{-1} (repeat)\n")
	end
end
	
puts ""
# for t in tasks do 
# 	STDERR.puts "id: #{t[0]}, duration: #{t[1]}, start at: #{t[2]}, energy cost: #{t[3]} "
# end

total = 0
STDERR.puts "total electricity bill: #{totalenergy} "


file.close
