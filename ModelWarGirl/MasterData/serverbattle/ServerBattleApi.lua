-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ServerBattle\\ServerBattleApi.lua

require("Common/OfflineApiInit")
require("Network/protobuf")

local ServerBattleReplay = require("ServerBattle/ServerBattleReplay")

local function _initProtobufLib()
	local pbfiles = {
		"roledata.pb"
	}

	for _, pbfile in pairs(pbfiles) do
		local bpfilename = "proto/" .. pbfile
		local pbfhandle = io.open(bpfilename, "rb")
		local buffer = pbfhandle:read("*a")

		pbfhandle:close()
		protobuf.register(buffer)
	end
end

local function _relayReplayStart(ssmsg)
	local t = protobuf.decode("datap.BattleData", ssmsg, string.len(ssmsg))

	return ServerBattleReplay._realReplayStart(t)
end

local function _onReplayResult(ssmsg)
	local t = protobuf.decode("datap.BattleData", ssmsg, string.len(ssmsg))

	return ServerBattleReplay._onReplayResult(t)
end

GLDeclare("initProtobufLib", _initProtobufLib)
GLDeclare("relayReplayStart", _relayReplayStart)
GLDeclare("onReplayResult", _onReplayResult)
jit.off()
jit.flush()
