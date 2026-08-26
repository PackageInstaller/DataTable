-- chunkname: @modules/logic/guide/controller/GuideExceptionController.lua

module("modules.logic.guide.controller.GuideExceptionController", package.seeall)

local GuideExceptionController = class("GuideExceptionController", BaseController)

function GuideExceptionController:onInit()
	self.guideId = nil
	self.stepId = nil
	self.checkFuncDict = {}
	self.checkFuncDict.checkCurrency = GuideExceptionChecker.checkCurrency
	self.checkFuncDict.checkDungeonUsePower = GuideExceptionChecker.checkDungeonUsePower
	self.checkFuncDict.checkBuildingPut = GuideExceptionChecker.checkBuildingPut
	self.checkFuncDict.checkBuildingPutMatchStep = GuideExceptionChecker.checkBuildingPutMatchStep
	self.checkFuncDict.checkViewShow = GuideExceptionChecker.checkViewShow
	self.checkFuncDict.checkViewNotShow = GuideExceptionChecker.checkViewNotShow
	self.checkFuncDict.checkViewExist = GuideExceptionChecker.checkViewExist
	self.checkFuncDict.checkViewNotExist = GuideExceptionChecker.checkViewNotExist
	self.checkFuncDict.checkScene = GuideExceptionChecker.checkScene
	self.checkFuncDict.checkMaterial = GuideExceptionChecker.checkMaterial
	self.checkFuncDict.findTalentFirstChess = GuideExceptionChecker.findTalentFirstChess
	self.checkFuncDict.checkTaskFinish = GuideExceptionChecker.checkTaskFinish
	self.checkFuncDict.checkTaskNotFinish = GuideExceptionChecker.checkTaskNotFinish
	self.checkFuncDict.checkBlockCountGE = GuideExceptionChecker.checkBlockCountGE
	self.checkFuncDict.checkBlockCountL = GuideExceptionChecker.checkBlockCountL
	self.checkFuncDict.checkRoomCanGetRes = GuideExceptionChecker.checkRoomCanGetRes
	self.checkFuncDict.noRemainStars = GuideExceptionChecker.noRemainStars
	self.checkFuncDict.noPointReward = GuideExceptionChecker.noPointReward
	self.checkFuncDict.checkAllEquipLevel = GuideExceptionChecker.checkAllEquipLevel
	self.checkFuncDict.checkHeroTalent = GuideExceptionChecker.checkHeroTalent
	self.checkFuncDict.checkSummon = GuideExceptionChecker.checkSummon
	self.checkFuncDict.check1_2DungeonHasNotCollectNote = GuideExceptionChecker.check1_2DungeonHasNotCollectNote
	self.checkFuncDict.check1_2DungeonHasNotBonusFinisd = GuideExceptionChecker.check1_2DungeonHasNotBonusFinisd
	self.checkFuncDict.check1_2DungeonBonusFinish = GuideExceptionChecker.check1_2DungeonBonusFinish
	self.checkFuncDict.checkRoleStoryCanExchange = GuideExceptionChecker.checkRoleStoryCanExchange
	self.checkFuncDict.checkCurBgmGearStateEqual = GuideExceptionChecker.checkCurBgmGearStateEqual
	self.checkFuncDict.checkCurBgmDeviceNotShowingPPT = GuideExceptionChecker.checkCurBgmDeviceNotShowingPPT
	self.checkFuncDict.checkReturnFalse = GuideExceptionChecker.checkReturnFalse
	self.checkFuncDict.checkMaterialNotEnough = GuideExceptionChecker.checkMaterialNotEnough
	self.checkFuncDict.checkCan174EnoughHpToBet = GuideExceptionChecker.checkCan174EnoughHpToBet
	self.checkFuncDict.checkRouge2AlreadyHaveAlchemy = GuideExceptionChecker.checkRouge2AlreadyHaveAlchemy
	self.checkFuncDict.checkCanRouge2EnoughMaterialToAlchemy = GuideExceptionChecker.checkCanRouge2EnoughMaterialToAlchemy
	self.checkFuncDict.checkRouge2TalentIsActive = GuideExceptionChecker.checkRouge2TalentIsActive
	self.checkFuncDict.checkRouge2TalentEnoughToActive = GuideExceptionChecker.checkRouge2TalentEnoughToActive
	self.handlerFuncDict = {}
	self.handlerFuncDict.finishStep = GuideExceptionHandler.finishStep
	self.handlerFuncDict.finishGuide = GuideExceptionHandler.finishGuide
	self.handlerFuncDict.finishNextGuide = GuideExceptionHandler.finishNextGuide
	self.handlerFuncDict.gotoStep = GuideExceptionHandler.gotoStep
	self.handlerFuncDict.openView = GuideExceptionHandler.openView
	self.handlerFuncDict.closeView = GuideExceptionHandler.closeView
	self._findBtn = GuideExceptionFindBtn.New()
