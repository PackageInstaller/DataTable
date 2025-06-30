-- chunkname: @IQIGame\\UI\\Equip\\EquipIntensifyListCellNew.lua

local EquipIntensifyListCellNew = {}

function EquipIntensifyListCellNew.New(go, mainView)
	local o = Clone(EquipIntensifyListCellNew)

	o:Initialize(go, mainView)

	return o
end

function EquipIntensifyListCellNew:Initialize(go, mainView)
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitDelegation()
	self:InitComponent()
end

function EquipIntensifyListCellNew:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

function EquipIntensifyListCellNew:InitDelegation()
	function self.delegateOnClickAddLongButton()
		self:OnClickAdd()
	end

	function self.delegateOnClickSubLongButton()
		self:OnClickSub()
	end

	function self.delegateOnLongDownClickAddLongButton()
		if self.itemData.equipData ~= nil then
			self.AddLongBtn.repeatCall = false

			ItemModule.OpenItemTipsByItemData(self.itemData, false, false)
		else
			self.AddLongBtn.repeatCall = true

			self:OnClickAdd()
		end
	end

	function self.delegateOnLongDownClickSubLongButton()
		self:OnClickSub()
	end
end

function EquipIntensifyListCellNew:InitComponent()
	self.BaseItemCell = ItemCell.New(self.ItemObj, false, false)
	self.AddLongBtn = self.IntensifyButton:GetComponent("LongButton")

	self.AddLongBtn.onLongDownClick:AddListener(self.delegateOnLongDownClickAddLongButton)
	self.AddLongBtn.onClick:AddListener(self.delegateOnClickAddLongButton)

	self.AddLongBtn.clickInterval = 0.05
	self.SubLongBtn = self.DeCreaseBtn:GetComponent("LongButton")

	self.SubLongBtn.onLongDownClick:AddListener(self.delegateOnLongDownClickSubLongButton)
	self.SubLongBtn.onClick:AddListener(self.delegateOnClickSubLongButton)

	self.SubLongBtn.clickInterval = 0.05
end

function EquipIntensifyListCellNew:Refresh(itemData)
	self.itemData = itemData

	self.BaseItemCell:SetItem(itemData)

	if self.itemData.ItemCustomCount == nil then
		self.itemData.ItemCustomCount = 0
	end

	self:RefreshChooseState()

	if self.itemData.equipData ~= nil then
		self.DeCreaseBtn:SetActive(false)
	else
		self.BaseItemCell:SetNum(self.itemData.num)

		if self.itemData.ItemCustomCount > 0 then
			self.BaseItemCell:SetCostAllNumberShow(self.itemData.ItemCustomCount, self.itemData.num)
			self.DeCreaseBtn:SetActive(true)
		else
			self.DeCreaseBtn:SetActive(false)
		end
	end

	self.LockState:SetActive(self.itemData.equipData ~= nil and self.itemData.equipData.isLock)
	self:RefreshLevel()
	self:RefreshPartIcon()
end

function EquipIntensifyListCellNew:RefreshLevel()
	if self.itemData.equipData then
		self.BaseItemCell:SetItemAddLvShow(self.itemData.equipData.lv)
	end
end

function EquipIntensifyListCellNew:RefreshPartIcon()
	if self.itemData.equipData then
		AssetUtil.LoadImage(self, EquipApi:GetEquipPartImg(self.itemData:GetCfg().Part), self.equipPartImg:GetComponent("Image"))
		self.equipPartImg:SetActive(true)
	else
		self.equipPartImg:SetActive(false)
	end
end

function EquipIntensifyListCellNew:OnClickAdd()
	if self.itemData.equipData ~= nil and self.itemData.equipData.isLock then
		NoticeModule.ShowNotice(70005)

		return
	end

	if self.mainView.currentIntensifyEquip.isMaxLv then
		NoticeModule.ShowNotice(20015)

		return
	end

	if (self.itemData.equipData ~= nil and not self:IsChoose() or self.itemData.equipData == nil) and self.mainView:IsIntensifyExpOverflow() then
		NoticeModule.ShowNotice(20015)

		return
	end

	if self.mainView:IsConsumeItemListFull() and not self:IsChoose() then
		NoticeModule.ShowNotice(20035)

		return
	end

	local previewCount = 0

	if self.itemData.equipData ~= nil then
		previewCount = 1 - self.itemData.ItemCustomCount
	else
		previewCount = self.itemData.ItemCustomCount + 1
	end

	if previewCount > self.itemData.num then
		return
	end

	self.itemData.ItemCustomCount = previewCount

	self:Refresh(self.itemData)
	self.mainView.OnPreviewClickCallClicked()
end

function EquipIntensifyListCellNew:OnClickSub()
	if self.itemData.ItemCustomCount - 1 < 0 then
		return
	end

	self.itemData.ItemCustomCount = self.itemData.ItemCustomCount - 1

	self:Refresh(self.itemData)
	self.mainView.OnPreviewClickCallClicked()
end

function EquipIntensifyListCellNew:RefreshChooseState()
	self.BaseItemCell:SetSelectFrame(self:IsChoose())
end

function EquipIntensifyListCellNew:IsChoose()
	return self.itemData.ItemCustomCount > 0
end

return EquipIntensifyListCellNew
