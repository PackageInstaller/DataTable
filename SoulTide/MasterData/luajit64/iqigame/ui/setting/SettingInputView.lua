-- chunkname: @IQIGame\\UI\\Setting\\SettingInputView.lua

local SettingInputView = {}

function SettingInputView.__New(ui)
	local o = Clone(SettingInputView)

	o:InitView(ui)

	return o
end

function SettingInputView:InitView(ui)
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.inputCodeComponent = self.Input:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	UGUIUtil.SetText(self.TextBtnExchange, SettingInputViewApi:GetString("TextBtnExchange"))
	UGUIUtil.SetText(self.TextSettingInputTitle, SettingInputViewApi:GetString("TextSettingInputTitle"))

	self.btnExchange = self.BtnExchange:GetComponent("Button")

	function self.delegateBtnExchange()
		self:onClickBtnExchange()
	end

	self:AddEventListener()
end

function SettingInputView:OnMainUIOpen()
	return
end

function SettingInputView:OnMainUIClose()
	self:Close()
end

function SettingInputView:AddEventListener()
	self.btnExchange.onClick:AddListener(self.delegateBtnExchange)
end

function SettingInputView:RemoveEventListener()
	self.btnExchange.onClick:RemoveListener(self.delegateBtnExchange)
end

function SettingInputView:UpDateView()
	return
end

function SettingInputView:onClickBtnExchange()
	local sendGiftCode = tostring(self.inputCodeComponent.text)

	if sendGiftCode == "" or sendGiftCode == nil then
		NoticeModule.ShowNoticeByType(1, SettingInputViewApi:GetString("ErrorMsg"))

		return
	end

	local len = utf8.len(sendGiftCode)
	local totalBytes = 0

	if len == 13 then
		for i = 1, 12 do
			local c = sendGiftCode:byte(i)

			totalBytes = totalBytes + c
		end

		local num = totalBytes % 31
		local str = {
			"q",
			"w",
			"e",
			"r",
			"t",
			"y",
			"u",
			"p",
			"a",
			"s",
			"d",
			"f",
			"g",
			"h",
			"j",
			"k",
			"z",
			"x",
			"c",
			"v",
			"b",
			"n",
			"m",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9"
		}
		local char = str[num + 1]
		local s = string.subUTF8(sendGiftCode, 13, 1)

		if char ~= s then
			NoticeModule.ShowNoticeByType(1, SettingInputViewApi:GetString("ErrorMsg"))

			return
		end
	end

	net_player.sendGiftCode(sendGiftCode)
end

function SettingInputView:Dispose()
	self:Close()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingInputView:Open()
	self.rootUI:SetActive(true)
	self:UpDateView()
end

function SettingInputView:Close()
	self.rootUI:SetActive(false)
end

return SettingInputView
