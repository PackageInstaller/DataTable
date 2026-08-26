-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepDeleteObject.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepDeleteObject", package.seeall)

local ActivityChessStepDeleteObject = class("ActivityChessStepDeleteObject", ActivityChessStepBase)

function ActivityChessStepDeleteObject:start()
	local objId = self.originData.id
	local actId = ActivityChessGameModel.instance:getActId()
	local interactMgr = ActivityChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(objId)

		if interactObj and interactObj.config and interactObj.config.interactType == ActivityChessEnum.InteractType.Player and self:checkPlayDisappearAnim(interactObj) then
			return
		end
	end

	self:removeFinish()
end

function ActivityChessStepDeleteObject:checkPlayDisappearAnim(interactObj)
	if interactObj.avatar and interactObj.avatar.goSelected then
		local anim = interactObj.avatar.goSelected:GetComponent(typeof(UnityEngine.Animator))

		if anim then
			anim:Play("close", 0, 0)
		end
	end

	local go = interactObj:tryGetGameObject()

	if not gohelper.isNil(go) then
		local goVfx = gohelper.findChild(go, "vx_disappear")

		gohelper.setActive(goVfx, true)

		local goTracked = gohelper.findChild(go, "piecea/vx_tracked")

		if not gohelper.isNil(goTracked) then
			local animTracked = goTracked:GetComponent(typeof(UnityEngine.Animator))

			if animTracked then
				animTracked:Play("close", 0, 0)
			end
		end

		local anim = go:GetComponent(typeof(UnityEngine.Animator))

		if anim then
			anim:Play("close", 0, 0)
		end

		AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerDisappear)
		TaskDispatcher.runDelay(self.removeFinish, self, 0.7)

		return true
	end

	return false
end

function ActivityChessStepDeleteObject:removeFinish()
	local objId = self.originData.id

	ActivityChessGameModel.instance:removeObjectById(objId)
	ActivityChessGameController.instance:deleteInteractObj(objId)
	self:finish()
end

function ActivityChessStepDeleteObject:dispose()
	ActivityChessStepDeleteObject.super.dispose(self)
	TaskDispatcher.cancelTask(self.removeFinish, self)
end

return ActivityChessStepDeleteObject
