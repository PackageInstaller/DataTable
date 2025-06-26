-- chunkname: @IQIGame\\UI\\PassCheckNewTipUI.lua

local PassCheckNewTipUI = {
	itemCellPool = {}
}

PassCheckNewTipUI = Base:Extend("PassCheckNewTipUI", "IQIGame.Onigao.UI.PassCheckNewTipUI", PassCheckNewTipUI)

function PassCheckNewTipUI:OnInit()
	self:Initialize()
end

function PassCheckNewTipUI:GetPreloadAssetPaths()
	return nil
end

function PassCheckNewTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PassCheckNewTipUI:IsManualShowOnOpen(userData)
	return false
end

function PassCheckNewTipUI:GetBGM(userData)
	return nil
end

function PassCheckNewTipUI:OnOpen(userData)
	self:Refresh(userData)
end

function PassCheckNewTipUI:OnClose(userData)
	self:OnHide()
end

function PassCheckNewTipUI:OnPause()
	return
end

function PassCheckNewTipUI:OnResume()
	return
end

function PassCheckNewTipUI:OnCover()
	return
end

function PassCheckNewTipUI:OnReveal()
	return
end

function PassCheckNewTipUI:OnRefocus(userData)
	return
end

function PassCheckNewTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PassCheckNewTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PassCheckNewTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PassCheckNewTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PassCheckNewTipUI:Initialize()
	self.tfLastLv = self.goLastLv:GetComponent("Text")
	self.tfCurLv = self.goCurLv:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.rewardList = self.goRewardList:GetComponent("ScrollAreaList")

	function self.rewardList.onRenderCell(grid)
		self:OnRenderReward(grid)
	end

	self.goBtnClose.transform:Find("Text_01"):GetComponent("Text").text = PassCheckNewTipUIApi:GetString("btnCloseTxt")
	self.goDesc1:GetComponent("Text").text = PassCheckNewTipUIApi:GetString("desc1")
	self.goDesc2:GetComponent("Text").text = PassCheckNewTipUIApi:GetString("desc2")
	self.goDesc3:GetComponent("Text").text = PassCheckNewTipUIApi:GetString("desc3")
end

function PassCheckNewTipUI:Refresh(userData)
	self.rewardDatum = userData
	self.tfLastLv.text = PassCheckNewTipUIApi:GetString("lastLv", PassCheckModule.lastLv)
	self.tfCurLv.text = PassCheckNewTipUIApi:GetString("curLv", PassCheckModule.lv)

	self.rewardList:Refresh(#self.rewardDatum)
end

function PassCheckNewTipUI:OnHide()
	return
end

function PassCheckNewTipUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function PassCheckNewTipUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function PassCheckNewTipUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function PassCheckNewTipUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PassCheckNewTipUI:OnRenderReward(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.rewardDatum[luaIndex]
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.transform:Find("Slot/CommonSlotUI").gameObject, true, true)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:SetItemByCID(data.cid, data.num)
end

return PassCheckNewTipUI
