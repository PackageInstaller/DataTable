-- chunkname: @modules/logic/activity/controller/chessmap/event/ActivityChessStateUseItem.lua

module("modules.logic.activity.controller.chessmap.event.ActivityChessStateUseItem", package.seeall)

local ActivityChessStateUseItem = class("ActivityChessStateUseItem", ActivityChessStateBase)

function ActivityChessStateUseItem:start()
	logNormal("ActivityChessStateUseItem start")

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		self:startNotifyView()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	end
end

function ActivityChessStateUseItem:onOpenViewFinish(viewName)
	if viewName == ViewName.ActivityChessGame then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
		self:startNotifyView()
	end
end

function ActivityChessStateUseItem:startNotifyView()
	local interactId = self.originData.interactId
	local range = self.originData.range

	if not range or not interactId then
		logError("ActivityChessStateUseItem range = " .. tostring(range) .. ", interactId = " .. tostring(interactId))

		return
	end

	local interactMgr = ActivityChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(interactId)

		if interactObj then
			local go = interactObj:tryGetGameObject()

			if not gohelper.isNil(go) then
				local goVfx = gohelper.findChild(go, "vx_daoju")

				gohelper.setActive(goVfx, true)
			end

			if interactObj.goToObject then
				interactObj.goToObject:setMarkAttract(true)
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(self.delayCallChoosePos, self, 1)
end

function ActivityChessStateUseItem:delayCallChoosePos()
	TaskDispatcher.cancelTask(self.delayCallChoosePos, self)

	local interactId = self.originData.interactId
	local range = self.originData.range
	local interactMgr = ActivityChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(interactId)

		if interactObj then
			local posX, posY = interactObj.originData.posX, interactObj.originData.posY

			self._centerX, self._centerY = posX, posY

			self:packEventObjs(posX, posY, range)
		end
	end
end

function ActivityChessStateUseItem:packEventObjs(posX, posY, range)
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = posX,
		selfPosY = posY,
		selectType = ActivityChessEnum.ChessSelectType.UseItem
	}

	for x = posX - range, posX + range do
		for y = posY - range, posY + range do
			if self:checkCanThrow(posX, posY, x, y) then
				table.insert(evtObj.posXList, x)
				table.insert(evtObj.posYList, y)
			end
		end
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetCenterHintText, {
		visible = true,
		text = luaLang("versionact_109_itemplace_hint")
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, evtObj)
end

function ActivityChessStateUseItem:checkCanThrow(srcX, srcY, tarX, tarY)
	if srcX ~= tarX or srcY ~= tarY then
		return ActivityChessGameController.instance:posCanWalk(tarX, tarY)
	end

	return false
end

function ActivityChessStateUseItem:onClickPos(x, y, manualClick)
	if not self._centerX then
		logNormal("ActivityChessStateUseItem no interact pos found !")

		return
	end

	local range = self.originData.range
	local deltaX, deltaY = math.abs(x - self._centerX), math.abs(y - self._centerY)

	if self:checkCanThrow(self._centerX, self._centerY, x, y) and deltaX <= range and deltaY <= range then
		local actId = self.originData.activityId

		Activity109Rpc.instance:sendAct109UseItemRequest(actId, x, y, self.onReceiveReply, self)
	end
end

function ActivityChessStateUseItem:onReceiveReply(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetCenterHintText, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, self)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.SetItem)
end

function ActivityChessStateUseItem:hideAttractEffect()
	local interactId = self.originData.interactId
	local interactMgr = ActivityChessGameController.instance.interacts
	local interactObj = interactMgr:get(interactId)

	if interactObj and interactObj.goToObject then
		interactObj.goToObject:setMarkAttract(false)
	end
end

function ActivityChessStateUseItem:dispose()
	self:hideAttractEffect()
	TaskDispatcher.cancelTask(self.delayCallChoosePos, self)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetCenterHintText, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ActivityChessStateUseItem.super.dispose(self)
end

return ActivityChessStateUseItem