end

function GuideExceptionController:checkStep(guideId, stepId)
	local guideStepCO = GuideConfig.instance:getStepCO(guideId, stepId)

	if not guideStepCO then
		return
	end

	if string.nilorempty(guideStepCO.exception) then
		if self:_checkInterruptFinish(guideId) then
			self:_startInterruptFinish(guideId, stepId)
		end

		return
	end

	self.guideId = guideId
	self.stepId = stepId

	if guideStepCO.exceptionDelay > 0 then
		TaskDispatcher.runDelay(self._startCheck, self, guideStepCO.exceptionDelay)
	else
		self:_startCheck()
	end
end

function GuideExceptionController:stopCheck()
	self._findBtn:stopCheck()
	TaskDispatcher.cancelTask(self._startCheck, self)
end

function GuideExceptionController:_checkInterruptFinish(guideId)
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	return guideCO.interruptFinish == 1
end

function GuideExceptionController:_startInterruptFinish(guideId, stepId)
	local goPath = GuideModel.instance:getStepGOPath(guideId, stepId)

	if string.nilorempty(goPath) then
		return
	end

	local guideCO = GuideConfig.instance:getGuideCO(guideId)
	local checkerParam = "4_1"
	local handlerFuncs = {
		"finishGuide"
	}
	local handlerParams = {}

	self._findBtn:startCheck(guideId, stepId, checkerParam, handlerFuncs, handlerParams)
end

function GuideExceptionController:_startCheck()
	local guideId = self.guideId
	local stepId = self.stepId

	self.guideId = nil
	self.stepId = nil

	local guideStepCO = GuideConfig.instance:getStepCO(guideId, stepId)
	local checkers = string.split(guideStepCO.exception, "|")

	if not string.find(guideStepCO.exception, "findBtn") and self:_checkInterruptFinish(guideId) then
		self:_startInterruptFinish(guideId, stepId)
	end

	for i = 1, #checkers do
		local temp = string.split(checkers[i], "#")
		local checkerFunc = temp[1]
		local checkerParam = temp[2]
		local handlerFuncs = {}
		local handlerParams = {}

		for j = 3, #temp, 2 do
			table.insert(handlerFuncs, temp[j])
			table.insert(handlerParams, temp[j + 1])
		end

		if checkerFunc == "findBtn" then
			self._findBtn:startCheck(guideId, stepId, checkerParam, handlerFuncs, handlerParams)
		else
			if self.checkFuncDict[checkerFunc] == nil then
				logError("guide exception checker not exist: " .. checkerFunc)
			end

			if not self.checkFuncDict[checkerFunc](guideId, stepId, checkerParam) then
				logNormal(string.format("<color=#FF0000>guide_%d_%d exception-> %s</color>", guideId, stepId, checkers[i]))

				for j = 1, #handlerFuncs do
					self:handle(guideId, stepId, handlerFuncs[j], handlerParams[j])
				end

				break
			end
		end
	end
end

function GuideExceptionController:handle(guideId, stepId, handlerFunc, handlerParam)
	self.handlerFuncDict[handlerFunc](guideId, stepId, handlerParam)
	GuideController.instance:statFinishStep(guideId, stepId, true)
end

GuideExceptionController.instance = GuideExceptionController.New()

return GuideExceptionController
