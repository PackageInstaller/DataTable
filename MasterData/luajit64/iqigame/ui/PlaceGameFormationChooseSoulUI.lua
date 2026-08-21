-- chunkname: @IQIGame\\UI\\PlaceGameFormationChooseSoulUI.lua

local PlaceGameFormationChooseSoulUI = {
	soulCells = {}
}

PlaceGameFormationChooseSoulUI = Base:Extend("PlaceGameFormationChooseSoulUI", "IQIGame.Onigao.UI.PlaceGameFormationChooseSoulUI", PlaceGameFormationChooseSoulUI)

require("IQIGame.UIExternalApi.PlaceGameFormationChooseSoulUIApi")
require("IQIGame.UIExternalApi.PlaceGamePlayerFormationUIApi")

local PlaceGameFormationChooseSoulCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseSoul.PlaceGameFormationChooseSoulCell")
local PlaceGameFormationSoulInfoItem = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseSoul.PlaceGameFormationSoulInfoItem")
local PlaceGameFormationSkillGroupItem = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseSoul.PlaceGameFormationSkillGroupItem")

function PlaceGameFormationChooseSoulUI:OnInit()
	function self.DelegateOnClickGoEquipBtn()
		self:OnClickGoEquipBtn()
	end

	function self.DelegateOnClickRemoveBtn()
		self:OnClickRemoveBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegatePlaceGameChooseSoulComplete()
		self:OnChooseSoulComplete()
	end

	self.SoulCellGrid:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderSoulCell(cell)
	end
	self.SoulCellGrid:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedSoulCell(cell)
	end
	self.soulInfoItem = PlaceGameFormationSoulInfoItem.New(self.SoulInfoView)
	self.formationSkillGroupItem = PlaceGameFormationSkillGroupItem.New(self.SkillGroupPrefab)
end

function PlaceGameFormationChooseSoulUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameFormationChooseSoulUI:GetOpenPreloadAssetPaths(userData)
	local soulPortraitPath
	local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(userData.PrefabId)

	if soulPrefabData.placeGameSoulPrefabPOD.soulCid ~= nil and soulPrefabData.placeGameSoulPrefabPOD.soulCid > 0 then
		local placeGameSoulData = PlaceGameModule.GetPlaceGameSoulDataByCid(soulPrefabData.placeGameSoulPrefabPOD.soulCid)

		soulPortraitPath = PlaceGameFormationChooseSoulUIApi:GetString("SoulPortraitPath", placeGameSoulData:GetCfgPlaceGameSoulData().SoulID, placeGameSoulData:GetCfgPlaceGameSoulData().SoulResID)
	end

	if soulPortraitPath ~= nil then
		return {
			soulPortraitPath
		}
	else
		return nil
	end
end

function PlaceGameFormationChooseSoulUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameFormationChooseSoulUI:GetBGM(userData)
	return nil
end

function PlaceGameFormationChooseSoulUI:OnOpen(userData)
	self.formationIndex = userData.FormationIndex
	self.currentPrefabId = userData.PrefabId

	self:UpdateView()
end

function PlaceGameFormationChooseSoulUI:OnClose(userData)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameFormationChooseSoulComplete, self.DelegatePlaceGameChooseSoulComplete)

	self.currentPrefabIndexBeforeSave = nil
end

function PlaceGameFormationChooseSoulUI:OnAddListeners()
	self.GoEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoEquipBtn)
	self.RemoveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRemoveBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function PlaceGameFormationChooseSoulUI:OnRemoveListeners()
	self.GoEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoEquipBtn)
	self.RemoveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRemoveBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function PlaceGameFormationChooseSoulUI:OnPause()
	return
end

function PlaceGameFormationChooseSoulUI:OnResume()
	return
end

function PlaceGameFormationChooseSoulUI:OnCover()
	return
end

function PlaceGameFormationChooseSoulUI:OnReveal()
	return
end

function PlaceGameFormationChooseSoulUI:OnRefocus(userData)
	return
end

function PlaceGameFormationChooseSoulUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameFormationChooseSoulUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameFormationChooseSoulUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameFormationChooseSoulUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameFormationChooseSoulUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.soulCells) do
		v:Dispose()
	end

	self.soulCells = {}

	self.soulInfoItem:Dispose()

	self.soulInfoItem = nil

	self.formationSkillGroupItem:Dispose()

	self.formation = nil
end

