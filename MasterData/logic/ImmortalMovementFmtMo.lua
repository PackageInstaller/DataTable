-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/model/ImmortalMovementFmtMo.lua

module("logic.extensions.immortalmovement.model.ImmortalMovementFmtMo", package.seeall)

local ImmortalMovementFmtMo = class("ImmortalMovementFmtMo", BaseCustomFmtMo)

function ImmortalMovementFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local day = ImmortalMovementController.instance:getCurDay(self.activityId)

	self._stageCfgs = ImmortalMovementConfig.instance:getStageCfgs(self.activityId, day)

	local stageCfg = self._stageCfgs[self.stageId]
	local creepsMasterId = stageCfg.creepsMasterId

	self._masterData = ImmortalMovementConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = ImmortalMovementConfig.instance:getCreepCfgs(creepsMasterId)
	self.helpCfgs = ImmortalMovementConfig.instance:getSupportPetCfgs(self.activityId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function ImmortalMovementFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		ImmortalMovementController.instance:startChallenge(self.activityId, simpleForm, self.stageId)
	end

	self:setFightHandler(handler, nil)
end

function ImmortalMovementFmtMo:updateData()
	self:tryInitPetList()
end

function ImmortalMovementFmtMo:initPetList()
	self:clearAllPetList()

	if self.helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(self.helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function ImmortalMovementFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function ImmortalMovementFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ImmortalMovementFmtMo:getFmtInfoConfig()
	return self._masterData
end

function ImmortalMovementFmtMo:getExtendViewName()
	return ViewName.ImmortalMoveFmtExView
end

return ImmortalMovementFmtMo
