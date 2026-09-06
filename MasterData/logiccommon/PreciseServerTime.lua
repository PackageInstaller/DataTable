-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/PreciseServerTime.lua

module("logiccommon.common.util.PreciseServerTime", package.seeall)

local PreciseServerTime = {}
local gettime = tolua.gettime
local _serverBaseMs = 0
local _clientBaseMs = 0

local function _nowLocalMs()
	return gettime() * 1000
end

function PreciseServerTime.sync(serverMillis)
	serverMillis = checknumber(serverMillis)

	if serverMillis <= 0 then
		return
	end

	_serverBaseMs = serverMillis
	_clientBaseMs = _nowLocalMs()
end

function PreciseServerTime.nowMs()
	return _serverBaseMs + (_nowLocalMs() - _clientBaseMs)
end

return PreciseServerTime
