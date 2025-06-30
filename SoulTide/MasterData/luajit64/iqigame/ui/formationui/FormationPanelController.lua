-- chunkname: @IQIGame\\UI\\FormationUI\\FormationPanelController.lua

local m = {
	TeamPower = 0,
	FormationTabIndex = 0
}
local FormationSoulHeadCell = require("IQIGame.UI.FormationUI.FormationSoulHeadCell")
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

	function self.DelegateOnUpdateFormation()
		self:OnUpdateFormation()
	end

	function self.DelegateOnSoulPrefabUpdate()
		self:OnSoulPrefabUpdate()
	end

	function self.DelegateOnClickEditFormationBtn()
		self:OnClickEditFormationBtn()
	end

	function self.DelegateOnClickChangeFormationBtn()
		self:OnClickChangeFormationBtn()
	end

	function self.DelegateOnSoulUpdateMood(soulCid, oldMood, nowMood, type)
		self:OnSoulUpdateMood(soulCid, oldMood, nowMood, type)
	end

	self.SoulCells = {}

	for i = 1, 5 do
		local soulCell = FormationSoulHeadCell.New(UnityEngine.Object.Instantiate(self.SoulHeadPrefab))

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

	UGUIUtil.SetTextInChildren(self.ChangeFormationBtn, MazeDetailUIApi:GetString("ChangeFormationBtnText"))
	UGUIUtil.SetTextInChildren(self.MoodTipView, MazeDetailUIApi:GetString("MoodTipViewText"))
end

function m:AddEventListeners()
	self.EditFormationBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEditFormationBtn)
	self.ChangeFormationBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeFormationBtn)
	EventDispatcher.AddEventListener(EventID.UpdateFormationTeam, self.DelegateOnUpdateFormation)
	EventDispatcher.AddEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
	EventDispatcher.AddEventListener(EventID.SoulUpdateMood, self.DelegateOnSoulUpdateMood)
end

function m:RemoveEventListeners()
	self.EditFormationBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEditFormationBtn)
	self.ChangeFormationBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeFormationBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateFormationTeam, self.DelegateOnUpdateFormation)
	EventDispatcher.RemoveEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
	EventDispatcher.RemoveEventListener(EventID.SoulUpdateMood, self.DelegateOnSoulUpdateMood)
end

function m:ShowSoulByTab(tabIndex)
	if tabIndex <= 0 and tabIndex > #PlayerModule.PlayerInfo.formations then
		logError("TabIndex out of bounds. " .. tabIndex .. " range: 1-" .. #PlayerModule.PlayerInfo.formations)

		tabIndex = 1
	end

	self.FormationTabIndex = tabIndex

	local formationPOD = FormationModule.GetFormationByIndex(self.FormationTabIndex)
	local prefabList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		prefabList[prefabIndex] = prefabId
	end

	local power = 0

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]
		local prefabId = prefabList[i]
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)
		local soulData

		if soulPrefabData.soulCid ~= nil then
			soulData = SoulModule.GetSoulData(soulPrefabData.soulCid)
		end

		soulCell:SetData(soulData)

		power = power + soulPrefabData.power
	end

	self.TeamPower = power

	UGUIUtil.SetText(self.NameText, FormationUIApi:GetString("DefaultFormationName", self.FormationTabIndex, formationPOD.name))

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]
		local prefabId = prefabList[(i - 1) % 5 + 1]
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		cell:SetData(soulPrefabData.position, soulPrefabData.soulCid ~= nil)
	end

	self:CheckTeamMood()

	if self.OnUpdateCallback ~= nil then
		self.OnUpdateCallback()
	end
end

function m:CheckTeamMood()
	local isNotHappy = false
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationTabIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			local soulData = SoulModule.GetSoulData(soulPrefabData.soulCid)
			local state = SoulModule.GetMoodState(soulData.soulCid, soulData.mood)

			if state == 1 then
				isNotHappy = true

				break
			end
		end
	end

	self.MoodTipView:SetActive(isNotHappy)
end

function m:GetPower()
	return self.TeamPower
end

function m:OnUpdateFormation()
	self:Refresh(self.FormationTabIndex)
end

function m:UpdateView()
	local defaultTabIndex = FormationModule.GetLastChooseFormationId()

	self:Refresh(defaultTabIndex)
end

function m:Refresh(defaultTabIndex)
	self:ShowSoulByTab(defaultTabIndex)
end

function m:CheckValidation()
	local hasSoul = false
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationTabIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			hasSoul = true

			break
		end
	end

	if not hasSoul then
		NoticeModule.ShowNotice(21040093)

		return false, nil
	end

	return true, formationPOD
end

function m:GetIndex()
	return self.FormationTabIndex
end

function m:OnSoulPrefabUpdate()
	self:ShowSoulByTab(self.FormationTabIndex)
end

function m:OnClickEditFormationBtn()
	local isUnlock = self:IsFormationUnlock()

	if not isUnlock then
		return
	end

	UIModule.Close(Constant.UIControllerName.FormationUI)
	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, {
		tabIndex = self.FormationTabIndex,
		onConfirm = function(index)
			if self.View == nil then
				return
			end

			PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.FormationTeamIndex, index)
			self:Refresh(index)
		end
	})
end

function m:OnClickChangeFormationBtn()
	local isUnlock = self:IsFormationUnlock()

	if not isUnlock then
		return
	end

	UIModule.Open(Constant.UIControllerName.QuickChangeFormationUI, Constant.UILayer.UI, {
		tabIndex = self.FormationTabIndex,
		onConfirm = function(index)
			if self.View == nil then
				return
			end

			self:Refresh(index)
		end
	})
end

function m:IsFormationUnlock()
	local isUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FORMATION)

	if not isUnlock then
		NoticeModule.ShowNoticeByType(1, UnlockFunctionModule.LockTitle(Constant.UnlockType.FORMATION))

		return false
	end

	if not UnlockFunctionModule.CanUserOperate(Constant.UnlockType.FORMATION) then
		return false
	end

	return true
end

function m:OnSoulUpdateMood(soulCid, oldMood, nowMood, type)
	local needCheck = false
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationTabIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid == soulCid then
			needCheck = true

			break
		end
	end

	if not needCheck then
		return
	end

	self:CheckTeamMood()
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

	self.View = nil
end

return m
