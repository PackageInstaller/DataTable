-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/viewblackfade/controller/ViewBlackFadeController.lua

module("logic.extensions.viewblackfade.controller.ViewBlackFadeController", package.seeall)

local M = class("ViewBlackFadeController", BaseController)
local WindowOpenReasonType = WindowType.WindowOpenReasonType
local WindowCloseReasonType = WindowType.WindowCloseReasonType

M.FADE_TYP = {
	FadeOut = 3,
	FadeIn = 2,
	None = 1
}

function M:ctor()
	self._viewBlackFadeGadget = nil
	self._colorBlack = parsecolor("#000000")
	self._colorBlackFade = parsecolor("#00000000")
end

function M:onInit()
	self:onReset()
	self:_setEvent(true)
	self:_tryCreateBackFade()
end

function M:onLateInit()
	return
end

function M:onReset()
	if self._viewBlackFadeGadget then
		self._viewBlackFadeGadget:DOKill(false)
	end

	self:setActive(false)
	self:setCurFadeTyp(self.FADE_TYP.None)
	removetimer(self._timerCheckHide, self)

	self._timeContinueShow = 0
	self._fadeOpenView = nil
	self._autoHide = false
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_WILL_OPEN_EVENT, self._handleViewWillOpenEvent, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._handleViewOpeningEvent, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewOpenOverEvent, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._handleViewClosingEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_WILL_OPEN_EVENT, self._handleViewWillOpenEvent, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, self._handleViewOpeningEvent, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewOpenOverEvent, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._handleViewClosingEvent, self)
	end
end

function M:_handleViewWillOpenEvent(e, viewName, opTyp, isBackOpen)
	if not isBackOpen and self:getNeedBlackFade(viewName) then
		local info = ViewBlackFadeEnum.getAllInfo(viewName)

		if info.typ == ViewBlackFadeEnum.TYP.ALL or info.typ == ViewBlackFadeEnum.TYP.FADE_OPEN then
			local duration = info.openFadeInTime or ViewBlackFadeEnum.Default.openFadeInTime

			self._fadeOpenView = viewName

			self:showGadget(false, duration, nil, nil, string.format("%s (willOpen)", viewName))
		end
	end
end

function M:_handleViewOpeningEvent(e, viewName, opTyp, isBackOpen)
	if self:getNeedBlackFade(viewName) and self:getIsActive() then
		local info = ViewBlackFadeEnum.getAllInfo(viewName)

		if info.typ == ViewBlackFadeEnum.TYP.ALL or info.typ == ViewBlackFadeEnum.TYP.FADE_OPEN then
			local duration = info.openFadeOutTime or ViewBlackFadeEnum.Default.openFadeOutTime
			local delay = info.openDelay or ViewBlackFadeEnum.Default.openDelay

			if self:isCurFadeTypEqual(self.FADE_TYP.None) then
				self:hideGadget(duration, delay, string.format("%s (opening)", viewName))
			else
				self._autoHide = true
				self._autoHideDuration = duration
				self._autoHideDelay = delay

				self:_print(string.format("[触发autoHide] %s (opening)", viewName))
			end
		end
	end
end

function M:_handleViewOpenOverEvent(e, viewName, opTyp)
	if self:getNeedBlackFade(viewName) and self:getIsActive() then
		local info = ViewBlackFadeEnum.getAllInfo(viewName)

		if info.typ == ViewBlackFadeEnum.TYP.ALL or info.typ == ViewBlackFadeEnum.TYP.FADE_OPEN then
			local duration = info.openFadeOutTime or ViewBlackFadeEnum.Default.openFadeOutTime
			local delay = info.openDelay or ViewBlackFadeEnum.Default.openDelay

			if self:isCurFadeTypEqual(self.FADE_TYP.None) then
				self:hideGadget(duration, delay, string.format("%s (open over)", viewName))
			else
				self._autoHide = true
				self._autoHideDuration = duration
				self._autoHideDelay = delay

				self:_print(string.format("[触发autoHide] %s (open over)", viewName))
			end
		end
	end
end

function M:_handleViewClosingEvent(e, viewName, opTyp, windowCloseReasonType)
	if not self:getNeedBlackFade(viewName) then
		return
	end

	if windowCloseReasonType == WindowCloseReasonType.QuickCloseType then
		self:_print(string.format("[show阻断] 快速关闭类型，不需要黑底过渡 %s, cacheOpen:%s", viewName, self._fadeOpenView))

		return
	end

	local info = ViewBlackFadeEnum.getAllInfo(viewName)

	if (info.typ == ViewBlackFadeEnum.TYP.ALL or info.typ == ViewBlackFadeEnum.TYP.FADE_CLOSE) and (not self._fadeOpenView or self._fadeOpenView == viewName) then
		self._autoHideDuration = info.closeFadeOutTime or ViewBlackFadeEnum.Default.closeFadeOutTime
		self._autoHideDelay = info.closeDelay or ViewBlackFadeEnum.Default.closeDelay

		local duration = info.closeFadeInTime or ViewBlackFadeEnum.Default.closeFadeInTime

		self:showGadget(true, duration, nil, nil, string.format("%s (closing)", viewName))
	end
end

function M:getNeedBlackFade(viewName)
	return ViewBlackFadeEnum.getNeedBlackFade(viewName)
end

function M:getIsActive()
	return self._activeState
end

function M:setActive(active)
	self._activeState = active

	if self._viewBlackFadeGadget then
		goutil.setActive(self._viewBlackFadeGadget.gameObject, active)
	end
end

