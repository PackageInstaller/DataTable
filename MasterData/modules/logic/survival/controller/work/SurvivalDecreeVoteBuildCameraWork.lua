-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVoteBuildCameraWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVoteBuildCameraWork", package.seeall)

local SurvivalDecreeVoteBuildCameraWork = class("SurvivalDecreeVoteBuildCameraWork", BaseWork)

function SurvivalDecreeVoteBuildCameraWork:ctor(param)
	self:initParam(param)
end

function SurvivalDecreeVoteBuildCameraWork:initParam(param)
	self.playerPos = param.playerPos
end

function SurvivalDecreeVoteBuildCameraWork:onStart()
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self.playerPos.q, self.playerPos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 0.44)
	self:onBuildFinish()
end

function SurvivalDecreeVoteBuildCameraWork:onBuildFinish()
	self:onDone(true)
end

function SurvivalDecreeVoteBuildCameraWork:clearWork()
	return
end

return SurvivalDecreeVoteBuildCameraWork
