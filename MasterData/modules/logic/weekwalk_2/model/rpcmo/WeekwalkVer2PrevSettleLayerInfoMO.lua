-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2PrevSettleLayerInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleLayerInfoMO", package.seeall)

local WeekwalkVer2PrevSettleLayerInfoMO = pureTable("WeekwalkVer2PrevSettleLayerInfoMO")

function WeekwalkVer2PrevSettleLayerInfoMO:init(info)
	self.layerId = info.layerId
	self.platinumCupNum = info.platinumCupNum

	local config = lua_weekwalk_ver2.configDict[self.layerId]

	if config then
		self.layerIndex = config.layer or 0
	end
end

return WeekwalkVer2PrevSettleLayerInfoMO
