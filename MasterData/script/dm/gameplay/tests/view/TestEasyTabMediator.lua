-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestEasyTabMediator.lua

TestEasyTabMediator = class("TestEasyTabMediator", DmPopupViewMediator)

TestEasyTabMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TestEasyTabMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {}

function TestEasyTabMediator:initialize()
	super.initialize(self)
end

function TestEasyTabMediator:dispose()
	super.dispose(self)
end

function TestEasyTabMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function TestEasyTabMediator:mapEventListeners()
	return
end

function TestEasyTabMediator:enterWithData(data)
	self:setupView()
end

function TestEasyTabMediator:setupView()
	self._panel_base = self:getChildView("Panel_base")
	self._button_one = self:getChildView("Panel_base.Button_one")
	self._button_two = self:getChildView("Panel_base.Button_two")
	self._button_three = self:getChildView("Panel_base.Button_three")

	local data = {}

	data.buttons = {
		self._button_one,
		self._button_two,
		self._button_three
	}
	data.buttonClick = self.tabClickByIndex
	data.delegate = self
	self._tabGroup = EasyTab:new(data)
end

function TestEasyTabMediator:tabClickByIndex(button, eventType, index)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = index .. "按钮被选中了"
	}))
end
