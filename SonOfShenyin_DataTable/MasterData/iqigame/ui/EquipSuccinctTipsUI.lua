-- chunkname: @IQIGame\\UI\\EquipSuccinctTipsUI.lua

local ItemView = {}

function ItemView.New(view)
	local obj = Clone(ItemView)

	obj:__Init(view)

	return obj
end

function ItemView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ItemView:Show(attrCid, attrValue)
	local equipAttrCfg = CfgEquipAttrTable[attrCid]
	local cfgAttribute = CfgAttributeTable[equipAttrCfg.MasterAttrType]
	local path = UIGlobalApi.IconPath .. cfgAttribute.ImageUrl

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))

	local attrValueStr = EquipApi:FormatAttrValue(cfgAttribute.IsPer, attrValue)

	self.Content:GetComponent("Text").text = cfgAttribute.Name .. " + " .. attrValueStr

	local sliderCom = self.Slider:GetComponent("Slider")

	sliderCom.minValue = equipAttrCfg.AttrShowRange[1] * 1000
	sliderCom.maxValue = equipAttrCfg.AttrShowRange[2] * 1000
	sliderCom.value = attrValue * 1000

	self.gameObject:SetActive(true)
end

function ItemView:Hide()
	self.gameObject:SetActive(false)
end

function ItemView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EquipSuccinctTipsUI = Base:Extend("EquipSuccinctTipsUI", "IQIGame.Onigao.UI.EquipSuccinctTipsUI", {})

function EquipSuccinctTipsUI:OnInit()
	self.leftPropertyView = ItemView.New(self.LeftRoot)
	self.rightPropertyView = ItemView.New(self.RightRoot)

	UIEventUtil.AddClickEventListener_Button(self, "Btn1", self.__OnBtn1Click)
	UIEventUtil.AddClickEventListener_Button(self, "Btn2", self.__OnBtn2Click)
	UIEventUtil.AddClickEventListener_Button(self, "Btn3", self.__OnBtn3Click)
end

function EquipSuccinctTipsUI:GetPreloadAssetPaths()
	return nil
end

function EquipSuccinctTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipSuccinctTipsUI:IsManualShowOnOpen(userData)
	return false
end

function EquipSuccinctTipsUI:GetBGM(userData)
	return nil
end

function EquipSuccinctTipsUI:OnOpen(userData)
	self.__userData = userData

	ForPairs(self.__userData.attrMap, function(_sourceAttrCid, _targetAttrCid)
		local _sourceAttrValue = self.__userData.attrValueMap[_sourceAttrCid]

		if _sourceAttrCid == _targetAttrCid then
			_sourceAttrValue = self:__GetEquipAttrValue(self.__userData.equipId, _sourceAttrCid)
		end

		self.leftPropertyView:Show(_sourceAttrCid, _sourceAttrValue)
		self.rightPropertyView:Show(_targetAttrCid, self.__userData.attrValueMap[_targetAttrCid])
	end)
end

function EquipSuccinctTipsUI:__GetEquipAttrValue(equipId, attrCid)
	local itemData = WarehouseModule.GetItemDataById(equipId)
	local attributeData

	ForPairs(itemData.equipData.sourceSlaverAttrs, function(_, _attrData)
		if _attrData.attrId ~= attrCid then
			return
		end

		attributeData = _attrData

		return true
	end)

	if attributeData == nil then
		return 0
	end

	return attributeData.attrValue
end

function EquipSuccinctTipsUI:OnClose(userData)
	return
end

function EquipSuccinctTipsUI:OnAddListeners()
	return
end

function EquipSuccinctTipsUI:OnRemoveListeners()
	return
end

function EquipSuccinctTipsUI:OnPause()
	return
end

function EquipSuccinctTipsUI:OnResume()
	return
end

function EquipSuccinctTipsUI:OnCover()
	return
end

function EquipSuccinctTipsUI:OnReveal()
	return
end

function EquipSuccinctTipsUI:OnRefocus(userData)
	return
end

function EquipSuccinctTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipSuccinctTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipSuccinctTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipSuccinctTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipSuccinctTipsUI:OnDestroy()
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
end

function EquipSuccinctTipsUI:__OnBtn1Click()
	UIModule.Close(Constant.UIControllerName.EquipSuccinctTipsUI)
	EventDispatcher.Dispatch(EventID.OnApplySuccinctAttrResult)
end

function EquipSuccinctTipsUI:__OnBtn2Click()
	UIModule.Close(Constant.UIControllerName.EquipSuccinctTipsUI)

	if not self:__CheckCost() then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "消耗不足")
	else
		net_equip.succinctAttr(self.__userData.equipId, self.__userData.attrCid, self.__userData.succinctType)
	end
end

function EquipSuccinctTipsUI:__CheckCost()
	local hasEnough = true
	local cid = 210

	if self.__userData.succinctType == 2 then
		cid = 211
	end

	local costCfgData = CfgDiscreteDataTable[cid].Data

	ForArrayCustomStep(costCfgData, function(_index, _itemCid)
		local cnt = WarehouseModule.GetItemNumByCfgID(_itemCid)

		hasEnough = cnt >= costCfgData[_index + 1]

		return not hasEnough
	end, 2)

	return hasEnough
end

function EquipSuccinctTipsUI:__OnBtn3Click()
	UIModule.Close(Constant.UIControllerName.EquipSuccinctTipsUI)
	net_equip.applySuccinctAttr(self.__userData.equipId, 1)
end

return EquipSuccinctTipsUI
