-- chunkname: @IQIGame\\UI\\Setting\\SettingExchangeView.lua

local SettingExchangeView = {}

function SettingExchangeView.New(go, mianView)
	local o = Clone(SettingExchangeView)

	o:Initialize(go, mianView)

	return o
end

function SettingExchangeView:Initialize(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.inputCodeComponent = self.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.btnExchange = self.BtnExchange:GetComponent("Button")

	function self.delegateBtnExchange()
		self:onClickBtnExchange()
	end

	function self.__delegateSendGiftCodeResult()
		self:ResetCodeText()
	end

	self:AddEventListener()
end

function SettingExchangeView:AddEventListener()
	self.btnExchange.onClick:AddListener(self.delegateBtnExchange)
	EventDispatcher.AddEventListener(EventID.SendGiftCodeResult, self.__delegateSendGiftCodeResult)
end

function SettingExchangeView:RemoveEventListener()
	self.btnExchange.onClick:RemoveListener(self.delegateBtnExchange)
	EventDispatcher.RemoveEventListener(EventID.SendGiftCodeResult, self.__delegateSendGiftCodeResult)
end

function SettingExchangeView:onClickBtnExchange()
	local sendGiftCode = tostring(self.inputCodeComponent.text)

	if sendGiftCode == "" or sendGiftCode == nil then
		NoticeModule.ShowNoticeByType(1, SettingUIApi:GetTextInput())

		return
	end

	net_player.sendGiftCode(sendGiftCode)
end

function SettingExchangeView:ResetCodeText()
	self.inputCodeComponent.text = ""
end

function SettingExchangeView:OnDestroy()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return SettingExchangeView
