-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepPickUpItem.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepPickUpItem", package.seeall)

local Va3ChessStepPickUpItem = class("Va3ChessStepPickUpItem", Va3ChessStepBase)

function Va3ChessStepPickUpItem:start()
	local objId = self.originData.id
	local delayTime = 0
	local interactMgr = Va3ChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(objId)

		if interactObj then
			local go = interactObj:tryGetGameObject()

			if not gohelper.isNil(go) then
				local goVfx = gohelper.findChild(go, "vx_daoju")

				gohelper.setActive(goVfx, true)

				delayTime = goVfx and 1 or 0
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)

	if delayTime ~= 0 then
		TaskDispatcher.runDelay(self.delayCallPick, self, delayTime)
	else
		self:delayCallPick()
	end
end

function Va3ChessStepPickUpItem:delayCallPick()
	TaskDispatcher.cancelTask(self.delayCallPick, self)

	local actId = Va3ChessGameModel.instance:getActId()
	local objId = self.originData.id

	if actId then
		local interactCo = Va3ChessConfig.instance:getInteractObjectCo(actId, objId)

		if interactCo then
			Va3ChessGameController.instance:registerCallback(Va3ChessEvent.RewardIsClose, self.finish, self)

			local param = {
				collectionId = self.originData.collectionId
			}

			if Va3ChessViewController.instance:openRewardView(actId, interactCo, param) then
				return
			end
		end
	end

	self:finish()
end

function Va3ChessStepPickUpItem:finish()
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.RewardIsClose, self.finish, self)
	Va3ChessStepPickUpItem.super.finish(self)
end

function Va3ChessStepPickUpItem:dispose()
	TaskDispatcher.cancelTask(self.delayCallPick, self)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.RewardIsClose, self.finish, self)
	Va3ChessStepPickUpItem.super.dispose(self)
end

return Va3ChessStepPickUpItem
