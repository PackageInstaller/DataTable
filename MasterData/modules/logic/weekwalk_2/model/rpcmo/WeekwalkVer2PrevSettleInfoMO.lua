-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2PrevSettleInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleInfoMO", package.seeall)

local WeekwalkVer2PrevSettleInfoMO = pureTable("WeekwalkVer2PrevSettleInfoMO")

function WeekwalkVer2PrevSettleInfoMO:init(info)
	self.maxLayerId = info.maxLayerId
	self.maxBattleId = info.maxBattleId
	self.maxBattleIndex = info.maxBattleIndex
	self.show = info.show
	self.layerInfos = GameUtil.rpcInfosToMap(info.layerInfos, WeekwalkVer2PrevSettleLayerInfoMO, "layerIndex")
end

function WeekwalkVer2PrevSettleInfoMO:getLayerPlatinumCupNum(index)
	local layerInfo = self.layerInfos[index]

	return layerInfo and layerInfo.platinumCupNum
end

function WeekwalkVer2PrevSettleInfoMO:getTotalPlatinumCupNum()
	local num = 0

	for _, layerInfo in pairs(self.layerInfos) do
		num = num + layerInfo.platinumCupNum
	end

	return num
end

return WeekwalkVer2PrevSettleInfoMO
