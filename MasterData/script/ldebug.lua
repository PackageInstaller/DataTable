-- chunkname: @/tmp/or_script/lua_compile/ldebug.lua

local csock = require("socket")
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next
local scheduler = cc.Director:getInstance():getScheduler()
local ldebug = {}
local socks_fd, socks_handle
local socks_prompt = "debug>"
local debug_env = {}
local debug_cmd = {}
local im_cmd = {}
local stack_frame_base
local enter_im = false
local in_hook = false
local SOCKET_TICK_TIME = 0.1
local _print = print

setmetatable(debug_env, {
	__index = _G
})

local function short_value(root)
	if type(root) ~= "table" then
		if type(root) == "string" then
			return string.format("'%s'", root)
		end

		return tostring(root)
	end

	local cache = {
		[root] = "."
	}

	local function _dump(t, name, depth)
		local temp = {}

		for k, v in ipairs(t) do
			if type(v) == "table" then
				local new_key = string.format("[%d].%s", k, key)

				tinsert(temp, _dump(v, new_key))
			else
				tinsert(temp, tostring(v))
			end
		end

		for k, v in pairs(t) do
			local key

			if type(k) ~= "number" then
				key = tostring(k)
				k = 0
			else
				key = "[" .. k .. "]"
			end

			if k <= 0 or k > #t then
				if cache[v] then
					tinsert(temp, string.format("%s = @%s", key, cache[v]))
				elseif type(v) == "table" and depth < 3 then
					local new_key = name .. "." .. key

					cache[v] = new_key

					tinsert(temp, string.format("%s = { %s }", key, _dump(v, new_key, depth + 1)))
				else
					if type(v) == "string" then
						v = string.format("'%s'", v)
					end

					tinsert(temp, string.format("%s = %s", key, tostring(v)))
				end
			end
		end

		return tconcat(temp, ", ")
	end

	local v = _dump(root, "", 0)

	if #v > 512 then
		return string.format("{ %s ...}", string.sub(v, 1, 256))
	else
		return string.format("{ %s }", v)
	end
end

