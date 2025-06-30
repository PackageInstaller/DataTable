-- chunkname: @IQIGame\\UI\\EvilErosionSoulListUI.lua

require("IQIGame.UIExternalApi.EvilErosionSoulListUIApi")

local EvilErosionSoulCell = require("IQIGame.UI.EvilErosion.EvilErosionSoulCell")
local EvilErosionSoulListUI = {
	SelectedSoulIndex = 1,
	SoulCells = {}
}

EvilErosionSoulListUI = Base:Extend("EvilErosionSoulListUI", "IQIGame.Onigao.UI.EvilErosionSoulListUI", EvilErosionSoulListUI)

function EvilErosionSoulListUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	function self.DelegateOnClickRemoveBtn()
		self:OnClickRemoveBtn()
	end

	local scrollAreaList = self.SoulScrollList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderSoulCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectSoulCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, EvilErosionSoulListUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.SelectBtn, EvilErosionSoulListUIApi:GetString("SelectBtnText"))
	UGUIUtil.SetTextInChildren(self.RemoveBtn, EvilErosionSoulListUIApi:GetString("RemoveBtnText"))
end

function EvilErosionSoulListUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionSoulListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionSoulListUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionSoulListUI:GetBGM(userData)
	return nil
end

function EvilErosionSoulListUI:OnOpen(userData)
	local curFormationPos

	if userData ~= nil then
		curFormationPos = userData.curFormationPos
	end

	self:UpdateView(curFormationPos)
end

function EvilErosionSoulListUI:OnClose(userData)
	return
end

function EvilErosionSoulListUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
	self.RemoveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRemoveBtn)
end

function EvilErosionSoulListUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
	self.RemoveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRemoveBtn)
end

function EvilErosionSoulListUI:OnPause()
	return
end

function EvilErosionSoulListUI:OnResume()
	return
end

function EvilErosionSoulListUI:OnCover()
	return
end

function EvilErosionSoulListUI:OnReveal()
	return
end

function EvilErosionSoulListUI:OnRefocus(userData)
	return
end

function EvilErosionSoulListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionSoulListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionSoulListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionSoulListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionSoulListUI:OnDestroy()
	for instanceId, cell in pairs(self.SoulCells) do
		cell:Dispose()
	end
end

function EvilErosionSoulListUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionSoulListUI:OnClickSelectBtn()
	UIModule.CloseSelf(self)

	local soulPrefabPOD = self.SoulDataList[self.SelectedSoulIndex]

	EvilErosionModule.SendChangeFormationPos(soulPrefabPOD.id, self.CurFormationPos)
end

function EvilErosionSoulListUI:OnClickRemoveBtn()
	UIModule.CloseSelf(self)

	local soulPrefabPOD = self.SoulDataList[self.SelectedSoulIndex]

	EvilErosionModule.SendChangeFormationPos(soulPrefabPOD.id, 0)
end

function EvilErosionSoulListUI:UpdateView(curFormationPos)
	self.CurFormationPos = curFormationPos

	local scrollAreaList = self.SoulScrollList:GetComponent("ScrollAreaList")

	self.SelectedSoulIndex = 1
	self.SoulDataList = self:FilterAndSortSoul(EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs)
	scrollAreaList.defaultSelectedToggle = self.SelectedSoulIndex - 1

	scrollAreaList:Refresh(#self.SoulDataList)
	self:RefreshOperationBtns()
	UGUIUtil.SetText(self.TipText, EvilErosionSoulListUIApi:GetString("TipText", self.CurFormationPos ~= nil))
end

function EvilErosionSoulListUI:FilterAndSortSoul(soulPrefabs)
	local list = table.clone(soulPrefabs)

	table.sort(list, function(pod1, pod2)
		local priority1 = pod1.formationPos ~= 0 and pod1.formationPos or Constant.Number.IntMaxValue
		local priority2 = pod2.formationPos ~= 0 and pod2.formationPos or Constant.Number.IntMaxValue

		if priority1 == priority2 then
			return pod1.soulCid < pod2.soulCid
		end

		return priority1 < priority2
	end)

	return list
end

function EvilErosionSoulListUI:OnRenderSoulCell(cell)
	local soulCell = self.SoulCells[cell.gameObject:GetInstanceID()]

	if soulCell == nil then
		soulCell = EvilErosionSoulCell.New(cell.gameObject)
		self.SoulCells[cell.gameObject:GetInstanceID()] = soulCell
	end

	soulCell:SetData(self.SoulDataList[cell.index + 1], self.CurFormationPos)
	soulCell:SetSelected(cell.index + 1 == self.SelectedSoulIndex)
end

function EvilErosionSoulListUI:OnSelectSoulCell(cell)
	self.SelectedSoulIndex = cell.index + 1

	for instanceId, soulCell in pairs(self.SoulCells) do
		soulCell:SetSelected(soulCell.View == cell.gameObject)
	end

	self:RefreshOperationBtns()
end

function EvilErosionSoulListUI:RefreshOperationBtns()
	local soulPrefabPOD = self.SoulDataList[self.SelectedSoulIndex]

	self.SelectBtn:SetActive(self.CurFormationPos ~= nil and soulPrefabPOD.formationPos ~= self.CurFormationPos)
	self.RemoveBtn:SetActive(self.CurFormationPos ~= nil and soulPrefabPOD.formationPos == self.CurFormationPos)
end

return EvilErosionSoulListUI
