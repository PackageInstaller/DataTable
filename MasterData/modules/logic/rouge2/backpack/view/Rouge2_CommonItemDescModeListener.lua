-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonItemDescModeListener.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonItemDescModeListener", package.seeall)

local Rouge2_CommonItemDescModeListener = class("Rouge2_CommonItemDescModeListener", LuaCompBase)

function Rouge2_CommonItemDescModeListener.Get(go, dataFlag)
	if gohelper.isNil(go) then
		logError("Rouge2_CommonItemDescModeListener.Get error, go is nil")

		return
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CommonItemDescModeListener, dataFlag)
end

function Rouge2_CommonItemDescModeListener:ctor(dataFlag)
	self._startListen = false

	self:setDataFlag(dataFlag)
end

function Rouge2_CommonItemDescModeListener:init(go)
	self.go = go
end

function Rouge2_CommonItemDescModeListener:addEventListeners()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSwitchItemDescMode, self._onSwitchItemDescMode, self)
end

function Rouge2_CommonItemDescModeListener:initCallback(callback, callbackObj)
	self._callback = callback
	self._callBackObj = callbackObj

	self:refresh()
end

function Rouge2_CommonItemDescModeListener:setDataFlag(dataFlag)
	self._dataFlag = dataFlag

	self:refresh()
end

function Rouge2_CommonItemDescModeListener:startListen()
	self._startListen = true

	self:refresh()
end

function Rouge2_CommonItemDescModeListener:stopListen()
	self._startListen = false
end

function Rouge2_CommonItemDescModeListener:refresh()
	if not self._startListen or not self._dataFlag then
		return
	end

	self._curDescMode = Rouge2_BackpackController.instance:getItemDescMode(self._dataFlag)

	if self._callback then
		self._callback(self._callBackObj, self._curDescMode)
	end
end

function Rouge2_CommonItemDescModeListener:_onSwitchItemDescMode(descModeFlag)
	if self._dataFlag ~= descModeFlag then
		return
	end

	self:refresh()
end

return Rouge2_CommonItemDescModeListener
