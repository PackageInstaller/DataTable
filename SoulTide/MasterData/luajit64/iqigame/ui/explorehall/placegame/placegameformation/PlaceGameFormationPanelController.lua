-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameFormationPanelController.lua

local m = {
	TeamPower = 0,
	FormationTabIndex = 0
}

require("IQIGame.UIExternalApi.PlaceGameChallengeDetailUIApi")

local PlaceGameFormationSoulHeadCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationSoulHeadCell")
local FormationPanelPositionCell = require("IQIGame.UI.FormationUI.FormationPanelPositionCell")

function m.New(view, onUpdateCallback)
	local obj = Clone(m)

	obj:Init(view, onUpdateCallback)

	return obj
end

function m:Init(view, onUpdateCallback)
	self.View = view
	self.OnUpdateCallback = onUpdateCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnSoulPrefabUpdate()
		self:OnSoulPrefabUpdate()
	end

	function self.DelegateOnClickEditFormationBtn()
		self:OnClickEditFormationBtn()
	end

	function self.DelegateOnClickChangeFormationBtn()
		self:OnClickChangeFormationBtn()
	end

	self.SoulCells = {}

	for i = 1, 5 do
		local soulCell = PlaceGameFormationSoulHeadCell.New(UnityEngine.Object.Instantiate(self.SoulHeadPrefab))

		soulCell.View.transform:SetParent(self.SoulGrid.transform, false)
		table.insert(self.SoulCells, soulCell)
	end

	self.PositionCells = {}

	for i = 1, 10 do
		local cellGo = UnityEngine.Object.Instantiate(self.PosCellPrefab)

		cellGo.transform:SetParent(self.PositionGrid.transform, false)

		local cell = FormationPanelPositionCell.New(cellGo, i)

		self.PositionCells[i] = cell
	end

	UGUIUtil.SetTextInChildren(self.ChangeFormationBtn, PlaceGameChallengeDetailUIApi:GetString("ChangeFormationBtnText"))
	UGUIUtil.SetTextInChildren(self.MoodTipView, PlaceGameChallengeDetailUIApi:GetString("MoodTipViewText"))
end

function m:AddEventListeners()
	self.EditFormationBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEditFormationBtn)
	self.ChangeFormationBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeFormationBtn)
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
end

function m:RemoveEventListeners()
	self.EditFormationBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEditFormationBtn)
	self.ChangeFormationBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeFormationBtn)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
end

function m:ShowSoulByTab(tabIndex)
	local formations = PlaceGameModule.DailyDupPOD.placeGamePOD.placeGameFormationPODs or {}

	if tabIndex <= 0 and tabIndex > #formations then
		logError("TabIndex out of bounds. " .. tabIndex .. " range: 1-" .. #formations)

		tabIndex = 1
	end

	self.FormationTabIndex = tabIndex

	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.FormationTabIndex)
	local prefabList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		prefabList[prefabIndex] = prefabId
	end

	local power = 0

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]
		local prefabId = prefabList[i]
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)
		local soulData

		if soulPrefabData.placeGameSoulPrefabPOD.soulCid and soulPrefabData.placeGameSoulPrefabPOD.soulCid > 0 then
			soulData = PlaceGameModule.GetPlaceGameSoulDataByCid(soulPrefabData.placeGameSoulPrefabPOD.soulCid)
		end

		soulCell:SetData(soulData)

		power = power + soulPrefabData.placeGameSoulPrefabPOD.power
	end

	self.TeamPower = power

	UGUIUtil.SetText(self.TextPower, PlaceGameChallengeDetailUIApi:GetString("TextPower", self.TeamPower))
	UGUIUtil.SetText(self.NameText, PlaceGameChallengeDetailUIApi:GetString("DefaultFormationName", self.FormationTabIndex, formationPOD.name))

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]
		local prefabId = prefabList[(i - 1) % 5 + 1]
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		cell:SetData(soulPrefabData.placeGameSoulPrefabPOD.position, tonumber(soulPrefabData.placeGameSoulPrefabPOD.soulCid) > 0)
	end

	self:CheckTeamMood()

	if self.OnUpdateCallback ~= nil then
		self.OnUpdateCallback()
	end
end

function m:CheckTeamMood()
	local isNotHappy = false

	self.MoodTipView:SetActive(isNotHappy)
end

function m:UpdateView()
	local defaultTabIndex = PlaceGameModule.GetPlaceGameLastChooseFormationId()

	self:Refresh(defaultTabIndex)
end

function m:Refresh(defaultTabIndex)
	self:ShowSoulByTab(defaultTabIndex)
end

function m:CheckValidation()
	local hasSoul = false
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.FormationTabIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		if tonumber(soulPrefabData.placeGameSoulPrefabPOD.soulCid) > 0 then
			hasSoul = true

			break
		end
	end

	if not hasSoul then
		NoticeModule.ShowNotice(21045108)

		return false, nil
	end

	return true, formationPOD
end

function m:OnSoulPrefabUpdate()
	self:ShowSoulByTab(self.FormationTabIndex)
end

function m:OnClickEditFormationBtn()
	local isUnlock = self:IsFormationUnlock()

	if not isUnlock then
		return
	end

	UIModule.Close(Constant.UIControllerName.PlaceGamePlayerFormationUI)
	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerFormationUI, Constant.UILayer.UI, {
		FormationIndex = self.FormationTabIndex,
		OnConfirm = function(index)
			if self.View == nil then
				return
			end

			PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.PlaceGameFormationTeamIndex, index)
			self:Refresh(index)
		end
	})
end

function m:OnClickChangeFormationBtn()
	local isUnlock = self:IsFormationUnlock()

	if not isUnlock then
		return
	end

	UIModule.Open(Constant.UIControllerName.PlaceGameQuickChangeFormationUI, Constant.UILayer.UI, {
		FormationIndex = self.FormationTabIndex,
		OnConfirm = function(index)
			if self.View == nil then
				return
			end

			self:Refresh(index)
		end
	})
end

function m:IsFormationUnlock()
	return true
end

function m:SetFormationSoulLv(lv)
	if self.SoulCells then
		for i = 1, #self.SoulCells do
			local cell = self.SoulCells[i]

			if cell.SoulHeadCell and cell.SoulHeadCell.soulData and lv > cell.SoulHeadCell.soulData.lv then
				cell:SetSoulLv(lv)
			end
		end
	end
end

function m:SetFormationShowTag(formationInfoPOD, str)
	local otherFormationSouls = {}
	local isShowTag = false

	if formationInfoPOD and formationInfoPOD.soulPrefabs then
		for k, formationSoulPrefabPOD in pairs(formationInfoPOD.soulPrefabs) do
			if formationSoulPrefabPOD.soulCid > 0 then
				table.insert(otherFormationSouls, formationSoulPrefabPOD.soulCid)
			end
		end
	end

	if self.SoulCells then
		for i = 1, #self.SoulCells do
			local cell = self.SoulCells[i]

			if cell.SoulData ~= nil and table.indexOf(otherFormationSouls, cell.SoulHeadCell.soulData.soulCid) ~= -1 then
				cell:ShowTag(true, str)

				isShowTag = true
			else
				cell:ShowTag(false, str)
			end
		end
	end

	return isShowTag
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]

		soulCell:Dispose()
	end

	self.SoulCells = nil

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]

		cell:Dispose()
	end

	self.PositionCells = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
