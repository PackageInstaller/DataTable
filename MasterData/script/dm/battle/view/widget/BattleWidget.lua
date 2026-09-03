-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleWidget.lua

BattleWidget = class("BattleWidget", DisposableObject, _M)

function BattleWidget:initialize(view)
	super.initialize(self)
	assert(view ~= nil, "`view` must NOT be nil")

	self._view = view
end

function BattleWidget:dispose()
	super.dispose(self)
end

function BattleWidget:getView()
	return self._view
end

function BattleWidget:setVisible(visible)
	if self._view then
		self._view:setVisible(visible)
	end
end

function BattleWidget:isVisible()
	return self._view and self._view:isVisible()
end