function PlaceGameFormationChooseSoulUI:UpdateView()
	local curPrefab = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(self.currentPrefabId)

	self.currentSoulCid = curPrefab.placeGameSoulPrefabPOD.soulCid
	self.placeGameSoulDataList = PlaceGameModule.placeGameSoulDataList

	table.sort(self.placeGameSoulDataList, function(soulData1, soulData2)
		local soulIndex1 = PlaceGameModule.GetPlaceGameSoulIndexInFormation(soulData1, self.formationIndex)
		local soulIndex2 = PlaceGameModule.GetPlaceGameSoulIndexInFormation(soulData2, self.formationIndex)

		if soulIndex1 ~= -1 == (soulIndex2 ~= -1) then
			if soulIndex1 ~= -1 then
				return soulIndex1 < soulIndex2
			elseif soulData1.placeGameSoulPOD.level == soulData2.placeGameSoulPOD.level then
				return soulData1.cid < soulData2.cid
			else
				return soulData1.placeGameSoulPOD.level > soulData2.placeGameSoulPOD.level
			end
		else
			return soulIndex1 ~= -1
		end
	end)

	local defaultSelectIndex = 1

	for i = 1, #self.placeGameSoulDataList do
		local soulData = self.placeGameSoulDataList[i]
		local soulIndex = PlaceGameModule.GetPlaceGameSoulIndexInFormation(soulData, self.formationIndex)

		if soulData.cid == self.currentSoulCid or soulIndex == -1 then
			defaultSelectIndex = i

			break
		end
	end

	local scrollAreaList = self.SoulCellGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = defaultSelectIndex - 1

	scrollAreaList:Refresh(#self.placeGameSoulDataList)
end

function PlaceGameFormationChooseSoulUI:OnRenderSoulCell(cell)
	local placeGameChooseSoulCell = self.soulCells[cell.gameObject]

	if placeGameChooseSoulCell == nil then
		placeGameChooseSoulCell = PlaceGameFormationChooseSoulCell.New(cell.gameObject)
		self.soulCells[cell.gameObject] = placeGameChooseSoulCell
	end

	local placeGameSoulData = self.placeGameSoulDataList[cell.index + 1]

	placeGameChooseSoulCell:SetData(placeGameSoulData, self.formationIndex, self.currentPrefabId)

	if self.currentSoulCid ~= nil and self.currentSoulCid == placeGameSoulData.cid then
		placeGameChooseSoulCell:SetSelect(true)
		self:ShowSoulInfo(placeGameSoulData)
	end
end

function PlaceGameFormationChooseSoulUI:OnSelectedSoulCell(cell)
	local chooseSoulCell = self.soulCells[cell.gameObject]

	chooseSoulCell:SetSelect(true)
	self:ShowSoulInfo(chooseSoulCell.placeGameSoulData)
end

function PlaceGameFormationChooseSoulUI:ShowSoulInfo(placeGameSoulData)
	self.selectSoulData = placeGameSoulData

	self.RemoveBtn:SetActive(self.selectSoulData.cid == self.currentSoulCid)

	local soulPrefabData
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local lSoulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		if lSoulPrefabData.placeGameSoulPrefabPOD.soulCid == self.selectSoulData.cid then
			soulPrefabData = lSoulPrefabData

			break
		end
	end

	self.soulInfoItem:SetData(placeGameSoulData, soulPrefabData, self.formationIndex)
	self.formationSkillGroupItem:SetData(placeGameSoulData)
end

function PlaceGameFormationChooseSoulUI:Save()
	local currentPrefabIndex, selectedPrefabIndex = self:GetCurrentAndSelectedPrefabIndexes()

	if selectedPrefabIndex ~= 0 and currentPrefabIndex ~= selectedPrefabIndex then
		local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

		PlaceGameModule.GoIntoBattle(formationPOD.id, selectedPrefabIndex, currentPrefabIndex)
	else
		PlaceGameModule.ModifySoul(self.currentPrefabId, self.selectSoulData.cid)
	end
end

function PlaceGameFormationChooseSoulUI:GetCurrentAndSelectedPrefabIndexes()
	local selectedPrefabIndex = 0
	local currentPrefabIndex = 0
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		if soulPrefabData.placeGameSoulPrefabPOD.soulCid == self.selectSoulData.cid then
			selectedPrefabIndex = prefabIndex
		end

		if prefabId == self.currentPrefabId then
			currentPrefabIndex = prefabIndex
		end
	end

	return currentPrefabIndex, selectedPrefabIndex
end

function PlaceGameFormationChooseSoulUI:OnClickGoEquipBtn()
	local currentPrefabIndex, selectedPrefabIndex = self:GetCurrentAndSelectedPrefabIndexes()

	local function goToEquip()
		self.currentPrefabIndexBeforeSave = currentPrefabIndex

		EventDispatcher.AddEventListener(EventID.PlaceGameFormationChooseSoulComplete, self.DelegatePlaceGameChooseSoulComplete)

		if selectedPrefabIndex ~= 0 and currentPrefabIndex == selectedPrefabIndex then
			self:OnChooseSoulComplete()

			return
		end

		self:Save()
	end

	local curPrefab = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(self.currentPrefabId)

	if curPrefab.placeGameSoulPrefabPOD.soulCid ~= nil and selectedPrefabIndex ~= currentPrefabIndex then
		NoticeModule.ShowNotice(21045107, goToEquip)
	else
		goToEquip()
	end
end

function PlaceGameFormationChooseSoulUI:OnChooseSoulComplete()
	EventDispatcher.RemoveEventListener(EventID.PlaceGameFormationChooseSoulComplete, self.DelegatePlaceGameChooseSoulComplete)

	local currentPrefabIndex = self.currentPrefabIndexBeforeSave

	self.currentPrefabIndexBeforeSave = nil

	UIModule.CloseSelf(self)

	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)
	local currentPrefabId

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		if prefabIndex == currentPrefabIndex then
			currentPrefabId = prefabId
		end
	end

	UIModule.Open(Constant.UIControllerName.PlaceGameFormationChooseEquipUI, Constant.UILayer.UI, {
		PrefabId = currentPrefabId,
		FormationIndex = self.formationIndex
	})
end

function PlaceGameFormationChooseSoulUI:OnClickRemoveBtn()
	PlaceGameModule.ModifySoul(self.currentPrefabId, 0)
	UIModule.CloseSelf(self)
end

function PlaceGameFormationChooseSoulUI:OnClickConfirmBtn()
	self:Save()
	UIModule.CloseSelf(self)
end

function PlaceGameFormationChooseSoulUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return PlaceGameFormationChooseSoulUI
