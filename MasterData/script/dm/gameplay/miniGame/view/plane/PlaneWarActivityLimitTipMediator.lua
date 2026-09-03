-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarActivityLimitTipMediator.lua

PlaneWarActivityLimitTipMediator = class("PlaneWarActivityLimitTipMediator", DmPopupViewMediator, _M)

function PlaneWarActivityLimitTipMediator:initialize()
	super.initialize(self)
end

function PlaneWarActivityLimitTipMediator:enterWithData(data)
	self._activityId = data.activityId

	local bgNode = self:getView():getChildByFullName("main.bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onContinueClicked, self),
		title = Strings:get("MiniPlaneText28")
	})
end

function PlaneWarActivityLimitTipMediator:activityClose(event)
	local data = event:getData()

	if data.activityId == self._activityId then
		self:close()
	end
end

function PlaneWarActivityLimitTipMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function PlaneWarActivityLimitTipMediator:bindWidgets()
	self:bindWidget("main.continue_btn", TwoLevelMainButton, {
		handler = bind1(self.onContinueClicked, self)
	})
	self:bindWidget("main.leave_btn", TwoLevelViceButton, {
		handler = bind1(self.onLeaveClicked, self)
	})
end

function PlaneWarActivityLimitTipMediator:onTouchMaskLayer()
	return
end

function PlaneWarActivityLimitTipMediator:onContinueClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)
		snkAudio.play("Se_Click_Common_2")
	end
end

function PlaneWarActivityLimitTipMediator:onLeaveClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onLeave then
		self._popupDelegate:onLeave(self)
		snkAudio.play("Se_Click_Common_2")
	end
end
