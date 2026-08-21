-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionDragBeforeBattle.lua

module("logic.extensions.guide.controller.action.GuideActionDragBeforeBattle", package.seeall)

local GuideActionDragBeforeBattle = class("GuideActionDragBeforeBattle", BaseGuideAction)

function GuideActionDragBeforeBattle:ctor(guideId, stepId, guideStepCO)
	GuideActionDragBeforeBattle.super.ctor(self, guideId, stepId, guideStepCO)
end

function GuideActionDragBeforeBattle:onEnter(context)
	GuideActionDragBeforeBattle.super.onEnter(self, context)
	BattleDispatcher:addEventListener(BattleEventType.OnPlaceEntityEnd, self._onOperationCampEnd, self)

	local uiPath, cellCoordinate, npcId = self:_getDragBeforeBattleParam(self.guideStepCO)

	if self:_isUnitAtTargetCell(cellCoordinate, npcId) then
		self:onDone(WorkResult.Succeed)
	else
		GuideController.instance:openGuideView(self.guideStepCO)
	end
end

function GuideActionDragBeforeBattle:_isUnitAtTargetCell(cellCoordinate, npcId)
	if cellCoordinate and npcId then
		return GuideUtility.isUnitAtTargetCell(npcId, cellCoordinate[1], cellCoordinate[2])
	end

	return false
end

function GuideActionDragBeforeBattle:_getDragBeforeBattleParam(stepCO)
	local params = stepCO.guideControlParam
	local cellCoordinate = Vector2.New(0, 0)
	local uiPath = false
	local npcId = false

	if params then
		local tempParams = string.split(params, "#")

		if #tempParams ~= 3 and enableErrorLog then
			printError("GuideStep==>params invalid in drag before battle action , step id:" .. tostring(stepId) .. " _ params:" .. guideStepCO.guideControlParam)
		end

		uiPath = tempParams[1]

		local posParam = string.split(tempParams[2], ",")

		if #posParam ~= 2 and enableErrorLog then
			printError("GuideStep==>params invalid in drag before battle action , step id:" .. tostring(stepId) .. " _ params:" .. guideStepCO.guideControlParam)
		end

		cellCoordinate = {
			tonumber(posParam[1]),
			tonumber(posParam[2])
		}
		npcId = tonumber(tempParams[3])
	end

	return uiPath, cellCoordinate, npcId
end

function GuideActionDragBeforeBattle:onExit()
	GuideActionDragBeforeBattle.super.onExit(self)
	BattleDispatcher:removeEventListener(BattleEventType.OnPlaceEntityEnd, self._onOperationCampEnd, self)
end

function GuideActionDragBeforeBattle:_onOperationCampEnd()
	self:onDone(WorkResult.Succeed)
end

return GuideActionDragBeforeBattle
