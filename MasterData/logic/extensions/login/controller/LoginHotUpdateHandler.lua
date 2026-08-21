-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/controller/LoginHotUpdateHandler.lua

module("logic.extensions.login.controller.LoginHotUpdateHandler", package.seeall)

local M = class("LoginHotUpdateHandler")

function M:ctor(controller)
	self._controller = controller
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.HOtUPDATE_FORCE, self._popHotUpdateDialog, self)
end

function M:onReset()
	removetimer(self._popHotUpdateDialog, self)
end

function M:_popHotUpdateDialog()
	if ViewMgr.instance:isOpen(ViewName.Login) then
		return
	end

	if BattleMgr.instance:isInBattle() or ViewMgr.instance:isOpen(ViewName.StoreMainViewViewPresentor) then
		removetimer(self._popHotUpdateDialog, self)
		settimer(5, self._popHotUpdateDialog, self, false)
	else
		removetimer(self._popHotUpdateDialog, self)

		local deviceType = BootstrapUtil.getHotUpdateDeviceType()

		Astral.GameUpdateHelper.Instance:ClearListeners()

		if Astral.GameConstParser.Instance.gameOpenHotUpdate then
			local helper = Astral.GameUpdateHelper.Instance

			helper:AddListener(Astral.HotUpdateEventType.RequestRemoteVersionFail, self._onRequestRemoteVersionFail, self)
			helper:AddListener(Astral.HotUpdateEventType.RequestRemoteVersionSuccess, self._onRequestRemoteVersionSuccess, self)

			self._requestRemoteCount = 0

			if Astral.OSDef.isEditor then
				local isOpenPcHotUpdate = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kOpenPcHotdate, 0) == 1

				if isOpenPcHotUpdate then
					local deviceTypeIndex = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kDeviceType, 1)

					deviceType = BootstrapConst.HOTUPDATE_DEVIVE_TYPE[deviceTypeIndex]

					HotUpdateUtil.RequestRemoteVersion(BootstrapGameConfigMgr.getHotUpdateInfoUrl(), BootstrapGameConfigMgr.getHotUpdateAppCode(), deviceType, tostring(BootstrapUtil.getPlatformId()), BootstrapUtil.getGameVersionCode(), BootstrapUtil.getGamePackageName())
				end
			else
				HotUpdateUtil.RequestRemoteVersion(BootstrapGameConfigMgr.getHotUpdateInfoUrl(), BootstrapGameConfigMgr.getHotUpdateAppCode(), deviceType, tostring(BootstrapUtil.getPlatformId()), BootstrapUtil.getGameVersionCode(), BootstrapUtil.getGamePackageName())
			end
		end
	end
end

function M:_onRequestRemoteVersionFail()
	forcePrint("LoginController 请求回来的最新版本号=,===请求失败")

	local deviceType = BootstrapUtil.getHotUpdateDeviceType()

	self._requestRemoteCount = self._requestRemoteCount + 1

	if self._requestRemoteCount < 3 then
		HotUpdateUtil.RequestRemoteVersion(BootstrapGameConfigMgr.getHotUpdateInfoUrl(), BootstrapGameConfigMgr.getHotUpdateAppCode(), deviceType, tostring(BootstrapUtil.getPlatformId()), BootstrapUtil.getGameVersionCode(), BootstrapUtil.getGamePackageName())
	else
		Astral.GameUpdateHelper.Instance:ClearListeners()
		printError("=====LoginController:_onRequestRemoteVersionFail====count=", self._requestRemoteCount)

		self._requestRemoteCount = 0
	end
end

function M:_onRequestRemoteVersionSuccess(gameHotUpdateVersionCode)
	forcePrint("LoginController 再次检查资源版本号，当前版本号=，请求回来的最新版本号=", BootstrapUtil.getGameHotUpdateVersionCode(), gameHotUpdateVersionCode)

	if ViewMgr.instance:isOpen(ViewName.Login) then
		return
	end

	Astral.GameUpdateHelper.Instance:ClearListeners()

	if gameHotUpdateVersionCode ~= "0.0.0" and not self:_checkAgainHotUpdateVersion(gameHotUpdateVersionCode) then
		forcePrint("请求回来的最新版本号=,come here ...")

		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("客户端已更新，请重新启动游戏"))

		dialog:setConfirmButtonText(lang("tip_common_confirm"))
		dialog:setConfirmListener(self.confirmExit, self)
		dialog:setConfirmNotCloseListener(self.confirmExit, self)
	end
end

function M:_checkAgainHotUpdateVersion(gameHotUpdateVersionCode)
	local remoteVersion = string.split(gameHotUpdateVersionCode, ".")
	local bigVersion = checknumber(remoteVersion[1])
	local midVersion = checknumber(remoteVersion[2])
	local smallVerion = checknumber(remoteVersion[3])
	local localVersion = string.split(BootstrapUtil.getGameHotUpdateVersionCode(), ".")
	local localbigVersion = checknumber(localVersion[1])
	local localMidVersion = checknumber(localVersion[2])
	local localsmallVersion = checknumber(localVersion[3])

	if localbigVersion < bigVersion then
		forcePrint("LoginController 服务器资源版本号 大包版本号 大于 本地，需要整包")

		return false
	elseif bigVersion == localbigVersion and midVersion == localMidVersion and localsmallVersion < smallVerion then
		forcePrint("LoginController 服务器资源版本号 小包版本号 大于 本地，需要热更新")

		return false
	end

	return true
end

function M:confirmExit()
	self._controller:confirmExit()
end

return M
