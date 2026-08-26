-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2SettleBattleInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleBattleInfoMO", package.seeall)

local WeekwalkVer2SettleBattleInfoMO = pureTable("WeekwalkVer2SettleBattleInfoMO")

function WeekwalkVer2SettleBattleInfoMO:init(info)
	self.battleId = info.battleId
	self.cupInfos = GameUtil.rpcInfosToMap(info.cupInfos or {}, WeekwalkVer2CupInfoMO, "index")
end

return WeekwalkVer2SettleBattleInfoMO
