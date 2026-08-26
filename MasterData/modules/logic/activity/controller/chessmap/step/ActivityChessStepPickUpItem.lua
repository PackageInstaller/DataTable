-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepPickUpItem.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepPickUpItem", package.seeall)

local ActivityChessStepPickUpItem = class("ActivityChessStepPickUpItem", ActivityChessStepBase)

function ActivityChessStepPickUpItem:start()
	local objId = self.originData.id
	local interactMgr = ActivityChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(objId)

		if interactObj then
			local go = interactObj:tryGetGameObject()

			if not gohelper.isNil(go) then
				local goVfx = gohelper.findChild(go, "vx_daoju")

				gohelper.setActive(goVfx, true)
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(self.delayCallPick, self, 1)
end

function ActivityChessStepPickUpItem:delayCallPick()
	TaskDispatcher.cancelTask(self.delayCallPick, self)

	local actId = ActivityChessGameModel.instance:getActId()
	local objId = self.originData.id

	if actId then
		local interactCo = Activity109Config.instance:getInteractObjectCo(actId, objId)

		if interactCo then
			ActivityChessGameController.instance:registerCallback(ActivityChessEvent.RewardIsClose, self.finish, self)
			ViewMgr.instance:openView(ViewName.ActivityChessGameRewardView, {
				config = interactCo
			})

			return
		end
	end

	self:finish()
end

function ActivityChessStepPickUpItem:finish()
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.RewardIsClose, self.finish, self)
	ActivityChessStepPickUpItem.super.finish(self)
end

function ActivityChessStepPickUpItem:dispose()
	TaskDispatcher.cancelTask(self.delayCallPick, self)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.RewardIsClose, self.finish, self)
	ActivityChessStepPickUpItem.super.dispose(self)
end

return ActivityChessStepPickUpItem
