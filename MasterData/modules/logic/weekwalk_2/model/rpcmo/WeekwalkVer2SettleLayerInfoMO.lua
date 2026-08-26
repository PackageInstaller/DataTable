-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2SettleLayerInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleLayerInfoMO", package.seeall)

local WeekwalkVer2SettleLayerInfoMO = pureTable("WeekwalkVer2SettleLayerInfoMO")

function WeekwalkVer2SettleLayerInfoMO:init(info)
	self.layerId = info.layerId
	self.battleInfos = GameUtil.rpcInfosToMap(info.battleInfos, WeekwalkVer2SettleBattleInfoMO, "battleId")
	self.config = lua_weekwalk_ver2.configDict[self.layerId]
	self.sceneConfig = lua_weekwalk_ver2_scene.configDict[self.config.sceneId]
end

return WeekwalkVer2SettleLayerInfoMO