function M:_tryCreateBackFade()
	if self._viewBlackFadeGadget then
		return
	end

	local go = goutil.create("ViewBlackFadeGadget")

	self._activeState = false

	goutil.setActive(go, self._activeState)

	local root = ViewMgr.instance:getRoot(ViewRootType.Top)

	goutil.addChildToParent(go, root)

	local rect = go.transform

	rect.anchorMin = UnityEngine.Vector2.zero
	rect.anchorMax = UnityEngine.Vector2.one
	rect.offsetMin = UnityEngine.Vector2.New(-150, -150)
	rect.offsetMax = UnityEngine.Vector2.New(150, 150)
	self._viewBlackFadeGadget = goutil.addComponentOnce(go, typeof(UnityEngine.UI.Image))
	self._viewBlackFadeGadget.color = self._colorBlack
end

function M:showGadget(autoHide, duration, callBack, callBackHandler, msg, _autoHideDuration, _autoHideDelay)
	local canShow = true

	if not self._viewBlackFadeGadget then
		canShow = false
	end

	if self:isCurFadeTypEqual(self.FADE_TYP.FadeIn) then
		self:_print(string.format("[show阻断] 当前fadeType已是FadeIn,不执行[show],msg:%s", msg))

		canShow = false
	end

	if not canShow then
		self:_invokeCB(callBack, callBackHandler)

		return
	end

	duration = duration or ViewBlackFadeEnum.Default.openFadeInTime

	self:setCurFadeTyp(self.FADE_TYP.FadeIn, msg)

	self._autoHide = autoHide

	if autoHide then
		self._autoHideDuration = _autoHideDuration
		self._autoHideDelay = _autoHideDelay
	end

	local finalAlpha = 1

	self._viewBlackFadeGadget:DOKill(false)
	settimer(duration, function()
		self:_invokeCB(callBack, callBackHandler)
	end, self, false)
	self:setActive(true)
	self:_print(string.format("[show] time[%s] autoHide[%s] msg:%s", duration, autoHide, msg))
	self._viewBlackFadeGadget:DOFade(finalAlpha, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._onFadeInFinish, self)
end

function M:hideGadget(duration, delay, msg)
	if not self._viewBlackFadeGadget then
		return
	end

	if self:isCurFadeTypEqual(self.FADE_TYP.FadeOut) then
		self:_print(string.format("[hide阻断] 当前fadeType已是FadeOut,不执行[hide],msg:%s", msg))

		return
	end

	duration = duration or ViewBlackFadeEnum.Default.openFadeOutTime
	delay = delay or ViewBlackFadeEnum.Default.openDelay

	self:setCurFadeTyp(self.FADE_TYP.FadeOut, msg)

	local finalAlpha = 0

	self._viewBlackFadeGadget:DOKill(false)
	self:setActive(true)
	self:_print(string.format("[hide] time[%s] delay[%s] msg:%s", duration, delay, msg))
	self._viewBlackFadeGadget:DOFade(finalAlpha, duration):SetDelay(delay):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._onFadeOutFinish, self)
end

function M:_onFadeInFinish()
	local msg = string.format("[onFadeInFinish] autoHide:%s, lastMsg:%s", self._autoHide, self._setFadeTypMsg)

	self:_print(msg)
	GlobalDispatcher:dispatchEvent(EventType.ON_VIEW_BLACK_FADE_FINISH, true)

	if self._autoHide then
		self:hideGadget(self._autoHideDuration, self._autoHideDelay, "autoHide")
	else
		self:setCurFadeTyp(self.FADE_TYP.None, msg)
	end
end

function M:_onFadeOutFinish()
	self:_print(string.format("[onFadeOutFinish]"))

	self._viewBlackFadeGadget.color = self._colorBlackFade

	self:setActive(false)
	GlobalDispatcher:dispatchEvent(EventType.ON_VIEW_BLACK_FADE_FINISH, false)
	self:setCurFadeTyp(self.FADE_TYP.None)
end

function M:_invokeCB(callBack, callBackHandler)
	if callBack then
		if callBackHandler then
			callBack(callBackHandler)
		else
			callBack()
		end
	end
end

function M:_print(msg)
	if enableLog then
		printWarn(string.format("[黑底] %s", msg), debug.traceback())
	end
end

function M:printStatus()
	local status

	if self._viewBlackFadeGadget then
		status = self._viewBlackFadeGadget.gameObject.activeSelf
	end

	local msg = string.format("active[%s,%s] curFadeTyp[%s] cacheOpen[%s] contineShow[%s]", self._activeState, status, self:getCurFadeTyp(), self._fadeOpenView, self._timeContinueShow)

	self:_print(msg)

	return msg
end

function M:getCurFadeTyp()
	return self._curFadeTyp
end

function M:isCurFadeTypEqual(typ)
	return self:getCurFadeTyp() == typ
end

function M:setCurFadeTyp(typ, msg)
	self._curFadeTyp = typ
	self._timeContinueShow = 0
	self._setFadeTypMsg = msg

	settimer(1, self._timerCheckHide, self, false)
end

function M:_timerCheckHide()
	removetimer(self._timerCheckHide, self)

	local time = self._timeContinueShow or 0

	if self:getIsActive() then
		time = time + 1

		if time > 7 then
			time = 0

			printWarn("[黑底] 超时自动关闭,上次msg:", self._setFadeTypMsg)
			self:setCurFadeTyp(self.FADE_TYP.None)
			self:hideGadget(0.5, 0, "超时自动关闭")

			self._setFadeTypMsg = nil
		else
			settimer(1, self._timerCheckHide, self, false)
		end
	else
		time = 0
	end

	self._timeContinueShow = time
end

M.instance = M.New()

return M
