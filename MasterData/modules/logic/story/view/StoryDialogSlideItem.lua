-- chunkname: @modules/logic/story/view/StoryDialogSlideItem.lua

module("modules.logic.story.view.StoryDialogSlideItem", package.seeall)

local StoryDialogSlideItem = class("StoryDialogSlideItem")

function StoryDialogSlideItem:init(go)
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryView)
	local itemPath = viewContainer:getSetting().otherRes[3]

	self._dialogGo = viewContainer:getResInst(itemPath, go)
	self._simagedialog = gohelper.findChildSingleImage(self._dialogGo, "#simage_dialog")
	self._imagedialog = gohelper.findChildImage(self._dialogGo, "#simage_dialog")
end

function StoryDialogSlideItem:clearSlideDialog()
	self._callback = nil
	self._callbackObj = nil
end

function StoryDialogSlideItem:startShowDialog(data, callback, callbackObj)
	local imgPath = ResUrl.getStoryLangPath(data.img)

	self._speed = data.speed
	self._showTime = data.showTime
	self._callback = callback
	self._callbackObj = callbackObj

	gohelper.setActive(self._dialogGo, true)
	self._simagedialog:LoadImage(imgPath, self._imgLoaded, self)
end

function StoryDialogSlideItem:hideDialog()
	gohelper.setActive(self._dialogGo, false)
	self._simagedialog:UnLoadImage()
end

function StoryDialogSlideItem:_imgLoaded()
	gohelper.setActive(self._imagedialog.gameObject, false)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(self._imagedialog.gameObject, true)
		self._imagedialog:SetNativeSize()
		self:_startMove()
	end, nil, 0.05)
end

function StoryDialogSlideItem:_moveUpdate(value)
	local _, posY = transformhelper.getLocalPos(self._simagedialog.transform)

	transformhelper.setLocalPosXY(self._simagedialog.transform, value, posY)
end

function StoryDialogSlideItem:_startMove()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local width = recthelper.getWidth(self._simagedialog.transform)
	local screenWidth = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local from = 0.5 * (screenWidth + width)
	local time = self._showTime
	local to = from - 0.2 * (screenWidth + width) * self._speed * time

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(from, to, time, self._moveUpdate, self._moveDone, self, nil, EaseType.Linear)
end

function StoryDialogSlideItem:_moveDone()
	if self._callback then
		self._callback(self._callbackObj)
	end

	TaskDispatcher.runDelay(self._startMove, self, 3)
end

function StoryDialogSlideItem:destroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._startMove, self)
	self._simagedialog:UnLoadImage()
end

return StoryDialogSlideItem
