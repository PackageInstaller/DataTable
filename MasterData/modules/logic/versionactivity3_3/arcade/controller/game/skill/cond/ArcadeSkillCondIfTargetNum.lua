-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondIfTargetNum.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondIfTargetNum", package.seeall)

local ArcadeSkillCondIfTargetNum = class("ArcadeSkillCondIfTargetNum", ArcadeSkillCondBase)

function ArcadeSkillCondIfTargetNum:onCtor()
	local params = self._params

	self._changeName = params[1]

	local targetId = tonumber(params[2])

	if targetId then
		self._targetBase = ArcadeSkillFactory.instance:createSkillTargetById(targetId)
	end

	self._opStr = string.lower(params[3] or "")
	self._compNum = tonumber(params[4])
end

function ArcadeSkillCondIfTargetNum:onIsCondSuccess()
	local targetNum

	if self._targetBase then
		self._targetBase:findByContext(self._context)

		local targetMOList = self._targetBase:getTargetList()

		targetNum = targetMOList and #targetMOList
	end

	if not targetNum or not self._compNum then
		logError(string.format("ArcadeSkillCondIfTargetNum:onIsCondSuccess error targetNum：%s compNum:%s", targetNum, self._compNum))

		return
	end

	local compareFunc = ArcadeGameHelper.getCompareFunc(self._opStr)

	if compareFunc then
		return compareFunc(targetNum, self._compNum)
	end
end

return ArcadeSkillCondIfTargetNum
