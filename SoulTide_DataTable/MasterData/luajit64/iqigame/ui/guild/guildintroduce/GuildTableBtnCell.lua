-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildTableBtnCell.lua

local m = {}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.OnText1, GuildIntroduceUIApi:GetString("TabBtnText", self.index))
	UGUIUtil.SetText(self.OffText1, GuildIntroduceUIApi:GetString("TabBtnText", self.index))

	function self.DelegateOnClickTab(isOn)
		self:OnSelect(isOn)
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
end

function m:RemoveListener()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTab)
end

function m:SetSelect(top)
	self.View:GetComponent("Toggle").isOn = top
end

function m:OnSelect(isOn)
	if isOn and self.selectCallBack then
		self.selectCallBack(self.index)
	end
end

function m:UpdateView()
	self.RedPoint:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()

	self.selectCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
