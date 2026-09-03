-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/BaseWidget.lua

BaseWidget = class("BaseWidget", _G.DisposableObject)

function BaseWidget:initialize(view)
	super.initialize(self)
	assert(view ~= nil, "`view` must NOT be nil")

	self._view = view
end

function BaseWidget:dispose()
	self._view = nil

	super.dispose(self)
end

function BaseWidget:autoDispose()
	if self._view then
		self._view:atExit(function()
			self:dispose()
		end)
	end

	return self
end

function BaseWidget:getView()
	return self._view
end

function BaseWidget:getChildView(fullname)
	return self._view and self._view:getChildByFullName(fullname)
end

function BaseWidget:setVisible(visible)
	if self._view then
		self._view:setVisible(visible)
	end
end

function BaseWidget:isVisible()
	return self._view and self._view:isVisible()
end
