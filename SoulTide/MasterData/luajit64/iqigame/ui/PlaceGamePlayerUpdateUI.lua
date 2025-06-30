-- chunkname: @IQIGame\\UI\\PlaceGamePlayerUpdateUI.lua

local PlaceGamePlayerUpdateUI = {
	placeGameSoulList = {},
	placeGameSoulHeadPool = {},
	playerAttrItemCells = {},
	playerFeatureItemCells = {}
}

PlaceGamePlayerUpdateUI = Base:Extend("PlaceGamePlayerUpdateUI", "IQIGame.Onigao.UI.PlaceGamePlayerUpdateUI", PlaceGamePlayerUpdateUI)

require("IQIGame.UIExternalApi.PlaceGamePlayerUpdateUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local PlaceGamePlayerAttrItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerUpdate.PlaceGamePlayerAttrItemCell")
local PlaceGameSoulHeadCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerRecruit.PlaceGameSoulHeadCell")
local PlaceGamePlayerFeatureItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerUpdate.PlaceGamePlayerFeatureItemCell")

function PlaceGamePlayerUpdateUI:OnInit()
	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnSkill()
		self:OnBtnSkill()
	end

	function self.DelegateBtnUpGrade()
		self:OnBtnUpGrade()
	end

	function self.DelegateBtnUpGradeMore()
		self:OnBtnUpGradeMore()
	end

	function self.DelegateBtnFeatureDetail()
		self:OnBtnFeatureDetail()
	end

	function self.DelegateUpdateItem()
		self:RefreshCostItem()
	end

	function self.DelegatePlaceGameSoulDataChange()
		self:OnPlaceGameSoulDataChange()
	end

	self.RoleScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderSoulHeadCell(cell)
	end
	self.RoleScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectSoulHeadCell(cell)
	end
	self.playerAttrItemCellPool = UIObjectPool.New(10, function()
		return PlaceGamePlayerAttrItemCell.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))
	end, function(cell)
		cell:Dispose()
	end)
	self.playerFeatureItemCellPool = UIObjectPool.New(10, function()
		return PlaceGamePlayerFeatureItemCell.New(UnityEngine.Object.Instantiate(self.FeatureItemPrefab))
	end, function(cell)
		cell:Dispose()
	end)
	self.playerUpdateCostItem = ItemCell.New(self.SpendCommonSlot)
end

function PlaceGamePlayerUpdateUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGamePlayerUpdateUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGamePlayerUpdateUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGamePlayerUpdateUI:GetBGM(userData)
	return nil
end

function PlaceGamePlayerUpdateUI:OnOpen(userData)
	self:UpdateView(true)
end

function PlaceGamePlayerUpdateUI:OnClose(userData)
	return
end

function PlaceGamePlayerUpdateUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnSkill:GetComponent("Button").onClick:AddListener(self.DelegateBtnSkill)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGrade)
	self.BtnUpGradeMore:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGradeMore)
	self.BtnFeatureDetail:GetComponent("Button").onClick:AddListener(self.DelegateBtnFeatureDetail)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulDataChange, self.DelegatePlaceGameSoulDataChange)
end

function PlaceGamePlayerUpdateUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnSkill:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSkill)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGrade)
	self.BtnUpGradeMore:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGradeMore)
	self.BtnFeatureDetail:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnFeatureDetail)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulDataChange, self.DelegatePlaceGameSoulDataChange)
end

function PlaceGamePlayerUpdateUI:OnPause()
	return
end

function PlaceGamePlayerUpdateUI:OnResume()
	return
end

function PlaceGamePlayerUpdateUI:OnCover()
	return
end

function PlaceGamePlayerUpdateUI:OnReveal()
	return
end

function PlaceGamePlayerUpdateUI:OnRefocus(userData)
	return
end

function PlaceGamePlayerUpdateUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGamePlayerUpdateUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGamePlayerUpdateUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGamePlayerUpdateUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGamePlayerUpdateUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.playerUpdateCostItem:Dispose()

	for i, v in pairs(self.placeGameSoulHeadPool) do
		v:Dispose()
	end

	for i, v in pairs(self.playerAttrItemCells) do
		self.playerAttrItemCellPool:Release(v)
	end

	self.playerAttrItemCells = {}

	self.playerAttrItemCellPool:Dispose()

	for i, v in pairs(self.playerFeatureItemCells) do
		self.playerFeatureItemCellPool:Release(v)
	end

	self.playerFeatureItemCells = {}

	self.playerFeatureItemCellPool:Dispose()
end

function PlaceGamePlayerUpdateUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGamePlayerUpdateUI:OnBtnSkill()
	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerSkillUI, Constant.UILayer.UI, {
		PlaceGameSoulList = self.placeGameSoulList,
		SelectPlaceGameSoul = self.selectPlaceGameSoulData
	})
end

function PlaceGamePlayerUpdateUI:OnBtnUpGrade()
	local top = self:CheckUpdateLv()

	if top then
		PlaceGameModule.LevelUp(self.selectPlaceGameSoulData.cid, 1)
	end
end

function PlaceGamePlayerUpdateUI:OnBtnUpGradeMore()
	local top = self:CheckUpdateLv()

	if top then
		PlaceGameModule.LevelUp(self.selectPlaceGameSoulData.cid, 10)
	end
end

function PlaceGamePlayerUpdateUI:OnBtnFeatureDetail()
	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerEvolutionInfoUI, Constant.UILayer.UI, {
		PlaceGameSoulData = self.selectPlaceGameSoulData
	})
