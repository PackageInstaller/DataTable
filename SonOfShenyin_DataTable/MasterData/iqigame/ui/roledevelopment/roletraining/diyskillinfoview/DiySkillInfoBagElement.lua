-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillInfoView\\DiySkillInfoBagElement.lua

local CommonSortingPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")
local diySkillBagItemCell = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillBagItemCell")
local SkillBarItem = {}

function SkillBarItem.New(view, selectHandler)
	local obj = Clone(SkillBarItem)

	obj:Init(view, selectHandler)

	return obj
end

function SkillBarItem:Init(view, selectHandler)
	self.view = view
	self.selectHandler = selectHandler

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.delegateOnClickSkillItem()
		self:OnClickSkillItem()
	end

	self:AddListeners()
end

function SkillBarItem:AddListeners()
	self.view:GetComponent("Button").onClick:AddListener(self.delegateOnClickSkillItem)
end

function SkillBarItem:RemoveListeners()
	self.view:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickSkillItem)
end

function SkillBarItem:SetData(skillData, skillType, heroCid)
	self.isEquip = skillData ~= nil
	self.skillData = skillData
	self.skillType = skillType

	local index = RoleDevelopmentModule.GetIndexByDiySkillType(skillType)
	local needLV = CfgHeroTable[heroCid].DiyField[index]

	self.isUnLock = needLV <= WarlockModule.WarlockDataDic[heroCid].lv

	LuaUtility.SetGameObjectShow(self.addImg, not self.isEquip and self.isUnLock)
	LuaUtility.SetGameObjectShow(self.skillIcon, self.isEquip)
	LuaUtility.SetGameObjectShow(self.lock, not self.isUnLock)

	if self.isEquip then
		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.skillData:GetCfg().Icon), self.skillIcon:GetComponent("Image"))
	end
end

function SkillBarItem:OnClickSkillItem()
	if not self.isUnLock then
		NoticeModule.ShowNotice(51011)

		return
	end

	if self.selectHandler ~= nil then
		self.selectHandler(self.skillType)
	end
end

function SkillBarItem:Select()
	LuaUtility.SetGameObjectShow(self.select, true)
end

function SkillBarItem:UnSelect()
	LuaUtility.SetGameObjectShow(self.select, false)
end

function SkillBarItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local DiySkillInfoBagElement = {
	sortOrder = true,
	bagItemCellList = {},
	skillBarItemList = {}
}

function DiySkillInfoBagElement.New(view, itemSelectAction, skillBarItemSelectHandler)
	local obj = Clone(DiySkillInfoBagElement)

	obj:__Init(view, itemSelectAction, skillBarItemSelectHandler)

	return obj
end

function DiySkillInfoBagElement:__Init(view, itemSelectAction, skillBarItemSelectHandler)
	self.gameObject = view
	self.itemSelectAction = itemSelectAction
	self.skillBarItemSelectHandler = skillBarItemSelectHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.bagScrollArea = self.equipBagScroll:GetComponent("ScrollAreaList")

	function self.bagScrollArea.onRenderCell(cell)
		self:__OnRenderBagCell(cell)
	end

	function self.bagScrollArea.onSelectedCell(cell)
		self:__OnSelectedBagCell(cell)
	end

	self.sortPopupList = CommonSortingPopupListView.New(self.SortingPopup, function(_index)
		self:__OnSortingTypeChange(_index)
	end)

	function self.__OnSortingOrderButtonClickProxy()
		self:__OnOrderChange()
	end

	function self.__OnDelegateUpdateItemEvent(updateItems)
		self:__OnDelegateUpdateItem(updateItems)
	end

	function self.__OnDelegateWearSkillEvent()
		self:__OnDelegateWearSkill()
	end

	ForTransformChild(self.diySkillItemParent.transform, function(trans, index)
		self.skillBarItemList[Constant.DIYSkillPosMapping[index + 1]] = SkillBarItem.New(trans.gameObject, function(skillType)
			self:OnSelectSkillBarItem(skillType, true)
		end)
	end)
