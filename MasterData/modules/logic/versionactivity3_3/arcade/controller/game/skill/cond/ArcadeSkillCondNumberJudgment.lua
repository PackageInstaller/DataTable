-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondNumberJudgment.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondNumberJudgment", package.seeall)

local ArcadeSkillCondNumberJudgment = class("ArcadeSkillCondNumberJudgment", ArcadeSkillCondBase)

function ArcadeSkillCondNumberJudgment:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._opStr = string.lower(params[2] or "")
	self._compNum = tonumber(params[3])
end

function ArcadeSkillCondNumberJudgment:onIsCondSuccess()
	local beJudgedNum

	if self._context then
		beJudgedNum = self._context.beJudgedNum
	end

	if not beJudgedNum or not self._compNum then
		logError(string.format("ArcadeSkillCondNumberJudgment:onIsCondSuccess error judgedNum：%s compNum:%s", beJudgedNum, self._compNum))

		return
	end

	local compareFunc = ArcadeGameHelper.getCompareFunc(self._opStr)

	if compareFunc then
		return compareFunc(beJudgedNum, self._compNum)
	end
end

return ArcadeSkillCondNumberJudgment
