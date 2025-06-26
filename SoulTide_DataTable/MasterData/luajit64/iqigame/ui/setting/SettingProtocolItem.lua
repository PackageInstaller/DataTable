-- chunkname: @IQIGame\\UI\\Setting\\SettingProtocolItem.lua

local m = {}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCheckDetailBtn()
		self:OnClickCheckDetailBtn()
	end

	UGUIUtil.SetTextInChildren(self.CheckDetailBtn, SettingUIApi:GetString("ProtocolCheckDetailBtnText"))
end

function m:AddListeners()
	self.CheckDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCheckDetailBtn)
end

function m:RemoveListeners()
	self.CheckDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCheckDetailBtn)
end

function m:SetData(name, url)
	self.View:SetActive(name ~= nil and name ~= "")

	if name == nil or name == "" then
		return
	end

	self.Name = name
	self.Url = url

	UGUIUtil.SetText(self.NameText, self.Name)
end

function m:OnClickCheckDetailBtn()
	self.OnClickCallback(self.Name, self.Url)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
