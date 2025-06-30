-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillStrengthView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local MaterialItemCell = {
	ItemNum = 0,
	IsNewTips = true
}

function MaterialItemCell.New(view, fatherView, selectMatHandler)
	local obj = Clone(MaterialItemCell)

	obj:Init(view, fatherView, selectMatHandler)

	return obj
end

function MaterialItemCell:Init(view, fatherView, selectMatHandler)
	self.View = view
	self.fatherView = fatherView
	self.selectMatHandler = selectMatHandler

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateAddMatericalBtn()
		self:AddBtnClick()
	end

	function self.DelegateAddLongBtn(time)
		self:AddLongBtnClick(time)
	end

	function self.DelegateMaxBtn()
		self:MaxBtnClick()
	end

	function self.DelegateReduceBtn()
		self:ReduceBtnClick()
	end

	function self.DelegateReduceLongBtn()
		self:ReduceLongBtnClick()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self.ItemCell = ItemCell.New(self.CommonSlot, false, false)

	self:AddListeners()
end

function MaterialItemCell:AddListeners()
	self.MaxBtn:GetComponent("Button").onClick:AddListener(self.DelegateMaxBtn)
	self.View:GetComponent("LongButton").onClick:AddListener(self.DelegateAddMatericalBtn)
	self.View:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateAddLongBtn)
	self.ReduceBtn:GetComponent("LongButton").onClick:AddListener(self.DelegateReduceBtn)
	self.ReduceBtn:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateReduceLongBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function MaterialItemCell:RemoveListeners()
	self.MaxBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateMaxBtn)
	self.View:GetComponent("LongButton").onClick:RemoveListener(self.DelegateAddMatericalBtn)
	self.View:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateAddLongBtn)
	self.ReduceBtn:GetComponent("LongButton").onClick:RemoveListener(self.DelegateReduceBtn)
	self.ReduceBtn:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateReduceLongBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function MaterialItemCell:OnUpdateItem()
	if self.itemCid == nil or self.itemCid == 0 then
		return
	end

	self:SetData(self.itemCid)
end

function MaterialItemCell:SetData(itemCid)
	self.itemCid = itemCid

	UGUIUtil.SetText(self.SelectCountText, "0")
	UGUIUtil.SetText(self.MaterialCountText, "0")

	self.ItemData = WarehouseModule.FindItemForCid(self.itemCid)

	local num = 0

	if self.ItemData == nil then
		self.ItemData = ItemData.CreateByCIDAndNumber(self.itemCid, 0)
		num = self.ItemData.num
	else
		num = WarehouseModule.GetItemNumByCfgID(self.itemCid)
	end

	self.ItemNum = num

	local colorNum = string.format(ColorCfg.RoleUpdate.normalNum, num)

	UGUIUtil.SetText(self.MaterialCountText, colorNum)
	UGUIUtil.SetText(self.MaterialName, self.ItemData:GetCfg().Name)

	self.ItemExp = self.ItemData:GetCfg().ActionParams[1]

	self.ItemCell:SetItem(self.ItemData)
	self.ItemCell:SetItemNumShow(0, false)

	self.SelectCount = 0

	self.SelectParent:SetActive(false)
end

function MaterialItemCell:AddBtnClick()
	if self.SelectCount == self.ItemData.num then
		if self.ItemData.num == 0 then
			ItemModule.OpenItemTipsByItemData(self.ItemData)
		elseif self.IsNewTips then
			NoticeModule.ShowNotice(20003)

			self.IsNewTips = false
		end

		return
	end

	if not self.fatherView.IsCanUpgradeHero then
		NoticeModule.ShowNotice(20005)

		return
	end

	self.SelectParent:SetActive(true)

	self.SelectCount = self.SelectCount + 1

	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function MaterialItemCell:AddLongBtnClick()
	for i = 1, 2 do
		if not RoleDevelopmentModule.IsCanUpgradeHero then
			self:AddBtnClick()
		end
	end
end

function MaterialItemCell:InitSelect()
	self.SelectCount = 0

	LuaUtility.SetGameObjectShow(self.SelectParent, false)
end

function MaterialItemCell:MaxSingleAddClick()
	self.SelectCount = self.SelectCount + 1
end

function MaterialItemCell:ReduceBtnClick()
	self.SelectCount = self.SelectCount - 1
	self.IsNewTips = true

	if self.SelectCount < 0 then
		self.SelectCount = 0

		return
	end

	if self.SelectCount <= 0 then
		self.SelectParent:SetActive(false)
	end

	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function MaterialItemCell:ReduceLongBtnClick()
	for i = 1, 2 do
		self:ReduceBtnClick()
	end
