-- chunkname: @IQIGame\\UI\\RoleDevelopment\\Skill\\NewSkillItem.lua

local m = {
	skillIsOpen = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOpenSkillDetails()
		self:OnClickSkill()
	end

	self.diySlotUIItem = ItemCell.New(self.DiySlotUI, false, false)

	LuaUtility.SetGameObjectShow(self.LockLevelText, false)
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOpenSkillDetails)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOpenSkillDetails)
end

function m:SetData(data, index, heroData, isSelfSkill)
	self.isSelfSkill = isSelfSkill
	self.heroData = heroData
	self.skillData = data
	self.clickIndex = index

	LuaUtility.SetGameObjectShow(self.Euqip, index <= 3)
	self.Lock:SetActive(false)
	self.UnEquip:SetActive(false)

	if index > 3 then
		self.skillIsOpen = self:GetSkillIsOpen(index)

		self.Lock:SetActive(not self.skillIsOpen)

		if self.skillIsOpen then
			self.UnEquip:SetActive(self.skillData == nil)
			LuaUtility.SetGameObjectShow(self.DiySlotUI, self.skillData ~= nil)
			LuaUtility.SetGameObjectShow(self.UnEquip, self.skillData == nil)
		else
			self.UnEquip:SetActive(self.skillIsOpen)
			LuaUtility.SetGameObjectShow(self.DiySlotUI, self.skillIsOpen)
		end

		if self.skillData ~= nil then
			self.diySlotUIItem:SetItem(WarehouseModule.FindItem(self.skillData.id))
		end

		return
	else
		LuaUtility.SetGameObjectShow(self.DiySlotUI, false)
	end

	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[self.skillData.itemCid].Icon), self.SkillIcon)
	UGUIUtil.SetText(self.SkillTypeText, self.skillData:GetSkillType())
	UGUIUtil.SetText(self.SkillLevel, self.skillData.lv)
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"), nil, nil, nil, true)
end

function m:GetSkillIsOpen(index)
	local isOpen = false
	local OpenLv = RoleDevelopmentModule.GetOpenSkillCondition(index)

	if OpenLv <= self.heroData.lv then
		isOpen = true
	else
		isOpen = false

		self:ShowLockInfo(OpenLv)
	end

	return isOpen
end

function m:ShowLockInfo(lv)
	UGUIUtil.SetText(self.LockInfo, RoleDevelopmentApi:GetSkillOpenConditionText(lv))
	UGUIUtil.SetText(self.LockLevelText, lv)
end

function m:OnClickSkill()
	return
end

function m:EquipmentSkill()
	UIModule.Open(Constant.UIControllerName.SkillReplaceUI, Constant.UILayer.UI, {
		self.skillData,
		self.clickIndex
	})
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
