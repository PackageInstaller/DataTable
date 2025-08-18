-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\AutoTest\\TButtonClick.lua

local Button = require("UI/Control/Com/Button")
local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local AutoRecordClick = AutoRecordClick

local function _packageCallbackEx(self, func)
	if not func then
		return nil
	end

	local function callback(root, sender, ...)
		if self.mWindow and not self.mWindow:isInShow() and not UIConst.EXECUTABLE_CONTROL_TYPE[self:_getControlType()] then
			return
		end

		if self.mWindow and self.mWindow.mOpening and not UIConst.EXECUTABLE_CONTROL_TYPE[self:_getControlType()] then
			return
		end

		if root == self.mRoot and sender == self:getComObj() then
			AutoRecordClick.RecordClick(self._obj.transform)
			func(self.mParent, self, ...)
		end
	end

	return callback
end

Button._packageCallback = _packageCallbackEx
