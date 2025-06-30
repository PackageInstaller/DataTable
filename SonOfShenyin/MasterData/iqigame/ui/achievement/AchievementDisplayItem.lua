-- chunkname: @IQIGame\\UI\\Achievement\\AchievementDisplayItem.lua

local AchievementDisplayItem = {}

function AchievementDisplayItem.New(go, mainView)
	local o = Clone(AchievementDisplayItem)

	o:Initialize(go, mainView)

	return o
end

function AchievementDisplayItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.isUsed = false

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AchievementDisplayItem:InitComponent()
	self.grayComponent = self.imageItem:GetComponent("GrayComponent")
	self.buttonDetail = self.buttonDetail:GetComponent("Button")
end

function AchievementDisplayItem:InitDelegate()
	function self.buttonDetailDelegate()
		self:OnButtonDetailClick()
	end

	function self.objectMaskDelegate()
		self:OnObjectMaskClick()
	end
end

function AchievementDisplayItem:AddListener()
	self.buttonDetail.onClick:AddListener(self.buttonDetailDelegate)
	self.objectMask:GetComponent("Button").onClick:AddListener(self.objectMaskDelegate)
end

function AchievementDisplayItem:RemoveListener()
	self.buttonDetail.onClick:AddListener(self.buttonDetailDelegate)
	self.objectMask:GetComponent("Button").onClick:RemoveListener(self.objectMaskDelegate)
end

function AchievementDisplayItem:OnButtonDetailClick()
	self.mainView.AchievementDisplayDetailTip:Show(self.Data.Id)
end

function AchievementDisplayItem:OnObjectMaskClick()
	self.mainView.AchievementDisplayDetailTip:Show(self.Data.Id)
end

function AchievementDisplayItem:ResetStatus()
	LuaUtility.SetGameObjectShow(self.objectMask, false)
	LuaUtility.SetGameObjectShow(self.objectUsed, false)
	LuaUtility.SetGameObjectShow(self.objectSelect, false)
	self.grayComponent:SetGray(false)
end

function AchievementDisplayItem:Refresh(Data)
	self.Data = Data

	self:ResetStatus()
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.Data.Icon), self.imageItem:GetComponent("Image"))

	if WarehouseModule.GetItemDataByCfgID(self.Data.Id) then
		if self.mainView:CheckIsDisplay(self.Data.Id) then
			self:SetUsed()
		else
			self:SetNonUse()
		end
	else
		self.grayComponent:SetGray(true)
		LuaUtility.SetGameObjectShow(self.objectMask, true)
	end
end

function AchievementDisplayItem:SetChose()
	if self.mainView.currentBagItemSelect then
		self.mainView.currentBagItemSelect:SetNonChose()
	end

	LuaUtility.SetGameObjectShow(self.objectSelect, true)

	self.mainView.currentBagItemSelect = self
end

function AchievementDisplayItem:SetNonChose()
	LuaUtility.SetGameObjectShow(self.objectSelect, false)
end

function AchievementDisplayItem:SetUsed()
	self.isUsed = true

	LuaUtility.SetGameObjectShow(self.objectUsed, true)
end

function AchievementDisplayItem:SetNonUse()
	self.isUsed = false

	LuaUtility.SetGameObjectShow(self.objectUsed, false)
end

function AchievementDisplayItem:GetUsed()
	return self.isUsed
end

return AchievementDisplayItem
