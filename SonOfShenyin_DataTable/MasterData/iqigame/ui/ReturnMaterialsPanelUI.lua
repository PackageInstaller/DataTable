-- chunkname: @IQIGame\\UI\\ReturnMaterialsPanelUI.lua

local returnMaterialItemCell = {}

function returnMaterialItemCell.New(view)
	local obj = Clone(returnMaterialItemCell)

	obj:Init(view)

	return obj
end

function returnMaterialItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.commonSlotUI, true, true, true)
end

function returnMaterialItemCell:SetItem(itemData, tag)
	if itemData == nil then
		self:Hide()

		return
	end

	self.ItemCell:SetItem(itemData)
	self.ItemCell:SetNum(itemData.num)

	self.ItemNameText:GetComponent("Text").text = ""
end

function returnMaterialItemCell:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function returnMaterialItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function returnMaterialItemCell:Dispose()
	self.ItemCell:Dispose()

	self.ItemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local ReturnMaterialsPanelUI = {
	isShowAllItem = false,
	ShowIndex = 1,
	DelayTime = 0.2,
	isDelay = true,
	ItemList = {}
}

ReturnMaterialsPanelUI = Base:Extend("ReturnMaterialsPanelUI", "IQIGame.Onigao.UI.ReturnMaterialsPanelUI", ReturnMaterialsPanelUI)

local GetPanelItemCell = require("IQIGame.UI.GetPanel.GetPanelItemCell")

function ReturnMaterialsPanelUI:OnInit()
	self.ContentGridLayout = self.ItemContentParent:GetComponent("GridLayoutGroup")
	self.ContentSizeFitter = self.ItemContentParent:GetComponent("ContentSizeFitter")
end

function ReturnMaterialsPanelUI:GetPreloadAssetPaths()
	return nil
end

function ReturnMaterialsPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ReturnMaterialsPanelUI:IsManualShowOnOpen(userData)
	return false
end

function ReturnMaterialsPanelUI:GetBGM(userData)
	return nil
end

function ReturnMaterialsPanelUI:OnOpen(userData)
	LuaUtility.PlaySoundWithID(11100005)

	self.isDelay = true

	self:HideItem()
	self:RefreshShow(userData)
end

function ReturnMaterialsPanelUI:OnClose(userData)
	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end
end

function ReturnMaterialsPanelUI:OnAddListeners()
	return
end

function ReturnMaterialsPanelUI:OnRemoveListeners()
	return
end

function ReturnMaterialsPanelUI:OnPause()
	return
end

function ReturnMaterialsPanelUI:OnResume()
	return
end

function ReturnMaterialsPanelUI:OnCover()
	return
end

function ReturnMaterialsPanelUI:OnReveal()
	return
end

function ReturnMaterialsPanelUI:OnRefocus(userData)
	return
end

function ReturnMaterialsPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ReturnMaterialsPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ReturnMaterialsPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ReturnMaterialsPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ReturnMaterialsPanelUI:OnDestroy()
	for _, v in pairs(self.ItemList) do
		v:Dispose()
	end

	self.ItemList = {}

	self:StopTimer()
	AssetUtil.UnloadAsset(self)
end

function ReturnMaterialsPanelUI:RefreshShow(userData)
	if userData == nil then
		return
	end

	self.callback = userData.callback
	self.args = userData.args
	self.isShowAllItem = false
	self.ShowIndex = 1

	self:AwardShow(userData)
	self:SetTitleState()
end

function ReturnMaterialsPanelUI:SetTitleState()
	local state = false

	if self.args == nil or self.args[1] == nil then
		state = false
	end

	state = self.args[1]

	LuaUtility.SetGameObjectShow(self.TitleText, state)
end

function ReturnMaterialsPanelUI:AwardShow(userData)
	self.UserData = userData
	self.RawItemDatas = {}

	for i = 1, #self.UserData.items do
		local cfgItem = CfgItemTable[self.UserData.items[i].cid]

		if cfgItem and cfgItem.IsHide ~= 1 then
			local rawItemData = self.UserData.items[i]

			table.insert(self.RawItemDatas, rawItemData)
		end
	end

	self:UpdateView(self.RawItemDatas, self.UserData.args)
end

function ReturnMaterialsPanelUI:HideItem()
	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end
end

function ReturnMaterialsPanelUI:UpdateView(items, args)
	self:CreateSlotItem()
end

function ReturnMaterialsPanelUI:CreateSlotItem()
	self.ContentSizeFitter.enabled = true
	self.ContentGridLayout.enabled = true

	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end

	local tag = 0
	local itemData

	for i = 1, #self.RawItemDatas do
		local itemObj = self:InstantiateItemObj(i)
		local rawItemData = self.RawItemDatas[i]

		if rawItemData ~= nil then
			itemData = ItemData.CreateItemShowDataByItemShowPOD(rawItemData)
			tag = rawItemData.tag
		end

		itemObj:SetItem(itemData, tag)
		self.ItemList[i]:Show()
	end

	self:StopTimer()

	self.countDownTimer = Timer.New(function()
		UIModule.Close(Constant.UIControllerName.ReturnMaterialsPanelUI)
	end, 1.5, 1)

	self.countDownTimer:Start()
end

function ReturnMaterialsPanelUI:InstantiateItemObj(index)
	local itemObj = self.ItemList[index]

	if itemObj == nil then
		local obj = UnityEngine.Object.Instantiate(self.Grid_Mould)

		itemObj = GetPanelItemCell.New(obj)

		obj.transform:SetParent(self.ItemContentParent.transform, false)

		self.ItemList[index] = itemObj
	end

	return itemObj
end

function ReturnMaterialsPanelUI:StopTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end
end

return ReturnMaterialsPanelUI
