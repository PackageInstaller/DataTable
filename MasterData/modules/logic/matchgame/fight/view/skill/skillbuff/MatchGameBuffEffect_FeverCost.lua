-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_FeverCost.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_FeverCost", package.seeall)

local MatchGameBuffEffect_FeverCost = class("MatchGameBuffEffect_FeverCost")

function MatchGameBuffEffect_FeverCost:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_FeverCost:progressBuff_110(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Hero or not gameInfoMo then
		return
	end

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self:refreshFeverCost(gameInfoMo)
end

function MatchGameBuffEffect_FeverCost:progressBuff_111(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy or not gameInfoMo then
		return
	end

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self:refreshFeverCost(gameInfoMo)
end

function MatchGameBuffEffect_FeverCost:refreshFeverCost(targetObj, removeSkillBuffMo)
	local removeBuffUid = removeSkillBuffMo and removeSkillBuffMo:getBuffUid()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()
	local maxFeverNum = gameInfoData.gameConfig.feverCost

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap or {}) do
		if buffUid ~= removeBuffUid and (skillBuffMo.buffEffectId == 110 or skillBuffMo.buffEffectId == 111) then
			local buffEffectData = string.splitToNumber(skillBuffMo.buffConfig.buffEffect, "#")

			maxFeverNum = maxFeverNum + (buffEffectData[2] or 0)
		end
	end

	targetObj.maxFeverNum = Mathf.Max(0, maxFeverNum)

	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverCost:removeBuff_110(buffEffectData, targetObj, skillBuffMo)
	self:refreshFeverCost(targetObj, skillBuffMo)
end

function MatchGameBuffEffect_FeverCost:removeBuff_111(buffEffectData, targetObj, skillBuffMo)
	self:refreshFeverCost(targetObj, skillBuffMo)
end

return MatchGameBuffEffect_FeverCost
