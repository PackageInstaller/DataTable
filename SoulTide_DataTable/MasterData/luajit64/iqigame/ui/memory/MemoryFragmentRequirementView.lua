-- chunkname: @IQIGame\\UI\\Memory\\MemoryFragmentRequirementView.lua

MemoryFragmentRequirementView = {
	itemTable = {}
}

function MemoryFragmentRequirementView.New(ui, memoryChapterView)
	local cloneObject = Clone(MemoryFragmentRequirementView)

	cloneObject:InitView(ui, memoryChapterView)

	return cloneObject
end

function MemoryFragmentRequirementView:InitView(ui, memoryChapterView)
	self.ui = ui
	self.memoryChapterView = memoryChapterView

	LuaCodeInterface.BindOutlet(ui, self)

	self.imgFragmentIcon = self.img_FragmentIcon:GetComponent("Image")
	self.txtDescription = self.txt_Description:GetComponent("Text")
	self.txtDescriptionTitle = self.txt_DescTitle:GetComponent("Text")
	self.btnActive = self.btn_Active:GetComponent("Button")
	self.btnCancel = self.btn_Cancel:GetComponent("Button")

	function self.delegateOnClickBtnActive()
		self:OnClickBtnActive()
	end

	function self.delegateOnClickBtnCancel()
		self:OnClickBtnCancel()
	end

	function self.delegateUpdateItem(cell)
		self:UpdateItemCell(cell)
	end

	function self.delegateSelectedItem(cell)
		self:SelectedItemCell(cell)
	end

	self.gridSlotComponent = self.gridSlotComponent:GetComponent("ScrollAreaList")
	self.gridSlotComponent.onRenderCell = self.delegateUpdateItem
	self.gridSlotComponent.onSelectedCell = self.delegateSelectedItem
end

function MemoryFragmentRequirementView:AddEventListeners()
	self.btnActive.onClick:AddListener(self.delegateOnClickBtnActive)
	self.btnCancel.onClick:AddListener(self.delegateOnClickBtnCancel)
end

function MemoryFragmentRequirementView:RemoveEventListeners()
	self.btnActive.onClick:RemoveListener(self.delegateOnClickBtnActive)
	self.btnCancel.onClick:RemoveListener(self.delegateOnClickBtnCancel)
end

function MemoryFragmentRequirementView:CloseUI()
	self:RemoveEventListeners()
	self.ui.gameObject:SetActive(false)
end

function MemoryFragmentRequirementView:OpenUI(cfgFragmentData)
	self.ui.gameObject:SetActive(true)
	self:AddEventListeners()
	self.xiaohaoNode:SetActive(true)

	if self.cfgFragmentData == nil or self.cfgFragmentData.Id ~= cfgFragmentData.Id then
		self.cfgFragmentData = cfgFragmentData

		local dataPath = UIGlobalApi.GetImagePath(cfgFragmentData.Icon)

		self.txtDescriptionTitle.text = cfgFragmentData.Describe1
		self.txtDescription.text = "消耗:"

		local itemID = cfgFragmentData.Cost[1]
		local cfgItemData = CfgItemTable[itemID]

		dataPath = UIGlobalApi.GetIconPath(cfgItemData.Icon)
		self.txt_Title:GetComponent("Text").text = self.cfgFragmentData.Name
	end

	for i, v in ipairs(cfgFragmentData.Cost) do
		if i % 2 ~= 0 then
			local item = CfgItemTable[v]

			table.insert(self.itemTable, {
				item = item,
				costNum = cfgFragmentData.Cost[i + 1]
			})
		end
	end

	local len = #cfgFragmentData.Cost / 2

	self.gridSlotComponent:Refresh(len)

	self.itemTable = {}
end

function MemoryFragmentRequirementView:OnClickBtnActive()
	if self.cfgFragmentData == nil then
		return -1
	end

	for i, v in ipairs(self.cfgFragmentData.Cost) do
		if i % 2 ~= 0 then
			local itemID = self.cfgFragmentData.Cost[i]
			local needItemNumber = self.cfgFragmentData.Cost[i + 1]
			local itemNum = WarehouseModule.GetItemNumByCfgID(itemID)

			if itemNum < needItemNumber then
				return -1
			end
		end
	end

	self.xiaohaoNode:SetActive(false)
	self.flashNode:SetActive(true)

	if self.timerFlash == nil then
		self.timerFlash = Timer.New(function()
			self.flashNode:SetActive(false)
			MemoryModule.RequestActiveMemoryPiece(MemoryModule.currentSoulChapterInfo.cid, self.cfgFragmentData.Id)

			if self.timerFlash ~= nil then
				self.timerFlash:Stop()

				self.timerFlash = nil
			end
		end, 1.1)
	end

	self.timerFlash:Start()
end

function MemoryFragmentRequirementView:OnClickBtnCancel()
	self:CloseUI()

	if self.timerFlash ~= nil then
		self.timerFlash:Stop()

		self.timerFlash = nil
	end
end

function MemoryFragmentRequirementView:UpdateItemCell(cell)
	local itemData = self.itemTable[cell.index + 1]

	if itemData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local itemGo = cell.gameObject
	local itemObj

	itemObj = itemGo

	itemObj:SetActive(true)

	local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

	itemCell:SetItem(itemData.item)

	local num = WarehouseModule.GetItemNumByCfgID(itemData.item.Id)

	if num < itemData.costNum then
		itemCell.View.ItemNumText:GetComponent("Text").text = "<color=red>" .. num .. "</color>" .. "/" .. itemData.costNum
	else
		itemCell.View.ItemNumText:GetComponent("Text").text = num .. "/" .. itemData.costNum
	end
end

function MemoryFragmentRequirementView:SelectedItemCell(cell)
	return
end

function MemoryFragmentRequirementView:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.timerFlash ~= nil then
		self.timerFlash:Stop()

		self.timerFlash = nil
	end

	LuaCodeInterface.ClearOutlet(self.ui, self)

	self.ui = nil
end
