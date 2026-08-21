-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/SystemInfoHackToolView.lua

module("logic.extensions.hacktool.view.SystemInfoHackToolView", package.seeall)

local M = class("SystemInfoHackToolView")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
	self:bindEvents()
end

function M:destroy()
	self:unbindEvents()
	self:destroyUI()

	self.mainGO = false
end

function M:buildUI()
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtContent")
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnClose"))
	self._btnForceAdaptation = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnForceAdaptation"))
end

function M:destroyUI()
	self._txtContent = nil
	self._btnClose = nil
	self._btnForceAdaptation = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnForceAdaptation:AddClickListener(self._onClickForceAdaptation, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnForceAdaptation:RemoveClickListener()
end

function M:active()
	self:_updateView()
	goutil.setActive(self.mainGO, true)
end

function M:inactive()
	goutil.setActive(self.mainGO, false)
end

function M:_updateView()
	self._txtContent.text = self:_buildSystemInfo()
end

function M:_buildSystemInfo()
	local str = "<color=red>SYSTEM INFO</color>"
	local SystemInfo = UnityEngine.SystemInfo

	str = str .. "\n[device model] " .. SystemInfo.deviceModel
	str = str .. "\n[os version] " .. SystemInfo.operatingSystem
	str = str .. "\n[system memory size] " .. SystemInfo.systemMemorySize .. "M"
	str = str .. "\n"
	str = str .. "\n[graphic device name] " .. SystemInfo.graphicsDeviceName .. " (version " .. SystemInfo.graphicsDeviceVersion .. ")"
	str = str .. "\n[graphic memory size] " .. SystemInfo.graphicsMemorySize .. "M"
	str = str .. "\n[graphic max texSize] " .. SystemInfo.maxTextureSize
	str = str .. "\n[graphic shader level] " .. SystemInfo.graphicsShaderLevel
	str = str .. "\n"
	str = str .. "\n[processor type] " .. SystemInfo.processorType
	str = str .. "\n[processor count] " .. SystemInfo.processorCount
	str = str .. "\n[processor frequency] " .. SystemInfo.processorFrequency .. "MHz"
	str = str .. "\n"
	str = str .. "\n[screen size] " .. UnityEngine.Screen.width .. " x " .. UnityEngine.Screen.height
	str = str .. "\n[screen pixel density dpi] " .. UnityEngine.Screen.dpi

	local w, h = AdaptationUtils.GetUISize(0, 0)

	str = str .. "\n[adaptation size] " .. w .. " x " .. h

	return str
end

function M:_onClickForceAdaptation()
	AdaptationUtils.Recalculate()
end

function M:_onClickClose()
	self:inactive()
end

return M
