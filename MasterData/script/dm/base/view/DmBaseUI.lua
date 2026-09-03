-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmBaseUI.lua

DmBaseUI = class("DmBaseUI", objectlua.Object)

DmBaseUI:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function DmBaseUI:initialize(data)
	super.initialize(self)

	if data then
		self:setView(data.view)
	end
end

function DmBaseUI:getView()
	return self._view
end

function DmBaseUI:getViewName()
	return self._viewName
end

function DmBaseUI:setView(viewComponent)
	self._view = viewComponent
	self._viewName = nil

	if viewComponent ~= nil and viewComponent.getViewName ~= nil then
		self._viewName = viewComponent:getViewName()
	end
end

function DmBaseUI:getChildView(fullname)
	return self._view and self._view:getChildByFullName(fullname)
end

function DmBaseUI:dispatch(event)
	local eventDispatcher = self:getEventDispatcher()

	if eventDispatcher ~= nil then
		return eventDispatcher:dispatchEvent(event)
	end
end

function DmBaseUI:mapButtonHandlerClick(buttonName, handler, view)
	mapButtonHandlerClick(self, buttonName, handler, view)
end

function DmBaseUI:mapButtonHandlersClick(buttonsConfig, view)
	for buttonName, handler in pairs(buttonsConfig) do
		self:mapButtonHandlerClick(buttonName, handler, view)
	end
end
