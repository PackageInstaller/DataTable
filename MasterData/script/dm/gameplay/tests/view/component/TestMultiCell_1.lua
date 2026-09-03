-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/component/TestMultiCell_1.lua

TestMultiCell_1 = class("TestMultiCell_1", DmBaseUI)

local kBtnHandlers = {}

function TestMultiCell_1:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TestMultiCell_1:update(data, index)
	return
end

function TestMultiCell_1:intiView()
	return
end
