-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/controller/PetCollegeController.lua

module("logic.extensions.petcollege.controller.PetCollegeController", package.seeall)

local PetCollegeController = class("PetCollegeController", BaseController)

function PetCollegeController:ctor()
	return
end

function PetCollegeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self.stopListenBattle, self)
end

function PetCollegeController:onReset()
	self._isRequireInfo = false

	self:stopListenBattle()
end

function PetCollegeController:openView(...)
	local params = {
		...
	}
	local skinId = params[1]

	if not skinId then
		printError("open PetcollegeView no skinId")

		return
	end

	skinId = checknumber(skinId)

	local challengeId
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		local raceId = cfg.raceId

		challengeId = raceId == skinId and PetCollegeConfig.instance:raceId2ChallengeId(checknumber(raceId), 0) or PetCollegeConfig.instance:raceId2ChallengeId(checknumber(raceId), skinId)
	end

	if not challengeId then
		printError("pet_skin 没有对应配置 skinId:", skinId)

		return
	end

	UIStateManager.instance:push(ViewName.PetcollegeView, challengeId)
end

function PetCollegeController:requireProcessInfo()
	if self._isRequireInfo then
		return
	end

	self._isRequireInfo = true

	PetCollegeAgent.instance:sendPetCollegeProcessInfoReq()
end

function PetCollegeController:resetRequireTag()
	self._isRequireInfo = false
end

function PetCollegeController:sendPetCollegeChallengeReq(challengeId, stageId)
	local curFormation = PetCollegeModel.instance:getFormation()
	local form = curFormation:createFormPb()

	form.extParams.formStrengthId = 0
	form.extParams.formStrengthLv = 0

	PetCollegeAgent.instance:sendPetCollegeChallengeReq(challengeId, stageId, form)
end

function PetCollegeController:startListenBattle()
	GlobalDispatcher:addListener(GlobalNotify.OnBattleBuffStart, self._OnBattleBuffStart, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleRoundBirthFinish, self._OnBattleEnter, self)
	GlobalDispatcher:addListener(GlobalNotify.HookSkillStart, self._OnHookSkillStart, self)
end

function PetCollegeController:stopListenBattle()
	GlobalDispatcher:removeListener(GlobalNotify.OnBattleBuffStart, self._OnBattleBuffStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundBirthFinish, self._OnBattleEnter, self)
	GlobalDispatcher:removeListener(GlobalNotify.HookSkillStart, self._OnHookSkillStart, self)
end

function PetCollegeController:_OnBattleBuffStart(unit, buff)
	if unit.teamId == GameEnum.BattleTeam.Left then
		local pause, content, npcId = PetCollegeModel.instance:playBuff(buff:getBuffId())

		if pause then
			self:_openGuide(content, npcId)
		end
	end
end

function PetCollegeController:_OnHookSkillStart(skill, targetUnit)
	if skill.unit.teamId == GameEnum.BattleTeam.Left then
		local pause, content, npcId = PetCollegeModel.instance:playSkill(skill.skillCo.id)

		if pause then
			self:_openGuide(content, npcId)
		end
	end
end

function PetCollegeController:_OnBattleEnter()
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundBirthFinish, self._OnBattleEnter, self)

	local pause, content, npcId = PetCollegeModel.instance:startGuide()

	if pause then
		self:_openGuide(content, npcId)
	end
end

function PetCollegeController:_openGuide(content, npcId)
	BattleFacade.instance:setBattlePause(true)
	ViewMgr.instance:open(ViewName.PetcollegeheadView, content, npcId)
end

PetCollegeController.instance = PetCollegeController.New()

return PetCollegeController
