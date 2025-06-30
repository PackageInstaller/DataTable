-- chunkname: @IQIGame\\UI\\Setting\\SettingChangeNameView.lua

local SettingChangeNameView = {}

function SettingChangeNameView.__New(ui)
	local o = Clone(SettingChangeNameView)

	o:InitView(ui)

	return o
end

function SettingChangeNameView:InitView(ui)
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.TextTitle1:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextTitle6")
	self.TextTitle2:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextTitle7")

	UGUIUtil.SetText(self.TextPlaceholder, SettingUIApi:GetString("TextPlaceholder"))
	UGUIUtil.SetText(self.TextBtnClean, SettingUIApi:GetString("TextBtnClean"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnSureComponent = self.BtnSure:GetComponent("Button")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateClickBtnSure()
		self:OnClickBtnSure()
	end

	function self.delegateOnValueChanged(text)
		self:OnValueChanged(text)
	end

	self.maxCharNum = CfgDiscreteDataTable[6520052].Data[1]
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").characterLimit = self.maxCharNum

	self:AddEventListener()
end

function SettingChangeNameView:AddEventListener()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
	self.btnSureComponent.onClick:AddListener(self.delegateClickBtnSure)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:AddListener(self.delegateOnValueChanged)
end

function SettingChangeNameView:RemoveEventListener()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
	self.btnSureComponent.onClick:RemoveListener(self.delegateClickBtnSure)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:RemoveListener(self.delegateOnValueChanged)
end

function SettingChangeNameView:UpdateView()
	local id = CfgDiscreteDataTable[6506029].Data[1]
	local itemData = CfgItemTable[id]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemData.Icon), self.ItemIcon:GetComponent("Image"))

	self.TextCost:GetComponent("Text").text = "x" .. CfgDiscreteDataTable[6506029].Data[2]
end

function SettingChangeNameView:OnClickBtnClose()
	self:Close()
end

function SettingChangeNameView:OnClickBtnSure()
	local name = self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if name == "" or name == nil then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg3"))

		return
	end

	if string.len(name) < 4 then
		NoticeModule.ShowNotice(21041055)

		return
	end

	if WarnStrFunc:isWarningInPutStr(name) then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg6"))

		return
	end

	local id = CfgDiscreteDataTable[6506029].Data[1]
	local haveNum = WarehouseModule.GetItemNumByCfgID(id)
	local num = CfgDiscreteDataTable[6506029].Data[2]

	if haveNum < num then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg4", CfgItemTable[id].Name))

		return
	end

	SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_NAME, name)
	self:Close()
end

function SettingChangeNameView:OnValueChanged(text)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = string.subUTF8Length(text, 27)
end

function SettingChangeNameView:Dispose()
	self:Close()
	self:RemoveEventListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingChangeNameView:Open()
	self.rootUI:SetActive(true)
	self:UpdateView()
end

function SettingChangeNameView:Close()
	self.rootUI:SetActive(false)
end

return SettingChangeNameView