end

function MaterialItemCell:MaxBtnClick()
	local count = RoleDevelopmentModule.GetSelectMaterialMaxCount(self.ItemExp)

	if count <= 0 then
		return
	end

	if self.SelectCount >= self.ItemNum then
		return
	end

	if count <= self.ItemNum then
		self.SelectCount = self.SelectCount + count
	else
		self.SelectCount = self.SelectCount + self.ItemNum

		if self.SelectCount >= self.ItemNum then
			self.SelectCount = self.ItemNum
		end
	end

	self:ShowSelectInfo()
	self.SelectParent:SetActive(true)
	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
end

function MaterialItemCell:IsMaxSelect()
	return self.SelectCount >= self.ItemNum
end

function MaterialItemCell:ClearSelect()
	if self.SelectCount <= 0 then
		return
	end

	self.SelectCount = 0

	if self.SelectCount <= 0 then
		self.SelectParent:SetActive(false)
	end

	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function MaterialItemCell:ShowSelectInfo()
	if self.selectMatHandler then
		self.selectMatHandler({
			[self.ItemData.cid] = {
				self.SelectCount,
				self.SelectCount * self.ItemExp
			}
		})
	end
end

function MaterialItemCell:SetSelectCount(num)
	self.SelectCount = num

	if self.SelectCount > 0 then
		UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
		self.SelectParent:SetActive(true)
	else
		self.SelectParent:SetActive(false)
	end
end

function MaterialItemCell:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local MATERIAL_CELL_COUNT = 8
local quickStrengthFilterText = {
	EquipApi:GetTextFilter(1),
	EquipApi:GetTextFilter(2),
	(EquipApi:GetTextFilter(3))
}
local DiySkillStrengthView = {
	IsCanUpgradeHero = false,
	MaterialItemIds = {},
	SkillAttributes = {},
	MaterialItems = {},
	CurSelectMaterialItems = {},
	SelectUpgradeItems = {}
}

function DiySkillStrengthView.New(view, matCellClickEvent, matChangeEvent)
	local obj = Clone(DiySkillStrengthView)

	obj:__Init(view, matCellClickEvent, matChangeEvent)

	return obj
end

function DiySkillStrengthView:__Init(view, matCellClickEvent, matChangeEvent)
	self.gameObject = view
	self.matCellClickEvent = matCellClickEvent
	self.matChangeEvent = matChangeEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	for i = 1, self.itemGrid.transform.childCount do
		table.insert(self.MaterialItems, MaterialItemCell.New(self.itemGrid.transform:GetChild(i - 1).gameObject, self, function(mat)
			self:SelectMaterialCallback(mat)
		end))
	end

	function self.__onClearButtonClickProxy()
		self:__OnClearButtonClickHandler()
	end

	function self.__onQuickAddButtonClickProxy()
		self:__OnQuickAddButtonClickHandler()
	end

	function self.__onStrengthButtonClickProxy()
		self:__OnStrengthButtonClickHandler()
	end

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)

	self.moneyCell:RefreshItem(Constant.TopMoneyType.DiySkillStrengthUI)

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
	self:__AddListeners()
end

function DiySkillStrengthView:__AddListeners()
	self.ClearSelectBtn:GetComponent("Button").onClick:AddListener(self.__onClearButtonClickProxy)
	self.QuickAddBtn:GetComponent("Button").onClick:AddListener(self.__onQuickAddButtonClickProxy)
	self.strengthBtn:GetComponent("Button").onClick:AddListener(self.__onStrengthButtonClickProxy)
end

function DiySkillStrengthView:__RemoveListeners()
	self.ClearSelectBtn:GetComponent("Button").onClick:RemoveListener(self.__onClearButtonClickProxy)
	self.QuickAddBtn:GetComponent("Button").onClick:RemoveListener(self.__onQuickAddButtonClickProxy)
	self.strengthBtn:GetComponent("Button").onClick:RemoveListener(self.__onStrengthButtonClickProxy)
end

function DiySkillStrengthView:Dispose()
	self.moneyCell:Dispose()
	self.consumeGoldCell:Dispose()

	for k, v in pairs(self.MaterialItems) do
		v:Dispose()
	end

	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillStrengthView:SetData(skillData, isMaxLevel)
	self.CurSelectMaterialItems = {}
	self.SelectUpgradeItems = {}
	self.materialAddExp = 0

	self:RefreshUpgradeBtnInteractable()
	self.gameObject:SetActive(true)

	self.curSkillData = skillData

	self:__Refresh(isMaxLevel)
	LuaUtility.SetGameObjectShow(self.StrengthBoxGirdParent, not isMaxLevel)
	LuaUtility.SetGameObjectShow(self.BottomBtnParent, not isMaxLevel)
	LuaUtility.SetGameObjectShow(self.filterRoot, not isMaxLevel)
	LuaUtility.SetGameObjectShow(self.maxLevelRoot, isMaxLevel)
	EventDispatcher.Dispatch(EventID.PlayDiySkillStrengthInAnimationEvent, nil, nil, true)
	self:RefreshMaterialItems()
