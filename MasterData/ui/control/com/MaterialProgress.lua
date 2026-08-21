-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\MaterialProgress.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local UIConst = UIConst
local strClassName = "MaterialProgress"
local MaterialProgress = Class(strClassName, UIBaseControl)

function MaterialProgress:_getControlType()
	return UIConst.ControlTypeUIMaterialProgressBase
end

function MaterialProgress:setValue(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:SetProgress(v)
	end
end

function MaterialProgress:UpdateImageUV()
	local obj = self:getComObj()

	if obj ~= nil then
		obj:UpdateImageUV()
	end
end

function MaterialProgress:setImage(filePath, spriteName)
	if not self.image then
		self.image = UIControls.Image(self.mParent, self.mPath)
	end

	self.image:setImage(filePath, spriteName)
	self:UpdateImageUV()
end

function MaterialProgress:setValueEx(startValue, endValue, durationTime)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:SetProgressDuration(startValue, endValue, durationTime)
	end
end

function MaterialProgress:getValue()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj:GetProgress()
	end
end

return MaterialProgress
