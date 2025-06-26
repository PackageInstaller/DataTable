-- chunkname: @IQIGame\\UI\\Tips\\EquipInfoCell.lua

local EquipInfoCell = {}

function EquipInfoCell.New(go)
	local o = Clone(EquipInfoCell)

	o:Initialize(go)

	return o
end

function EquipInfoCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfEquipName = self.goEquipName:GetComponent("Text")
	self.tfPartName = self.goPartName:GetComponent("Text")
	self.tfType = self.goType:GetComponent("Text")
	self.toggleLock = self.goToggleLock:GetComponent("Toggle")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlotParent.transform:GetChild(0).gameObject, false)

	function self.onClickToggleLockDelegate(isOn)
		self:OnClickToggleLock(isOn)
	end

	function self.onEquipLockOverDelegate(id, lock)
		self:OnEquipLockOver(id, lock)
	end
end

function EquipInfoCell:RefreshView(itemData, mainView)
	self.itemData = itemData
	self.mainView = mainView
	self.cfgItemData = self.itemData:GetCfg()

	self:RefreshMisc()
	self.itemCell:SetItem(self.itemData)
	self:AddListener()
end

function EquipInfoCell:OnHide()
	self:RemoveListener()
end

function EquipInfoCell:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.mainView = nil
end

function EquipInfoCell:AddListener()
	self:RemoveListener()
	self.toggleLock.onValueChanged:AddListener(self.onClickToggleLockDelegate)
	EventDispatcher.AddEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
end

function EquipInfoCell:RemoveListener()
	self.toggleLock.onValueChanged:RemoveListener(self.onClickToggleLockDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
end

function EquipInfoCell:RefreshMisc()
	self.tfEquipName.text = EquipTipApi:GetString("goEquipName", self.cfgItemData.Name, self.cfgItemData.Quality)
	self.tfPartName.text = EquipTipApi:GetString("goPartName", self.cfgItemData.SubType)
	self.tfType.text = ItemTipsApi:GetType(self.cfgItemData.Type, self.cfgItemData.SubType)
	self.toggleLock.isOn = self.itemData.equipData.lock

	self.goToggleLock:SetActive(not self.mainView.forShow and not self.itemData.IsMazeItem)
end

function EquipInfoCell:OnClickToggleLock(isOn)
	if self.mainView.UIController:GetCurrentTarget() == self.toggleLock.gameObject then
		EquipModule.ReqLock(self.itemData.id)
	end
end

function EquipInfoCell:OnEquipLockOver(id, lock)
	if self.itemData.id == id then
		self.itemCell:SetEquipLock(lock)

		self.toggleLock.isOn = lock
	end
end

return EquipInfoCell
