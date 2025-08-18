-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\luacov\\hook.lua

local hook = {}
local dir_sep = package.config:sub(1, 1)

if not dir_sep:find("[/\\]") then
	dir_sep = "/"
end

function hook.new(runner)
	local ignored_files = {}
	local steps_after_save = 0

	return function(_, line_nr, level)
		level = level or 2

		if not runner.initialized then
			return
		end

		local name = debug.getinfo(level, "S").source
		local data = runner.data
		local file = data[name]

		if not file then
			if ignored_files[name] then
				return
			elseif runner.file_included(name) then
				file = {
					max_hits = 0,
					max = 0
				}
				data[name] = file
			else
				ignored_files[name] = true

				return
			end
		end

		if line_nr > file.max then
			file.max = line_nr
		end

		local hits = (file[line_nr] or 0) + 1

		file[line_nr] = hits

		if hits > file.max_hits then
			file.max_hits = hits
		end

		if runner.tick then
			steps_after_save = steps_after_save + 1

			if steps_after_save == runner.configuration.savestepsize then
				steps_after_save = 0

				if not runner.paused then
					runner.save_stats()
				end
			end
		end
	end
end

return hook
