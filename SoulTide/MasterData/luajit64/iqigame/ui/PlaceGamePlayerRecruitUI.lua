-- chunkname: @IQIGame\\UI\\PlaceGamePlayerRecruitUI.lua

local PlaceGamePlayerRecruitUI = {
	playerRecruitCellPool = {},
	placeGameSoulHeadPool = {},
	playerRecruitList = {},
	placeGameSoulList = {}
}

PlaceGamePlayerRecruitUI = Base:Extend("PlaceGamePlayerRecruitUI", "IQIGame.Onigao.UI.PlaceGamePlayerRecruitUI", PlaceGamePlayerRecruitUI)

require("IQIGame.UIExternalApi.PlaceGamePlayerRecruitUIApi")

local PlaceGamePlayerRecruitCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerRecruit.PlaceGamePlayerRecruitCell")
local PlaceGameSoulHeadCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerRecruit.PlaceGameSoulHeadCell")

function PlaceGamePlayerRecruitUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateSoulDataChange(soulCid)
		self:OnSoulDataChange(soulCid)
	end

	self.PosScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderRecruitCell(cell)
	end
	self.RoleScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderSoulHeadCell(cell)
	end
	self.RoleScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectSoulHeadCell(cell)
	end
end

function PlaceGamePlayerRecruitUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGamePlayerRecruitUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGamePlayerRecruitUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGamePlayerRecruitUI:GetBGM(userData)
	return nil
end

function PlaceGamePlayerRecruitUI:OnOpen(userData)
	self:UpdateView()
end

function PlaceGamePlayerRecruitUI:OnClose(userData)
	return
end

function PlaceGamePlayerRecruitUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulDataChange, self.DelegateSoulDataChange)
end

function PlaceGamePlayerRecruitUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulDataChange, self.DelegateSoulDataChange)
end

function PlaceGamePlayerRecruitUI:OnPause()
	return
end

function PlaceGamePlayerRecruitUI:OnResume()
	return
end

function PlaceGamePlayerRecruitUI:OnCover()
	return
end

function PlaceGamePlayerRecruitUI:OnReveal()
	return
end

function PlaceGamePlayerRecruitUI:OnRefocus(userData)
	return
end

function PlaceGamePlayerRecruitUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGamePlayerRecruitUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGamePlayerRecruitUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGamePlayerRecruitUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGamePlayerRecruitUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.placeGameSoulHeadPool) do
		v:Dispose()
	end

	for i, v in pairs(self.playerRecruitCellPool) do
		v:Dispose()
	end
end

function PlaceGamePlayerRecruitUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGamePlayerRecruitUI:OnSoulDataChange(soulCid)
	if self.selectPlaceGameSoulData then
		self.selectPlaceGameSoulData = PlaceGameModule.GetPlaceGameSoulDataByCid(self.selectPlaceGameSoulData.cid)
	end

	self:UpdateView()
end

function PlaceGamePlayerRecruitUI:GetSoulRecruitList()
	local tabList = {}

	for i, v in pairsCfg(CfgPlaceGameSoulTable) do
		if v.Group == PlaceGameModule.GlobalCid then
			local placeGameSoulData = PlaceGameModule.GetPlaceGameSoulDataByCid(v.Id)

			if placeGameSoulData == nil then
				table.insert(tabList, v.Id)
			end
		end
	end

	return tabList
end

function PlaceGamePlayerRecruitUI:UpdateView()
	local floor = 0

	if PlaceGameModule.DailyDupPOD.placeGamePOD.customs > 0 then
		floor = CfgPlaceGameTowerTable[PlaceGameModule.DailyDupPOD.placeGamePOD.customs].Floor
	end

	UGUIUtil.SetText(self.TextSelectDes, PlaceGamePlayerRecruitUIApi:GetString("TextSelectDes", floor))

	local soulMaxNum = PlaceGameModule.GetPlayerRecruitMaxNum()

	self.placeGameSoulList = PlaceGameModule.placeGameSoulDataList

	self.RoleScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.placeGameSoulList)
	UGUIUtil.SetText(self.TextSelectValue, PlaceGamePlayerRecruitUIApi:GetString("TextSelectValue", #self.placeGameSoulList, soulMaxNum))

	self.playerRecruitList = self:GetSoulRecruitList()

	self.PosScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.playerRecruitList)
end

function PlaceGamePlayerRecruitUI:OnRenderRecruitCell(cell)
	local placeGameSoulCid = self.playerRecruitList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local playerRecruitCell = self.playerRecruitCellPool[instanceID]

	if playerRecruitCell == nil then
		playerRecruitCell = PlaceGamePlayerRecruitCell.New(cell.gameObject)
		self.playerRecruitCellPool[instanceID] = playerRecruitCell
	end

	local lv = PlaceGameModule.GetPlayerRecruitLv(placeGameSoulCid)

	playerRecruitCell:SetData(placeGameSoulCid, lv)
end

function PlaceGamePlayerRecruitUI:OnRenderSoulHeadCell(cell)
	local placeGameSoulData = self.placeGameSoulList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local placeGameSoulHeadCell = self.placeGameSoulHeadPool[instanceID]

	if placeGameSoulHeadCell == nil then
		placeGameSoulHeadCell = PlaceGameSoulHeadCell.New(cell.gameObject)
		self.placeGameSoulHeadPool[instanceID] = placeGameSoulHeadCell
	end

	placeGameSoulHeadCell:SetData(placeGameSoulData)
	placeGameSoulHeadCell:SetSelect(false)

	if self.selectPlaceGameSoulData and self.selectPlaceGameSoulData.cid == placeGameSoulData.cid then
		placeGameSoulHeadCell:SetSelect(true)
	end
end

function PlaceGamePlayerRecruitUI:OnSelectSoulHeadCell(cell)
	self.selectPlaceGameSoulData = self.placeGameSoulList[cell.index + 1]

	for i, v in pairs(self.placeGameSoulHeadPool) do
		v:SetSelect(v.placeGameSoulData.cid == self.selectPlaceGameSoulData.cid)
	end
end

return PlaceGamePlayerRecruitUI
