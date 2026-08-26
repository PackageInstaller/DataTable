-- chunkname: @projbooter/ui/BootVersionView.lua

module("projbooter.ui.BootVersionView", package.seeall)

local BootVersionView = class("BootVersionView")

function BootVersionView:show()
	if not self._go then
		self._go = BootResMgr.instance:getVersionViewGo()
		self._rootTr = self._go.transform
		self._txtVersion = self._rootTr:Find("#txt_version"):GetComponent(typeof(UnityEngine.UI.Text))
	end

	if self._go then
		self._go:SetActive(true)

		local versionName = UnityEngine.Application.version
		local resourceName = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
		local buildId = BootNativeUtil.getAppVersion()

		self._txtVersion.text = string.format("V%s-%s-%s", versionName, resourceName, tostring(buildId))
	end
end

function BootVersionView:hide()
	if self._go then
		self._go:SetActive(false)
	end
end

function BootVersionView:dispose()
	self:hide()

	self._go = nil
	self._rootTr = nil
	self._txtVersion = nil
end

BootVersionView.instance = BootVersionView.New()

return BootVersionView
