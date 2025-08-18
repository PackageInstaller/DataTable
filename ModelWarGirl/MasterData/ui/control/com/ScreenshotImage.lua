-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\ScreenshotImage.lua

local Label = require("UI/Control/Com/Label")
local RawImage = require("UI/Control/Com/RawImage")
local UIUtils = Framework.UI.UIUtils
local UIConst = UIConst
local strClassName = "ScreenshotImage"
local ScreenshotImage = Class(strClassName, RawImage)

function ScreenshotImage:_getControlType()
	return UIConst.ControlTypeScreenshotImage
end

function ScreenshotImage:refresh()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():RefreshScreenshot(obj)
	end
end

function ScreenshotImage:clean()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():CleanScreenshot(obj)
	end
end

function ScreenshotImage:saveJPG(filePath)
	local go = self:getGameObject()

	if go ~= nil then
		local RawImageType = typeof(UnityEngine.UI.RawImage)
		local rawImage = go:GetComponent(RawImageType)

		if rawImage then
			Framework.Network.WebResourcesHelper.Instance:SaveTextureInFile(filePath, rawImage.texture)
		end
	end
end

function ScreenshotImage:savePNG(filePath)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SaveCapturedScreenshot(obj, filePath)
	end
end

return ScreenshotImage
