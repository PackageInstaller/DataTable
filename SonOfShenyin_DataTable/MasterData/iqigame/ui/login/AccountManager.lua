-- chunkname: @IQIGame\\UI\\Login\\AccountManager.lua

local m = {
	CurPlayerPrefsIndex = 0,
	AccountDatas = {}
}
local OptionData = UnityEngine.UI.Dropdown.OptionData

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateCloseBtn()
		self:Hide()
	end

	function self.delegateNewAccountBtn()
		self.CurPlayerPrefsIndex = 0

		self:DispatchEvent()
	end

	function self.delegateConfrimBtn()
		self:DispatchEvent()
	end

	self:InitAccountData()
	self:AddListeners()
end

function m:onValueChangedCallBack(index)
	self.CurPlayerPrefsIndex = index + 1

	self:SetBtnState(true)
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.delegateConfrimBtn)
	self.NewAccountBtn:GetComponent("Button").onClick:AddListener(self.delegateNewAccountBtn)
	self.AccountDrop.onValueChanged:AddListener(self.CallbackDeleagte)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateCloseBtn)
	self.AccountDrop.onValueChanged:RemoveListener(self.CallbackDeleagte)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateConfrimBtn)
	self.NewAccountBtn:GetComponent("Button").onClick:RemoveListener(self.delegateNewAccountBtn)
end

function m:SetData()
	return
end

function m:InitAccountData()
	for i = 1, 10 do
		local uName = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserName .. i)

		if uName == nil or uName == "" then
			break
		else
			table.insert(self.AccountDatas, uName)
		end
	end

	self:SetDropDownData()
end

function m:SetDropDownData()
	self.AccountDrop = self.AccountDropdown:GetComponent("Dropdown")

	self.AccountDrop.options:Clear()

	for i = 1, #self.AccountDatas do
		local data = OptionData.New(self.AccountDatas[i])

		self.AccountDrop.options:Add(data)
	end

	self.AccountDrop:Select()

	function self.CallbackDeleagte(index)
		self:onValueChangedCallBack(index)
	end
end

function m:SetBtnState(state)
	self.ConfirmBtn:SetActive(state)
	self.NewAccountBtn:SetActive(not state)
end

function m:DispatchEvent()
	EventDispatcher.Dispatch(EventID.ChangAccount, self.CurPlayerPrefsIndex)
	self:Hide()
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.AccountDatas do
		self.AccountDatas[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:Show()
	self.View:SetActive(true)
	self:SetBtnState(false)
end

function m:Hide()
	self.View:SetActive(false)
end

return m
