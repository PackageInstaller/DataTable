-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestClippingNodeMediator.lua

TestClippingNodeMediator = class("TestClippingNodeMediator", DmPopupViewMediator)

TestClippingNodeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TestClippingNodeMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {}

function TestClippingNodeMediator:initialize()
	super.initialize(self)
end

function TestClippingNodeMediator:dispose()
	super.dispose(self)
end

function TestClippingNodeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function TestClippingNodeMediator:mapEventListeners()
	return
end

function TestClippingNodeMediator:enterWithData(data)
	self:setupView()
end

function TestClippingNodeMediator:setupView()
	ClippingNodeUtils.transformToClippingNodeByUI(self:getChildView("Panel_base.Node_needClipping"), 0.98)
end
