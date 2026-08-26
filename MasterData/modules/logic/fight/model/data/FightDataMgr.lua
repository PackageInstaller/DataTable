-- chunkname: @modules/logic/fight/model/data/FightDataMgr.lua

module("modules.logic.fight.model.data.FightDataMgr", package.seeall)

local FightDataMgr = class("FightDataMgr", BaseModel)

function FightDataMgr:registMgr(class)
	local obj = class.New()

	obj.dataMgr = self

	table.insert(self.mgrList, obj)

	return obj
end

function FightDataMgr:initDataMgr()
	self.mgrList = {}

	self:initTrueDataMgr()
	self:initTempDataMgr()
end

function FightDataMgr:initTrueDataMgr()
	self.calMgr = self:registMgr(FightCalculateDataMgr)
	self.roundMgr = self:registMgr(FightRoundDataMgr)
	self.cacheFightMgr = self:registMgr(FightCacheFightDataMgr)
	self.protoCacheMgr = self:registMgr(FightProtoCacheDataMgr)
	self.entityMgr = self:registMgr(FightEntityDataMgr)
	self.entityExMgr = self:registMgr(FightEntityExDataMgr)
	self.handCardMgr = self:registMgr(FightHandCardDataMgr)
	self.fieldMgr = self:registMgr(FightFieldDataMgr)
	self.paTaMgr = self:registMgr(FightPaTaDataMgr)
	self.playCardMgr = self:registMgr(FightPlayCardDataMgr)
	self.ASFDDataMgr = self:registMgr(FightASFDDataMgr)
	self.teamDataMgr = self:registMgr(FightTeamDataMgr)
end

function FightDataMgr:initTempDataMgr()
	self.stageMgr = self:registMgr(FightStageMgr)
	self.stateMgr = self:registMgr(FightStateDataMgr)
	self.lockOperateMgr = self:registMgr(FightLockOperateDataMgr)
	self.counterMgr = self:registMgr(FightCounterDataMgr)
	self.operationDataMgr = self:registMgr(FightOperationDataMgr)
	self.tempMgr = self:registMgr(FightTempDataMgr)
	self.LYDataMgr = self:registMgr(FightLYDataMgr)
	self.bloodPoolDataMgr = self:registMgr(FightBloodPoolDataMgr)
	self.rouge2MusicDataMgr = self:registMgr(FightRouge2MusicDataMgr)
	self.baiFuZhangWheelDataMgr = self:registMgr(Fight3_5BaiFuZhangWheelDataMgr)
	self.meiLeiErExRoundDataMgr = self:registMgr(FightMeiLeiErExRoundDataMgr)
end

function FightDataMgr:cancelOperation()
	for i, mgr in ipairs(self.mgrList) do
		mgr:onCancelOperation()
	end
end

function FightDataMgr:updateFightData(fightData)
	self.calMgr:updateFightData(fightData)
end

function FightDataMgr:getEntityById(entityId)
	return self.entityMgr:getById(entityId)
end

function FightDataMgr:beforePlayRoundData(roundData)
	self.calMgr:beforePlayRoundData(roundData)
end

function FightDataMgr:afterPlayRoundData(roundData)
	self.calMgr:afterPlayRoundData(roundData)
end

function FightDataMgr:dealRoundData(roundData)
	self.calMgr:playStepDataList(roundData.fightStep)
	self.calMgr:playStepDataList(roundData.nextRoundBeginStep)
	self.calMgr:dealExPointInfo(roundData.exPointInfo)
end

FightDataMgr.instance = FightDataMgr.New()

FightDataMgr.instance:initDataMgr()

return FightDataMgr
