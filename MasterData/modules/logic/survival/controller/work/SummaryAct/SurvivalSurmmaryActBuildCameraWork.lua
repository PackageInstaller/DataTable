-- chunkname: @modules/logic/survival/controller/work/SummaryAct/SurvivalSurmmaryActBuildCameraWork.lua

module("modules.logic.survival.controller.work.SummaryAct.SurvivalSurmmaryActBuildCameraWork", package.seeall)

local SurvivalSurmmaryActBuildCameraWork = class("SurvivalSurmmaryActBuildCameraWork", BaseWork)

function SurvivalSurmmaryActBuildCameraWork:ctor(param)
	self.mapCo = param.mapCo
end

function SurvivalSurmmaryActBuildCameraWork:onStart()
	local playerPos = string.splitToNumber(self.mapCo.orderPosition, ",")
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(playerPos[1], playerPos[2] + SurvivalModel.instance.summaryActPosOffset)

	SurvivalMapHelper.instance:setFocusPos(x, y, z)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 0.44)
	self:onDone(true)
end

function SurvivalSurmmaryActBuildCameraWork:onDestroy()
	local playerMo = SurvivalShelterModel.instance:getPlayerMo()
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(playerMo.pos.q, playerMo.pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z), 0)
	SurvivalSurmmaryActBuildCameraWork.super.onDestroy(self)
end

return SurvivalSurmmaryActBuildCameraWork
