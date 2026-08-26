-- chunkname: @modules/logic/fight/model/data/FightStateDataMgr.lua

module("modules.logic.fight.model.data.FightStateDataMgr", package.seeall)

local FightStateDataMgr = FightDataClass("FightStateDataMgr", FightDataMgrBase)

FightStateDataMgr.Mark = {
	NewAllEntityWhenEnter = "NewAllEntityWhenEnter"
}

function FightStateDataMgr:onConstructor()
	self.isAuto = false
	self.forceAuto = false
	self.isReplay = false
	self.isFinish = false
	self.buffForceAuto = false
	self.playingEnd = false
	self.forceUseCard = false
	self.dealingCrash = false
	self.markDic = {}
end

function FightStateDataMgr:setMark(mark)
	self.markDic[mark] = true
end

function FightStateDataMgr:hasMark(mark)
	return self.markDic[mark] == true
end

function FightStateDataMgr:clearMark(mark)
	self.markDic[mark] = nil
end

function FightStateDataMgr:initReplayState()
	local version = FightDataHelper.fieldMgr.version
	local isRecord = FightDataHelper.fieldMgr.isRecord

	if version >= 1 then
		if isRecord then
			self.isReplay = true
		end
	else
		local fightParam = FightModel.instance:getFightParam()

		if fightParam and fightParam.isReplay then
			self.isReplay = true
		end
	end
end

function FightStateDataMgr:initAutoState()
	if self.isReplay then
		self:setAutoState(false)

		return
	end

	local customData = FightDataHelper.fieldMgr.customData

	if customData then
		local data = customData[FightCustomData.CustomDataType.Act191]

		if data and data.auto then
			self.forceAuto = true

			self:setAutoState(true)

			return
		end
	end

	if FightDataHelper.fieldMgr:isDouQuQu() then
		self:setAutoState(false)

		return
	end

	local battleConfig = lua_battle.configDict[FightDataHelper.fieldMgr.battleId]
	local episodeCanAutoFight = battleConfig and (not battleConfig.noAutoFight or battleConfig.noAutoFight == 0)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		self:setAutoState(false)
	elseif not episodeCanAutoFight then
		self:setAutoState(false)
	else
		local auto = FightController.instance:getPlayerPrefKeyAuto(0)

		self:setAutoState(auto)
	end
end

function FightStateDataMgr:setAutoState(isAuto)
	if not isAuto and self.isAuto then
		FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
		FightDataHelper.operationDataMgr:resetCurSelectEntityIdDefault()
	end

	self.isAuto = isAuto

	self:com_sendMsg(FightMsgId.SetAutoState, isAuto)
	self:com_sendFightEvent(FightEvent.SetAutoState, isAuto)
end

function FightStateDataMgr:setBuffForceAuto(isForce)
	self.buffForceAuto = isForce

	local isAuto = self:getIsAuto()

	self:com_sendMsg(FightMsgId.SetAutoState, isAuto)
	self:com_sendFightEvent(FightEvent.SetAutoState, isAuto)
end

function FightStateDataMgr:getIsAuto()
	if self.buffForceAuto then
		return true
	end

	return self.isAuto
end

function FightStateDataMgr:setPlayingEnd(isEnd)
	self.playingEnd = isEnd
end

function FightStateDataMgr:isPlayingEnd()
	return self.playingEnd
end

return FightStateDataMgr
