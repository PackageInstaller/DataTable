-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_Giddy.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_Giddy", package.seeall)

local MatchGameBuffEffect_Giddy = class("MatchGameBuffEffect_Giddy")

function MatchGameBuffEffect_Giddy:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_Giddy:progressBuff_103(buffEffectData, targetInfoList, skillData, skillBuffMo)
	for index, targetInfo in ipairs(targetInfoList) do
		local selectHeroMap = targetInfo.targetData

		for posIndex, heroFightMo in pairs(selectHeroMap) do
			if heroFightMo and heroFightMo.attackRate then
				heroFightMo:setGiddyState(true)
				MatchGameSkillBuffHandler.instance:attachBuffToTarget(heroFightMo, skillBuffMo)
				self.fightView:refreshHeroFight()
				self.fightView:showRoleEffect(MatchGameFightEnum.RoleEffectType.Lock, heroFightMo.id, false)
				self.fightView:playHeroInfoItemLockAnim(heroFightMo.id)
			end
		end
	end
end

function MatchGameBuffEffect_Giddy:removeBuff_103(buffEffectData, targetObj)
	targetObj:setGiddyState(false)
	self.fightView:refreshHeroFight()
	self.fightView:closeRoleEffect(MatchGameFightEnum.RoleEffectType.Lock, targetObj.id, false)
	self.fightView:closeHeroInfoItemLockAnim(targetObj.id)
end

return MatchGameBuffEffect_Giddy