end

function DiySkillStrengthView:Hide()
	self.gameObject:SetActive(false)
end

function DiySkillStrengthView:__Refresh(isMaxLevel)
	local showPreviewObj = self.materialAddExp > 0

	LuaCodeInterface.SetGameObjectShow(self.previewItem, showPreviewObj)
	LuaCodeInterface.SetGameObjectShow(self.previewExpText, showPreviewObj)

	self.costMoney = self.materialAddExp * CfgDiscreteDataTable[2].Data[1] / 100

	if self.materialAddExp == 0 then
		self:SetQuickAddButtonShow(true)
	end

	local totalExp = DiySkillModule.GetSkillTotalExpBySkillData(self.curSkillData) + self.materialAddExp
	local previewLv, overflowExp, maxLevel = DiySkillModule.CalcSkillLevelDataWithTotalEXPBySkillData(self.curSkillData, totalExp)

	self:__CreatePreviewAttributeChangeData(previewLv)

	self.overflowExp = previewLv == maxLevel and overflowExp or -1

	UGUIUtil.SetText(self.levelNumText, self.curSkillData.lv)
	UGUIUtil.SetText(self.previewLevelText, DiySkillStrengthenUIApi:GetPreviewAddLevelText(previewLv - self.curSkillData.lv))
	UGUIUtil.SetText(self.previewExpText, DiySkillStrengthenUIApi:GetPreviewMaterialAddExpText(self.materialAddExp))

	local previewLevelCfg = DiySkillModule.GetCfgSkillLevelData(self.curSkillData.Quality, previewLv)
	local levelCfg = DiySkillModule.GetCfgSkillLevelData(self.curSkillData.Quality, self.curSkillData.lv)

	LuaUtility.SetText(self.limitExpNumText, levelCfg.UpgradeNeedExp[1])
	LuaUtility.SetText(self.presentNumText, self.curSkillData.exp)

	if previewLv == maxLevel then
		self.expPreviewImg:GetComponent("Image").fillAmount = 1
		self.expPresentImg:GetComponent("Image").fillAmount = 1
	else
		self.expPresentImg:GetComponent("Image").fillAmount = self.curSkillData.exp / levelCfg.UpgradeNeedExp[1]
		self.expPreviewImg:GetComponent("Image").fillAmount = overflowExp / previewLevelCfg.UpgradeNeedExp[1]
	end

	self.consumeGoldCell:SetData(self.costMoney)
	LuaUtility.SetGameObjectShow(self.textMAX, isMaxLevel)
	LuaUtility.SetGameObjectShow(self.limitExpNumText, not isMaxLevel)

	self.IsCanUpgradeHero = previewLv < maxLevel

	if self.matCellClickEvent then
		self.matCellClickEvent()
	end
end

function DiySkillStrengthView:__CreatePreviewAttributeChangeData(previewLv)
	self.SkillAttributes = {}

	local baseSubAttrs = DiySkillModule.GetSkillLevelAttributes(self.curSkillData.Quality, self.curSkillData.skillCid, self.curSkillData.lv, self.curSkillData.purifyLv, Constant.DIYSkillDisplayAttrTable)
	local newAddSubAttrs = DiySkillModule.GetSkillLevelAttributes(self.curSkillData.Quality, self.curSkillData.skillCid, previewLv, self.curSkillData.purifyLv, Constant.DIYSkillDisplayAttrTable)
	local rankAttrs = DiySkillModule.GetSkillRankAttributes(self.curSkillData.skillCid, self.curSkillData.strengLv, Constant.DIYSkillDisplayAttrTable)

	for _attrType, __attrValue in pairs(newAddSubAttrs) do
		local attrData = {}

		attrData.type = _attrType
		attrData.curLvValue = baseSubAttrs[_attrType] + rankAttrs[_attrType]
		attrData.nextLvValue = __attrValue + rankAttrs[_attrType]

		table.insert(self.SkillAttributes, attrData)
	end
end

function DiySkillStrengthView:__OnClearButtonClickHandler()
	self:SetQuickAddButtonShow(true)

	self.materialAddExp = 0
	self.SelectUpgradeItems = {}
	self.CurSelectMaterialItems = {}

	for k, v in pairs(self.MaterialItems) do
		v:SetSelectCount(0)
	end

	self:__Refresh()