end

function PlaceGamePlayerUpdateUI:CheckUpdateLv()
	if self.selectPlaceGameSoulData.placeGameSoulPOD.level >= self.selectPlaceGameSoulData:GetSoulCanUpdateMaxLv() then
		NoticeModule.ShowNotice(21045102)

		return false
	end

	local needItemCid = CfgPlaceGameControlTable[PlaceGameModule.GlobalCid].ExpId
	local haveNum = WarehouseModule.GetItemNumByCfgID(needItemCid)

	if haveNum <= 0 then
		NoticeModule.ShowNotice(21045103)

		return false
	end

	return true
end

function PlaceGamePlayerUpdateUI:RefreshCostItem()
	local needItemCid = CfgPlaceGameControlTable[PlaceGameModule.GlobalCid].ExpId
	local haveNum = WarehouseModule.GetItemNumByCfgID(needItemCid)

	self.playerUpdateCostItem:SetItemByCID(needItemCid, haveNum)
end

function PlaceGamePlayerUpdateUI:OnPlaceGameSoulDataChange()
	self:UpdateView(false)
end

function PlaceGamePlayerUpdateUI:RefreshSelectSoul()
	UGUIUtil.SetText(self.TextName, self.selectPlaceGameSoulData:GetCfgPlaceGameSoulData().Name)
	UGUIUtil.SetText(self.TextLevel, self.selectPlaceGameSoulData.placeGameSoulPOD.level)

	local exp = self.selectPlaceGameSoulData.placeGameSoulPOD.experience
	local needExp = self.selectPlaceGameSoulData:GetCfgPlaceGameSoulLevelData().NeedExp

	UGUIUtil.SetText(self.ExpText, PlaceGamePlayerUpdateUIApi:GetString("ExpText", exp, needExp))

	self.ExpBar:GetComponent("Image").fillAmount = exp / needExp

	for i, v in pairs(self.playerAttrItemCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.playerAttrItemCellPool:Release(v)
	end

	self.playerAttrItemCells = {}

	local cfgSoulLevelData = self.selectPlaceGameSoulData:GetCfgPlaceGameSoulLevelData()

	for i = 1, #cfgSoulLevelData.AttType do
		local attType = cfgSoulLevelData.AttType[i]
		local value = cfgSoulLevelData.AttValue[i]
		local attrItemCell = self.playerAttrItemCellPool:Obtain()

		attrItemCell.View:SetActive(true)
		attrItemCell.View.transform:SetParent(self.AttrGrid.transform, false)
		attrItemCell:SetData(attType, value)
		table.insert(self.playerAttrItemCells, attrItemCell)
	end

	for i, v in pairs(self.playerFeatureItemCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.playerFeatureItemCellPool:Release(v)
	end

	self.playerFeatureItemCells = {}

	local cfgSoulData = self.selectPlaceGameSoulData:GetCfgPlaceGameSoulData()
	local lv = self.selectPlaceGameSoulData.placeGameSoulPOD.level

	for i = 1, #cfgSoulData.ADDSkillID do
		local skillID = cfgSoulData.ADDSkillID[i]
		local needOpenLv = cfgSoulData.UnLockSkillStrengthenLevel[i]
		local featureItemCell = self.playerFeatureItemCellPool:Obtain()

		featureItemCell.View:SetActive(true)
		featureItemCell.View.transform:SetParent(self.FeatureGrid.transform, false)
		featureItemCell:SetData(skillID, true, 1)
		table.insert(self.playerFeatureItemCells, featureItemCell)
	end

	self:RefreshCostItem()
end

function PlaceGamePlayerUpdateUI:UpdateView(top)
	self.placeGameSoulList = PlaceGameModule.placeGameSoulDataList

	if self.selectPlaceGameSoulData == nil then
		self.selectPlaceGameSoulData = self.placeGameSoulList[1]
	end

	if top then
		table.sort(self.placeGameSoulList, function(data1, data2)
			if data1.placeGameSoulPOD.level == data2.placeGameSoulPOD.level then
				return data1.cid < data2.cid
			end

			return data1.placeGameSoulPOD.level > data2.placeGameSoulPOD.level
		end)
		self.RoleScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.placeGameSoulList)
	else
		self.RoleScrollArea:GetComponent("ScrollAreaList"):RenderCellsDynamic(#self.placeGameSoulList)
	end

	self:RefreshSelectSoul()

	local finishTowerLV = 0
	local maxFinish = PlaceGameModule.DailyDupPOD.placeGamePOD.customs

	if maxFinish > 0 then
		finishTowerLV = CfgPlaceGameTowerTable[maxFinish].Floor
	end

	UGUIUtil.SetText(self.TextLayer, finishTowerLV)
	UGUIUtil.SetText(self.TextMaxLv, self.selectPlaceGameSoulData:GetSoulCanUpdateMaxLv())
end

function PlaceGamePlayerUpdateUI:OnRenderSoulHeadCell(cell)
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

function PlaceGamePlayerUpdateUI:OnSelectSoulHeadCell(cell)
	self.selectPlaceGameSoulData = self.placeGameSoulList[cell.index + 1]

	for i, v in pairs(self.placeGameSoulHeadPool) do
		v:SetSelect(v.placeGameSoulData.cid == self.selectPlaceGameSoulData.cid)
	end

	self:RefreshSelectSoul()
end

return PlaceGamePlayerUpdateUI
