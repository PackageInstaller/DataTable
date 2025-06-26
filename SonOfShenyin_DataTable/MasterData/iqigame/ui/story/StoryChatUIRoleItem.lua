-- chunkname: @IQIGame\\UI\\Story\\StoryChatUIRoleItem.lua

local StoryChatUIRoleItem = {}

function StoryChatUIRoleItem.New(go, mainView)
	local o = Clone(StoryChatUIRoleItem)

	o:Initialize(go, mainView)

	return o
end

function StoryChatUIRoleItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryChatUIRoleItem:InitComponent()
	self.toggle = self.roleDialogItem:GetComponent("Toggle")
	self.imageHead = self.heroHeadImg:GetComponent("Image")
end

function StoryChatUIRoleItem:InitDelegate()
	function self.toggleValueChangedDelegate(isOn)
		self:OnClick(isOn)
	end
end

function StoryChatUIRoleItem:AddListener()
	self.toggle.onValueChanged:AddListener(self.toggleValueChangedDelegate)
end

function StoryChatUIRoleItem:RemoveListener()
	self.toggle.onValueChanged:RemoveListener(self.toggleValueChangedDelegate)
end

function StoryChatUIRoleItem:OnDestroy()
	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryChatUIRoleItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function StoryChatUIRoleItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function StoryChatUIRoleItem:OnClick(isOn)
	if isOn then
		self.mainView:SelectGroup(self.groupId)
	end
end

function StoryChatUIRoleItem:SetSelect(v)
	LuaUtility.SetGameObjectShow(self.selectState, v)
	LuaUtility.SetGameObjectShow(self.normalState, not v)
end

function StoryChatUIRoleItem:ResetView()
	self:SetSelect(false)
end

function StoryChatUIRoleItem:Refresh(Data)
	self:ResetView()

	self.Data = Data
	self.groupId = self.Data.index

	LuaUtility.SetText(self.heroNameText, CfgUtil.GetCfgStoryTextDataWithID(self.Data.nameID))
	LuaUtility.LoadImage(self, self.Data.iconPath, self.imageHead)

	if self.mainView.isPerformance then
		self.toggle.interactable = false
	else
		self.toggle.interactable = true
	end
end

return StoryChatUIRoleItem
