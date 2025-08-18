-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\UIBrowser.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "UIBrowser"
local UIBrowser = Class(strClassName, UIBaseControl)

function UIBrowser:ctor(parent, path)
	return
end

function UIBrowser:_getControlType()
	return UIConst.ControlTypeUIBrowser
end

function UIBrowser:openUrl(url)
	local obj = self:getComObj()

	if obj ~= nil and url ~= nil then
		self:getController():BrowserOpenUrl(obj, url)
	end
end

function UIBrowser:reload()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():BrowserReload(obj)
	end
end

return UIBrowser
