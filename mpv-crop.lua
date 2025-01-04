-- Original by KNNeo
-- Usage: "Ctrl+[" to set start frame, "Ctrl+]" to set end frame, "Ctrl+C" to create.

start_time = -1
end_time = -1

function crop_video()
	-- get values
	local start_time_l = start_time
	local end_time_l = end_time
	if start_time_l == -1 or end_time_l == -1 or start_time_l >= end_time_l then
		mp.osd_message("Invalid start/end time.")
		return
	end
	-- crop video
	mp.osd_message("Extracting...")
	local video_path = mp.get_property("path")
	local video_dir_path = video_path:gsub("(.*)/.*$","%1")
	local kdialogcommand = string.format("kdialog --getsavefilename %q '*.*' | tr -d '\n'", video_dir_path)
	local handle = io.popen(kdialogcommand)
	local output_path = handle:read("*a")
	handle:close()    
	-- runn ffmpeg command
	args = string.format(
	'ffmpeg -i "%s" -ss %s -to %s -c copy -progress pipe:1 -nostats "%s"',
	video_path, start_time_l, end_time_l, output_path
	)
	local handle = io.popen(args, "r")
	if not handle then
		print("Failed to start ffmpeg process")
		return
	end
	-- monitor progress
	for line in handle:lines() do
		-- Extract key progress information from each line
		if line:match("^frame=") or line:match("^out_time=") then
			mp.osd_message(line:gsub("out_time=","Extracting..."))
		end
	end
	-- display complete
	mp.osd_message("Done. ")
end

function set_video_start()
	start_time = mp.get_property_number("time-pos", -1)
	mp.osd_message("Video start: " .. start_time)
end

function set_video_end()
	end_time = mp.get_property_number("time-pos", -1)
	mp.osd_message("Video end: " .. end_time)
end

mp.add_key_binding("Ctrl+[", "set_video_start", set_video_start)
mp.add_key_binding("Ctrl+]", "set_video_end", set_video_end)
mp.add_key_binding("Ctrl+c", "crop_video", crop_video)
