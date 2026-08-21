-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionLoginView.lua

module("logic.extensions.controlaction.view.ControlActionLoginView", package.seeall)

local M = class("ControlActionLoginView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnLogin = self:getBtn("regulatory_action_login_view_-318277420")
	self._normalGo = goutil.findChild(self.mainGO, "imgBg/imgNormal")
	self._secretGo = goutil.findChild(self.mainGO, "imgBg/imgSecret")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnLogin:AddClickListener(self._onClickLogin, self)
end

function M:unbindEvents()
	self._btnLogin:RemoveClickListener()
end

function M:onEnter()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.ControlAction)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_diaocha_guanzhixingdongdakai, nil, nil, nil)

	local isIn = AirtightRoomController.instance:getIsInAirtightTime()

	goutil.setActive(self._secretGo, isIn)
	goutil.setActive(self._normalGo, not isIn)
end

function M:onExit()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:onExitFinished()
	return
end

function M:_onClickLogin()
	return
end

function M:_handleViewAniDoneEvent(e, tagName, reason)
	if tagName == "open" then
		ViewMgr.instance:open(ViewName.ControlAction)
	end
end

return M
