-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreSetFov.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreSetFov", package.seeall)

local WaitGuideActionExploreSetFov = class("WaitGuideActionExploreSetFov", BaseGuideAction)

function WaitGuideActionExploreSetFov:onStart(context)
	local arr = string.splitToNumber(self.actionParam, "#")

	if not arr[1] then
		if not arr[2] then
			local time = 0

			if not arr[3] then
				local easeType = EaseType.Linear
				local cameraComp = GameSceneMgr.instance:getCurScene().camera

				if not cameraComp or not isTypeOf(cameraComp, ExploreSceneCameraComp) then
					self:onDone(true)

					return
				end

				if time > 0 then
					cameraComp:setEaseTime(time)
					cameraComp:setEaseType(easeType)
					cameraComp:setFov(arr[1])
					TaskDispatcher.runDelay(self.onCameraChangeDone, self, time)
				else
					cameraComp:setFov(arr[1])
					cameraComp:applyDirectly()
					self:onDone(true)
				end
			end
		end
	end
end

function WaitGuideActionExploreSetFov:onCameraChangeDone()
	self:resetCameraParam()
	self:onDone(true)
end

function WaitGuideActionExploreSetFov:resetCameraParam()
	local cameraComp = GameSceneMgr.instance:getCurScene().camera

	if not cameraComp or not isTypeOf(cameraComp, ExploreSceneCameraComp) then
		return
	end

	cameraComp:setEaseTime(ExploreConstValue.CameraTraceTime)
	cameraComp:setEaseType(EaseType.Linear)
end

function WaitGuideActionExploreSetFov:clearWork()
	self:resetCameraParam()
	TaskDispatcher.cancelTask(self.onCameraChangeDone, self)
end

return WaitGuideActionExploreSetFov
