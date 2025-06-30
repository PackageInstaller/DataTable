-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildEstablishView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.EstablishTitle, GuildIntroduceUIApi:GetString("EstablishTitle"))
	UGUIUtil.SetTextInChildren(self.BtnEstablish, GuildIntroduceUIApi:GetString("EstablishBtnLabel"))

	function self.delegateOnValueChanged(text)
		self:OnValueChanged(text)
	end

	function self.delegateBtnEstablish()
		self:OnBtnEstablish()
	end

	self.maxCharNum = CfgDiscreteDataTable[6520052].Data[1]
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").characterLimit = self.maxCharNum
end

function m:AddListener()
	self.BtnEstablish:GetComponent("Button").onClick:AddListener(self.delegateBtnEstablish)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:AddListener(self.delegateOnValueChanged)
end

function m:RemoveListener()
	self.BtnEstablish:GetComponent("Button").onClick:RemoveListener(self.delegateBtnEstablish)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:RemoveListener(self.delegateOnValueChanged)
end

function m:OnValueChanged(text)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = string.subUTF8Length(text, 27)
end

function m:OnBtnEstablish()
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

	local need = CfgDiscreteDataTable[6520092].Data[1]
	local have = PlayerModule.GetNumAttrValue(Constant.ItemID.TREASURE)

	if have < need then
		NoticeModule.ShowNoticeNoCallback(21040015)

		return
	end

	NoticeModule.ShowNotice(21066300, function()
		GuildModule.CreateGuild(name)
	end, nil, self, name)
end

function m:UpdateView()
	local itemData = CfgItemTable[Constant.ItemID.TREASURE]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemData.Icon), self.ImgCost:GetComponent("Image"))

	local needNum = CfgDiscreteDataTable[6520092].Data[1]

	UGUIUtil.SetText(self.TextCost, GuildIntroduceUIApi:GetString("EstablishTextCost", needNum))
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
