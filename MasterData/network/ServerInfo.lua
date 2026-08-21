-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\ServerInfo.lua

local ServerInfo = {}

function ServerInfo.createWith(data)
	local info = {}

	ServerInfo.fillWith(info, data)

	return info
end

function ServerInfo.fillWith(info, data)
	if not data then
		return
	end

	info.id = data.i
	info.name = data.n
	info.state = data.state or Const.SERVER_STATE_NORMAL

	local url = data.u

	if url then
		local splitted = utils.splitString(url, ":")

		if splitted[2] then
			info.ip = string.sub(splitted[2], 3)
		end

		if splitted[3] then
			info.port = tonumber(splitted[3])
		end
	end

	info.svrMark = data.svrmark or ""
	info.msg = data.msg

	if data.finish then
		info.maintainFinishTime = tonumber(data.finish)
	end

	info.isValid = info.ip ~= nil and info.port ~= nil
end

function ServerInfo.fillName(info, data)
	if not data then
		return
	end

	info.name = data.n
end

return ServerInfo
