-- chunkname: @IQIGame\\UI\\ChangeExhibitionUI.lua

local ChangeExhibitionUI = {
	exhibitionCellPool = {},
	itemTab = {}
}

ChangeExhibitionUI = Base:Extend("ChangeExhibitionUI", "IQIGame.Onigao.UI.ChangeExhibitionUI", ChangeExhibitionUI)

local ExhibitionCell = require("IQIGame.UI.Setting.ChangeExhibition.ExhibitionCell")

function ChangeExhibitionUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, ChangeExhibitionUIApi:GetString("PanelTitle"))
	UGUIUtil.SetText(self.TextBtnCancel, ChangeExhibitionUIApi:GetString("TextBtnCancel"))
	UGUIUtil.SetText(self.TextBtnSure, ChangeExhibitionUIApi:GetString("TextBtnSure"))
	UGUIUtil.SetText(self.TextBtnRemove, ChangeExhibitionUIApi:GetString("TextBtnRemove"))

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateBtnCancel()
		self:OnBtnCancel()
	end

	function self.delegateBtnSure()
		self:OnBtnSure()
	end

	function self.delegateBtnRemove()
		self:OnBtnRemove()
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	function self.delegateSettingChangeEvent()
		self:OnSettingChangeEvent()
	end
end

function ChangeExhibitionUI:GetPreloadAssetPaths()
	return nil
end

function ChangeExhibitionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChangeExhibitionUI:IsManualShowOnOpen(userData)
	return false
end

function ChangeExhibitionUI:GetBGM(userData)
	return nil
end

function ChangeExhibitionUI:OnOpen(userData)
	self.pos = userData[1]
	self.posCfgID = userData[2]
	self.selectItem = nil

	self:UpdateView()
end

function ChangeExhibitionUI:OnClose(userData)
	return
end

function ChangeExhibitionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.delegateBtnCancel)
	self.BtnSure:GetComponent("Button").onClick:AddListener(self.delegateBtnSure)
	self.BtnRemove:GetComponent("Button").onClick:AddListener(self.delegateBtnRemove)
	EventDispatcher.AddEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
end

function ChangeExhibitionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCancel)
	self.BtnSure:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSure)
	self.BtnRemove:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRemove)
	EventDispatcher.RemoveEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
end

function ChangeExhibitionUI:OnPause()
	return
end

function ChangeExhibitionUI:OnResume()
	return
end

function ChangeExhibitionUI:OnCover()
	return
end

function ChangeExhibitionUI:OnReveal()
	return
end

function ChangeExhibitionUI:OnRefocus(userData)
	return
end

function ChangeExhibitionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChangeExhibitionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChangeExhibitionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChangeExhibitionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChangeExhibitionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.exhibitionCellPool) do
		v:Dispose()
	end
end

function ChangeExhibitionUI:OnSettingChangeEvent()
	if self.pos then
		self.posCfgID = PlayerModule.PlayerInfo.showCollectItems[self.pos]

		self:UpdateView()
	end
end

function ChangeExhibitionUI:UpdateView()
	self.itemTab = WarehouseModule.GetItemsByTypeAndSubType(Constant.ItemType.Item, 39)

	table.sort(self.itemTab, function(item1, item2)
		return item1:GetCfg().Sort < item2:GetCfg().Sort
	end)
	self.scrollList:Refresh(#self.itemTab)
	self:ShowSelectMsg()
end

function ChangeExhibitionUI:OnRenderCell(cell)
	local itemData = self.itemTab[cell.index + 1]

	if itemData == nil then
		cell.gameObject:SetActive(false)
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local exhibitionCell = self.exhibitionCellPool[instanceID]

	if exhibitionCell == nil then
		exhibitionCell = ExhibitionCell.New(cell.gameObject)
		self.exhibitionCellPool[instanceID] = exhibitionCell
	end

	exhibitionCell:SetData(itemData, self.pos)

	if self.posCfgID then
		if itemData.cid == self.posCfgID then
			exhibitionCell:SetSelect(true)

			self.selectItem = itemData
		else
			exhibitionCell:SetSelect(false)
		end
	else
		if self.selectItem == nil then
			self.selectItem = itemData
		end

		if itemData.cid == self.selectItem.cid then
			exhibitionCell:SetSelect(true)
		else
			exhibitionCell:SetSelect(false)
		end
	end
end

function ChangeExhibitionUI:OnSelectedCell(cell)
	self.selectItem = self.itemTab[cell.index + 1]

	for i, v in pairs(self.exhibitionCellPool) do
		if v.itemData and v.itemData.cid == self.selectItem.cid then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:ShowSelectMsg()
end

function ChangeExhibitionUI:ShowSelectMsg()
	if self.selectItem then
		local path = UIGlobalApi.GetIconPath(CfgItemTable[self.selectItem.cid].Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextItemName, self.selectItem:GetCfg().Name)
		UGUIUtil.SetText(self.TextItemDes, self.selectItem:GetCfg().Describe)

		local isSelf = self.selectItem.cid == self.posCfgID

		self.BtnSure:SetActive(not isSelf)
		self.BtnRemove:SetActive(isSelf)
	end
end

function ChangeExhibitionUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ChangeExhibitionUI)
end

function ChangeExhibitionUI:OnBtnCancel()
	self:OnClickBtnClose()
end

function ChangeExhibitionUI:OnBtnSure()
	local newTab = {}

	if self.selectItem then
		newTab[self.pos] = self.selectItem.cid
	end

	local tab = PlayerModule.PlayerInfo.showCollectItems

	if tab then
		for i, v in pairs(tab) do
			if i ~= self.pos and v ~= self.selectItem.cid then
				newTab[i] = v
			end
		end
	end

	SettingModule.SaveShowCollectItems(newTab)
	self:OnClickBtnClose()
end

function ChangeExhibitionUI:OnBtnRemove()
	local tab = PlayerModule.PlayerInfo.showCollectItems

	if tab then
		local newTab = {}

		for i, v in pairs(tab) do
			if self.pos ~= i then
				newTab[i] = v
			end
		end

		SettingModule.SaveShowCollectItems(newTab)
	end
end

return ChangeExhibitionUI
