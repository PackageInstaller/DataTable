-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/component/TestCell.lua

TestCell = class("TestCell", DmBaseUI)

local kBtnHandlers = {}

function TestCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TestCell:update(data, index)
	self._title:setString(data.title)
end

function TestCell:intiView()
	self._title = self:getChildView("Text_des")
end
