-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\luacov\\runner.lua

local runner = {}

runner.version = "0.15.0"

local stats = require("Debug/Modules/luacov.stats")
local util = require("Debug/Modules/luacov.util")

runner.defaults = require("Debug/Modules/luacov.defaults")

local debug = require("debug")
local raw_os_exit = os.exit
local new_anchor = newproxy or function()
	return {}
end

local function on_exit_wrap(fn)
	local anchor = new_anchor()

	debug.setmetatable(anchor, {
		__gc = fn
	})

	return anchor
end

runner.data = {}
runner.paused = true
runner.initialized = false
runner.tick = false

local function match_any(patterns, str, on_empty)
	if not patterns or not patterns[1] then
		return on_empty
	end

	for _, pattern in ipairs(patterns) do
		if string.match(str, pattern) then
			return true
		end
	end

	return false
end

function runner.file_included(filename)
	filename = string.gsub(filename, "\\", "/")
	filename = string.gsub(filename, "%.lua$", "")

	return match_any(runner.configuration.include, filename, true) and not match_any(runner.configuration.exclude, filename, false)
end

function runner.update_stats(old_stats, extra_stats)
	old_stats.max = math.max(old_stats.max, extra_stats.max)
	extra_stats.max = nil
	extra_stats.max_hits = nil

	for line_nr, run_nr in pairs(extra_stats) do
		old_stats[line_nr] = (old_stats[line_nr] or 0) + run_nr
		old_stats.max_hits = math.max(old_stats.max_hits, old_stats[line_nr])
	end
end

function runner.save_stats()
	local loaded = stats.load(runner.configuration.statsfile) or {}

	for name, file_data in pairs(runner.data) do
		if string.find(name, "./Assets/Code/.LuaCode/") == nil then
			name = "./Assets/Code/.LuaCode/" .. name
		end

		if string.find(name, ".lua") == nil then
			name = name .. ".lua"
		end

		if loaded[name] then
			runner.update_stats(loaded[name], file_data)
		else
			loaded[name] = file_data
		end
	end

	stats.save(runner.configuration.statsfile, loaded)

	runner.data = {}
end

function runner.merge_stats(path1)
	local path2 = runner.configuration.statsfile
	local ori_data = stats.load(path1) or {}
	local loaded = stats.load(path2) or {}

	for name, file_data in pairs(ori_data) do
		if string.find(name, "./Assets/Code/.LuaCode/") == nil then
			name = "./Assets/Code/.LuaCode/" .. name
		end

		if string.find(name, ".lua") == nil then
			name = name .. ".lua"
		end

		if loaded[name] then
			runner.update_stats(loaded[name], file_data)
		else
			loaded[name] = file_data
		end
	end

	stats.save(path2, loaded)
end

local cluacov_ok = pcall(require, "cluacov.version")

runner.debug_hook = require(cluacov_ok and "Debug/Modules/cluacov.hook" or "Debug/Modules/luacov.hook").new(runner)

function runner.run_report(configuration)
	configuration = runner.load_config(configuration)

	local reporter = "Debug/Modules/luacov.reporter"

	if configuration.reporter then
		reporter = reporter .. "." .. configuration.reporter
	end

	require(reporter).report()
end

local on_exit_run_once = false

local function on_exit()
	if on_exit_run_once then
		return
	end

	on_exit_run_once = true

	runner.save_stats()

	if runner.configuration.runreport then
		runner.configuration.isshutdown = true

		runner.run_report(runner.configuration)
	end
end

local function on_output()
	runner.save_stats()

	if runner.configuration.runreport then
		runner.configuration.isshutdown = false

		runner.run_report(runner.configuration)
	end
end

local function on_gen_report(isshutdown)
	if runner.configuration.runreport then
		runner.configuration.isshutdown = isshutdown

		runner.run_report(runner.configuration)
	end
end

local function on_merge(path1)
	runner.merge_stats(path1)

	if runner.configuration.runreport then
		runner.configuration.isshutdown = false

		runner.run_report(runner.configuration)
	end
end

local function on_reset()
	os.remove(runner.configuration.statsfile)
	os.remove(runner.configuration.reportfile)
end

local dir_sep = package.config:sub(1, 1)
local wildcard_expansion = "[^/]+"

if not dir_sep:find("[/\\]") then
	dir_sep = "/"
end

local function escape_module_punctuation(ch)
	if ch == "." then
		return "/"
	elseif ch == "*" then
		return wildcard_expansion
	else
		return "%" .. ch
	end
end

local function reversed_module_name_parts(name)
	local parts = {}

	for part in name:gmatch("[^%.]+") do
		table.insert(parts, 1, part)
	end

	return parts
end

