-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\GiftExchangeDlg.lua

local GiftExchangeDlg = Class("GiftExchangeDlg", UIControls.Window)
local GameSettings = require("Helper/GameSettings")
local SDKAppUtils = require("SDK/SDKAppUtils")
local UserData = require("Helper/UserData")
local RemoteConfig = require("Helper/RemoteConfig")
local LuaToolkit = Framework.Tools.LuaToolkit
local Const = Const

function GiftExchangeDlg:ctor()
	self:initUI()
end

local languageName = "chf"
local currentCode = ""
local changeLanguageCode = "0011010"

function GiftExchangeDlg:initUI()
	self.btnExchange = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnExchange:addEventClick(self.onClickExchange)

	self.btnCancel = UIControls.Button(self, "Bg/BtnDeny")

	self.btnCancel:addEventClick(self.onClickCancel)

	self.inputGiftCode = UIControls.Input(self, "Bg/TextCode/InputField")

	self.inputGiftCode:addEventValueChanged(self.onCodeCheck)
	self.inputGiftCode:addEventEndEdit(self.onCodeEditEnd)

	if self:canChangeLanguage() then
		self.codeTimeEnd = false

		Framework.Tools.LuaToolkit.LogEx("canChangeLanguage")

		self.btnLeft = UIControls.Button(self, "Bg/BtnA")

		self.btnLeft:addEventClick(self.onClickBtnA)

		self.btnRight = UIControls.Button(self, "Bg/BtnB")

		self.btnRight:addEventClick(self.onClickBtnB)

		self.codeTimer = Timer.New(Slot(self.codeTime, self), 3)

		self.codeTimer:Start()
	end

	if UIControls.checkControlFunc(self, "Bg/AdressPanel") then
		self.adressPanel = UIControls.Panel(self, "Bg/AdressPanel")
		self.textName = UIControls.Label(self, "Bg/AdressPanel/AddressNode/TextName")
		self.addressNode = UIControls.Panel(self, "Bg/AdressPanel/AddressNode")
		self.btnEdit = UIControls.Button(self, "Bg/AdressPanel/AddressNode/BtnEdit")

		self.btnEdit:addEventClick(self.onBtnEditClick)

		self.btnCreate = UIControls.Button(self, "Bg/AdressPanel/BtnCreate")

		self.btnCreate:addEventClick(self.onBtnCreateClick)

		if VersionUtils.IsReviewVersion() then
			self.btnCreate:setVisible(false)
		end
	end
end

function GiftExchangeDlg:onOpen()
	GiftExchangeDlg.super.onOpen(self)
	self:refreshAdressUI()
end

function GiftExchangeDlg:refreshAdressUI()
	self.adressPanel:setVisible(true)
	self.addressNode:setVisible(CurAvatar.consigneeName ~= nil and CurAvatar.consigneeName ~= "")

	if CurAvatar.consigneeName and CurAvatar.consigneeName ~= "" then
		self.textName:setText(string.format(Lang.get(84511), CurAvatar.consigneeName, CurAvatar.consigneePhone, CurAvatar.consigneeAddress))
		self.textName:setVisible(true)
	end
end

function GiftExchangeDlg:canChangeLanguage()
	local curLanguageList = Framework.Tools.LuaToolkit.GetLanguageList()
	local flag = false

	for i = 0, curLanguageList.Count - 1 do
		if languageName == curLanguageList[i] then
			flag = true

			break
		end
	end

	if flag then
		if LuaToolkit.GetCurLanguage() == languageName then
			return false
		end

		if GameSettings.getCustomSetting("HighFramerate") and GameSettings.getCustomSetting("MSAAEnable") == 1 and GameSettings.getCustomSetting("ResolutionLv") == 3 then
			return true
		end
	end

	return false
end

local function _changeLanguage()
	Framework.Tools.LuaToolkit.SetCurLanguage(languageName)
	UserData.save()
	SDKAppUtils.exitApp()
end

function GiftExchangeDlg:codeTime()
	self.codeTimeEnd = true
end

function GiftExchangeDlg:onBtnEditClick()
	UIManager.getUI("editAdressDlg", true):setData()
end

function GiftExchangeDlg:onBtnCreateClick()
	UIManager.getUI("editAdressDlg", true):setData()
end

function GiftExchangeDlg:onClickBtnA()
	if self.codeTimeEnd then
		return
	end

	currentCode = currentCode .. "0"

	if currentCode == changeLanguageCode then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), "error", _changeLanguage, nil, nil, Lang.get(8), Lang.get(7))
	end
end

function GiftExchangeDlg:onClickBtnB()
	if self.codeTimeEnd then
		return
	end

	currentCode = currentCode .. "1"
end

function GiftExchangeDlg:onClose(...)
	currentCode = ""

	self.inputGiftCode:setText("")
	GiftExchangeDlg.super.onClose(self)
end

GiftExchangeDlg.MaxInputLength = 20

function GiftExchangeDlg:onClickExchange()
	local codeText = self.inputGiftCode:getText()

	if #codeText == 0 then
		MsgManager.notice(Lang.get(30435))

		return
	end

	if RegionUtils.isJP() then
		local gift = {}

		gift.cdkey = codeText

		ChannelUtil.doAnyFunction("getGiftpack", gift)
	else
		RPC.cDKey(codeText)
	end
end

function GiftExchangeDlg:_cullUnlegal(inputText, needLength)
	inputText = string.gsub(inputText, "[%p%c]", "")

	local lenInByte = #inputText
	local nowIndex = 1
	local chnCount = 0
	local engCount = 0

	for i = 1, lenInByte do
		local curByte = string.byte(inputText, nowIndex)

		if not curByte then
			break
		end

		local byteCount = 1

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte < 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		if byteCount ~= 1 then
			nowIndex = nowIndex + byteCount
			chnCount = chnCount + 1
		elseif curByte < 48 and curByte ~= 32 or curByte > 57 and curByte < 65 or curByte > 122 or curByte > 90 and curByte < 97 then
			local char = string.sub(inputText, nowIndex, nowIndex + byteCount - 1)

			inputText = string.gsub(inputText, char, "")
		else
			nowIndex = nowIndex + byteCount
			engCount = engCount + 1
		end

		local afterLength = chnCount * 2 + engCount

		if needLength <= afterLength then
			local resultStr = string.sub(inputText, 1, nowIndex - 1)

			return resultStr, chnCount > 0
		end
	end

	return inputText, chnCount > 0
end

function GiftExchangeDlg:onClickCancel()
	self:setVisible(false)
end

function GiftExchangeDlg:onCodeCheck()
	local nowCode = self.inputGiftCode:getText()
	local legalTxt, hasCNWord = self:_cullUnlegal(nowCode, GiftExchangeDlg.MaxInputLength)

	self.hasCNWord = hasCNWord

	self.inputGiftCode:setText(legalTxt)
end

function GiftExchangeDlg:onCodeEditEnd(...)
	return
end

function GiftExchangeDlg:onSetCode(initStr)
	self.inputGiftCode:setText(initStr or "")
end

return GiftExchangeDlg