end

function DiySkillInfoBagElement:__AddListeners()
	self.SortingOrderButton:GetComponent("Button").onClick:AddListener(self.__OnSortingOrderButtonClickProxy)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.__OnDelegateUpdateItemEvent)
	EventDispatcher.AddEventListener(EventID.WearSkillSucess, self.__OnDelegateWearSkillEvent)
	EventDispatcher.AddEventListener(EventID.RemoveSkillSucess, self.__OnDelegateWearSkillEvent)
end

function DiySkillInfoBagElement:__RemoveListeners()
	self.SortingOrderButton:GetComponent("Button").onClick:RemoveListener(self.__OnSortingOrderButtonClickProxy)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.__OnDelegateUpdateItemEvent)
	EventDispatcher.RemoveEventListener(EventID.WearSkillSucess, self.__OnDelegateWearSkillEvent)
	EventDispatcher.RemoveEventListener(EventID.RemoveSkillSucess, self.__OnDelegateWearSkillEvent)
end

function DiySkillInfoBagElement:Dispose()
	for k, v in pairs(self.bagItemCellList) do
		v:Dispose()
	end

	for k, v in pairs(self.skillBarItemList) do
		v:Dispose()
	end

	self:__RemoveListeners()
	self.sortPopupList:Dispose()
	ItemCell.DisposeIn(self)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillInfoBagElement:Show(heroCid, skillType)
	self.selectSkillId = nil
	self.heroCid = heroCid
	self.skillType = skillType

	self.gameObject:SetActive(true)
	self:RefreshSkillBarItem()
	self:OnSelectSkillBarItem(skillType, false)
	self:__AddListeners()
end

