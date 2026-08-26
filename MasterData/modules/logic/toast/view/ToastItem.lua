-- chunkname: @modules/logic/toast/view/ToastItem.lua

module("modules.logic.toast.view.ToastItem", package.seeall)

local ToastItem = class("ToastItem", LuaCompBase)
local OutSidePos = 10000
local csTweenHelper = ZProj.TweenHelper

ToastItem.ToastType = {
	Achievement = 2,
	Season166 = 3,
	Normal = 1
}

function ToastItem:getGo()
	return self._go
end

function ToastItem:init(go)
	self._go = go
	self.tr = go.transform
	self._gonormal = gohelper.findChild(go, "#go_normal")
	self._txt = gohelper.findChildText(go, "#go_normal/content/contentText")
	self._icon = gohelper.findChildImage(go, "#go_normal/icon")
	self._sicon = gohelper.findChildSingleImage(go, "#go_normal/sicon")
	self._goachievement = gohelper.findChild(go, "#go_achievement")
	self._goseason166 = gohelper.findChild(go, "#go_season166")
	self.canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._duration = 0.5
	self._animDuration = self._duration * 2
	self.height = recthelper.getHeight(self.tr)
	self.width = recthelper.getWidth(self.tr)
	self.startAnchorPositionY = 0
end

function ToastItem:setMsg(msg)
	self._toastId = msg.co and msg.co.id
	self.msg = msg
	self.canvasGroup.alpha = 1
	self._txt.text = self:getTip()

	self:setToastType(ToastItem.ToastType.Normal)

	if not msg.co.icon or msg.co.icon == 0 or not string.nilorempty(msg.sicon) then
		gohelper.setActive(self._icon.gameObject, false)
	else
		gohelper.setActive(self._icon.gameObject, true)
		UISpriteSetMgr.instance:setToastSprite(self._icon, tostring(msg.co.icon), false)
	end

	if string.nilorempty(msg.sicon) then
		gohelper.setActive(self._sicon.gameObject, false)
	else
		gohelper.setActive(self._sicon.gameObject, true)
		self._sicon:LoadImage(msg.sicon)
	end

	if self.msg and self.msg.callbackGroup then
		self.msg.callbackGroup:tryOnOpen(self)
	end
end

function ToastItem:_delay()
	ToastController.instance:dispatchEvent(ToastEvent.RecycleToast, self)
end

function ToastItem:appearAnimation()
	if self.msg and self.msg.co.audioId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end

	recthelper.setAnchorX(self.tr, self.width)
	csTweenHelper.KillById(self.startTweenId or -1)

	self.startTweenId = csTweenHelper.DOAnchorPosX(self.tr, 0, self._duration, function()
		self.startTweenId = nil

		local showTime = ToastController.instance:getShowTime(self._toastId) - self._animDuration

		TaskDispatcher.runDelay(self._delay, self, showTime)
	end)
end

function ToastItem:upAnimation(targetPosY)
	csTweenHelper.KillById(self.upTweenId or -1)

	self.upTweenId = csTweenHelper.DOAnchorPosY(self.tr, targetPosY, self._duration, function()
		self.upTweenId = nil
	end)
end

function ToastItem:quitAnimation(quitAnimationDoneCallback, callbackObj)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.quitAnimationDoneCallback = quitAnimationDoneCallback
	self.callbackObj = callbackObj
	self.startAnchorPositionY = self.tr.anchoredPosition.y
	self.quitTweenId = csTweenHelper.DOTweenFloat(1, 0, self._duration, self.quitAnimationFrame, self.quitAnimationDone, self)
end

function ToastItem:quitAnimationFrame(value)
	local upPositionY = (1 - value) * ((not ToastParamEnum.ToastHeight[self._toastId] or nil) and self.height)

	recthelper.setAnchorY(self.tr, self.startAnchorPositionY + upPositionY)

	self.canvasGroup.alpha = value
end

function ToastItem:quitAnimationDone()
	if self.msg and self.msg.callbackGroup then
		self.msg.callbackGroup:tryOnClose(self)
	end

	if self.quitAnimationDoneCallback then
		self.quitAnimationDoneCallback(self.callbackObj, self)
	end

	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
	self.quitTweenId = nil
end

function ToastItem:clearAllTask()
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

function ToastItem:setToastType(toastType)
	if toastType == ToastItem.ToastType.Normal then
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._goachievement, false)
		gohelper.setActive(self._goseason166, false)
	elseif toastType == ToastItem.ToastType.Achievement then
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._goachievement, true)
		gohelper.setActive(self._goseason166, false)
	elseif toastType == ToastItem.ToastType.Season166 then
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._goachievement, false)
		gohelper.setActive(self._goseason166, true)
	end
end

function ToastItem:getToastRootByType(toastType)
	if toastType == ToastItem.ToastType.Normal then
		return self._gonormal
	elseif toastType == ToastItem.ToastType.Achievement then
		return self._goachievement
	elseif toastType == ToastItem.ToastType.Season166 then
		return self._goseason166
	end
end

function ToastItem:getTip()
	return self.msg.extra and #self.msg.extra > 0 and GameUtil.getSubPlaceholderLuaLang(self.msg.co.tips, self.msg.extra) or self.msg.co.tips
end

function ToastItem:reset()
	self.msg = nil
	self.startAnchorPositionY = 0

	recthelper.setAnchor(self.tr, OutSidePos, OutSidePos)
end

function ToastItem:onDestroy()
	self._sicon:UnLoadImage()
	self:clearAllTask()
end

return ToastItem
