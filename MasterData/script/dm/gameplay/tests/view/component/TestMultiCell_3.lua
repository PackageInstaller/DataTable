-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/component/TestMultiCell_3.lua

TestMultiCell_3 = class("TestMultiCell_3", DmBaseUI)

local kBtnHandlers = {}

function TestMultiCell_3:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TestMultiCell_3:update(data, index)
	return
end

function TestMultiCell_3:intiView()
	return
end
