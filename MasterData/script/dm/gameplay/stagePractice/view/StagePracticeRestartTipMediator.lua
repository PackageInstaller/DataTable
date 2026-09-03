-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeRestartTipMediator.lua

StagePracticeRestartTipMediator = class("StagePracticeRestartTipMediator", DmPopupViewMediator, _M)

function StagePracticeRestartTipMediator:initialize()
	super.initialize(self)
end

function StagePracticeRestartTipMediator:enterWithData(data)
	local bgNode = self:getView():getChildByFullName("main.image_bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onContinueClicked, self),
		title = Strings:get("MiniPlane_Ticket_Buy"),
		bgSize = {
			width = 547,
			height = 407
		}
	})

	local mainPanel = self:getView():getChildByFullName("main")
end

function StagePracticeRestartTipMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function StagePracticeRestartTipMediator:bindWidgets()
	self:bindWidget("main.ok_btn", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})
end

function StagePracticeRestartTipMediator:onContinueClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)
	end
end

function StagePracticeRestartTipMediator:onLeaveClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onLeave then
		self._popupDelegate:onLeave(self)
	end
end
