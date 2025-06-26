-- chunkname: @IQIGame\\UI\\CheckPlayerExhibitionUI.lua

local CheckPlayerExhibitionUI = {
	exhibitionCellPool = {},
	itemTab = {}
}

CheckPlayerExhibitionUI = Base:Extend("CheckPlayerExhibitionUI", "IQIGame.Onigao.UI.CheckPlayerExhibitionUI", CheckPlayerExhibitionUI)

local CheckPlayerExhibitionCell = require("IQIGame.UI.CheckPlayerExhibition.CheckPlayerExhibitionCell")

function CheckPlayerExhibitionUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, CheckPlayerExhibitionUIApi:GetString("PanelTitle"))
	UGUIUtil.SetText(self.TextBtnCancel, CheckPlayerExhibitionUIApi:GetString("TextBtnCancel"))

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateBtnCancel()
		self:OnBtnCancel()
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end
end

function CheckPlayerExhibitionUI:GetPreloadAssetPaths()
	return nil
end

function CheckPlayerExhibitionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CheckPlayerExhibitionUI:IsManualShowOnOpen(userData)
	return false
end

function CheckPlayerExhibitionUI:GetBGM(userData)
	return nil
end

function CheckPlayerExhibitionUI:OnOpen(userData)
	self.itemTab = userData
	self.selectItemCid = nil

	self:UpdateView()
end

function CheckPlayerExhibitionUI:OnClose(userData)
	return
end

function CheckPlayerExhibitionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.delegateBtnCancel)
end

function CheckPlayerExhibitionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCancel)
end

function CheckPlayerExhibitionUI:OnPause()
	return
end

function CheckPlayerExhibitionUI:OnResume()
	return
end

function CheckPlayerExhibitionUI:OnCover()
	return
end

function CheckPlayerExhibitionUI:OnReveal()
	return
end

function CheckPlayerExhibitionUI:OnRefocus(userData)
	return
end

function CheckPlayerExhibitionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CheckPlayerExhibitionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CheckPlayerExhibitionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CheckPlayerExhibitionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CheckPlayerExhibitionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.exhibitionCellPool) do
		v:Dispose()
	end
end

function CheckPlayerExhibitionUI:UpdateView()
	table.sort(self.itemTab, function(item1, item2)
		return CfgItemTable[item1].Sort < CfgItemTable[item2].Sort
	end)
	self.scrollList:Refresh(#self.itemTab)
	self:ShowSelectMsg()
end

function CheckPlayerExhibitionUI:OnRenderCell(cell)
	local itemCid = self.itemTab[cell.index + 1]

	if itemCid == nil then
		cell.gameObject:SetActive(false)
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local exhibitionCell = self.exhibitionCellPool[instanceID]

	if exhibitionCell == nil then
		exhibitionCell = CheckPlayerExhibitionCell.New(cell.gameObject)
		self.exhibitionCellPool[instanceID] = exhibitionCell
	end

	exhibitionCell:SetData(itemCid)

	if self.selectItemCid == nil then
		self.selectItemCid = itemCid
	end

	if itemCid == self.selectItemCid then
		exhibitionCell:SetSelect(true)
	else
		exhibitionCell:SetSelect(false)
	end
end

function CheckPlayerExhibitionUI:OnSelectedCell(cell)
	self.selectItemCid = self.itemTab[cell.index + 1]

	for i, v in pairs(self.exhibitionCellPool) do
		if v.itemCid == self.selectItemCid then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:ShowSelectMsg()
end

function CheckPlayerExhibitionUI:ShowSelectMsg()
	if self.selectItemCid then
		local path = UIGlobalApi.GetIconPath(CfgItemTable[self.selectItemCid].Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextItemName, CfgItemTable[self.selectItemCid].Name)
		UGUIUtil.SetText(self.TextItemDes, CfgItemTable[self.selectItemCid].Describe)
	end
end

function CheckPlayerExhibitionUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.CheckPlayerExhibitionUI)
end

function CheckPlayerExhibitionUI:OnBtnCancel()
	self:OnClickBtnClose()
end

return CheckPlayerExhibitionUI
