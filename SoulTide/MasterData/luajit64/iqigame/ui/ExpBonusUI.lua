-- chunkname: @IQIGame\\UI\\ExpBonusUI.lua

local ExpBonusUI = {
	cellPool = {},
	cfgDataList = {}
}

ExpBonusUI = Base:Extend("ExpBonusUI", "IQIGame.Onigao.UI.ExpBonusUI", ExpBonusUI)

local TargetCell = require("IQIGame.UI.ExpBouns.TargetCell")

function ExpBonusUI:OnInit()
	self:Initialize()
end

function ExpBonusUI:GetPreloadAssetPaths()
	return nil
end

function ExpBonusUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ExpBonusUI:IsManualShowOnOpen(userData)
	return false
end

function ExpBonusUI:GetBGM(userData)
	return nil
end

function ExpBonusUI:OnOpen(userData)
	self:Refresh(userData)
end

function ExpBonusUI:OnClose(userData)
	self:OnHide()
end

function ExpBonusUI:OnPause()
	return
end

function ExpBonusUI:OnResume()
	return
end

function ExpBonusUI:OnCover()
	return
end

function ExpBonusUI:OnReveal()
	return
end

function ExpBonusUI:OnRefocus(userData)
	return
end

function ExpBonusUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ExpBonusUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ExpBonusUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ExpBonusUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ExpBonusUI:Initialize()
	self.imgLv1 = self.goImgLv1:GetComponent("Image")
	self.imgLv10 = self.goImgLv10:GetComponent("Image")
	self.imgLv100 = self.goImgLv10:GetComponent("Image")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.delegateUpgradeBigBattle()
		self:OnUpgradeBigBattle()
	end

	function self.delegateUpdateChaseEvent()
		self:OnUpdateChaseEvent()
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self.goDesc1:GetComponent("Text").text = ExpBonusUIApi:GetString("desc1")
	self.goDesc2:GetComponent("Text").text = ExpBonusUIApi:GetString("desc2")
	self.goBtnCloseTxt:GetComponent("Text").text = ExpBonusUIApi:GetString("btnCloseTxt")
end

function ExpBonusUI:Refresh(userData)
	self:RefreshTargetLv()
	self:RefreshCells()
end

function ExpBonusUI:OnHide()
	return
end

function ExpBonusUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end
end

function ExpBonusUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateUpgradeBigBattle, self.delegateUpgradeBigBattle)
	EventDispatcher.AddEventListener(EventID.UpdateChaseEvent, self.delegateUpdateChaseEvent)
end

function ExpBonusUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateUpgradeBigBattle, self.delegateUpgradeBigBattle)
	EventDispatcher.RemoveEventListener(EventID.UpdateChaseEvent, self.delegateUpdateChaseEvent)
end

function ExpBonusUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ExpBonusUI:OnUpgradeBigBattle()
	self:RefreshCells()
end

function ExpBonusUI:OnUpdateChaseEvent()
	self:RefreshCells()
end

function ExpBonusUI:RefreshTargetLv()
	local targetLv = CfgDiscreteDataTable[6520062].Data[1]

	self.goImgLv10:SetActive(targetLv > 9)
	self.goImgLv100:SetActive(targetLv > 99)

	if targetLv > 99 then
		AssetUtil.LoadImage(self, ExpBonusUIApi:GetString("lvImg", math.floor(targetLv / 100)), self.imgLv100)
	end

	if targetLv > 9 then
		AssetUtil.LoadImage(self, ExpBonusUIApi:GetString("lvImg", math.floor(targetLv / 10)), self.imgLv10)
	end

	AssetUtil.LoadImage(self, ExpBonusUIApi:GetString("lvImg", targetLv % 10), self.imgLv1)
end

function ExpBonusUI:RefreshCells()
	self.cfgDataList = {}

	for i, v in pairsCfg(CfgLevelCatchupTable) do
		if v.Id == 5 then
			local top = MallModule.CheckGoodsIsSelling(v.Parameter)

			if top then
				self.cfgDataList[#self.cfgDataList + 1] = v
			end
		elseif v.Id == 4 then
			self.cfgDataList[#self.cfgDataList + 1] = v
		elseif v.Id == 3 then
			if ActiveModule.idsList and #ActiveModule.idsList > 0 then
				self.cfgDataList[#self.cfgDataList + 1] = v
			end
		else
			self.cfgDataList[#self.cfgDataList + 1] = v
		end
	end

	table.sort(self.cfgDataList, function(a, b)
		return a.Id < b.Id
	end)
	self.scrollList:Refresh(#self.cfgDataList)
end

function ExpBonusUI:OnRenderGridCell(cell)
	local data = self.cfgDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.cellPool[instanceID]

	if renderCell == nil then
		renderCell = TargetCell.New(cell.gameObject)
		self.cellPool[instanceID] = renderCell
	end

	renderCell:Refresh(data, cell.index + 1)
end

return ExpBonusUI
