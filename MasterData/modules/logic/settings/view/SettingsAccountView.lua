-- chunkname: @modules/logic/settings/view/SettingsAccountView.lua

module("modules.logic.settings.view.SettingsAccountView", package.seeall)

local SettingsAccountView = class("SettingsAccountView", BaseView)

function SettingsAccountView:onInitView()
	self._btnaccount = gohelper.findChildButtonWithAudio(self.viewGO, "Scroll View/Viewport/layout/accountInfo/content/#btn_account")
	self._btnaccountlogout = gohelper.findChildButtonWithAudio(self.viewGO, "Scroll View/Viewport/layout/accountlogout/content/#btn_accountlogout")
	self._btncdkey = gohelper.findChildButtonWithAudio(self.viewGO, "Scroll View/Viewport/layout/cdkey/content/#btn_cdkey")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "Scroll View/Viewport/layout/other/content/#btn_exit")
	self._btnPrivacy = gohelper.findChildClick(self.viewGO, "agreement/txtPrivacy")
	self._btnPersonal = gohelper.findChildClick(self.viewGO, "agreement/txtPersonal")
	self._btnThirdParty = gohelper.findChildClick(self.viewGO, "agreement/txtThirdParty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsAccountView:addEvents()
	self._btnaccount:AddClickListener(self._btnaccountOnClick, self)
	self._btnaccountlogout:AddClickListener(self._btnaccountlogoutOnClick, self)
	self._btncdkey:AddClickListener(self._btncdkeyOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btnPrivacy:AddClickListener(self._btnPrivacyOnClick, self)
	self._btnPersonal:AddClickListener(self._btnPersonalOnClick, self)
	self._btnThirdParty:AddClickListener(self._btnThirdPartyOnClick, self)
end

function SettingsAccountView:removeEvents()
	self._btnaccount:RemoveClickListener()
	self._btnaccountlogout:RemoveClickListener()
	self._btncdkey:RemoveClickListener()
	self._btnexit:RemoveClickListener()
	self._btnPrivacy:RemoveClickListener()
	self._btnPersonal:RemoveClickListener()
	self._btnThirdParty:RemoveClickListener()
end

function SettingsAccountView:_btnaccountOnClick()
	if self.isShowUserCenter then
		SDKMgr.instance:showUserCenter()
	end
end

function SettingsAccountView:_btnaccountlogoutOnClick()
	SDKMgr.instance:unregisterSdk()
end

function SettingsAccountView:_btncdkeyOnClick()
	ViewMgr.instance:openView(ViewName.SettingsCdkeyView)
end

function SettingsAccountView:_btnexitOnClick()
	SDKController.instance:openSDKExitView()
end

function SettingsAccountView:_editableInitView()
	self.goAccountContainer = gohelper.findChild(self.viewGO, "Scroll View/Viewport/layout/accountInfo")
	self.goCdkContainer = gohelper.findChild(self.viewGO, "Scroll View/Viewport/layout/cdkey")
	self.goAccountLogoutContainer = gohelper.findChild(self.viewGO, "Scroll View/Viewport/layout/accountlogout")

	gohelper.setActive(self.goAccountLogoutContainer, false)

	if VersionValidator.instance:isInReviewing() and SLFramework.FrameworkSettings.IsIOSPlayer() then
		gohelper.setActive(self.goCdkContainer, false)
	end

	if not HotUpdateVoiceMgr.IsGuoFu then
		gohelper.setActive(self._btnPrivacy.gameObject, false)
		gohelper.setActive(self._btnPersonal.gameObject, false)
		gohelper.setActive(self._btnThirdParty.gameObject, false)
	end
end

function SettingsAccountView:onUpdateParam()
	return
end

function SettingsAccountView:onOpen()
	self.isShowUserCenter = SDKMgr.instance:isShowUserCenter()

	local isOfficial = GameChannelConfig.isXfsdk() and not SettingsModel.isBilibili()

	gohelper.setActive(self.goAccountContainer, self.isShowUserCenter and isOfficial)

	local isBilibili = SettingsModel.isBilibili()
	local isShowUnregisterButton = SDKMgr.instance:isShowUnregisterButton()

	logNormal(string.format("SettingsAccountView isShowUserCenter:%s,isBilibili:%s,isShowUnregisterButton:%s", tostring(self.isShowUserCenter), tostring(isBilibili), tostring(isShowUnregisterButton)))

	if isShowUnregisterButton and not BootNativeUtil.isIOS() then
		gohelper.setActive(self.goAccountLogoutContainer, true)
	end
end

function SettingsAccountView:_btnPrivacyOnClick()
	GameUtil.openURL("https://m.sl916.com/protocol.html")
end

function SettingsAccountView:_btnPersonalOnClick()
	GameUtil.openURL("https://m.sl916.com/collected.html")
end

function SettingsAccountView:_btnThirdPartyOnClick()
	GameUtil.openURL("https://m.sl916.com/personal.html")
end

function SettingsAccountView:onClose()
	return
end

function SettingsAccountView:onDestroyView()
	return
end

return SettingsAccountView
