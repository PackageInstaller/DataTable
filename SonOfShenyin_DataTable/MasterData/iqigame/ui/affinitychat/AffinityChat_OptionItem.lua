-- chunkname: @IQIGame\\UI\\AffinityChat\\AffinityChat_OptionItem.lua

local AffinityChat_OptionItem = {}

function AffinityChat_OptionItem.New(go, mainView)
	local o = Clone(AffinityChat_OptionItem)

	o:Initialize(go, mainView)

	return o
end

function AffinityChat_OptionItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AffinityChat_OptionItem:InitComponent()
	self.button = self.gameObject:GetComponent("Button")
end

function AffinityChat_OptionItem:InitDelegate()
	function self.onButtonClickDelegate()
		self:OnButtonClick()
	end
end

function AffinityChat_OptionItem:AddListener()
	self.button.onClick:AddListener(self.onButtonClickDelegate)
end

function AffinityChat_OptionItem:RemoveListener()
	self.button.onClick:RemoveListener(self.onButtonClickDelegate)
end

function AffinityChat_OptionItem:OnButtonClick()
	self.mainView:OnOptionClick(self)
end

function AffinityChat_OptionItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AffinityChat_OptionItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AffinityChat_OptionItem:SetSelect(v)
	LuaUtility.SetGameObjectShow(self.selectState, v)
end

function AffinityChat_OptionItem:SetInteractable(interactable)
	if self.button == nil then
		return
	end

	self.button.interactable = interactable
end

function AffinityChat_OptionItem:OnDestroy()
	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.button = nil
end

function AffinityChat_OptionItem:Refresh(Data)
	self.data = Data

	self:SetSelect(false)
	LuaUtility.SetText(self.chatText, self.data.Context)
	self:SetInteractable(true)
end

return AffinityChat_OptionItem