end

function DiySkillStrengthView:__OnQuickAddButtonClickHandler()
	local havingMaterial = RoleDevelopmentModule.GetHavingUpgradeMaterial(self.UpgradeItems)

	if not havingMaterial then
		NoticeModule.ShowNotice(45012)

		return
	end

	self:SetQuickAddButtonShow(false)

	self.materialAddExp = 0
	self.SelectUpgradeItems = {}
	self.CurSelectMaterialItems = {}

	local totalCost = WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD)
	local mats, cost, maxExp = DiySkillModule.GetOneKeyDiySkillUpgradeMatNew(self.curSkillData, totalCost)

	ForPairs(mats, function(_itemId, num)
		local itemData = WarehouseModule.GetItemDataById(_itemId)

		if self.SelectUpgradeItems[itemData.cid] == nil then
			self.SelectUpgradeItems[itemData.cid] = num
		else
			self.SelectUpgradeItems[itemData.cid] = self.SelectUpgradeItems[itemData.cid] + num
		end

		local itemCfg = CfgItemTable[itemData.cid]
		local exp = num * itemCfg.ActionParams[1]

		if self.CurSelectMaterialItems[itemData.cid] == nil then
			self.CurSelectMaterialItems[itemData.cid] = {
				num,
				exp
			}
		else
			local count = self.CurSelectMaterialItems[itemData.cid][1]
			local curExp = self.CurSelectMaterialItems[itemData.cid][2]

			self.CurSelectMaterialItems[itemData.cid] = {
				count + num,
				curExp + exp
			}
		end

		self.materialAddExp = self.materialAddExp + exp
	end)
	ForPairs(self.MaterialItems, function(_, itemCell)
		itemCell:SetSelectCount(0)
		ForPairs(self.SelectUpgradeItems, function(_itemCid, _itemNum)
			if itemCell.itemCid == _itemCid then
				itemCell:SetSelectCount(_itemNum)

				return
			end
		end)
	end)
	self:__Refresh()
	self:RefreshUpgradeBtnInteractable()
end

function DiySkillStrengthView:__OnStrengthButtonClickHandler()
	if table.len(self.SelectUpgradeItems) <= 0 then
		NoticeModule.ShowNotice(45012)

		return
	end

	if self.costMoney > WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD) then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	self:__DoStrength()
end

function DiySkillStrengthView:__DoStrength()
	RoleDevelopmentModule.RoleSkillUpgrade(self.curSkillData.id, self.SelectUpgradeItems)
end

function DiySkillStrengthView:SetQuickAddButtonShow(show)
	LuaUtility.SetGameObjectShow(self.QuickAddBtn, show)
	LuaUtility.SetGameObjectShow(self.ClearSelectBtn, not show)
end

function DiySkillStrengthView:RefreshMaterialItems()
	self.UpgradeItems = RoleDevelopmentModule.GetItemByActionType(Constant.ActionType.AddSkillExpAction)

	table.sort(self.UpgradeItems, function(tab1, tab2)
		return tab1.Quality < tab2.Quality
	end)

	for i = 1, #self.UpgradeItems do
		self.MaterialItems[i]:SetData(self.UpgradeItems[i].Id)
	end

	local havingMaterial = RoleDevelopmentModule.GetHavingUpgradeMaterial(self.UpgradeItems)

	self.QuickAddBtn:GetComponent("GrayComponent"):SetGray(not havingMaterial)
end

function DiySkillStrengthView:SelectMaterialCallback(data)
	for k, v in pairs(data) do
		if v[1] <= 0 then
			self.CurSelectMaterialItems[k] = nil
			self.SelectUpgradeItems[k] = nil
		else
			self.CurSelectMaterialItems[k] = v
			self.SelectUpgradeItems[k] = v[1]
		end
	end

	self:RefreshUpgradeBtnInteractable()
	self:RefreshSelectAllExp()
end

function DiySkillStrengthView:RefreshSelectAllExp()
	self.materialAddExp = 0

	for k, v in pairs(self.CurSelectMaterialItems) do
		self.materialAddExp = self.materialAddExp + v[2]
	end

	self:__Refresh()
end

function DiySkillStrengthView:RefreshUpgradeBtnInteractable()
	local isGray = table.len(self.SelectUpgradeItems) <= 0

	self.strengthBtn:GetComponent("GrayComponent"):SetGray(isGray)

	self.strengthBtn:GetComponent("Button").enabled = not isGray
end

return DiySkillStrengthView
