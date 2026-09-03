-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarResultBuyTimesMediator.lua

PlaneWarResultBuyTimesMediator = class("PlaneWarResultBuyTimesMediator", DmPopupViewMediator, _M)

function PlaneWarResultBuyTimesMediator:initialize()
	super.initialize(self)
end

function PlaneWarResultBuyTimesMediator:enterWithData(data)
	local bgNode = self:getView():getChildByFullName("main.image_bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onContinueClicked, self),
		title = Strings:get("MiniPlane_Ticket_Buy")
	})

	local mainPanel = self:getView():getChildByFullName("main")
end

function PlaneWarResultBuyTimesMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function PlaneWarResultBuyTimesMediator:bindWidgets()
	self:bindWidget("main.ok_btn", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})
end

function PlaneWarResultBuyTimesMediator:onContinueClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)
	end
end

function PlaneWarResultBuyTimesMediator:onLeaveClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onLeave then
		self._popupDelegate:onLeave(self)
	end
end
