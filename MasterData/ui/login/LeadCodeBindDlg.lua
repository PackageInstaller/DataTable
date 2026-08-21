-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LeadCodeBindDlg.lua

local UIControls = require("UI/UIControls")
local GameSettingHelper = Framework.Settings.GameSettingHelper
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local strClassName = "LeadCodeBindDlg"
local LeadCodeBindDlg = Class(strClassName, UIControls.Window)
local CODE_MINI_CHARACTER = 8
local CODE_MAX_CHARACTER = 20

function LeadCodeBindDlg:ctor()
	self.noLeadCodePanel = UIControls.Panel(self, "Bg/SetPanel")
	self.hasLeadCodePanel = UIControls.Panel(self, "Bg/ShowPanel")
	self.textPanelName = UIControls.Label(self, "Bg/TextTitle")
	self.leadCode = UIControls.Input(self, "Bg/SetPanel/PasswordInputField")
	self.textTitleAccount = UIControls.Label(self, "Bg/SetPanel/PasswordInputField/TextTitle")
	self.leadCodeConfirm = UIControls.Input(self, "Bg/SetPanel/PassportConfirmField")
	self.textTitlePassword = UIControls.Label(self, "Bg/SetPanel/PassportConfirmField/TextTitle")
	self.textSetPanelTips = UIControls.Label(self, "Bg/SetPanel/TextTips")

	self.textSetPanelTips:setText("")

	self.textShowPanelTips = UIControls.Label(self, "Bg/ShowPanel/TextTips")

	self.textShowPanelTips:setText("")

	self.textSetTitle = UIControls.Label(self, "Bg/SetPanel/TextTitle")

	self.textSetTitle:setText("引継ぎコードのパスワードを設定してください")

	self.textShowTitle = UIControls.Label(self, "Bg/ShowPanel/TextTitle")

	self.textShowTitle:setText("引継ぎコードの設定が完了しました")

	self.txtSuccessionID = UIControls.Label(self, "Bg/ShowPanel/IDPanel/Text")
	self.txtSuccessionIDTitle = UIControls.Label(self, "Bg/ShowPanel/IDPanel/TextTitle")

	self.txtSuccessionIDTitle:setText("引継ぎコード")

	self.txtSuccessionCode = UIControls.Label(self, "Bg/ShowPanel/CodePanel/Text")
	self.txtSuccessionCodeTitle = UIControls.Label(self, "Bg/ShowPanel/CodePanel/TextTitle")

	self.txtSuccessionCodeTitle:setText("パスワード")

	self.btnConfirm_noID = UIControls.Button(self, "Bg/SetPanel/BtnConfirm")

	self.btnConfirm_noID:addEventClick(self.onConfirmBtnClick)

	self.btnCancel = UIControls.Button(self, "Bg/SetPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onCloseClick)

	self.btnChangeCode = UIControls.Button(self, "Bg/ShowPanel/BtnReset")

	self.btnChangeCode:addEventClick(self.changeSuccessionCode)

	self.btnConfirm_hasID = UIControls.Button(self, "Bg/ShowPanel/BtnConfirm")

	self.btnConfirm_hasID:addEventClick(self.onCloseClick)

	self.textAccountPlaceholder = UIControls.Label(self, "Bg/SetPanel/PasswordInputField/Placeholder")
	self.textPasswordPlaceholder = UIControls.Label(self, "Bg/SetPanel/PassportConfirmField/Placeholder")
	self._sdkImp = SDKAgent.getSDKImp()
end

function LeadCodeBindDlg:openForBind(bind)
	self.isForBind = bind

	if bind then
		self:tryGetSuccessionID()
		self.textPanelName:setText(Lang.get(30413))
		self.textAccountPlaceholder:setText(Lang.get(1353))
		self.textPasswordPlaceholder:setText(Lang.get(1355))
		self.textTitleAccount:setText(Lang.get(1354))
		self.textTitlePassword:setText(Lang.get(1356))
		self.textSetPanelTips:setText(Lang.get(36325))
		self.hasLeadCodePanel:setVisible(true)
		self.noLeadCodePanel:setVisible(false)
	else
		self.textPanelName:setText(Lang.get(30415))
		self.textTitleAccount:setText(Lang.get(1371))
		self.textTitlePassword:setText(Lang.get(1354))
		self.textAccountPlaceholder:setText(Lang.get(1372))
		self.textPasswordPlaceholder:setText(Lang.get(1372))
		self.textSetPanelTips:setText("")
		self.hasLeadCodePanel:setVisible(false)
		self.noLeadCodePanel:setVisible(true)
		self:setVisible(true)
	end
end

function LeadCodeBindDlg:onOpen()
	LeadCodeBindDlg.super.onOpen(self)
	self.leadCode:setText("")
	self.leadCodeConfirm:setText("")

	self.changeCode = false
	self.createCode = false
end

function LeadCodeBindDlg:tryGetSuccessionID()
	if self._sdkImp.successionId and self._sdkImp.successionCode then
		self:successionIDResult(true, self._sdkImp.successionId, self._sdkImp.successionCode)
	else
		SDKAgent.querySuccessionCode()
	end
end

function LeadCodeBindDlg:successionIDResult(result, successionId, code)
	if not self.isForBind then
		return
	end

	self:setVisible(true)

	if result then
		self.hasLeadCodePanel:setVisible(true)
		self.noLeadCodePanel:setVisible(false)
		self.txtSuccessionID:setText(successionId)
		self.txtSuccessionCode:setText(code)

		if self.changeCode then
			MsgManager.notice(Lang.get(30416))
		elseif self.createCode then
			MsgManager.notice(Lang.get(30417))
		end

		self.textShowPanelTips:setText("引継ぎコードとパスワードは他の人に教えないようにしてください")
	else
		self.hasLeadCodePanel:setVisible(false)
		self.noLeadCodePanel:setVisible(true)
		self.textShowPanelTips:setText("")
	end

	self.changeCode = false
	self.createCode = false
end

function LeadCodeBindDlg:onConfirmBtnClick()
	local code = self.leadCode:getText()
	local codeConfirm = self.leadCodeConfirm:getText()

	if self.isForBind then
		local length = code and utils.utf8len(code) or 0

		if length < CODE_MINI_CHARACTER or length > CODE_MAX_CHARACTER then
			MsgManager.notice(utils.format(Lang.get(30412), CODE_MINI_CHARACTER, CODE_MAX_CHARACTER))
		elseif code ~= codeConfirm then
			MsgManager.notice(Lang.get(30420))
		elseif self.changeCode then
			SDKAgent.changeSuccessionCode(code)
			self:muteAllBtn(Lang.get(30421))
		else
			self.createCode = true

			SDKAgent.createSuccessionCode(code)
			self:muteAllBtn(Lang.get(30422))
		end
	else
		local data = {}

		data[AttName.SUCCESSION_ID] = code
		data[AttName.SUCCESSION_CODE] = codeConfirm

		if code ~= "" and codeConfirm ~= "" then
			SDKAgent.successionCodeLogin(data)
			self:muteAllBtn(Lang.get(30402))
		else
			MsgManager.notice(Lang.get(30423))
		end
	end
end

function LeadCodeBindDlg:changeSuccessionCode()
	self.changeCode = true

	self.hasLeadCodePanel:setVisible(false)
	self.noLeadCodePanel:setVisible(true)
end

function LeadCodeBindDlg:muteAllBtn(text)
	local spinner = UIManager.getUI("loginSpinner", true, true)

	if spinner then
		spinner:setText(text)
		spinner:delayedClose(15)
	end
end

function LeadCodeBindDlg:onCloseClick()
	self:setVisible(false)
end

function LeadCodeBindDlg:closeAll()
	self:onCloseClick()

	local bind = UIManager.tryGetUI("accountBindAndSingDlg")

	if bind then
		bind:OnCloseClick()
	end

	local choose = UIManager.tryGetUI("accountChooseDlg")

	if choose then
		choose:OnCloseClick()
	end
end

return LeadCodeBindDlg
