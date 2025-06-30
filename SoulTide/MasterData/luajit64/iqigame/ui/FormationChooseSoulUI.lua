-- chunkname: @IQIGame\\UI\\FormationChooseSoulUI.lua

local FormationChooseSoulUI = {
	CurrentPrefabId = 0,
	FormationIndex = 0,
	SoulCells = {},
	OptionalSkillCells = {},
	SkillGroupItems = {},
	ChangedGroupSkills = {}
}

FormationChooseSoulUI = Base:Extend("FormationChooseSoulUI", "IQIGame.Onigao.UI.FormationChooseSoulUI", FormationChooseSoulUI)

local FormationChooseSoulCell = require("IQIGame.UI.FormationUI.FormationChooseSoulCell")
local FormationSoulInfoItem = require("IQIGame.UI.FormationUI.FormationSoulInfoItem")
local FormationSkillGroupItem = require("IQIGame.UI.FormationUI.FormationSkillGroupItem")
local FormationOptionalSpiritSkillCell = require("IQIGame.UI.FormationUI.FormationOptionalSpiritSkillCell")

function FormationChooseSoulUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickRemoveBtn()
		self:OnClickRemoveBtn()
	end

	function self.DelegateOnClickGoEquipBtn()
		self:OnClickGoEquipBtn()
	end

	function self.DelegateOnSwitchSingleSkill(skillGroupCid, skillCids, soulData)
		self:OnSwitchSingleSkill(skillGroupCid, skillCids, soulData)
	end

	function self.DelegateOnSoulDataChange(soulCid)
		self:OnSoulDataChange(soulCid)
	end

	function self.DelegateOnChooseSoulComplete()
		self:OnChooseSoulComplete()
	end

	function self.DelegateOnSelectOptionalSpiritSkill(index, isOn)
		self:OnSelectOptionalSpiritSkill(index, isOn)
	end

	local scrollAreaList = self.SoulCellGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderSoulCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedSoulCell(cell)
	end

	self.SoulInfoItem = FormationSoulInfoItem.New(self.SoulInfoView, false)

	for i = 1, 2 do
		local cell = FormationOptionalSpiritSkillCell.New(UnityEngine.Object.Instantiate(self.SpiritTogglePrefab), i, self.DelegateOnSelectOptionalSpiritSkill)

		cell.View.transform:SetParent(self.SpiritToggleGrid.transform, false)

		self.OptionalSkillCells[i] = cell
	end

	self.SpiritTogglePrefab:SetActive(false)

	for i = 1, 3 do
		local skillGroupItem = FormationSkillGroupItem.New(UnityEngine.Object.Instantiate(self.SkillGroupPrefab), i, self.DelegateOnSwitchSingleSkill)

		skillGroupItem.View.transform:SetParent(self.SkillGroupGrid.transform, false)

		self.SkillGroupItems[i] = skillGroupItem
	end

	UGUIUtil.SetText(self.TitleText, FormationChooseSoulUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.ChooseSoulLabel, FormationChooseSoulUIApi:GetString("ChooseSoulLabel"))
	UGUIUtil.SetTextInChildren(self.RemoveBtn, FormationChooseSoulUIApi:GetString("RemoveBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, FormationChooseSoulUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.GoEquipBtn, FormationChooseSoulUIApi:GetString("GoEquipBtnText"))
	UGUIUtil.SetTextInChildren(self.GoSoulText, FormationChooseSoulUIApi:GetString("GoSoulText"))
end

function FormationChooseSoulUI:GetPreloadAssetPaths()
	return nil
end

function FormationChooseSoulUI:GetOpenPreloadAssetPaths(userData)
	local soulPortraitPath
	local soulPrefabData = SoulPrefabModule.GetPrefab(userData.prefabId)

	if soulPrefabData.soulCid ~= nil then
		local soulData = SoulModule.GetSoulData(soulPrefabData.soulCid)

		soulPortraitPath = FormationChooseEquipUIApi:GetString("SoulPortraitPath", soulPrefabData.soulCid, soulData:GetCfgDress2D().SoulResID)
	end

	if soulPortraitPath ~= nil then
		return {
			soulPortraitPath
		}
	else
		return nil
	end
end

function FormationChooseSoulUI:IsManualShowOnOpen(userData)
	return false
end

function FormationChooseSoulUI:GetBGM(userData)
	return nil
end

function FormationChooseSoulUI:OnOpen(userData)
	self:UpdateView(userData.formationIndex, userData.prefabId)
end

function FormationChooseSoulUI:OnClose(userData)
	self.SoulInfoItem:OnClose()
	EventDispatcher.RemoveEventListener(EventID.FormationChooseSoulComplete, self.DelegateOnChooseSoulComplete)

	self.CurrentPrefabIndexBeforeSave = nil
end

function FormationChooseSoulUI:OnAddListeners()
	self.SoulInfoItem:AddListeners()

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:AddListeners()
	end

	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.RemoveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRemoveBtn)
	self.GoEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoEquipBtn)
	EventDispatcher.AddEventListener(EventID.SoulDataChange, self.DelegateOnSoulDataChange)
end