local function compare_names(name1, name2)
	local parts1 = reversed_module_name_parts(name1)
	local parts2 = reversed_module_name_parts(name2)

	for i = 1, math.max(#parts1, #parts2) do
		if not parts1[i] then
			return false
		end

		if not parts2[i] then
			return true
		end

		local is_literal1 = not parts1[i]:find("%*")
		local is_literal2 = not parts2[i]:find("%*")

		if is_literal1 ~= is_literal2 then
			return is_literal1
		end
	end

	return name1 < name2
end

local function acknowledge_modules()
	runner.modules = {
		patterns = {},
		filenames = {}
	}

	if not runner.configuration.modules then
		return
	end

	if not runner.configuration.include then
		runner.configuration.include = {}
	end

	local names = {}

	for name in pairs(runner.configuration.modules) do
		table.insert(names, name)
	end

	table.sort(names, compare_names)

	for _, name in ipairs(names) do
		local pattern = name:gsub("%p", escape_module_punctuation) .. "$"
		local filename = runner.configuration.modules[name]:gsub("[/\\]", dir_sep)

		table.insert(runner.modules.patterns, pattern)
		table.insert(runner.configuration.include, pattern)
		table.insert(runner.modules.filenames, filename)

		if filename:match("init%.lua$") then
			pattern = pattern:gsub("$$", "/init$")

			table.insert(runner.modules.patterns, pattern)
			table.insert(runner.configuration.include, pattern)
			table.insert(runner.modules.filenames, filename)
		end
	end
end

function runner.real_name(filename)
	local orig_filename = filename

	filename = filename:gsub("\\", "/"):gsub("%.lua$", "")

	for i, pattern in ipairs(runner.modules.patterns) do
		local match = filename:match(pattern)

		if match then
			local new_filename = runner.modules.filenames[i]

			if pattern:find(wildcard_expansion, 1, true) then
				if not new_filename:match("/$") then
					new_filename = new_filename .. "/"
				end

				new_filename = new_filename .. match .. ".lua"
			end

			return (new_filename:gsub("^%.[/\\]", ""):gsub("[/\\]", dir_sep))
		end
	end

	return orig_filename
end

local luacov_excludes = {
	"Debug/Modules/luacov$",
	"Debug/Modules/luacov/hook$",
	"Debug/Modules/luacov/reporter$",
	"Debug/Modules/luacov/reporter/default$",
	"Debug/Modules/luacov/defaults$",
	"Debug/Modules/luacov/runner$",
	"Debug/Modules/luacov/stats$",
	"Debug/Modules/luacov/tick$",
	"Debug/Modules/luacov/util$",
	"Debug/Modules/cluacov/version$"
}

local function is_absolute(path)
	if path:sub(1, 1) == dir_sep or path:sub(1, 1) == "/" then
		return true
	end

	if dir_sep == "\\" and path:find("^%a:") then
		return true
	end

	return false
end

local function get_cur_dir()
	local pwd_cmd = dir_sep == "\\" and "cd 2>nul" or "pwd 2>/dev/null"
	local handler = io.popen(pwd_cmd, "r")
	local cur_dir = handler:read()

	handler:close()

	cur_dir = cur_dir:gsub("\r?\n$", "")

	if cur_dir:sub(-1) ~= dir_sep and cur_dir:sub(-1) ~= "/" then
		cur_dir = cur_dir .. dir_sep
	end

	return cur_dir
end

local function set_config(configuration)
	runner.configuration = {}

	for option, default_value in pairs(runner.defaults) do
		runner.configuration[option] = default_value
	end

	for option, value in pairs(configuration) do
		runner.configuration[option] = value
	end

	local cur_dir

	for _, option in ipairs({
		"statsfile",
		"reportfile"
	}) do
		local path = runner.configuration[option]

		if not is_absolute(path) then
			cur_dir = cur_dir or get_cur_dir()
			runner.configuration[option] = cur_dir .. path
		end
	end

	acknowledge_modules()

	for _, patt in ipairs(luacov_excludes) do
		table.insert(runner.configuration.exclude, patt)
	end

	runner.tick = runner.tick or runner.configuration.tick
end

local function load_config_file(name, is_default)
	local conf = setmetatable({}, {
		__index = _G
	})
	local ok, ret, error_msg = util.load_config(name, conf)

	if ok then
		if type(ret) == "table" then
			for key, value in pairs(ret) do
				if conf[key] == nil then
					conf[key] = value
				end
			end
		end

		return conf
	end

	local error_type = ret

	if error_type == "read" and is_default then
		return nil
	end

	io.stderr:write(("Error: couldn't %s config file %s: %s\n"):format(error_type, name, error_msg))
	raw_os_exit(1)
end

local default_config_file = ".luacov"

function runner.load_config(configuration)
	if not runner.configuration then
		if not configuration then
			set_config(load_config_file(default_config_file, true) or runner.defaults)
		elseif type(configuration) == "string" then
			set_config(load_config_file(configuration))
		elseif type(configuration) == "table" then
			set_config(configuration)
		else
			error("Expected filename, config table or nil. Got " .. type(configuration))
		end
	end

	return runner.configuration
end

function runner.pause()
	runner.paused = true
end

function runner.resume()
	runner.paused = false
end

local hook_per_thread

local function has_hook_per_thread()
	if hook_per_thread == nil then
		local old_hook, old_mask, old_count = debug.gethook()

		local function noop()
			return
		end

		debug.sethook(noop, "l")

		local thread_hook = coroutine.wrap(function()
			return debug.gethook()
		end)()

		hook_per_thread = thread_hook ~= noop

		debug.sethook(old_hook, old_mask, old_count)
	end

	return hook_per_thread
end

function runner.with_luacov(f)
	return function(...)
		if has_hook_per_thread() then
			debug.sethook(runner.debug_hook, "l")
		end

		return f(...)
	end
end

function runner.init(configuration)
	runner.configuration = runner.load_config(configuration)

	function os.exit(...)
		on_exit()
		raw_os_exit(...)
	end

	debug.sethook(runner.debug_hook, "l")

	if has_hook_per_thread() then
		local rawcoroutinecreate = coroutine.create

		function coroutine.create(...)
			local co = rawcoroutinecreate(...)

			debug.sethook(co, runner.debug_hook, "l")

			return co
		end

		local function safeassert(ok, ...)
			if ok then
				return ...
			else
				error(..., 0)
			end
		end

		function coroutine.wrap(...)
			local co = rawcoroutinecreate(...)

			debug.sethook(co, runner.debug_hook, "l")

			return function(...)
				return safeassert(coroutine.resume(co, ...))
			end
		end
	end

	if not runner.tick then
		runner.on_exit_trick = on_exit_wrap(on_exit)
	end

	runner.initialized = true
	runner.paused = false
end

function runner.shutdown()
	on_exit()
end

function runner.output()
	on_output()
end

function runner.gen_report(isshutdown)
	on_gen_report(isshutdown)
end

function runner.merge(path1)
	on_merge(path1)
end

function runner.reset(configuration)
	runner.configuration = runner.load_config(configuration)

	on_reset()
end

local function getsourcefile(func)
	assert(type(func) == "function")

	local d = debug.getinfo(func).source

	if d and d:sub(1, 1) == "@" then
		return d:sub(2)
	end
end

local function findfunction(t, searched)
	if searched[t] then
		return
	end

	searched[t] = true

	for _, v in pairs(t) do
		if type(v) == "function" then
			return v
		elseif type(v) == "table" then
			local func = findfunction(v, searched)

			if func then
				return func
			end
		end
	end
end

local function getfilename(name)
	if type(name) == "function" then
		local sourcefile = getsourcefile(name)

		if not sourcefile then
			error("Could not infer source filename")
		end

		return sourcefile
	elseif type(name) == "table" then
		local func = findfunction(name, {})

		if not func then
			error("Could not find a function within " .. tostring(name))
		end

		return getfilename(func)
	else
		if type(name) ~= "string" then
			error("Bad argument: " .. tostring(name))
		end

		if util.file_exists(name) then
			return name
		end

		local success, result = pcall(require, name)

		if not success then
			error("Module/file '" .. name .. "' was not found")
		end

		if type(result) ~= "table" and type(result) ~= "function" then
			error("Module '" .. name .. "' did not return a result to lookup its file name")
		end

		return getfilename(result)
	end
end

local function escapefilename(name)
	return name:gsub("%.lua$", ""):gsub("[%%%^%$%.%(%)%[%]%+%*%-%?]", "%%%0"):gsub("\\", "/")
end

local function addfiletolist(name, list)
	local f = "^" .. escapefilename(getfilename(name)) .. "$"

	table.insert(list, f)

	return f
end

local function addtreetolist(name, level, list)
	local f = escapefilename(getfilename(name))

	f = (level or f:match("/init$")) and f:match("^(.*)/") or f

	local t = "^" .. f .. "/"

	f = "^" .. f .. "$"

	table.insert(list, f)
	table.insert(list, t)

	return f, t
end

local function checkresult(ok, ...)
	if ok then
		return ...
	else
		return nil, ...
	end
end

function runner.excludefile(name)
	return checkresult(pcall(addfiletolist, name, runner.configuration.exclude))
end

function runner.includefile(name)
	return checkresult(pcall(addfiletolist, name, runner.configuration.include))
end

function runner.excludetree(name, level)
	return checkresult(pcall(addtreetolist, name, level, runner.configuration.exclude))
end

function runner.includetree(name, level)
	return checkresult(pcall(addtreetolist, name, level, runner.configuration.include))
end

return setmetatable(runner, {
	__call = function(_, configfile)
		runner.init(configfile)
	end
})
