-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestLuaProfilerMediator.lua

TestLuaProfilerMediator = class("TestLuaProfilerMediator", DmPopupViewMediator)

TestLuaProfilerMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TestLuaProfilerMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {}

function TestLuaProfilerMediator:initialize()
	super.initialize(self)
	LuaProfilerUtils.startLuaProfiler()
end

function TestLuaProfilerMediator:dispose()
	super.dispose(self)
end

function TestLuaProfilerMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function TestLuaProfilerMediator:mapEventListeners()
	return
end

function TestLuaProfilerMediator:enterWithData(data)
	self:setupView()
	LuaProfilerUtils.stopLuaProfiler({
		key = "TestLuaProfiler"
	})
end

function TestLuaProfilerMediator:setupView()
	self._des = self:getChildView("Panel_base.Text_des")

	self._des:setString("测算对象初始化到最后显示到界面上的性能分析情况,测试结果已经上传至：http://192.168.1.79/logs/")
end