function FormationChooseSoulUI:OnRemoveListeners()
	self.SoulInfoItem:RemoveListeners()

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:RemoveListeners()
	end

	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.RemoveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRemoveBtn)
	self.GoEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoEquipBtn)
	EventDispatcher.RemoveEventListener(EventID.SoulDataChange, self.DelegateOnSoulDataChange)
end

function FormationChooseSoulUI:OnPause()
	return
end

function FormationChooseSoulUI:OnResume()
	return
end

function FormationChooseSoulUI:OnCover()
	return
end

function FormationChooseSoulUI:OnReveal()
	return
end

function FormationChooseSoulUI:OnRefocus(userData)
	return
end

function FormationChooseSoulUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FormationChooseSoulUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FormationChooseSoulUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FormationChooseSoulUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FormationChooseSoulUI:OnDestroy()
	for gameObject, soulCell in pairs(self.SoulCells) do
		soulCell:Dispose()
	end

	self.SoulCells = nil

	for i = 1, #self.OptionalSkillCells do
		self.OptionalSkillCells[i]:Dispose()
	end

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:Dispose()
	end

	self.SoulInfoItem:Dispose()
end

function FormationChooseSoulUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function FormationChooseSoulUI:UpdateView(formationIndex, prefabId)
	self.FormationIndex = formationIndex
	self.CurrentPrefabId = prefabId

	local curPrefab = SoulPrefabModule.GetPrefab(self.CurrentPrefabId)

	self.CurrentSoulCid = curPrefab.soulCid
	self.SoulDataList = SoulModule.GetSortedUnlockSoulDataList()

	table.sort(self.SoulDataList, function(soulData1, soulData2)
		local soulIndex1 = FormationModule.GetSoulIndexInFormation(soulData1, self.FormationIndex)
		local soulIndex2 = FormationModule.GetSoulIndexInFormation(soulData2, self.FormationIndex)

		if soulIndex1 ~= -1 == (soulIndex2 ~= -1) then
			if soulIndex1 ~= -1 then
				return soulIndex1 < soulIndex2
			elseif soulData1.lv == soulData2.lv then
				local quality1 = soulData1:GetCfgSoulQuality()
				local quality2 = soulData2:GetCfgSoulQuality()

				if quality1.Quality == quality2.Quality then
					return soulData1.soulCid < soulData2.soulCid
				else
					return quality1.Quality > quality2.Quality
				end
			else
				return soulData1.lv > soulData2.lv
			end
		else
			return soulIndex1 ~= -1
		end
	end)

	local defaultSelectIndex = 1

	for i = 1, #self.SoulDataList do
		local soulData = self.SoulDataList[i]
		local soulIndex = FormationModule.GetSoulIndexInFormation(soulData, self.FormationIndex)

		if soulData.soulCid == self.CurrentSoulCid or soulIndex == -1 then
			defaultSelectIndex = i

			break
		end
	end

	local scrollAreaList = self.SoulCellGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = defaultSelectIndex - 1

	scrollAreaList:Refresh(#self.SoulDataList)
end

function FormationChooseSoulUI:OnRenderSoulCell(cell)
	local soulCell = self.SoulCells[cell.gameObject]

	if soulCell == nil then
		soulCell = FormationChooseSoulCell.New(cell.gameObject)
		self.SoulCells[cell.gameObject] = soulCell
	end

	local soulData = self.SoulDataList[cell.index + 1]

	soulCell:SetData(soulData, self.FormationIndex, self.CurrentPrefabId)
end

function FormationChooseSoulUI:OnSelectedSoulCell(cell)
	local soulCell = self.SoulCells[cell.gameObject]

	self:ShowSoulInfo(soulCell.SoulData)
end

function FormationChooseSoulUI:ShowSoulInfo(soulData)
	self.SelectSoulData = soulData
	self.ChangedGroupSkills = {}

	self.RemoveBtn:SetActive(soulData.soulCid == self.CurrentSoulCid)

	local soulPrefabData
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local lSoulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if lSoulPrefabData.soulCid == soulData.soulCid then
			soulPrefabData = lSoulPrefabData

			break
		end
	end

	self.SoulInfoItem:SetData(soulData, soulPrefabData, self.FormationIndex)

	local selectedSkillIndex = 0

	for i = 1, #self.OptionalSkillCells do
		local cfgSkillData = soulData:GetSpOptionalSkillByIndex(i, true)

		self.OptionalSkillCells[i]:SetData(cfgSkillData, soulData, true)

		if cfgSkillData ~= nil and soulPrefabData ~= nil and cfgSkillData.Id == soulPrefabData.optionalSkill then
			selectedSkillIndex = i
		end
	end

	if selectedSkillIndex ~= 0 then
		self.OptionalSkillCells[selectedSkillIndex]:SetIsOn(true, true)
	end

	local defaultSkillGroups = soulData:GetCfgSoul().DefaultSkill
	local skillGroupIndex

	if soulPrefabData ~= nil then
		skillGroupIndex = table.indexOf(defaultSkillGroups, soulPrefabData.skillGroupId)
	else
		skillGroupIndex = 1
	end

	for i = 1, #self.SkillGroupItems do
		local skillGroupItem = self.SkillGroupItems[i]

		skillGroupItem:SetToggleOn(i == skillGroupIndex, true)
	end

	local customSkills

	if soulPrefabData ~= nil and skillGroupIndex == 3 then
		customSkills = soulPrefabData.customSkills
	end

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:SetData(soulData, defaultSkillGroups[i], customSkills)
	end
end

function FormationChooseSoulUI:OnClickConfirmBtn()
	self:Save()
	UIModule.CloseSelf(self)
end

function FormationChooseSoulUI:Save()
	local currentPrefabIndex, selectedPrefabIndex = self:GetCurrentAndSelectedPrefabIndexes()
	local selectedSkillGroupIndex

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		if item.IsSelected then
			selectedSkillGroupIndex = i

			break
		end
	end

	local defaultSkillGroups = self.SelectSoulData:GetCfgSoul().DefaultSkill
	local skillGroupCid = defaultSkillGroups[selectedSkillGroupIndex]
	local skills = self.ChangedGroupSkills[skillGroupCid]

	if selectedSkillGroupIndex == 3 and skills == nil then
		local skillGroupItem = self.SkillGroupItems[3]

		skills = skillGroupItem:GetSkills()
	end

	if selectedPrefabIndex ~= 0 and currentPrefabIndex ~= selectedPrefabIndex then
		local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

		FormationModule.SendExchangePrefab(formationPOD.id, selectedPrefabIndex, currentPrefabIndex, skillGroupCid, skills)
	else
		SoulPrefabModule.SendChangeSoulPrefab(self.CurrentPrefabId, self.SelectSoulData.soulCid, skillGroupCid, skills, self:GetOptionSkill())
	end

	self.ChangedGroupSkills = {}
end

function FormationChooseSoulUI:GetCurrentAndSelectedPrefabIndexes()
	local selectedPrefabIndex = 0
	local currentPrefabIndex = 0
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid == self.SelectSoulData.soulCid then
			selectedPrefabIndex = prefabIndex
		end

		if prefabId == self.CurrentPrefabId then
			currentPrefabIndex = prefabIndex
		end
	end

	return currentPrefabIndex, selectedPrefabIndex
end

function FormationChooseSoulUI:OnClickRemoveBtn()
	SoulPrefabModule.SendChangeSoulPrefab(self.CurrentPrefabId, 0, 0, nil, 0)
	UIModule.CloseSelf(self)
end

function FormationChooseSoulUI:OnClickGoEquipBtn()
	local currentPrefabIndex, selectedPrefabIndex = self:GetCurrentAndSelectedPrefabIndexes()

	local function goToEquip()
		self.CurrentPrefabIndexBeforeSave = currentPrefabIndex

		EventDispatcher.AddEventListener(EventID.FormationChooseSoulComplete, self.DelegateOnChooseSoulComplete)
		self:Save()
	end

	local curPrefab = SoulPrefabModule.GetPrefab(self.CurrentPrefabId)

	if curPrefab.soulCid ~= nil and selectedPrefabIndex ~= currentPrefabIndex then
		NoticeModule.ShowNotice(21046009, goToEquip)
	else
		goToEquip()
	end
end

function FormationChooseSoulUI:OnChooseSoulComplete()
	EventDispatcher.RemoveEventListener(EventID.FormationChooseSoulComplete, self.DelegateOnChooseSoulComplete)

	local currentPrefabIndex = self.CurrentPrefabIndexBeforeSave

	self.CurrentPrefabIndexBeforeSave = nil

	UIModule.CloseSelf(self)

	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)
	local currentPrefabId

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		if prefabIndex == currentPrefabIndex then
			currentPrefabId = prefabId
		end
	end

	UIModule.Open(Constant.UIControllerName.FormationChooseEquipUI, Constant.UILayer.UI, {
		prefabId = currentPrefabId,
		formationIndex = self.FormationIndex
	})
end

function FormationChooseSoulUI:OnSwitchSingleSkill(skillGroupCid, skillCids, soulData)
	self.ChangedGroupSkills[skillGroupCid] = skillCids

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		if item.SkillGroupCid == skillGroupCid then
			local skillStrengthens

			if soulData ~= nil then
				skillStrengthens = soulData.activationSkillStrengthen
			end

			item:SetSkills(skillCids, skillStrengthens)

			break
		end
	end
end

function FormationChooseSoulUI:OnSoulDataChange(soulCid)
	self:UpdateView(self.FormationIndex, self.CurrentPrefabId)
end

function FormationChooseSoulUI:OnSelectOptionalSpiritSkill(index, isOn)
	if isOn then
		for i = 1, #self.OptionalSkillCells do
			if i ~= index then
				self.OptionalSkillCells[i]:SetIsOn(false, true)
			end
		end
	end
end

function FormationChooseSoulUI:GetOptionSkill()
	for i = 1, #self.OptionalSkillCells do
		local cell = self.OptionalSkillCells[i]

		if cell.isOn and cell.CfgSkillData ~= nil then
			return cell.CfgSkillData.Id
		end
	end

	return 0
end

return FormationChooseSoulUI
