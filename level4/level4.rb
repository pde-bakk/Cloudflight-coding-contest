# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    level4.rb                                          :+:    :+:             #
#                                                      +:+                     #
#    By: peerdb <peerdb@student.codam.nl>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/10/30 15:07:55 by peerdb        #+#    #+#                  #
#    Updated: 2020/10/30 21:03:48 by peerdb        ########   odam.nl          #
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
mins = file_data.slice(1, N)
minutes = []
mins.each {|n| minutes.push([n, 5]) }
tasksarray = file_data[N + 2...]
tasks = []
tasksarray.each do |i|
	a = i.split(' ')
	tasks.push(Task.new(a[0], a[1], a[2], a[3]))
end
totalenergy = 0

for t in tasks do
	subarr = minutes[t.begin...t.end]
	while (t.getpower > 0)
		min = subarr.each_with_index.min
		subarr.delete(min[0])
		i = min[1]
		next if minutes[i][1] == 0
		usage = [ maxPower, t.getpower ].min
		usage = [ usage, minutes[i][1] ].min
		minutes[i][1] -= usage
		t.addpower(-usage)
		totalenergy += (usage * min[0][0].to_i)
		t.newminute(min[1].to_i + t.begin, usage)
	end
		
end

File.open("input/level4_1.out", "w") do |f|
	f.write("#{M}\n")
	for t in tasks do 
		f.write("#{t.gettaskId}")
		for m in t.getminutes do 
			f.write(" #{m[0]} #{m[1]}")
		end
		f.write("\n")
		# f.write("#{t.gettaskId} minuteId #{-1} (repeat)\n")
	end
end

STDERR.puts "total electricity bill: #{totalenergy} "


file.close
