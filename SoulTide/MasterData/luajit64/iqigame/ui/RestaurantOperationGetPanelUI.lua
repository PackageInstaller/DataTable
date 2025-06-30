-- chunkname: @IQIGame\\UI\\RestaurantOperationGetPanelUI.lua

local RestaurantOperationGetPanelUI = {
	getItemCellPool = {}
}

RestaurantOperationGetPanelUI = Base:Extend("RestaurantOperationGetPanelUI", "IQIGame.Onigao.UI.RestaurantOperationGetPanelUI", RestaurantOperationGetPanelUI)

require("IQIGame.UIExternalApi.RestaurantOperationGetPanelUIApi")

local RestaurantGetPanelCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantGetPanelCell")

function RestaurantOperationGetPanelUI:OnInit()
	function self.DelegateUpdateItem(cell)
		self:UpdateItem(cell)
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickCloseBtn()
	end

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateItem

	UGUIUtil.SetText(self.TextTitle, RestaurantOperationGetPanelUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextEng, RestaurantOperationGetPanelUIApi:GetString("TextEng"))

	self.goBtnTxt:GetComponent("Text").text = RestaurantOperationGetPanelUIApi:GetString("goBtnTxt")
end

function RestaurantOperationGetPanelUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationGetPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationGetPanelUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationGetPanelUI:GetBGM(userData)
	return 10801
end

function RestaurantOperationGetPanelUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self.OpenTime = Time.realtimeSinceStartup

	self:UpdateView(tonumber(userData.cid), userData.items, userData.args)
end

function RestaurantOperationGetPanelUI:OnClose(userData)
	return
end

function RestaurantOperationGetPanelUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationGetPanelUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationGetPanelUI:OnPause()
	return
end

function RestaurantOperationGetPanelUI:OnResume()
	return
end

function RestaurantOperationGetPanelUI:OnCover()
	return
end

function RestaurantOperationGetPanelUI:OnReveal()
	return
end

function RestaurantOperationGetPanelUI:OnRefocus(userData)
	return
end

function RestaurantOperationGetPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationGetPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationGetPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationGetPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationGetPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.getItemCellPool) do
		v:Dispose()
	end
end

function RestaurantOperationGetPanelUI:OnClickCloseBtn()
	if Time.realtimeSinceStartup - self.OpenTime < 1 then
		return
	end

	UIModule.Close(Constant.UIControllerName.RestaurantOperationGetPanelUI)
end

function RestaurantOperationGetPanelUI:UpdateView(tipCid, items, args)
	self.RawItemDatas = items

	UGUIUtil.SetText(self.ContentText, getTipText(tipCid, unpack(args)))

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#items)
end

function RestaurantOperationGetPanelUI:UpdateItem(cell)
	local rawItemData = self.RawItemDatas[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.getItemCellPool[instanceID]

	if itemCell == nil then
		itemCell = RestaurantGetPanelCell.New(cell.gameObject)
	end

	local itemData
	local tag = 0

	if rawItemData ~= nil then
		itemData = ItemData.CreateByCIDAndNumber(rawItemData.cid, rawItemData.num)
		tag = rawItemData.tag
	end

	itemCell:SetItem(itemData, tag)
end

return RestaurantOperationGetPanelUI
