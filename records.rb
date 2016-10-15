#!/usr/bin/env ruby -w

	offset = 0
	record = nil
	records = {}

	puts "/* generated on #{Time.now.ctime} */"
	puts ""

	ARGF.each_line {|x|

		x.chomp!
		x.gsub!(/(;.*)$/,'')
		x = x.rstrip
		next if x.empty?

		if record.nil?
			record = $1 if /^(\w+\d*)\s+begin_struct$/.match x
			next
		end

		case x
		when /^\s+end_struct$/
			puts ""
			records[record] = offset
			record = nil
			offset = 0

		when /^(\w+\d*)?\s+ds\s+(\w+\d*)$/i
			# bleh ds timerec
			puts "#define #{record}_#{$1} #{offset}" if $1
			raise "unknown record #{$2}" unless records.include? $2
			offset += records[$2]
		
		when /^(\w+\d*)?\s+ds\.b\s+(\d+)$/i
			puts "#define #{record}_#{$1} #{offset}" if $1
			offset += $2.to_i

		when /^(\w+\d*)?\s+ds\.w\s+(\d+)$/i
			puts "#define #{record}_#{$1} #{offset}" if $1
			offset += $2.to_i * 2

		when /^(\w+\d*)?\s+ds\.l\s+(\d+)$/i
			puts "#define #{record}_#{$1} #{offset}" if $1
			offset += $2.to_i * 4

		else

			raise "bad line #{x}"

		end

	}

	exit 0
