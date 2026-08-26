-- chunkname: @modules/logic/towercompose/model/TowerComposeBossSettleMo.lua

module("modules.logic.towercompose.model.TowerComposeBossSettleMo", package.seeall)

local TowerComposeBossSettleMo = pureTable("TowerComposeBossSettleMo")

function TowerComposeBossSettleMo:ctor()
	self.planeSettleMap = {}
	self.curScore = 0
	self.newFlag = false
	self.themeId = 1
	self.planeAtkStatsMap = {}
	self.recordData = nil
end

function TowerComposeBossSettleMo:update(info, themeId)
	self.newFlag = info.newFlag
	self.themeId = themeId

	self:_buildPlaneList(info.planes)
	self:buildRecordData(info.record)
end

function TowerComposeBossSettleMo:_buildPlaneList(planes)
	self.planeSettleMap = {}
	self.curScore = 0

	for _, plane in ipairs(planes) do
		local planeData = {}

		planeData.planeId = plane.planeId
		planeData.score = plane.score
		planeData.newFlag = plane.newFlag
		planeData.result = plane.result
		self.curScore = self.curScore + plane.score
		self.planeSettleMap[plane.planeId] = planeData
	end
end

function TowerComposeBossSettleMo:buildRecordData(recordInfo)
	if recordInfo and tonumber(recordInfo.createTime) > 0 then
		self.recordData = {}
		self.recordData.createTime = tonumber(recordInfo.createTime)
		self.recordData.bossMo = TowerComposeBossMo.New({
			themeId = self.themeId
		})

		self.recordData.bossMo:updateComposeBossInfo(recordInfo.boss)
	else
		self.recordData = nil
	end
end

function TowerComposeBossSettleMo:getRecordData()
	return self.recordData
end

function TowerComposeBossSettleMo:setAtkStat(endFightPushInfo)
	local customData = FightDataHelper.getCustomData(FightCustomData.CustomDataType.TowerCompose)

	if customData and self.themeId == customData.themeId then
		local recordData = endFightPushInfo.record

		self.planeAtkStatsMap[customData.planeId] = recordData and recordData.attackStatistics
	end
end

function TowerComposeBossSettleMo:getAtkStat(planeId)
	if self.planeAtkStatsMap and self.planeAtkStatsMap[planeId] then
		return self.planeAtkStatsMap[planeId]
	end
end

function TowerComposeBossSettleMo:cleanPlaneAtkStatsMap()
	self.planeAtkStatsMap = {}
end

function TowerComposeBossSettleMo:getPlaneSettleData(planeId)
	return self.planeSettleMap[planeId]
end

function TowerComposeBossSettleMo:isFirstPlaneSucc()
	return self.planeSettleMap[1] and self.planeSettleMap[1].result == TowerComposeEnum.FightResult.Win
end

return TowerComposeBossSettleMo
