-- chunkname: @IQIGame\\UI\\PlaceGamePlayerFormationUI.lua

local PlaceGamePlayerFormationUI = {
	formationIndex = 1,
	formationCells = {},
	formationToggleCells = {}
}

PlaceGamePlayerFormationUI = Base:Extend("PlaceGamePlayerFormationUI", "IQIGame.Onigao.UI.PlaceGamePlayerFormationUI", PlaceGamePlayerFormationUI)

require("IQIGame.UIExternalApi.PlaceGamePlayerFormationUIApi")
require("IQIGame.UIExternalApi.PlaceGamePlayerUpdateUIApi")

local PlaceGameFormationCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationCell")
local PlaceGameFormationToggleCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationToggleCell")

function PlaceGamePlayerFormationUI:OnInit()
	UGUIUtil.SetText(self.TitleText, PlaceGamePlayerFormationUIApi:GetString("TitleText"))

	function self.DelegateOnClickSwitchInfoViewBtn()
		self:OnClickSwitchInfoViewBtn()
	end

	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnClickPrevBtn()
		self:OnClickPrevBtn()
	end

	function self.DelegateOnTabTogglePrefabValueChanged(isOn)
		self:OnTabTogglePrefabValueChanged(isOn)
	end

	function self.DelegateOnClickUnloadAllEquipBtn()
		self:OnClickUnloadAllEquipBtn()
	end

	function self.DelegateOnClickUnloadAllSoulBtn()
		self:OnClickUnloadAllSoulBtn()
	end

	function self.DelegateOnClickBtnGuide()
		self:OnClickBtnGuide()
	end

	function self.DelegateOnClickEditNameBtn()
		self:OnClickEditNameBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegatePlaceGameSoulPrefabUpdate(id)
		self:OnPlaceGameSoulPrefabUpdate(id)
	end

	function self.DelegatePlaceGameFormationUpdate()
		self:OnPlaceGameFormationUpdate()
	end

	self.formationCells = {}

	for i = 1, 5 do
		local cell = PlaceGameFormationCell.New(UnityEngine.Object.Instantiate(self.SoulCellPrefab), i)

		cell.View.transform:SetParent(self.SoulGrid.transform, false)

		self.formationCells[i] = cell
	end

	self.formationToggleCells = {}

	for i = 1, #PlaceGameModule.DailyDupPOD.placeGamePOD.placeGameFormationPODs do
		local toggleCell = PlaceGameFormationToggleCell.New(UnityEngine.Object.Instantiate(self.TabTogglePrefab), i)

		toggleCell.View.transform:SetParent(self.TabToggleGrid.transform, false)

		function toggleCell.selectToggleCallBack(index)
			self:OnSelectToggle(index)
		end

		self.formationToggleCells[i] = toggleCell
	end
end

function PlaceGamePlayerFormationUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGamePlayerFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGamePlayerFormationUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGamePlayerFormationUI:GetBGM(userData)
	return nil
end

function PlaceGamePlayerFormationUI:OnOpen(userData)
	if userData and userData.FormationIndex then
		self.formationIndex = userData.FormationIndex
		self.onConfirmCallback = userData.OnConfirm
	end

	self:UpdateView()
end

function PlaceGamePlayerFormationUI:OnClose(userData)
	if self.onConfirmCallback ~= nil then
		self.onConfirmCallback(self.formationIndex)
	end

	self.onConfirmCallback = nil
end

function PlaceGamePlayerFormationUI:OnAddListeners()
	self.SwitchInfoViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchInfoViewBtn)
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	self.PrevBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevBtn)
	self.TabTogglePrefab:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnTabTogglePrefabValueChanged)
	self.UnloadAllEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllEquipBtn)
	self.UnloadAllSoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllSoulBtn)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGuide)
	self.EditNameBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEditNameBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegatePlaceGameSoulPrefabUpdate)
	EventDispatcher.AddEventListener(EventID.PlaceGameFormationUpdate, self.DelegatePlaceGameFormationUpdate)
end

function PlaceGamePlayerFormationUI:OnRemoveListeners()
	self.SwitchInfoViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchInfoViewBtn)
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	self.PrevBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevBtn)
	self.TabTogglePrefab:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnTabTogglePrefabValueChanged)
	self.UnloadAllEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllEquipBtn)
	self.UnloadAllSoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllSoulBtn)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGuide)
	self.EditNameBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEditNameBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegatePlaceGameSoulPrefabUpdate)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameFormationUpdate, self.DelegatePlaceGameFormationUpdate)
end

function PlaceGamePlayerFormationUI:OnPause()
	return
end

function PlaceGamePlayerFormationUI:OnResume()
	return
end

function PlaceGamePlayerFormationUI:OnCover()
	return
end

function PlaceGamePlayerFormationUI:OnReveal()
	return
end

function PlaceGamePlayerFormationUI:OnRefocus(userData)
	return
end

function PlaceGamePlayerFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGamePlayerFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGamePlayerFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGamePlayerFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGamePlayerFormationUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.formationCells) do
		v:Dispose()
	end

	for i, v in pairs(self.formationToggleCells) do
		v:Dispose()
	end
end

function PlaceGamePlayerFormationUI:OnClickSwitchInfoViewBtn()
	for i, v in pairs(self.formationCells) do
		v:NextInfoView()
	end
end

function PlaceGamePlayerFormationUI:OnClickNextBtn()
	self.formationIndex = self.formationIndex + 1

	if self.formationIndex > #PlaceGameModule.DailyDupPOD.placeGamePOD.placeGameFormationPODs then
		self.formationIndex = 1
	end

	self:RefreshFormationInfo()
end

function PlaceGamePlayerFormationUI:OnClickPrevBtn()
	self.formationIndex = self.formationIndex - 1

	if self.formationIndex < 1 then
		self.formationIndex = #PlaceGameModule.DailyDupPOD.placeGamePOD.placeGameFormationPODs
	end

	self:RefreshFormationInfo()
end

function PlaceGamePlayerFormationUI:OnTabTogglePrefabValueChanged(isOn)
	return
end

function PlaceGamePlayerFormationUI:OnClickUnloadAllEquipBtn()
	local hasEquip = false
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)
		local equipments = soulPrefabData.placeGameSoulPrefabPOD.equipments

		for i, v in pairs(equipments) do
			if v and tonumber(v) > 0 then
				hasEquip = true

				break
			end
		end

		if hasEquip then
			break
		end
	end

	if not hasEquip then
		self.UnloadAllToggle:GetComponent("Toggle").isOn = false

		return
	end

	NoticeModule.ShowNotice(21046004, function()
		local lFormationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

		PlaceGameModule.AllEquipUnload(lFormationPOD.id)

		self.UnloadAllToggle:GetComponent("Toggle").isOn = false
	end)
end

function PlaceGamePlayerFormationUI:OnClickUnloadAllSoulBtn()
	local hasSoul = false
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		if soulPrefabData.placeGameSoulPrefabPOD.soulCid ~= nil then
			hasSoul = true

			break
		end
	end

	if not hasSoul then
		self.UnloadAllToggle:GetComponent("Toggle").isOn = false

		return
	end

	NoticeModule.ShowNotice(21046003, function()
		local lFormationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

		PlaceGameModule.AllSoulUnload(lFormationPOD.id)

		self.UnloadAllToggle:GetComponent("Toggle").isOn = false
	end)
end

function PlaceGamePlayerFormationUI:OnClickBtnGuide()
	return
end

function PlaceGamePlayerFormationUI:OnClickEditNameBtn()
	UIModule.Open(Constant.UIControllerName.InputTextUI, Constant.UILayer.UI, {
		yes = function(text)
			if text == "" or string.getUTF8Length(text) > 6 then
				NoticeModule.ShowNotice(21046000)

				return
			end

			local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

			PlaceGameModule.ChangeFormationName(formationPOD.id, text)
		end,
		defaultTxt = PlaceGamePlayerFormationUIApi:GetString("InputNameNoticeText")
	})
end

function PlaceGamePlayerFormationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function PlaceGamePlayerFormationUI:OnPlaceGameSoulPrefabUpdate()
	self:UpdateView()
end

function PlaceGamePlayerFormationUI:OnPlaceGameFormationUpdate()
	self:UpdateView()
end

function PlaceGamePlayerFormationUI:UpdateView()
	self:RefreshFormationInfo()

	for i, v in pairs(self.formationCells) do
		v:UpdateInfoView()
	end
end

function PlaceGamePlayerFormationUI:RefreshFormationInfo()
	self.formationToggleCells[self.formationIndex]:RefreshSelect(true)

	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

	if formationPOD then
		UGUIUtil.SetText(self.NameText, PlaceGamePlayerFormationUIApi:GetString("DefaultFormationName", self.formationIndex, formationPOD.name))

		local power = 0

		for i, v in pairs(formationPOD.formation) do
			local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(i)

			if soulPrefabData then
				if soulPrefabData.placeGameSoulPrefabPOD.power ~= nil then
					power = power + soulPrefabData.placeGameSoulPrefabPOD.power
				end

				self.formationCells[soulPrefabData.placeGameSoulPrefabPOD.formationPos]:SetData(soulPrefabData, self.formationIndex)
			end
		end

		UGUIUtil.SetText(self.PowerText, power)
		UGUIUtil.SetText(self.FormationIndexText, PlaceGamePlayerFormationUIApi:GetString("FormationIndexText", self.formationIndex))
	end
end

function PlaceGamePlayerFormationUI:OnSelectToggle(toggleIndex)
	if self.formationIndex ~= toggleIndex then
		self.formationIndex = toggleIndex

		self:RefreshFormationInfo()
	end
end

return PlaceGamePlayerFormationUI
