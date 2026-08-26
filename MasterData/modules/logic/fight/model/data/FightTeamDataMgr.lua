-- chunkname: @modules/logic/fight/model/data/FightTeamDataMgr.lua

module("modules.logic.fight.model.data.FightTeamDataMgr", package.seeall)

local FightTeamDataMgr = FightDataClass("FightTeamDataMgr", FightDataMgrBase)

function FightTeamDataMgr:onConstructor()
	self.myData = {}
	self.enemyData = {}
	self[FightEnum.TeamType.MySide] = self.myData
	self[FightEnum.TeamType.EnemySide] = self.enemyData
	self.myCardHeatOffset = {}
end

function FightTeamDataMgr:clearClientSimulationData()
	self.myCardHeatOffset = {}
end

function FightTeamDataMgr:onCancelOperation()
	self:clearClientSimulationData()
end

function FightTeamDataMgr:onStageChanged(curStage, preStage)
	self:clearClientSimulationData()

	if curStage == FightStageMgr.StageType.Play and self.deviceArea then
		self.deviceArea:resetStopAttr()
	end
end

function FightTeamDataMgr:updateData(fightData)
	self:refreshTeamDataByProto(fightData.attacker, self.myData)
	self:refreshTeamDataByProto(fightData.defender, self.enemyData)
end

function FightTeamDataMgr:refreshTeamDataByProto(teamData, sideData)
	sideData.cardHeat = FightDataUtil.coverData(teamData.cardHeat, sideData.cardHeat)

	if teamData.bloodPool then
		sideData.bloodPool = FightDataUtil.coverData(teamData.bloodPool, sideData.bloodPool)
	end

	if teamData.heatScale then
		sideData.heatScale = FightDataUtil.coverData(teamData.heatScale, sideData.heatScale)
	end

	if teamData.rouge2MusicInfo then
		sideData.rouge2MusicInfo = FightDataUtil.coverData(teamData.rouge2MusicInfo, sideData.rouge2MusicInfo)
	end

	sideData.itemSkillInfos = FightDataUtil.coverData(teamData.itemSkillInfos, sideData.itemSkillInfos)
	sideData.deviceArea = FightDataUtil.coverData(teamData.deviceArea, sideData.deviceArea)
end

function FightTeamDataMgr:checkBloodPoolExist(side)
	local sideData = self[side]

	if sideData.bloodPool then
		return
	end

	sideData.bloodPool = FightDataBloodPool.New()
end

function FightTeamDataMgr:checkHeatScaleExist(side)
	local sideData = self[side]

	if sideData.heatScale then
		return
	end

	sideData.heatScale = FightDataHeatScale.New()
end

function FightTeamDataMgr:getRouge2MusicInfo(side)
	local sideData = self[side]

	if not sideData then
		return
	end

	return sideData.rouge2MusicInfo
end

function FightTeamDataMgr:getAssistBossInfo()
	return
end

function FightTeamDataMgr:setDeviceArea(deviceArea, side)
	side = side or FightEnum.TeamType.MySide

	local sideData = self[side]

	if not sideData then
		return
	end

	sideData.deviceArea = FightDataUtil.coverData(deviceArea, sideData.deviceArea)
end

return FightTeamDataMgr
