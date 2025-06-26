-- chunkname: @IQIGame\\UI\\AmusementParkGameSelectLevelUI.lua

local AmusementParkGameSelectLevelUI = {
	GameLevels = {},
	SelectLevelPool = {}
}

AmusementParkGameSelectLevelUI = Base:Extend("AmusementParkGameSelectLevelUI", "IQIGame.Onigao.UI.AmusementParkGameSelectLevelUI", AmusementParkGameSelectLevelUI)

local AmusementParkSelectLevelCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkOneConnectGame.AmusementParkSelectLevelCell")

require("IQIGame.UIExternalApi.AmusementParkGameSelectLevelUIApi")

function AmusementParkGameSelectLevelUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedCell(cell)
	end
end

function AmusementParkGameSelectLevelUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameSelectLevelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameSelectLevelUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameSelectLevelUI:GetBGM(userData)
	return nil
end

function AmusementParkGameSelectLevelUI:OnOpen(userData)
	self.SelectLevelData = AmusementParkOneConnectGameModule.oneConnectGameData.LevelData

	self:UpdateView()
end

function AmusementParkGameSelectLevelUI:OnClose(userData)
	return
end

function AmusementParkGameSelectLevelUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnBack1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function AmusementParkGameSelectLevelUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnBack1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function AmusementParkGameSelectLevelUI:OnPause()
	return
end

function AmusementParkGameSelectLevelUI:OnResume()
	return
end

function AmusementParkGameSelectLevelUI:OnCover()
	return
end

function AmusementParkGameSelectLevelUI:OnReveal()
	return
end

function AmusementParkGameSelectLevelUI:OnRefocus(userData)
	return
end

function AmusementParkGameSelectLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGameSelectLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameSelectLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGameSelectLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameSelectLevelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.SelectLevelPool) do
		v:Dispose()
	end
end

function AmusementParkGameSelectLevelUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AmusementParkGameSelectLevelUI:UpdateView()
	self.GameLevels = AmusementParkOneConnectGameModule.oneConnectLevels

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.GameLevels)

	local passNum = 0
	local totalNum = 0
	local showInfo = AmusementParkModule.ParkGameShowInfoList[AmusementParkConstant.BuildFunction.BuildFunction_OneStroke]

	if showInfo then
		passNum = showInfo.score
		totalNum = #AmusementParkOneConnectGameModule.oneConnectLevels
	end

	UGUIUtil.SetText(self.TextProcess, AmusementParkGameSelectLevelUIApi:GetString("TextProcess", passNum, totalNum))
end

function AmusementParkGameSelectLevelUI:OnRenderCell(cell)
	local levelData = self.GameLevels[cell.index + 1]

	if levelData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local levelCell = self.SelectLevelPool[insID]

	if levelCell == nil then
		levelCell = AmusementParkSelectLevelCell.New(cell.gameObject)
		self.SelectLevelPool[insID] = levelCell
	end

	levelCell:SetData(levelData)
	levelCell:SetSelect(levelData.cid == self.SelectLevelData.cid)
end

function AmusementParkGameSelectLevelUI:OnSelectedCell(cell)
	local levelData = self.GameLevels[cell.index + 1]

	if not levelData:IsUnlock() then
		return
	end

	if levelData:GetCfgData().Level > AmusementParkOneConnectGameModule.maxLevel + 1 then
		return
	end

	if levelData.cid == self.SelectLevelData.cid then
		self:OnClickBtnBack()

		return
	end

	self.SelectLevelData = levelData

	for i, v in pairs(self.SelectLevelPool) do
		v:SetSelect(v.cid == self.SelectLevelData.cid)
	end

	AmusementParkOneConnectGameModule.CreateNewGame(self.SelectLevelData.cid)
	EventDispatcher.Dispatch(EventID.APUpdateOneConnectGameEvent)
	self:OnClickBtnBack()
end

return AmusementParkGameSelectLevelUI
