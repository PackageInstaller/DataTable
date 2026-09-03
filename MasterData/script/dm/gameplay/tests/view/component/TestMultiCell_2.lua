-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/component/TestMultiCell_2.lua

TestMultiCell_2 = class("TestMultiCell_2", DmBaseUI)

local kBtnHandlers = {
	Button_one = "onClickButton"
}

function TestMultiCell_2:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TestMultiCell_2:update(data, index)
	return
end

function TestMultiCell_2:intiView()
	return
end

function TestMultiCell_2:onClickButton()
	self:dispatch(ShowTipEvent({
		tip = "按钮被点击",
		duration = 0.5
	}))
end
