-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingStarConditionItem.lua

module("logic.extensions.battle.viewsetting.BattleSettingStarConditionItem", package.seeall)

local M = class("BattleSettingStarConditionItem", UIReusableLuaBehavior)
local kFinishColor = "#47D3CB"
local kNormalColor = "#000000"

function M:buildUI()
	self._goStateList = {}
	self._goStateList[DungeonStarConditionChecker.Result.UNFINISHED] = goutil.findChild(self.mainGO, "type1")
	self._goStateList[DungeonStarConditionChecker.Result.FINISHED] = goutil.findChild(self.mainGO, "type2")
	self._goStateList[DungeonStarConditionChecker.Result.FAILED] = goutil.findChild(self.mainGO, "type3")
end

function M:destroyUI()
	self._goStateList = nil
end

function M:setDungeonInfo(dungeonStarCode, isPassed)
	if not dungeonStarCode then
		self:_resetAllState()
		goutil.setActive(self.mainGO, false)

		return
	end

	if isPassed then
		self:_setProgress(dungeonStarCode, DungeonStarConditionChecker.Result.FINISHED)
	else
		local result, pCurrent, pTotal = DungeonStarConditionChecker.checkCondition(dungeonStarCode)

		self:_setProgress(dungeonStarCode, result, pCurrent, pTotal)
	end
end

function M:_setProgress(dungeonStarCode, progressState, current, total)
	local txtNum = goutil.findChildTextComponent(self._goStateList[progressState], "txtNum")
	local txtDesc = goutil.findChildTextComponent(self._goStateList[progressState], "txtDesc")

	if progressState == DungeonStarConditionChecker.Result.UNFINISHED then
		txtNum.text = string.format("%s/%s", current, total)
	elseif progressState == DungeonStarConditionChecker.Result.FINISHED then
		local isAbsolutelyFinished = not current or not total

		if isAbsolutelyFinished then
			txtNum.text = lang("tip_finish")
		else
			txtNum.text = string.format("%s/%s", current, total)
		end
	elseif progressState == DungeonStarConditionChecker.Result.FAILED then
		txtNum.text = lang("tip_fail")
	elseif enableErrorLog then
		printError("unhandle progress state", progressState)
	end

	local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(dungeonStarCode)

	txtDesc.text = dungeonStarCOWrapper:getDescription()

	self:_resetAllState()

	local goState = self._goStateList[progressState]

	goutil.setActive(goState, true)
end

function M:_resetAllState()
	for _, go in pairs(self._goStateList) do
		goutil.setActive(go, false)
	end
end

return M
