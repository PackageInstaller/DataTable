-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/model/DomAdvFightCustomFmtMo.lua

module("logic.extensions.domainadventure.model.KingKaYaNorCustomFmtMo", package.seeall)

local KingKaYaNorCustomFmtMo = class("KingKaYaNorCustomFmtMo", BaseCustomFmtMo)

function KingKaYaNorCustomFmtMo:updateCfg(activityId, blockId)
	self._activityId = activityId
	self._blockId = blockId
	self._eventType = DomainAdventureConfig.instance:getEventType(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._scene = SceneMgr.instance:getCurScene()

	local masterData, creepsCfg
	local creepsMasterId = 0

	if self._eventType == DomAdvEnum.EventType_Fight then
		local clgEventData = DomainAdventureConfig.instance:getClgEventData(self._activityId, self._eventId)

		creepsMasterId = clgEventData.creepsMasterId
	elseif self._eventType == DomAdvEnum.EventType_EliteFight then
		local clgEventData = DomainAdventureConfig.instance:getClgEventData(self._activityId, self._eventId)

		creepsMasterId = clgEventData.creepsMasterId
	end

	self._masterData = DomainAdventureConfig.instance:getCreepsMasterCfg(creepsMasterId)
	self._creepsCfg = DomainAdventureConfig.instance:getCreepsCfg(creepsMasterId)
end

function KingKaYaNorCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function KingKaYaNorCustomFmtMo:initFightHandler()
	local function handler()
		local result, tips = self._scene:getTryStartEventFightResultAndTips(self._activityId, self._blockId, DomAdvEnum.EventFightMode_HAND)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DomainAdventureController.instance:sendPM_DomainAdventureActionReq(self._activityId, self._blockId, nil, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KingKaYaNorCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KingKaYaNorCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

return KingKaYaNorCustomFmtMo
