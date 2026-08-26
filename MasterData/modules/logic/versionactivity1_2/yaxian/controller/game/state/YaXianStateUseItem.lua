-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/state/YaXianStateUseItem.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateUseItem", package.seeall)

local YaXianStateUseItem = class("YaXianStateUseItem", YaXianStateBase)

function YaXianStateUseItem:start()
	logError("Ya Xian use Item, not realize")
end

function YaXianStateUseItem:onOpenViewFinish(viewName)
	if viewName == ViewName.ActivityChessGame then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
		self:startNotifyView()
	end
end

function YaXianStateUseItem:startNotifyView()
	local interactId = self.originData.interactId
	local range = self.originData.range

	if not range or not interactId then
		logError("YaXianStateUseItem range = " .. tostring(range) .. ", interactId = " .. tostring(interactId))

		return
	end

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

function YaXianStateUseItem:packEventObjs(posX, posY, range)
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = posX,
		selfPosY = posY
	}

	for x = posX - range, posX + range do
		for y = posY - range, posY + range do
			if self:checkCanThrow(posX, posY, x, y) then
				table.insert(evtObj.posXList, x)
				table.insert(evtObj.posYList, y)
			end
		end
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, evtObj)
end

function YaXianStateUseItem:checkCanThrow(srcX, srcY, tarX, tarY)
	if srcX ~= tarX or srcY ~= tarY then
		return ActivityChessGameController.instance:posCanWalk(tarX, tarY)
	end

	return false
end

function YaXianStateUseItem:onClickPos(x, y)
	if not self._centerX then
		logError("YaXianStateUseItem no interact pos found !")

		return
	end

	local range = self.originData.range
	local deltaX, deltaY = math.abs(x - self._centerX), math.abs(y - self._centerY)

	if self:checkCanThrow(self._centerX, self._centerY, x, y) and deltaX <= range and deltaY <= range then
		local actId = self.originData.activityId

		Activity109Rpc.instance:sendAct109UseItemRequest(actId, x, y, self.onReceiveReply, self)
	end
end

function YaXianStateUseItem:onReceiveReply(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, self)
end

function YaXianStateUseItem:dispose()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	YaXianStateUseItem.super.dispose(self)
end

return YaXianStateUseItem
