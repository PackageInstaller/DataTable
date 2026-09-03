-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/PopupViewMediator.lua

PopupViewMediator = class("PopupViewMediator", BaseViewMediator)

function PopupViewMediator:initialize()
	super.initialize(self)
end

function PopupViewMediator:dispose()
	super.dispose(self)
end

function PopupViewMediator:enterWithData(data)
	return
end

function PopupViewMediator:leaveWithData(data)
	self:close(data)
end

function PopupViewMediator:willStartEnterTransition(transition)
	return
end

function PopupViewMediator:didFinishEnterTransition(transition)
	return
end

function PopupViewMediator:willStartExitTransition(transition)
	return
end

function PopupViewMediator:didFinishExitTransition(transition)
	return
end

function PopupViewMediator:setPopupDelegate(delegate)
	self._popupDelegate = delegate
end

function PopupViewMediator:getPopupDelegate()
	return self._popupDelegate
end

function PopupViewMediator:onTouchMaskLayer()
	self:close()
end

function PopupViewMediator:getBoundingBox()
	local view = self:getView()

	return view:getBoundingBox()
end

function PopupViewMediator:close(data)
	return self:closeWithOptions(nil, data)
end

function PopupViewMediator:closeWithOptions(options, data)
	self:willBeClosed(data)

	if not DisposableObject:isDisposed(self) then
		local view = self:getView()

		view:dispatchEvent(ViewEvent:new(EVT_CLOSE_POPUP, view, options, data))
	end
end

function PopupViewMediator:willBeClosed(data)
	local delegate = self:getPopupDelegate()

	if delegate ~= nil and delegate.willClose ~= nil then
		delegate:willClose(self, data)
	end
end
