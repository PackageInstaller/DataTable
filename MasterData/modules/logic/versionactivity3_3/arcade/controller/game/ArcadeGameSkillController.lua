-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameSkillController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameSkillController", package.seeall)

local ArcadeGameSkillController = class("ArcadeGameSkillController", BaseController)

function ArcadeGameSkillController:onInit()
	return
end

function ArcadeGameSkillController:onInitFinish()
	return
end

function ArcadeGameSkillController:addConstEvents()
	return
end

function ArcadeGameSkillController:reInit()
	return
end

function ArcadeGameSkillController:_onUsePassiveSkill(target, skillMO, context)
	if skillMO then
		context = context or {}
		context.target = target

		skillMO:trigger(ArcadeGameEnum.TriggerPoint.None, context, true)
	end
end

function ArcadeGameSkillController:useSkill(target, skillId, context)
	local isPassiveSkill = ArcadeGameHelper.getIsPassiveSkill(skillId)

	if isPassiveSkill then
		local skillSetMO = target:getSkillSetMO()
		local skillMO = skillSetMO:getSkillById(skillId)

		if not skillMO then
			self._skillSetMO = self._skillSetMO or ArcadeGameSkillSetMO.New(0, nil)

			self._skillSetMO:addSkillById(skillId)

			skillMO = self._skillSetMO:getSkillById(skillId)
		end

		self:_onUsePassiveSkill(target, skillMO, context)
	else
		self:useActiveSkill(target, skillId, context)
	end
end

function ArcadeGameSkillController:passiveSkillMO(target, skillMO, context)
	self:_onUsePassiveSkill(target, skillMO, context)
end

function ArcadeGameSkillController:useActiveSkill(target, skillId, context, targetBase)
	if not targetBase then
		local targetId = ArcadeConfig.instance:getActiveSkillTarget(skillId)

		targetBase = ArcadeSkillFactory.instance:createSkillTargetById(targetId)
	end

	local targetMOList

	if targetBase then
		context = context or {}
		context.target = target

		targetBase:findByContext(context)

		targetMOList = {}

		tabletool.addValues(targetMOList, targetBase:getTargetList())
	end

	local attackDirection = target:getDirection()

	ArcadeGameController.instance:enterAttackFlow(ArcadeGameEnum.AttackType.Skill, target, targetMOList, attackDirection, skillId, true)
end

function ArcadeGameSkillController:_onPlayEffect(target, effectId)
	if target and self._entityMgr then
		local entity = self._entityMgr:getEntityWithType(target:getEntityType(), target:getUid())

		if entity and entity.effectComp then
			entity.effectComp:playEffect(effectId)
		end
	end
end

function ArcadeGameSkillController:_onRemoveEffect(target, effectId)
	if target and self._entityMgr then
		local entity = self._entityMgr:getEntityWithType(target:getEntityType(), target:getUid())

		if entity and entity.effectComp then
			entity.effectComp:removeEffect(effectId)
		end
	end
end

function ArcadeGameSkillController:_getEntityMgr()
	self._entityMgr = nil

	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		self._entityMgr = scene.entityMgr

		return scene.entityMgr
	end
end

function ArcadeGameSkillController:playEffectByTarget(target, effectId)
	if effectId and effectId ~= 0 then
		self:_getEntityMgr()
		self:_onPlayEffect(target, effectId)
	end
end

function ArcadeGameSkillController:playEffectByTargetList(targetList, effectId)
	if effectId and effectId ~= 0 then
		self:_getEntityMgr()

		for _, target in ipairs(targetList) do
			self:_onPlayEffect(target, effectId)
		end
	end
end

function ArcadeGameSkillController:removeEffectByTarget(target, effectId)
	if effectId and effectId ~= 0 then
		self:_getEntityMgr()
		self:_onRemoveEffect(target, effectId)
	end
end

ArcadeGameSkillController.instance = ArcadeGameSkillController.New()

return ArcadeGameSkillController