function DiySkillInfoBagElement:RefreshBag(isDynamic)
	self.selectSkillId = nil

	local selectItemData

	self:UnSelectAllItem()
	self.sortPopupList:SetData(CommonSortingPopupListView.GetSkillSortingData(), 1, false)

	local sortType = self.sortPopupList.SelectIndex

	self.allSkillItems = DiySkillModule.GetAllDiySkillsWithWarehouse(sortType ~= 1, self.heroCid)

	WarehouseModule.SortSkills(self.allSkillItems, sortType, self.sortOrder)

	local heroEquipedSkillCid = WarlockModule.WarlockDataDic[self.heroCid].SkillGroups[self.skillType] ~= nil and WarlockModule.WarlockDataDic[self.heroCid].SkillGroups[self.skillType].skillCid or -1
	local heroEquipedSKillId = WarlockModule.WarlockDataDic[self.heroCid].SkillGroups[self.skillType] ~= nil and WarlockModule.WarlockDataDic[self.heroCid].SkillGroups[self.skillType].id or 0
	local skillItem
	local heroEquipSkillItems = {}

	for i, v in pairs(self.allSkillItems) do
		if v.skillData.heroCid == self.heroCid then
			table.insert(heroEquipSkillItems, v)
		end
	end

	table.sort(heroEquipSkillItems, function(a, b)
		return a.skillData.heroPos < b.skillData.heroPos
	end)

	for _, v in ipairs(heroEquipSkillItems) do
		table.removeElement(self.allSkillItems, v)
	end

	for k, v in ipairs(heroEquipSkillItems) do
		table.insert(self.allSkillItems, k, v)

		if v.skillData.skillCid == heroEquipedSkillCid and heroEquipedSKillId == v.skillData.id then
			selectItemData = v
		end
	end

	if #self.allSkillItems > 0 then
		if selectItemData == nil then
			selectItemData = self.allSkillItems[1]
		end

		self.selectSkillId = selectItemData.skillData.id

		if self.itemSelectAction ~= nil then
			self.itemSelectAction(selectItemData)
		end
	end

	if isDynamic then
		self.bagScrollArea:RenderCellsDynamic(#self.allSkillItems)
	else
		self.bagScrollArea:Refresh(#self.allSkillItems)
	end
end

function DiySkillInfoBagElement:Hide()
	self:UnSelectAllItem()
	self:__RemoveListeners()

	self.selectSkillId = nil

	self.gameObject:SetActive(false)
end

function DiySkillInfoBagElement:UnSelectAllItem()
	for k, v in pairs(self.bagItemCellList) do
		v:OnCancelSelect()
	end
end

function DiySkillInfoBagElement:__OnSortingTypeChange(_index)
	self:__RefreshBagShow(true)
end

function DiySkillInfoBagElement:__OnOrderChange()
	self.sortOrder = not self.sortOrder

	self:__RefreshBagShow(true)
end

function DiySkillInfoBagElement:__RefreshBagShow(isDynamic)
	local sortType = self.sortPopupList.SelectIndex

	self.allSkillItems = DiySkillModule.GetAllDiySkillsWithWarehouse(sortType ~= 1, self.heroCid)

	WarehouseModule.SortSkills(self.allSkillItems, sortType, self.sortOrder)

	local heroEquipSkillItems = {}

	for i, v in pairs(self.allSkillItems) do
		if v.skillData.heroCid == self.heroCid then
			table.insert(heroEquipSkillItems, v)
		end
	end

	table.sort(heroEquipSkillItems, function(a, b)
		return a.skillData.heroPos < b.skillData.heroPos
	end)

	for _, v in ipairs(heroEquipSkillItems) do
		table.removeElement(self.allSkillItems, v)
	end

	for k, v in ipairs(heroEquipSkillItems) do
		table.insert(self.allSkillItems, k, v)
	end

	if isDynamic then
		self.bagScrollArea:RenderCellsDynamic(#self.allSkillItems)
	else
		self.bagScrollArea:Refresh(#self.allSkillItems)
	end
end

function DiySkillInfoBagElement:__OnRenderBagCell(cell)
	local index = cell.index + 1
	local itemData = self.allSkillItems[index]
	local instanceId = cell.gameObject:GetInstanceID()
	local bagItemCell = self.bagItemCellList[instanceId]

	if bagItemCell == nil then
		bagItemCell = diySkillBagItemCell.New(cell.gameObject)
		self.bagItemCellList[instanceId] = bagItemCell
	end

	bagItemCell:SetData(itemData, self.heroCid, index)

	if self.selectSkillId and self.selectSkillId == itemData.skillData.id then
		bagItemCell:OnSelect()
	end
end

function DiySkillInfoBagElement:__OnSelectedBagCell(cell)
	self:__CancleAllSelect()

	local itemData = self.allSkillItems[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local bagItemCell = self.bagItemCellList[instanceId]

	self.selectSkillId = itemData.skillData.id

	bagItemCell:OnSelect()

	if self.itemSelectAction ~= nil then
		self.itemSelectAction(itemData, bagItemCell.isLimit)
	end
end

function DiySkillInfoBagElement:__CancleAllSelect()
	for k, v in pairs(self.bagItemCellList) do
		v:OnCancelSelect(false)
	end
end

function DiySkillInfoBagElement:__OnDelegateUpdateItem()
	self:__RefreshBagShow(false)
end

function DiySkillInfoBagElement:__OnDelegateWearSkill()
	self:RefreshSkillBarItem()
end

function DiySkillInfoBagElement:RefreshSkillBarItem()
	self.SkillDataList = RoleDevelopmentModule.GetCurHeroSkill(self.heroCid)

	for k, v in pairs(self.skillBarItemList) do
		v:SetData(self.SkillDataList[k], k, self.heroCid)
	end
end

function DiySkillInfoBagElement:OnSelectSkillBarItem(skillType, isDynamic)
	self.skillType = skillType

	for k, v in pairs(self.skillBarItemList) do
		v:UnSelect()
	end

	self.skillBarItemList[skillType]:Select()

	if self.skillBarItemSelectHandler ~= nil then
		self.skillBarItemSelectHandler(skillType)
	end

	self:RefreshBag(isDynamic)
end

return DiySkillInfoBagElement
