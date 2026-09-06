-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/model/DualdragonExtremeChallengeFmtMo.lua

module("logic.extensions.dualdragonchallenge.model.DualdragonExtremeChallengeFmtMo", package.seeall)

local DualdragonExtremeChallengeFmtMo = class("DualdragonExtremeChallengeFmtMo", BaseCustomFmtMo)

function DualdragonExtremeChallengeFmtMo:initParams(activityId, groupId, stageId)
	self.isShowTab = false
	self._activityId = activityId
	self._stageCfg = DualdragonchallengeConfig.instance:getStageCfg(activityId, groupId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local cfg = DualdragonchallengeConfig.instance:getMasterCfg(self._creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.WinDesc
end

function DualdragonExtremeChallengeFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		local form = self:getCurFormation():createFormPb()

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DualdragonchallengeController.instance:sendPM_DualDragonExtremeChallengeReq(self._activityId, self._stageCfg.groupId, self._stageCfg.stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DualdragonExtremeChallengeFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DualdragonExtremeChallengeFmtMo:getMonsterConfigList()
	return DualdragonchallengeConfig.instance:getCreepCfgs(self._creepsMasterId)
end

function DualdragonExtremeChallengeFmtMo:getFmtInfoConfig()
	return DualdragonchallengeConfig.instance:getMasterCfg(self._creepsMasterId)
end

function DualdragonExtremeChallengeFmtMo:initSaveHandler()
	return
end

return DualdragonExtremeChallengeFmtMo
