-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_MatchTime.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_MatchTime", package.seeall)

local MatchGameBuffEffect_MatchTime = class("MatchGameBuffEffect_MatchTime")

function MatchGameBuffEffect_MatchTime:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_MatchTime:progressBuff_106(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Hero or not gameInfoMo then
		return
	end

	if not buffEffectData[2] then
		local offsetTime = 0
		local lastRoundTime = gameInfoMo.curRoundTime
		local lastMaxRoundTime = gameInfoMo.maxRoundTime

		gameInfoMo.curRoundTime = Mathf.Max(gameInfoMo.curRoundTime + offsetTime, 0)
		gameInfoMo.maxRoundTime = Mathf.Max(gameInfoMo.maxRoundTime, gameInfoMo.curRoundTime)
		skillBuffMo.effectData.maxRoundTimeOffset = gameInfoMo.maxRoundTime - lastMaxRoundTime

		MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
		self.sceneView:skillChangeRoundTime(gameInfoMo.curRoundTime, gameInfoMo.curRoundTime - lastRoundTime)
	end
end

function MatchGameBuffEffect_MatchTime:progressBuff_107(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy or not gameInfoMo then
		return
	end

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)

	local lastMaxRoundTime = gameInfoMo.maxRoundTime

	self:refreshMatchTime(gameInfoMo)
	self.sceneView:showRoundTimeChangeTip(gameInfoMo.maxRoundTime - lastMaxRoundTime)
end

function MatchGameBuffEffect_MatchTime:refreshMatchTime(targetObj, removeSkillBuffMo)
	local removeBuffUid = removeSkillBuffMo and removeSkillBuffMo:getBuffUid()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()
	local maxRoundTime = gameInfoData.gameConfig.matchTime

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap or {}) do
		if buffUid ~= removeBuffUid then
			local buffEffectData = string.splitToNumber(skillBuffMo.buffConfig.buffEffect, "#")

			if skillBuffMo.buffEffectId == 106 then
				maxRoundTime = maxRoundTime + (skillBuffMo.effectData.maxRoundTimeOffset or 0)
			elseif skillBuffMo.buffEffectId == 107 then
				maxRoundTime = maxRoundTime + (buffEffectData[2] or 0)
			end
		end
	end

	targetObj.maxRoundTime = Mathf.Max(0, maxRoundTime)
end

function MatchGameBuffEffect_MatchTime:removeBuff_106(buffEffectData, targetObj, skillBuffMo)
	self:refreshMatchTime(targetObj, skillBuffMo)

	targetObj.curRoundTime = Mathf.Min(targetObj.maxRoundTime, targetObj.curRoundTime)

	self.sceneView:refreshRoundTime(targetObj.curRoundTime)
end

function MatchGameBuffEffect_MatchTime:removeBuff_107(buffEffectData, targetObj, skillBuffMo)
	self:refreshMatchTime(targetObj, skillBuffMo)
	self.sceneView:refreshRoundTime()
end

return MatchGameBuffEffect_MatchTime
