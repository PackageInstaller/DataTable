-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ServerBattle\\ServerBattleReplay.lua

local ServerBattleReplay = {}

function ServerBattleReplay.RunHotfix(hotfix)
	local f = loadstring(hotfix)

	if f then
		f()

		return true
	else
		return false
	end
end

function ServerBattleReplay._realReplayStart(data)
	local ImmediateServerBattle = require("ServerBattle/ImmediateServerBattle")

	return ImmediateServerBattle:startServerBattle(data.start_data, data.client_operate)
end

function ServerBattleReplay._onReplayResult(data)
	local ImmediateServerBattle = require("ServerBattle/ImmediateServerBattle")

	return ImmediateServerBattle:startServerBattleByResult(data.start_data, data.client_operate)
end

return ServerBattleReplay
