-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/interacts/YaXianInteractTriggerFailHandle.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractTriggerFailHandle", package.seeall)

local YaXianInteractTriggerFailHandle = class("YaXianInteractTriggerFailHandle", YaXianInteractHandleBase)

function YaXianInteractTriggerFailHandle:init(targetObj)
	YaXianInteractTriggerFailHandle.super.init(self, targetObj)

	self._enableAlarm = true
end

function YaXianInteractTriggerFailHandle:onDrawAlert(map)
	if not self._enableAlarm then
		return
	end

	local curX, curY = self._target.originData.posX, self._target.originData.posY

	YaXianInteractTriggerFailHandle.insertToAlertMap(map, curX + 1, curY)
	YaXianInteractTriggerFailHandle.insertToAlertMap(map, curX - 1, curY)
	YaXianInteractTriggerFailHandle.insertToAlertMap(map, curX, curY + 1)
	YaXianInteractTriggerFailHandle.insertToAlertMap(map, curX, curY - 1)
end

function YaXianInteractTriggerFailHandle.insertToAlertMap(map, x, y)
	if YaXianGameController.instance:posCanWalk(x, y) then
		map[x] = map[x] or {}
		map[x][y] = true
	end
end

function YaXianInteractTriggerFailHandle:moveTo(x, y, callback, callbackObj)
	self._enableAlarm = false

	YaXianInteractTriggerFailHandle.super.moveTo(self, x, y, callback, callbackObj)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function YaXianInteractTriggerFailHandle:onMoveCompleted()
	YaXianInteractTriggerFailHandle.super.onMoveCompleted(self)

	self._enableAlarm = true

	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function YaXianInteractTriggerFailHandle:onAvatarLoaded()
	YaXianInteractTriggerFailHandle.super.onAvatarLoaded(self)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function YaXianInteractTriggerFailHandle:dispose()
	self._enableAlarm = false

	YaXianInteractTriggerFailHandle.super.dispose(self)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

return YaXianInteractTriggerFailHandle
