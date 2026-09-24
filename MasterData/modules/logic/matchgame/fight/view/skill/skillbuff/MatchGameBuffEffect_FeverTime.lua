-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_FeverTime.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_FeverTime", package.seeall)

local MatchGameBuffEffect_FeverTime = class("MatchGameBuffEffect_FeverTime")

function MatchGameBuffEffect_FeverTime:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_FeverTime:progressBuff_108(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Hero or not gameInfoMo then
		return
	end

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self:refreshFeverTime(gameInfoMo)
end

function MatchGameBuffEffect_FeverTime:progressBuff_109(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy or not gameInfoMo then
		return
	end

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self:refreshFeverTime(gameInfoMo)
end

function MatchGameBuffEffect_FeverTime:refreshFeverTime(targetObj, removeSkillBuffMo)
	local removeBuffUid = removeSkillBuffMo and removeSkillBuffMo:getBuffUid()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()
	local maxFeverTime = gameInfoData.gameConfig.feverTime

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap or {}) do
		if buffUid ~= removeBuffUid and (skillBuffMo.buffEffectId == 108 or skillBuffMo.buffEffectId == 109) then
			local buffEffectData = string.splitToNumber(skillBuffMo.buffConfig.buffEffect, "#")

			maxFeverTime = maxFeverTime + (buffEffectData[2] or 0)
		end
	end

	targetObj.maxFeverTime = Mathf.Max(0, maxFeverTime)

	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverTime:removeBuff_108(buffEffectData, targetObj, skillBuffMo)
	self:refreshFeverTime(targetObj, skillBuffMo)
end

function MatchGameBuffEffect_FeverTime:removeBuff_109(buffEffectData, targetObj, skillBuffMo)
	self:refreshFeverTime(targetObj, skillBuffMo)
end

return MatchGameBuffEffect_FeverTime
