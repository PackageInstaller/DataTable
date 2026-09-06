-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/model/DomAdvBossCustomFmtMo.lua

module("logic.extensions.domainadventure.model.DomAdvBossCustomFmtMo", package.seeall)

local DomAdvBossCustomFmtMo = class("DomAdvBossCustomFmtMo", BaseCustomFmtMo)

function DomAdvBossCustomFmtMo:updateCfg(activityId, blockId, mode)
	self._activityId = activityId
	self._blockId = blockId
	self._mode = mode
	self._eventType = DomainAdventureConfig.instance:getEventType(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._scene = SceneMgr.instance:getCurScene()

	if self._eventType ~= DomAdvEnum.EventType_Boss then
		printError("仅支持Boss地块挑战")
	end

	local data = DomainAdventureConfig.instance:getBossEventData(self._activityId, self._eventId)

	self._masterData = DomainAdventureConfig.instance:getCreepsMasterCfg(data.creepsMasterId)
	self._creepsCfg = DomainAdventureConfig.instance:getCreepsCfg(data.creepsMasterId)

	local lockRaceIds = self._domAdvMo:getLockPetIdsInBoss()

	self._lockedPetIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedPetIdMap[v] = v
	end
end

function DomAdvBossCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DomAdvBossCustomFmtMo:initFightHandler()
	local function handler()
		local result, tips = self._scene:getTryStartGridEventResultAndTips(self._activityId, self._blockId)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if self._mode == DomAdvEnum.BossFightMode_Normal then
			DomainAdventureController.instance:sendPM_DomainAdventureActionReq(self._activityId, self._blockId, nil, simpleForm)
		elseif self._mode == DomAdvEnum.BossFightMode_Exercise then
			local exParam = "1"

			DomainAdventureController.instance:sendPM_DomainAdventureActionReq(self._activityId, self._blockId, exParam, simpleForm)
		else
			printError("错误:未知的Boss挑战模式")
		end
	end

	self:setFightHandler(handler, nil)
end

function DomAdvBossCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DomAdvBossCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DomAdvBossCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getId())
end

function DomAdvBossCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DomAdvBossCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DomAdvBossCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		if petId > 0 then
			return not self:_isPetNotCanUp(petId)
		else
			return true
		end
	else
		return false
	end
end

function DomAdvBossCustomFmtMo:_isPetNotCanUp(petId)
	if petId > 0 then
		return self._lockedPetIdMap[petId] ~= nil
	else
		return false
	end
end

return DomAdvBossCustomFmtMo
