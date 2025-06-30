-- chunkname: @IQIGame\\UI\\Guild\\GuildEdit\\GuildEditChangeNameView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.BtnCancel, GuildEditUIApi:GetString("BtnCancelLabel"))
	UGUIUtil.SetTextInChildren(self.BtnSure, GuildEditUIApi:GetString("BtnSureLabel"))
	UGUIUtil.SetText(self.TextPlaceholder, GuildEditUIApi:GetString("TextPlaceholder"))

	function self.DelegateBtnSure()
		self:OnBtnSure()
	end

	function self.DelegateBtnCancel()
		self:OnBtnCancel()
	end

	function self.DelegateOnValueChanged(text)
		self:OnValueChanged(text)
	end

	self.maxCharNum = CfgDiscreteDataTable[6520052].Data[1]
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").characterLimit = self.maxCharNum
end

function m:AddListener()
	self.BtnSure:GetComponent("Button").onClick:AddListener(self.DelegateBtnSure)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.DelegateBtnCancel)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:AddListener(self.DelegateOnValueChanged)
end

function m:RemoveListener()
	self.BtnSure:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSure)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnCancel)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:RemoveListener(self.DelegateOnValueChanged)
end

function m:OnValueChanged(text)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = string.subUTF8Length(text, 27)
end

function m:UpdateView()
	local need = CfgDiscreteDataTable[6520089].Data[1]

	UGUIUtil.SetText(self.CostNumText, GuildEditUIApi:GetString("CostNumText", need))
end

function m:OnBtnSure()
	local name = self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if name == "" or name == nil then
		return
	end

	if string.len(name) < 4 then
		NoticeModule.ShowNotice(21066303)

		return
	end

	if WarnStrFunc:isWarningInPutStr(name) then
		NoticeModule.ShowNotice(21045002)

		return
	end

	local need = CfgDiscreteDataTable[6520089].Data[1]
	local have = GuildModule.guildPOD.fund

	if have < need then
		NoticeModule.ShowNoticeNoCallback(21047002)

		return
	end

	GuildModule.ChangeName(name)
	self:Close()
end

function m:OnBtnCancel()
	self:Close()
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:UpdateView()
end

function m:Close()
	self:RemoveListener()
	self.View:SetActive(false)
end

function m:Dispose()
	self:Close()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
