-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIMailView.lua

module("logic.extensions.mainui.view.MainUIMailView", package.seeall)

local M = class("MainUIMailView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goRoot = self:getGo("main_view_-284326696")
	self._canvasGroup = goutil.addComponentOnce(self._goRoot, ComponentType.CanvasGroup)
	self._canvasGroup.alpha = 0
	self._animation = self._goRoot:GetComponent(ComponentType.Animation)
	self._animation.playAutomatically = false

	goutil.setActive(self._goRoot, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonType)
	local isNormalOpen = not self._viewPresentor:getIsBackOpen() and reasonTyp ~= WindowType.WindowOpenReasonType.QuickOpenType

	self._isEnter = true

	self:_setEvent(true)

	if not isNormalOpen and self._goRoot.activeSelf then
		self._animation:Play("newmailtips_anim")
	end
end

function M:onExit(reasonType)
	self._isEnter = false

	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_NOTIFY_MAIL_CHANGE, self._checkShow, self)
		GlobalDispatcher:addEventListener(EventType.ON_MAIN_POP_UP_FINISH, self._handleMainPopUpFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_NOTIFY_MAIL_CHANGE, self._checkShow, self)
		GlobalDispatcher:removeEventListener(EventType.ON_MAIN_POP_UP_FINISH, self._handleMainPopUpFinish, self)
	end
end

function M:_handleMainPopUpFinish()
	self:_checkShow()
end

function M:_checkShow()
	if not self._isEnter then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Mail, false) then
		self:setRootActive(false)

		return
	end

	local isActive = false

	if MainUIModel.instance:getShowMailTips() then
		if MailMoList.instance:isCurMailListInit() then
			isActive = MainUIController.instance:getNotifyMailCount() > 0
		else
			isActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.Mail)
		end
	end

	self:setRootActive(isActive)
end

function M:_onClickClose()
	self:setRootActive(false)
	MainUIModel.instance:setShowMailTips(false)
end

function M:setRootActive(active)
	if not self._isEnter then
		return
	end

	active = active and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Mail, false)

	local orgActive = self._goRoot.activeSelf

	goutil.setActive(self._goRoot, active)

	if active and orgActive ~= active then
		self._animation:Play("newmailtips_anim")
	end
end

return M