local function tostring_r(root)
	if type(root) ~= "table" then
		return tostring(root)
	end

	local cache = {
		[root] = "."
	}

	local function _dump(t, space, name)
		local temp = {}

		for k, v in pairs(t) do
			local key = tostring(k)

			if cache[v] then
				tinsert(temp, "+" .. key .. " {" .. cache[v] .. "}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key

				cache[v] = new_key

				tinsert(temp, "+" .. key .. _dump(v, space .. (next(t, k) and "|" or " ") .. srep(" ", #key), new_key))
			else
				tinsert(temp, "+" .. key .. " [" .. tostring(v) .. "]")
			end
		end

		return tconcat(temp, "\r\n" .. space)
	end

	return _dump(root, "", "")
end

local function reply(r)
	socks_fd:send(tostring_r(r) .. "\r\n")
	socks_fd:send(socks_prompt)
end

function debug_env.print(...)
	for _, v in ipairs({
		...
	}) do
		socks_fd:send(tostring_r(v) .. "\r\n")
	end
end

function debug_cmd.help()
	reply("You can enter any valid lua code or enter command below:\n\thelp : show this help messages\n\tstartlog  : show all log\n\tstoplog : stop show log\n\tstop : stop the program at one of probe and then enter interactive mode.")
end

debug_cmd["?"] = debug_cmd.help

function debug_cmd.stop()
	enter_im = true
end

function debug_cmd.startlog()
	print = debug_env.print
end

function debug_cmd.stoplog()
	print = _print

	socks_fd:send(socks_prompt)
end

function debug_cmd.exit()
	socks_fd:close()
end

function debug_cmd.pwd()
	socks_prompt = lfs.currentdir() .. "$"

	socks_fd:send(lfs.currentdir() .. "\n\r")
	socks_fd:send(socks_prompt)
end

function debug_cmd.cd(path)
	path = path[1]

	if path == "~" then
		path = DOWNLOAD_PATH
	end

	lfs.chdir(path)

	socks_prompt = lfs.currentdir() .. "$"

	socks_fd:send(socks_prompt)
end

function debug_cmd.cat(path)
	path = path[1]

	local file = lfs.currentdir() .. "/" .. path

	file = cc.HelperFunc:getFileData(file)

	if file then
		socks_fd:send(file .. "\n\r")
	end

	socks_fd:send(socks_prompt)
end

function debug_cmd.ls()
	local iter, dir_obj = lfs.dir(lfs.currentdir())

	while true do
		local dir = iter(dir_obj)

		if dir == nil then
			break
		end

		if dir ~= "." and dir ~= ".." then
			socks_fd:send(dir .. "\r\n")
		end
	end

	socks_fd:send(socks_prompt)
end

function debug_cmd.wread(path)
	if #path < 1 then
		socks_fd:send("wread url is nil \r\n")
		socks_fd:send(socks_prompt .. "\r\n")

		return
	end

	local writablePath = cc.FileUtils:getInstance():getWritablePath()
	local datac = cc.FileUtils:getInstance():getStringFromFile(writablePath .. path)

	dsocks_fd:send(datac .. " \r\n")
	socks_fd:send(socks_prompt .. "\r\n")
end

function debug_cmd.wget(path)
	if #path < 2 then
		socks_fd:send("wget url savePath \r\n")
		socks_fd:send(socks_prompt .. "\r\n")

		return
	end

	savePath = path[2]

	local function _mkdir(filePath)
		local fileUtils = cc.FileUtils:getInstance()
		local writablePath = fileUtils:getWritablePath()
		local paths = string.split(filePath, "/")
		local parent = writablePath

		while true do
			local path = table.remove(paths, 1)

			print(path)

			if string.find(path, "%.+") then
				break
			else
				parent = parent .. path .. "/"

				lfs.mkdir(parent)
			end
		end

		return parent
	end

	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = 0

	xhr:open("GET", path[1])

	local function httpResponse()
		print("xhr.status----->>>>>", xhr.status)

		if xhr.status == 200 then
			dump(xhr.response)
			_mkdir(savePath)

			local fileUtils = cc.FileUtils:getInstance()
			local writablePath = fileUtils:getWritablePath()

			io.writefile(writablePath .. savePath, xhr.response, "w+b")
			socks_fd:send("save---file---ok--->>>>>" .. xhr.status .. "\r\n")
			socks_fd:send(socks_prompt .. "\r\n")
		else
			socks_fd:send("erro--->>>>>" .. xhr.status .. "\r\n")
			socks_fd:send(socks_prompt .. "\r\n")
		end
	end

	xhr:registerScriptHandler(httpResponse)
	xhr:send()
end

function readline()
	local receive, receive_status = socks_fd:receive()

	if receive_status ~= "closed" and receive then
		return receive
	end

	return ""
end

local function do_cmd(cmd)
	local cds = string.split(cmd, " ")

	if debug_cmd[cds[1]] then
		cmd = table.remove(cds, 1)

		debug_cmd[cmd](cds)
	elseif string.byte(cmd) == 61 then
		local f, err = load("return " .. string.sub(cmd, 2), "=console", "t", debug_env)

		if not f then
			reply(err)
		else
			local _, r = pcall(f)

			reply(r)
		end
	else
		local f, err = load(cmd, "=console", "t", debug_env)

		if not f then
			reply(err)
		else
			local ok, r = pcall(f)

			if ok then
				socks_fd:send(socks_prompt)
			else
				reply(r)
			end
		end
	end
end

function im_cmd.h()
	reply("s : run step\nn : run next\nr : run until return\nl (level) : show locals at level\np var : print var\nc : continue to next probe\nh : help message\nf : show stack frame\nq : quit interactive mode")
end

im_cmd["?"] = im_cmd.h

function im_cmd.f()
	local index = 1
	local tmp = {}

	while true do
		local info = debug.getinfo(stack_frame_base + index, "Sl")

		if info == nil then
			break
		end

		local source = string.format("[%d] %s:%d", index, info.short_src, info.currentline)

		tinsert(tmp, source)

		index = index + 1
	end

	reply(table.concat(tmp, "\r\n"))
end

function im_cmd.q()
	return true
end

function im_cmd.c()
	enter_im = true

	return true
end

function im_cmd.l(cmd)
	local level = tonumber(cmd[2]) or 1
	local s = stack_frame_base + level
	local info = debug.getinfo(s, "uf")
	local tmp = {}

	for i = 1, info.nparams do
		local name, value = debug.getlocal(s, i)

		tinsert(tmp, string.format("P %s : %s", name, short_value(value)))
	end

	if info.isvararg then
		local index = -1

		while true do
			local name, value = debug.getlocal(s, index)

			if name == nil then
				break
			end

			tinsert(tmp, string.format("P [%d] : %s", -index, short_value(value)))

			index = index - 1
		end
	end

	local index = info.nparams + 1

	while true do
		local name, value = debug.getlocal(s, index)

		if name == nil then
			break
		end

		tinsert(tmp, string.format("L %s : %s", name, short_value(value)))

		index = index + 1
	end

	for i = 1, info.nups do
		local name, value = debug.getupvalue(info.func, i)

		tinsert(tmp, string.format("U %s : %s", name, short_value(value)))
	end

	reply(table.concat(tmp, "\r\n"))
end

local function find_local(s, key)
	local index = 1

	while true do
		local name, value = debug.getlocal(s, index)

		if name == nil then
			break
		end

		if name == key then
			return value
		end

		index = index + 1
	end
end

local function find_upvalue(s, key)
	local info = debug.getinfo(s, "f")
	local index = 1

	while true do
		local name, value = debug.getupvalue(info.func, index)

		if name == nil then
			break
		end

		if name == key then
			return value
		end

		index = index + 1
	end
end

function im_cmd.p(cmd)
	local name = cmd[2]
	local level = tonumber(cmd[3]) or 1

	if name == nil then
		reply("need a var name")

		return
	end

	local base = stack_frame_base + level - 1

	if name == "..." then
		local tmp = {}
		local index = -1
		local s = base + 1

		while true do
			local name, value = debug.getlocal(s, index)

			if name == nil then
				break
			end

			tinsert(tmp, string.format("[%d] : %s", -index, tostring_r(value)))

			index = index - 1
		end

		reply(table.concat(tmp, "\r\n"))

		return
	end

	local v = find_local(base + 2, name)

	if v then
		reply(tostring_r(v))

		return
	end

	v = find_upvalue(base + 2, name)

	if v then
		reply(tostring_r(v))

		return
	end

	reply(tostring_r(_G[name]))
end

local function dispatch_im()
	local cmd = {}

	while true do
		local line = readline()

		if line then
			local i = 1

			for v in string.gmatch(line, "[^ \t]+") do
				cmd[i] = v
				i = i + 1
			end

			for j = i, #cmd do
				cmd[j] = nil
			end

			local c = cmd[1]

			if c == nil then
				socks_fd:send(socks_prompt)
			elseif im_cmd[c] == nil then
				reply("Invalid command, type ? for help")
			else
				local ok, err = pcall(im_cmd[c], cmd)

				if not ok then
					reply("Invalid command : " .. err)
				elseif err then
					break
				end
			end
		else
			csock.yield()
		end
	end
end

function ldebug.probe()
	if enter_im == true then
		debug.sethook()

		enter_im = false

		local info = debug.getinfo(2, "Sl")

		stack_frame_base = 4
		socks_prompt = string.format("%s:%d>", info.short_src, info.currentline)

		socks_fd:send(socks_prompt)

		in_hook = false

		dispatch_im()

		if not enter_im then
			socks_prompt = "debug>"

			reply("The program continue running")
		end
	else
		dump(debug.getinfo(2, "Sl"))

		local line = readline()

		if line then
			do_cmd(line)
		end
	end
end

local stack_depth

local function _hook(mode)
	if stack_depth then
		if mode == "call" or mode == "tail call" then
			stack_depth = stack_depth + 1
		elseif mode == "return" then
			stack_depth = stack_depth - 1
		end

		if stack_depth > 0 then
			return
		end

		stack_depth = nil
	end

	local info = debug.getinfo(2, "Sl")

	stack_frame_base = 4
	socks_prompt = string.format("%s:%d>", info.short_src, info.currentline)

	socks_fd:send(socks_prompt)

	in_hook = true

	dispatch_im()

	if not enter_im then
		debug.sethook()

		enter_im = false
		socks_prompt = "debug>"

		reply("The program continue running")
	end
end

local function debug_hook_step(level)
	debug.sethook(function(mode)
		if mode == "call" then
			level = level + 1
		elseif mode == "return" then
			level = level - 1
		end

		if level == 0 then
			debug.sethook(_hook, "l")
		end
	end, "cr")
end

function im_cmd.s()
	enter_im = "hook"

	if in_hook then
		debug.sethook(_hook, "l")
	else
		debug_hook_step(6)
	end

	return true
end

local function debug_hook_next(level)
	debug.sethook(function(mode)
		if mode == "call" then
			level = level + 1
		elseif mode == "return" then
			level = level - 1
		end

		if level == 0 then
			stack_depth = 0

			debug.sethook(_hook, "lcr")
		end
	end, "cr")
end

function im_cmd.n()
	enter_im = "hook"

	if in_hook then
		debug_hook_next(0)
	else
		debug_hook_next(6)
	end

	return true
end

function im_cmd.r()
	enter_im = "hook"

	if in_hook then
		debug_hook_step(1)
	else
		debug_hook_step(7)
	end

	return true
end

local function __tick()
	local receive, receive_status = socks_fd:receive()

	if receive_status ~= "closed" then
		if receive then
			do_cmd(receive)
		end
	else
		socks_fd:close()
		scheduler:unscheduleScriptEntry(socks_handle)
		print("Client  disconnect!")
	end
end

function ldebug.report()
	if BEFORECHARGE then
		local var_41_0 = BEFORECHARGE
		local var_41_1 = "?"
		local var_41_2 = "bid="
		local var_41_3 = l_sdk:getBundleID() or ""
		local var_41_4 = "&idfa="
		local var_41_5 = cc.Application:getInstance()
		local var_41_6 = var_41_5:getDeviceIDFA()
		local var_41_7 = "&mac="
		local var_41_8 = l_sdk:getMAC()
		local var_41_11
		local var_41_10
		local var_41_9

		if not var_41_5 then
			var_41_8 = ""
			var_41_9 = l_profile.role.getRoleCharacterId() or ""
			var_41_10 = l_profile.role.getName() or ""
			var_41_11 = l_sdk:getIMEI() or ""
		end

		local reporturl = var_41_0 .. var_41_1 .. var_41_2 .. var_41_3 .. var_41_4 .. var_41_6 .. var_41_7 .. var_41_8 .. "&roleid=" .. var_41_9 .. "&rolename=" .. var_41_10 .. "&serverid=" .. l_global.server.serverId .. "&imei=" .. var_41_11

		network.createHTTPRequest(function(event)
			if event.name == "completed" then
				-- block empty
			end
		end, reporturl, "GET"):start()
	end
end

function ldebug.start(host)
	GUIDEOPEN = "0"

	ldebug.report()

	if host then
		if not host.ip then
			local ip = "0.0.0.0"

			if host then
				if not host.port then
					local port = 6789
					local socks_fds = csock.bind(ip, port)

					socks_fds:settimeout(0)
					print("Server Start " .. ip .. ":" .. port)

					local client, waitingConnect, connectHander

					function waitingConnect()
						client = socks_fds:accept()

						if client then
							client:settimeout(0)

							socks_fd = client

							debug_cmd.help()

							socks_handle = scheduler:scheduleScriptFunc(__tick, SOCKET_TICK_TIME, false)
						else
							if connectHander then
								scheduler:unscheduleScriptEntry(connectHander)

								connectHander = nil
							end

							connectHander = scheduler:scheduleScriptFunc(waitingConnect, SOCKET_TICK_TIME, false)
						end
					end

					waitingConnect()
				end
			end
		end
	end
end

function ldebug.chooselogin()
	if CHOOSEOLDUSERSWITCH and CHOOSEOLDUSERSWITCH == "1" then
		device.showAlert(l_lang.getText("ldebug0"), l_lang.getText("ldebug2"), {
			l_lang.getText("LoginModel5")
		})

		local userDefault = cc.UserDefault:getInstance()

		userDefault:setBoolForKey("fluser", true)
		userDefault:flush()
	end
end

return ldebug
