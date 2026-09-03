-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/MinusView.lua

MinusView = class("MinusView", DisposableObject, _M)

function MinusView:initialize(view, callFunc, callBackParam)
	self._viewNode = view.node
	self._numText = view.numText or view.node:getChildByFullName("num")
	self._useCount = callBackParam.useCount or 0
	self._maxCount = callBackParam.maxCount or 0
	self._callBack = callFunc
	self._this = callBackParam.this
	self._callBackParam = callBackParam
	self._isSingleClick = true

	self._viewNode:setVisible(false)

	if self._numText then
		self._numText:setString(self._useCount)
	end
end

function MinusView:registerMinusEventListener(minusBtn, callFunc)
	minusBtn:setTouchEnabled(true)
	minusBtn:addTouchEventListener(callFunc or function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:onTouchBeganEvent(false)
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			self:onTouchEndedEvent(false)
		end
	end)
end

function MinusView:registerPlusEventListener(plusBtn, callFunc)
	plusBtn:setTouchEnabled(true)
	plusBtn:addTouchEventListener(callFunc or function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:onTouchBeganEvent(true)
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			self:onTouchEndedEvent(true)
		end
	end)
end

function MinusView:dispose()
	self:_closeDelayScheduler()
	self:_closeProgressScheduler()
	super.dispose(self)
end

function MinusView:onTouchBeganEvent(isAdd)
	self._add = 0
	self._isSingleClick = true
	self._delayScheduler = LuaScheduler:getInstance():schedule(function()
		self._isSingleClick = false

		self:_startschedule(isAdd)
	end, 0.8, false)
end

function MinusView:onTouchEndedEvent(isAdd)
	self:_closeDelayScheduler()
	self:_closeProgressScheduler()

	if self._isSingleClick then
		self:schedule(isAdd)
	end
end

function MinusView:_closeDelayScheduler()
	if self._delayScheduler then
		LuaScheduler:getInstance():unschedule(self._delayScheduler)

		self._delayScheduler = nil
	end
end

function MinusView:_startschedule(isAdd)
	self:_closeDelayScheduler()

	self._progressScheduler = LuaScheduler:getInstance():schedule(function()
		self:schedule(isAdd)
	end, 0.1, true)
end

function MinusView:_closeProgressScheduler()
	if self._progressScheduler then
		LuaScheduler:getInstance():unschedule(self._progressScheduler)

		self._progressScheduler = nil
	end
end

function MinusView:schedule(isAdd)
	self._add = self._add + 1

	if isAdd then
		if self._useCount < self._maxCount then
			self._useCount = self._useCount + self._add

			if self._useCount > self._maxCount then
				self._useCount = self._maxCount or self._useCount
			end

			if self._numText then
				self._numText:setString(self._useCount)
			end
		end
	elseif self._useCount > 0 then
		self._useCount = self._useCount - self._add
		self._useCount = self._useCount < 0 and 0 or self._useCount

		if self._numText then
			self._numText:setString(self._useCount)
		end
	end

	if self._callBack and not DisposableObject:isDisposed(self._this) then
		self._callBackParam.useCount = self._useCount

		if checkDependInstance(self._this) then
			self._callBack(self._this, self._callBackParam)
		end
	end

	self._viewNode:setVisible(self._useCount > 0)
end
