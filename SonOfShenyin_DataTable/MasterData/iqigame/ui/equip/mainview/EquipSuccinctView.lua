-- chunkname: @IQIGame\\UI\\Equip\\MainView\\EquipSuccinctView.lua

local EquipSuccinctRightView = require("IQIGame/UI/Equip/MainView/EquipSuccinctRightView")
local AttributeItem = {}

function AttributeItem.New(view, callback)
	local obj = Clone(AttributeItem)

	obj:__Init(view, callback)

	return obj
end

function AttributeItem:__Init(view, callback)
	self.gameObject = view
	self.__callback = callback

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "SelectBtn", self.__OnItemClick)
end

function AttributeItem:__OnItemClick()
	self.__callback(self.attributeIndex, self.__isLocked)
end

function AttributeItem:Show(attributeData, index, unlockLevel)
	self.gameObject:SetActive(true)
	self.SelectView.gameObject:SetActive(false)
	self.TagView.gameObject:SetActive(false)

	self.attributeIndex = index
	self.__isLocked = attributeData.OldAddAttNum == 0

	local contentText = ""
	local quality = 0

	if self.__isLocked then
		self.LockRoot.gameObject:SetActive(true)

		self.LockText:GetComponent("Text").text = EquipApi:GetUnLockLvDescribute(unlockLevel)

		local attrInerval = CfgEquipAttrTable[attributeData.onlyId].AttrShowRange
		local attrCfg = CfgAttributeTable[attributeData.id]
		local str = string.format("[%s-%s]", EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[1]), EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[2]))

		contentText = attributeData.Name .. " " .. str
	else
		self.LockRoot.gameObject:SetActive(false)

		contentText = attributeData.Name .. " + " .. attributeData.AddAttNum

		local cfgData = self.__GetEquipSuccinctData(CfgEquipAttrTable[attributeData.onlyId].MasterAttrType)
		local numStr = string.gsub(attributeData.AddAttNum, "%%", "")
		local num = TryToNumber(numStr, 0)

		self.TagView.gameObject:SetActive(num >= cfgData.AttrStone)

		for i = 1, #cfgData.AttrQuality do
			local value = cfgData.AttrQuality[i]

			if value <= num then
				quality = i
			end
		end
	end

	self.ContentText:GetComponent("Text").text = EquipStrengthUIApi:GetQualityAttr(contentText, quality)

	AssetUtil.LoadImage(self, attributeData.ImageUrl, self.Icon:GetComponent("Image"))
end

function AttributeItem.__GetEquipSuccinctData(attrType)
	local cfg

	ForPairs(CfgEquipSuccinctTable, function(_cid, _cfg)
		if _cfg.Attr ~= attrType then
			return
		end

		cfg = _cfg

		return true
	end)

	return cfg
end

function AttributeItem:ChangeSelected(isSelect)
	self.SelectView.gameObject:SetActive(isSelect)
end

function AttributeItem:Hide()
	self.gameObject:SetActive(false)
end

function AttributeItem:Dispose()
	UIEventUtil.ClearEventListener(self)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EquipSuccinctView = {
	AttributeItemTable = {}
}

function EquipSuccinctView.New(view)
	local obj = Clone(EquipSuccinctView)

	obj:__Init(view)

	return obj
end

function EquipSuccinctView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.AttributeItemRoot.transform, function(_trans, _index)
		local item = AttributeItem.New(_trans.gameObject, function(__index)
			self:__OnPropertyItemClick(__index)
		end)

		table.insert(self.AttributeItemTable, item)
	end)

	self.rightView = EquipSuccinctRightView.New(self.RightRoot)

	EventUtil.AddEventListener(self, EventID.OnApplySuccinctAttrResult, self.__Refresh)
end

function EquipSuccinctView:Show(equipData, xxx)
	self.gameObject:SetActive(true)

	self.__equipData = equipData
	self.__xxx = xxx

	self.__xxx.gameObject:SetActive(false)

	local cfgEquip = equipData:GetEquipCfg()

	AssetUtil.LoadImage(self, EquipApi:GetEquipBigIconPath(equipData.cid), self.EquipIcon:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipAttrQualityImagePath(cfgEquip.Place, cfgEquip.Quality), self.EquipQualityImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipQualityBgPath(cfgEquip.Place), self.EquipQualityBG:GetComponent("Image"))
	LuaUtility.SetText(self.EquipPartName, EquipApi:GetPartName(cfgEquip.Place))
	LuaUtility.SetText(self.EquipLevel, "+ " .. equipData.lv)

	if self.EquipPartName1 then
		LuaUtility.SetText(self.EquipPartName1, EquipApi:GetPartName(cfgEquip.Place))
	end

	if self.EquipStrengthLevelText then
		LuaUtility.SetText(self.EquipStrengthLevelText, "+ " .. equipData.lv)
	end

	if self.EquipName then
		LuaUtility.SetText(self.EquipName, equipData:GetEquipCfg().Name)
	end

	self:__RefreshAttributes(equipData)
	self:__RefreshRightView(equipData)
end

function EquipSuccinctView:__Refresh()
	local itemData = WarehouseModule.GetItemDataById(self.__equipData.id)

	self:Show(itemData.equipData, self.__xxx)
end

function EquipSuccinctView:__RefreshAttributes(equipData)
	local equipCfg = equipData:GetEquipCfg()
	local attributes = equipData.baseAttribute.Other

	if self.__attributeIndex == nil then
		self.__attributeIndex = 1
	end

	ForArray(self.AttributeItemTable, function(_index, _item)
		local attribute = attributes[_index]

		if attribute == nil then
			_item:Hide()
		else
			_item:Show(attribute, _index, equipCfg.CountCondition[_index])
			_item:ChangeSelected(self.__attributeIndex == _index)
		end
	end)
end

function EquipSuccinctView:__OnPropertyItemClick(index)
	self.__attributeIndex = index

	ForArray(self.AttributeItemTable, function(_index, _item)
		_item:ChangeSelected(_item.attributeIndex == self.__attributeIndex)
	end)
	self:__RefreshRightView(self.__equipData)
end

function EquipSuccinctView:__RefreshRightView(equipData)
	local mainAttr = equipData.baseAttribute.Main[1]
	local attrConfig = CfgEquipAttrTable[mainAttr.equipAttrID]
	local attributeTable = {}

	ForPairs(CfgEquipSuccinctTable, function(_cid, _cfg)
		if _cfg.Attr == attrConfig.MasterAttrType then
			return
		end

		table.insert(attributeTable, _cid)
	end)

	if self.__attributeIndex == 0 then
		self.rightView:Hide()
	else
		self.rightView:Show(equipData, attributeTable, self.__attributeIndex)
	end
end

function EquipSuccinctView:Hide()
	self.__xxx = nil

	self.gameObject:SetActive(false)
end

function EquipSuccinctView:Dispose()
	self.__xxx = nil

	EventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return EquipSuccinctView
