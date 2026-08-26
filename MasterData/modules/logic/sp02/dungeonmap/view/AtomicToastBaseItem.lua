-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicToastBaseItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicToastBaseItem", package.seeall)

local AtomicToastBaseItem = class("AtomicToastBaseItem", LuaCompBase)
local OutSidePos = 10000
local csTweenHelper = ZProj.TweenHelper

function AtomicToastBaseItem:ctor(param)
	self.toastView = param.toastView
	self.notSetX = false
end

function AtomicToastBaseItem:init(go)
	self:__onInit()

	self.width = 0
	self.height = 0
	self.go = go
	self.trans = go.transform
	self.canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._duration = 0.3
	self._showToastDuration = 1.5
	self.startAnchorPositionY = 0
	self.itemDefaultHeight = 80
end

function AtomicToastBaseItem:addEventListeners()
	return
end

function AtomicToastBaseItem:removeEventListeners()
	return
end

function AtomicToastBaseItem:setMsg(msg)
	self.canvasGroup.alpha = 1

	ZProj.UGUIHelper.RebuildLayout(self.trans)

	self.width = recthelper.getWidth(self.trans)
	self.height = recthelper.getHeight(self.trans)

	gohelper.setActive(self.go, true)
	self:refreshUI(msg)
end

function AtomicToastBaseItem:refreshUI(type)
	return
end

function AtomicToastBaseItem:_delay()
	return
end

function AtomicToastBaseItem:appearAnimation()
	gohelper.setActive(self.go, false)
	gohelper.setActive(self.go, true)
	self:setInitPosX()
	csTweenHelper.KillById(self.startTweenId or -1)

	self.startTweenId = csTweenHelper.DOAnchorPosX(self.trans, 0, self._duration, function()
		self.startTweenId = nil

		TaskDispatcher.runDelay(self._delay, self, self._showToastDuration)
	end)
end

function AtomicToastBaseItem:setInitPosX()
	recthelper.setAnchorX(self.trans, self.notSetX and 0 or self.width)
end

function AtomicToastBaseItem:upAnimation(targetPosY)
	csTweenHelper.KillById(self.upTweenId or -1)

	self.upTweenId = csTweenHelper.DOAnchorPosY(self.trans, targetPosY, self._duration, function()
		self.upTweenId = nil
	end)
end

function AtomicToastBaseItem:quitAnimation(quitAnimationDoneCallback, callbackObj)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.quitAnimationDoneCallback = quitAnimationDoneCallback
	self.callbackObj = callbackObj
	self.startAnchorPositionY = self.trans.anchoredPosition.y
	self.quitTweenId = csTweenHelper.DOTweenFloat(1, 0, self._duration, self.quitAnimationFrame, self.quitAnimationDone, self)
end

function AtomicToastBaseItem:quitAnimationFrame(value)
	local upPositionY = (1 - value) * self.height

	recthelper.setAnchorY(self.trans, self.startAnchorPositionY + upPositionY)

	self.canvasGroup.alpha = value
end

function AtomicToastBaseItem:quitAnimationDone()
	if self.quitAnimationDoneCallback then
		self.quitAnimationDoneCallback(self.callbackObj, self)
	end

	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
	self.quitTweenId = nil
end

function AtomicToastBaseItem:clearAllTask()
	TaskDispatcher.cancelTask(self._delay, self)
	csTweenHelper.KillById(self.startTweenId or -1)
	csTweenHelper.KillById(self.upTweenId or -1)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.startTweenId = nil
	self.upTweenId = nil
	self.quitTweenId = nil
	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
end

function AtomicToastBaseItem:reset()
	self.startAnchorPositionY = 0

	recthelper.setAnchor(self.trans, self.notSetX and 0 or OutSidePos, OutSidePos)
end

function AtomicToastBaseItem:getHeight()
	return (self.height > 0 or nil) and (self.height or self.itemDefaultHeight)
end

function AtomicToastBaseItem:onDestroy()
	self:clearAllTask()
end

return AtomicToastBaseItem
