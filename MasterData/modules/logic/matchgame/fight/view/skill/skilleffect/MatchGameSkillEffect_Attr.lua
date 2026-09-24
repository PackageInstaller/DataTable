-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Attr.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Attr", package.seeall)

local MatchGameSkillEffect_Attr = class("MatchGameSkillEffect_Attr")

function MatchGameSkillEffect_Attr:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Attr:progressEffect_1008(effectCoData, targetInfoList, skillData)
	local attrId = effectCoData[2]

	if not effectCoData[3] then
		if not attrId or effectCoData[3] == 0 then
			return
		end

		for index, targetInfo in ipairs(targetInfoList) do
			local targetObjList = MatchGameSkillEffectHandler.instance:getTargetObjList(targetInfo)

			for _, targetObj in ipairs(targetObjList) do
				self:updateTargetAttr(targetObj, attrId, effectCoData[3])
			end
		end

		self.fightView:refreshHeroFight()
	end
end

function MatchGameSkillEffect_Attr:updateTargetAttr(targetObj, attrId, offsetValue)
	if not targetObj or not targetObj.updateFightInfo then
		return
	end

	if attrId == MatchGameFightEnum.SkillAttrType.Attack then
		targetObj:updateFightInfo({
			attack = Mathf.Max(0, targetObj.attack + offsetValue)
		})
	elseif attrId == MatchGameFightEnum.SkillAttrType.Def then
		targetObj:updateFightInfo({
			def = Mathf.Max(0, targetObj.def + offsetValue)
		})
	elseif attrId == MatchGameFightEnum.SkillAttrType.Hp then
		local maxHp = Mathf.Max(1, targetObj.maxHp + offsetValue)
		local hp = Mathf.Clamp(targetObj.hp + offsetValue, 0, maxHp)

		targetObj:updateFightInfo({
			maxHp = maxHp,
			hp = hp
		})
		self.fightView:skillAddCurHeroTotalHp(offsetValue)
	elseif attrId == MatchGameFightEnum.SkillAttrType.Heal then
		targetObj:updateFightInfo({
			heal = Mathf.Max(0, targetObj.heal + offsetValue)
		})
	end
end

return MatchGameSkillEffect_Attr
