-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeTreasureUseSucMediator.lua

MazeTreasureUseSucMediator = class("MazeTreasureUseSucMediator", DmPopupViewMediator, _M)

MazeTreasureUseSucMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	touchmask = "onTouchPanel"
}

function MazeTreasureUseSucMediator:initialize()
	super.initialize(self)
end

function MazeTreasureUseSucMediator:dispose()
	super.dispose(self)
end

function MazeTreasureUseSucMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeTreasureUseSucMediator:dispose()
	super.dispose(self)
end

function MazeTreasureUseSucMediator:enterWithData(data)
	self._data = data

	self:initData()
	self:initViews()
end

function MazeTreasureUseSucMediator:initData()
	return
end

function MazeTreasureUseSucMediator:initViews()
	self._main = self:getView()
	self._name = self._main:getChildByFullName("bgs.bwname")
	self._desc = self._main:getChildByFullName("bgs.bweffect")

	self._name:setString(self._data.name)
	self._desc:setString(self._data.effect)
end

function MazeTreasureUseSucMediator:onTouchPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
