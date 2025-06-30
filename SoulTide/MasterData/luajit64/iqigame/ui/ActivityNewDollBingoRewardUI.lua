-- chunkname: @IQIGame\\UI\\ActivityNewDollBingoRewardUI.lua

local ActivityNewDollBingoRewardUI = {
	listBingoCellPool = {},
	listBingoDatum = {},
	listNumCellPool = {},
	listNumDatum = {}
}

ActivityNewDollBingoRewardUI = Base:Extend("ActivityNewDollBingoRewardUI", "IQIGame.Onigao.UI.ActivityNewDollBingoRewardUI", ActivityNewDollBingoRewardUI)

local BingoRewardCell = require("IQIGame.UI.Activity.DollBingo.BingoRewardCell")
local NumRewardCell = require("IQIGame.UI.Activity.DollBingo.NumRewardCell")

function ActivityNewDollBingoRewardUI:OnInit()
	self:Initialize()
end

function ActivityNewDollBingoRewardUI:GetPreloadAssetPaths()
	return nil
end

function ActivityNewDollBingoRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityNewDollBingoRewardUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityNewDollBingoRewardUI:GetBGM(userData)
	return nil
end

function ActivityNewDollBingoRewardUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityNewDollBingoRewardUI:OnClose(userData)
	self:OnHide()
end

function ActivityNewDollBingoRewardUI:OnPause()
	return
end

function ActivityNewDollBingoRewardUI:OnResume()
	return
end

function ActivityNewDollBingoRewardUI:OnCover()
	return
end

function ActivityNewDollBingoRewardUI:OnReveal()
	return
end

function ActivityNewDollBingoRewardUI:OnRefocus(userData)
	return
end

function ActivityNewDollBingoRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityNewDollBingoRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityNewDollBingoRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityNewDollBingoRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityNewDollBingoRewardUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.tgBingo = self.goTgBingo:GetComponent("Toggle")
	self.tgBingo2 = self.goTgBingo2:GetComponent("Toggle")
	self.tgNum = self.goTgNum:GetComponent("Toggle")

	function self.onClickTgBingoDelegate(isOn)
		self:OnClickTgBingo(isOn)
	end

	function self.onClickTgBingoDelegate2(isOn)
		self:OnClickTgBingo2(isOn)
	end

	function self.onClickTgNumDelegate(isOn)
		self:OnClickTgNum(isOn)
	end

	self.listBingo = self.goBingoList:GetComponent("ScrollAreaList")
	self.listNum = self.goNumList:GetComponent("ScrollAreaList")

	function self.listBingo.onRenderCell(cell)
		self:OnRenderBingoRewardCell(cell)
	end

	function self.listNum.onRenderCell(cell)
		self:OnRenderNumRewardCell(cell)
	end

	self.goTgBingo:GetComponent("ToggleHelperComponent").text = ActivityNewDollBingoUIApi:GetString("rewardTgBingoTxt", 1)
	self.goTgBingo2:GetComponent("ToggleHelperComponent").text = ActivityNewDollBingoUIApi:GetString("rewardTgBingoTxt", 2)
	self.goTgNum:GetComponent("ToggleHelperComponent").text = ActivityNewDollBingoUIApi:GetString("rewardTgNumTxt")
	self.goNumDesc:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("rewardNumDesc")
end

function ActivityNewDollBingoRewardUI:Refresh(userData)
	self.bingoData = userData

	self.goBingoList.transform.parent.gameObject:SetActive(false)
	self.goNumList.transform.parent.gameObject:SetActive(false)
	self.tgBingo.group:SetAllTogglesOff()

	self.tgBingo.isOn = true

	self:RefreshNumRewardList()
end

function ActivityNewDollBingoRewardUI:OnHide()
	for i, v in pairs(self.listBingoCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.listNumCellPool) do
		v:OnHide()
	end
end

function ActivityNewDollBingoRewardUI:OnDestroy()
	for i, v in pairs(self.listBingoCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.listNumCellPool) do
		v:OnDestroy()
	end
end

function ActivityNewDollBingoRewardUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.tgBingo.onValueChanged:AddListener(self.onClickTgBingoDelegate)
	self.tgBingo2.onValueChanged:AddListener(self.onClickTgBingoDelegate2)
	self.tgNum.onValueChanged:AddListener(self.onClickTgNumDelegate)
end

function ActivityNewDollBingoRewardUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.tgBingo.onValueChanged:RemoveListener(self.onClickTgBingoDelegate)
	self.tgBingo2.onValueChanged:RemoveListener(self.onClickTgBingoDelegate2)
	self.tgNum.onValueChanged:RemoveListener(self.onClickTgNumDelegate)
end

function ActivityNewDollBingoRewardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ActivityNewDollBingoRewardUI:OnClickTgBingo(isOn)
	self.goBingoList.transform.parent.gameObject:SetActive(isOn)
	self:RefreshBingoRewardList(1)
end

function ActivityNewDollBingoRewardUI:OnClickTgBingo2(isOn)
	self.goBingoList.transform.parent.gameObject:SetActive(isOn)
	self:RefreshBingoRewardList(2)
end

function ActivityNewDollBingoRewardUI:OnClickTgNum(isOn)
	self.goNumList.transform.parent.gameObject:SetActive(isOn)
end

function ActivityNewDollBingoRewardUI:OnRenderBingoRewardCell(cell)
	local luaIndex = cell.index + 1
	local data = self.listBingoDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local rewardCell = self.listBingoCellPool[insID]

	if rewardCell == nil then
		rewardCell = BingoRewardCell.New(cell.gameObject)
		self.listBingoCellPool[insID] = rewardCell
	end

	rewardCell:Refresh(data, self.curBingoRewardType)
end

function ActivityNewDollBingoRewardUI:OnRenderNumRewardCell(cell)
	local luaIndex = cell.index + 1
	local data = self.listNumDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local rewardCell = self.listNumCellPool[insID]

	if rewardCell == nil then
		rewardCell = NumRewardCell.New(cell.gameObject)
		self.listNumCellPool[insID] = rewardCell
	end

	rewardCell:Refresh(data)
end

function ActivityNewDollBingoRewardUI:RefreshBingoRewardList(type)
	self.curBingoRewardType = type
	self.listBingoDatum = self.bingoData.cfgBingoDatum

	self.listBingo:Refresh(#self.listBingoDatum)
end

function ActivityNewDollBingoRewardUI:RefreshNumRewardList()
	self.listNumDatum = self.bingoData.cfgBingoNumDatum

	self.listNum:Refresh(#self.listNumDatum)
end

return ActivityNewDollBingoRewardUI
