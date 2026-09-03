-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarWarningMediator.lua

PlaneWarWarningMediator = class("PlaneWarWarningMediator", DmPopupViewMediator, _M)

function PlaneWarWarningMediator:initialize()
	super.initialize(self)
end

function PlaneWarWarningMediator:enterWithData(data)
	local bgNode = self:getView():getChildByFullName("main.bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onContinueClicked, self),
		title = Strings:get("442180b0_e279_11e8_8709_7c04d0d9796c")
	})

	local mainPanel = self:getView():getChildByFullName("main")
end

function PlaneWarWarningMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function PlaneWarWarningMediator:bindWidgets()
	self:bindWidget("main.okbtn", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})
end

function PlaneWarWarningMediator:onOkClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
