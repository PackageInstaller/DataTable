-- chunkname: @IQIGame\\UI\\Equip\\MainView\\EquipSuccinctRightView.lua

local PropertyItem = {}

function PropertyItem.New(view)
	local obj = Clone(PropertyItem)

	obj:__Init(view)

	return obj
end

function PropertyItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function PropertyItem:Show(cid, selectAttrType, canNotWashAttributeIDs)
	self.gameObject:SetActive(true)

	local cfg = CfgEquipSuccinctTable[cid]
	local cfgAttribute = CfgAttributeTable[cfg.Attr]
	local iconPath = UIGlobalApi.IconPath .. cfgAttribute.ImageUrl

	AssetUtil.LoadImage(self, iconPath, self.Icon:GetComponent("Image"))

	local canWash = table.indexOf(canNotWashAttributeIDs, cfgAttribute.Id) == -1

	self.Content:GetComponent("Text").text = EquipStrengthUIApi:GetPropertyItemText(cfg.AttrName, canWash)

	local isSelect = selectAttrType == cfg.Attr

	self.SelectView.gameObject:SetActive(isSelect)
end

function PropertyItem:Hide()
	self.gameObject:SetActive(false)
end

function PropertyItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local View = {}

function View.New(view)
	local obj = Clone(View)

	obj:__Init(view)

	return obj
end

function View:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.DelegateUpdateItem()
		self:__RefreshCostItem()
	end

	self.attributeItemTable = {}

	ForTransformChild(self.PropertyRoot.transform, function(_trans, _index)
		local item = PropertyItem.New(_trans.gameObject)

		table.insert(self.attributeItemTable, item)
	end)

	self.leftCostItem = ItemCell.New(self.CostLeftItem, true, true, true)

	self.leftCostItem:SetClickHandler(self.__OnLeftCostItemSelect, self)
	self.leftCostItem:SetItemByCid(CfgDiscreteDataTable[210].Data[1], CfgDiscreteDataTable[210].Data[2])

	self.rightCostItem = ItemCell.New(self.CostRightItem, true, true, true)

	self.rightCostItem:SetClickHandler(self.__OnRightCostItemSelect, self)
	self.rightCostItem:SetItemByCid(CfgDiscreteDataTable[211].Data[1], CfgDiscreteDataTable[211].Data[2])
	UIEventUtil.AddClickEventListener_Button(self, "SuccinctBtn", self.__OnSuccinctBtnClick)
	UIEventUtil.AddClickEventListener_Button(self, "JumpStrengthBtn", self.__OnJumpStrengthBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function View:__OnLeftCostItemSelect(itemCell)
	self.__isSuccinctProperty = 1

	self:__RefreshSelectCostItem()

	self.CostMoney:GetComponent("Text").text = CfgDiscreteDataTable[210].Data[4]

	self:__CheckCost(210)
	UGUIUtil.SetText(self.DescText, EquipStrengthUIApi:GetDescText(210))
end

function View:__OnRightCostItemSelect(itemCell)
	self.__isSuccinctProperty = 2

	self:__RefreshSelectCostItem()

	self.CostMoney:GetComponent("Text").text = CfgDiscreteDataTable[211].Data[4]

	self:__CheckCost(211)
	UGUIUtil.SetText(self.DescText, EquipStrengthUIApi:GetDescText(211, self.__attrName))
end

function View:__RefreshSelectCostItem()
	self.leftCostItem:SetSelectFrame(self.__isSuccinctProperty == 1)
	self.rightCostItem:SetSelectFrame(self.__isSuccinctProperty == 2)
end

function View:__CheckCost(cid)
	self.__hasEnough = true

	local costCfgData = CfgDiscreteDataTable[cid].Data

	ForArrayCustomStep(costCfgData, function(_index, _itemCid)
		local cnt = WarehouseModule.GetItemNumByCfgID(_itemCid)

		self.__hasEnough = cnt >= costCfgData[_index + 1]

		return not self.__hasEnough
	end, 2)
end

function View:Show(equipData, attTable, attributeIndex)
	self.gameObject:SetActive(true)

	local attributeData = equipData.baseAttribute.Other[attributeIndex]

	if attributeData == nil then
		return
	end

	self.__equipData = equipData
	self.__attrCid = attributeData.onlyId
	self.__attrName = attributeData.Name
	self.__canNotWashAttributeIDs = {}

	for i = 1, #equipData.baseAttribute.Other do
		if i ~= attributeIndex then
			local attribute = equipData.baseAttribute.Other[i]

			table.insert(self.__canNotWashAttributeIDs, attribute.id)
		end
	end

	if self.__isSuccinctProperty == 2 then
		self:__OnRightCostItemSelect()
	else
		self:__OnLeftCostItemSelect()
	end

	self:__RefreshCostItem()

	local contentText = ""

	if attributeData.OldAddAttNum == 0 then
		local attrInerval = CfgEquipAttrTable[attributeData.onlyId].AttrShowRange
		local attrCfg = CfgAttributeTable[attributeData.id]
		local str = string.format("[%s-%s]", EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[1]), EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[2]))

		contentText = attributeData.Name .. " " .. str

		local equipCfg = equipData:GetEquipCfg()

		UGUIUtil.SetText(self.ConditionText, EquipStrengthUIApi:GetConditionText(equipCfg.CountCondition[attributeIndex]))
	else
		contentText = attributeData.Name .. " + " .. attributeData.AddAttNum
	end

	self.PropertyDesc:GetComponent("Text").text = contentText

	ForArray(self.attributeItemTable, function(_index, _item)
		local cid = attTable[_index]

		if cid == nil then
			_item:Hide()
		else
			_item:Show(cid, attributeData.id, self.__canNotWashAttributeIDs)
		end
	end)
	self.UnlockNode:SetActive(attributeData.OldAddAttNum ~= 0)
	self.LockNode:SetActive(attributeData.OldAddAttNum == 0)
end

function View:__OnSuccinctBtnClick()
	if not self.__hasEnough then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "消耗不足")

		return
	end

	net_equip.succinctAttr(self.__equipData.id, self.__attrCid, self.__isSuccinctProperty)
end

function View:__OnJumpStrengthBtn()
	EventDispatcher.Dispatch(EventID.JumpToStrengthEvent)
end

function View:__RefreshCostItem()
	if self.CostLeftText and not LuaCodeInterface.GameObjIsDestroy(self.CostLeftText) then
		local leftItemCid = CfgDiscreteDataTable[210].Data[1]
		local leftItemNeedNum = CfgDiscreteDataTable[210].Data[2]
		local leftHaveNum = WarehouseModule.GetItemNumByCfgID(leftItemCid)

		UGUIUtil.SetText(self.CostLeftText, EquipStrengthUIApi:GetCostText(leftHaveNum, leftItemNeedNum))
	end

	if self.CostRightText and not LuaCodeInterface.GameObjIsDestroy(self.CostRightText) then
		local rightItemCid = CfgDiscreteDataTable[211].Data[1]
		local rightItemNeedNum = CfgDiscreteDataTable[211].Data[2]
		local rightHaveNum = WarehouseModule.GetItemNumByCfgID(rightItemCid)

		UGUIUtil.SetText(self.CostRightText, EquipStrengthUIApi:GetCostText(rightHaveNum, rightItemNeedNum))
	end
end

function View:Hide()
	self.gameObject:SetActive(false)
end

function View:Dispose()
	UIEventUtil.ClearEventListener(self)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return View
