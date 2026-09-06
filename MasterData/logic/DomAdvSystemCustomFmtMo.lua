-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/model/DomAdvSystemCustomFmtMo.lua

module("logic.extensions.domainadventure.model.DomAdvSystemCustomFmtMo", package.seeall)

local DomAdvSystemCustomFmtMo = class("DomAdvSystemCustomFmtMo", BaseCustomFmtMo)

function DomAdvSystemCustomFmtMo:updateCfg(activityId, blockId)
	self._activityId = activityId
	self._blockId = blockId
	self._eventType = DomainAdventureConfig.instance:getEventType(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._scene = SceneMgr.instance:getCurScene()

	if self._eventType ~= DomAdvEnum.EventType_SolveForm then
		printError("仅支持破阵地块挑战")
	end

	local data = DomainAdventureConfig.instance:getSolveFormData(self._activityId, self._eventId)

	self._masterData = DomainAdventureConfig.instance:getCreepsMasterCfg(data.creepsMasterId)
	self._creepsCfg = DomainAdventureConfig.instance:getCreepsCfg(data.creepsMasterId)
	self._sysCfg = DomainAdventureConfig.instance:getSysPetData(data.systemPoolId)

	if self._systemPoolId ~= data.systemPoolId then
		self._systemPoolId = data.systemPoolId

		self:initPetList()
	end
end

function DomAdvSystemCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DomAdvSystemCustomFmtMo:initFightHandler()
	local function handler()
		local result, tips = self._scene:getTryStartGridEventResultAndTips(self._activityId, self._blockId)

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

function DomAdvSystemCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DomAdvSystemCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DomAdvSystemCustomFmtMo:initPetList()
	self:clearAllPetList()

	local fmo = FightingPowerPetMo.New()

	for _, data in pairs(self._sysCfg or {}) do
		fmo:fromChallengeCreepCo(data)

		local petMo = fmo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

return DomAdvSystemCustomFmtMo
