-- chunkname: @IQIGame\\UI\\MazeSettlementUI.lua

local MazeSettlementUI = {
	ItemList = {}
}

MazeSettlementUI = Base:Extend("MazeSettlementUI", "IQIGame.Onigao.UI.MazeSettlementUI", MazeSettlementUI)

function MazeSettlementUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	self.wrapContent = self.rewardScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end
end

function MazeSettlementUI:GetPreloadAssetPaths()
	return nil
end

function MazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function MazeSettlementUI:GetBGM(userData)
	return nil
end

function MazeSettlementUI:OnOpen(userData)
	self.itemDatas = userData.itemShows
	self.confirmCallback = userData.callback
	self.mazeStageId = userData.mazeStageId
	self.difficulty = userData.difficulty

	self:Refresh()
end

function MazeSettlementUI:OnClose(userData)
	return
end

function MazeSettlementUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function MazeSettlementUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function MazeSettlementUI:OnPause()
	return
end

function MazeSettlementUI:OnResume()
	return
end

function MazeSettlementUI:OnCover()
	return
end

function MazeSettlementUI:OnReveal()
	return
end

function MazeSettlementUI:OnRefocus(userData)
	return
end

function MazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSettlementUI:OnDestroy()
	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end

	self.ItemList = nil

	AssetUtil.UnloadAsset(self)
end

function MazeSettlementUI:OnClickConfirmBtn()
	if self.confirmCallback ~= nil then
		self.confirmCallback()
	end

	UIModule.CloseSelf(self)
end

function MazeSettlementUI:Refresh()
	local mazeIntergral, tempKey

	for k, v in pairs(self.itemDatas) do
		local itemCfg = CfgItemTable[v.cid]

		if itemCfg.ItemTypes == Constant.ItemType.Currency and itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Currency].MazeIntegral then
			tempKey = k
			mazeIntergral = v

			break
		end
	end

	if tempKey ~= nil then
		table.remove(self.itemDatas, tempKey)
	end

	self:RefreshMazeIntergral(mazeIntergral)
	self:RefreshMazeOtherInfo()
	self.wrapContent:Refresh(#self.itemDatas)
end

function MazeSettlementUI:OnRenderItem(cell)
	local rawItemData = self.itemDatas[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemList[instanceId]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject, true, true, true)
		self.ItemList[instanceId] = itemCell
	end

	if rawItemData ~= nil then
		itemCell:SetItemByCid(rawItemData.cid, rawItemData.num)
		itemCell:SetTag(rawItemData.tag)
		itemCell:SetItemNumShow(rawItemData.num)
	end
end

function MazeSettlementUI:RefreshMazeIntergral(mazeIntergral)
	if mazeIntergral == nil then
		UGUIUtil.SetText(self.mazeIntergralText, 0)

		return
	end

	UGUIUtil.SetText(self.mazeIntergralText, mazeIntergral.num)
end

function MazeSettlementUI:RefreshMazeOtherInfo()
	UGUIUtil.SetText(self.stageText, MazeModule.GetMazeStageCfg(self.difficulty).StageName .. "·" .. MazeApi:GetMazeStageDiffCNText(self.difficulty))

	local curStagePod = MazeModule.GetLabyrinthStagePOD(self.difficulty)

	LuaUtility.SetGameObjectShow(self.done, curStagePod.settlementFlg)
	LuaUtility.SetGameObjectShow(self.unDone, not curStagePod.settlementFlg)
end

return MazeSettlementUI
