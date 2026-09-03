-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleItemMediator.lua

BattleItemMediator = class("BattleItemMediator", PopupViewMediator, _M)

function BattleItemMediator:initialize()
	super.initialize(self)
end

function BattleItemMediator:dispose()
	super.dispose(self)
end

function BattleItemMediator:onRegister()
	super.onRegister(self)
end

function BattleItemMediator:onTouchMaskLayer()
	return
end

function BattleItemMediator:close()
	if self._closeCallBack then
		self._closeCallBack()
	end

	super.close(self)
end

function BattleItemMediator:enterWithData(data)
	self:getView():setVisible(false)

	local data = data.paseSta
	local handler = data.handler
	local cardArray = handler:getCardArray()

	cardArray:FlyCard(function()
		if not DisposableObject:isDisposed(self) then
			self:close()
		end
	end)
end
