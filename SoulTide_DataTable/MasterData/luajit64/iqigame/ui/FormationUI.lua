-- chunkname: @IQIGame\\UI\\FormationUI.lua

local FormationUI = {
	TogglePage = 1,
	FormationIndex = 0,
	SoulCells = {},
	TabToggles = {}
}

FormationUI = Base:Extend("FormationUI", "IQIGame.Onigao.UI.FormationUI", FormationUI)

local FormationSoulCell = require("IQIGame.UI.FormationUI.FormationSoulCell")

function FormationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnSoulPrefabUpdate()
		self:OnSoulPrefabUpdate()
	end

	function self.DelegateOnUpdateFormation()
		self:OnUpdateFormation()
	end

	function self.DelegateOnClickEditNameBtn()
		self:OnClickEditNameBtn()
	end

	function self.DelegateOnClickBtnGuide()
		self:OnClickBtnGuide()
	end

	function self.DelegateOnClickUnloadAllSoulBtn()
		self:OnClickUnloadAllSoulBtn()
	end

	function self.DelegateOnClickUnloadAllEquipBtn()
		self:OnClickUnloadAllEquipBtn()
	end

	function self.DelegateOnClickPrevBtn()
		self:OnClickPrevBtn()
	end

	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnClickSwitchInfoViewBtn()
		self:OnClickSwitchInfoViewBtn()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateOnCopyToggleValueChanged(isOn)
		self:OnCopyToggleValueChanged(isOn)
	end

	function self.DelegateOnClickPasteBtn()
		self:OnClickPasteBtn()
	end

	function self.DelegateOnClickSwitchTogglePageBtn()
		self:OnClickSwitchTogglePageBtn()
	end

	for i = 1, 5 do
		local soulGo = UnityEngine.Object.Instantiate(self.SoulCellPrefab)

		soulGo.name = "FormationSoulCell_" .. i

		local cell = FormationSoulCell.New(soulGo, i, self)

		soulGo.transform:SetParent(self.SoulGrid.transform, false)
		table.insert(self.SoulCells, cell)
	end

	for i = 1, 10 do
		local toggle = UnityEngine.Object.Instantiate(self.TabTogglePrefab)

		toggle.transform:SetParent(self.TabToggleGrid.transform, false)

		self.TabToggles[i] = toggle
		self["DelegateOnTabToggleValueChanged" .. i] = function()
			self:OnTabToggleValueChanged(i)
		end
	end

	UGUIUtil.SetText(self.TitleText, FormationUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.PowerLabel, FormationUIApi:GetString("PowerLabel"))
	UGUIUtil.SetText(self.UnloadAllToggleText1, FormationUIApi:GetString("UnloadAllToggleText"))
	UGUIUtil.SetText(self.UnloadAllToggleText2, FormationUIApi:GetString("UnloadAllToggleText"))
	UGUIUtil.SetTextInChildren(self.UnloadAllSoulBtn, FormationUIApi:GetString("UnloadAllSoulBtnText"))
	UGUIUtil.SetTextInChildren(self.UnloadAllEquipBtn, FormationUIApi:GetString("UnloadAllEquipBtnText"))
	UGUIUtil.SetTextInChildren(self.SwitchInfoViewBtn, FormationUIApi:GetString("SwitchInfoViewBtnText"))
	UGUIUtil.SetTextInChildren(self.PasteBtn, FormationUIApi:GetString("PasteBtnText"))
	self.CopyToggle:GetComponent("ToggleHelperComponent"):SetTexts(FormationUIApi:GetString("CopyToggleTexts"))
end

function FormationUI:GetPreloadAssetPaths()
	return nil
end

function FormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FormationUI:IsManualShowOnOpen(userData)
	return false
end

function FormationUI:GetBGM(userData)
	return nil
end

function FormationUI:OnOpen(userData)
	local formationIndex = 1

	if userData ~= nil and userData.tabIndex ~= nil and userData.tabIndex ~= 0 then
		formationIndex = userData.tabIndex
	end

	local onConfirm

	if userData ~= nil then
		onConfirm = userData.onConfirm
	end

	self:UpdateView(formationIndex, onConfirm)
end

function FormationUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseFormationUI")
end

function FormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.EditNameBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEditNameBtn)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGuide)
	self.UnloadAllSoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllSoulBtn)
	self.UnloadAllEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllEquipBtn)
	self.PrevBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevBtn)
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	self.SwitchInfoViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchInfoViewBtn)
	self.CopyToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnCopyToggleValueChanged)
	self.PasteBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPasteBtn)
	self.SwitchPageBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchTogglePageBtn)

	for i = 1, #self.TabToggles do
		self.TabToggles[i]:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateOnTabToggleValueChanged" .. i])
	end

	EventDispatcher.AddEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
	EventDispatcher.AddEventListener(EventID.UpdateFormationTeam, self.DelegateOnUpdateFormation)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function FormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.EditNameBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEditNameBtn)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGuide)
	self.UnloadAllSoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllSoulBtn)
	self.UnloadAllEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllEquipBtn)
	self.PrevBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevBtn)
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	self.SwitchInfoViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchInfoViewBtn)
	self.CopyToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnCopyToggleValueChanged)
	self.PasteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPasteBtn)
	self.SwitchPageBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchTogglePageBtn)

	for i = 1, #self.TabToggles do
		self.TabToggles[i]:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateOnTabToggleValueChanged" .. i])
	end

	EventDispatcher.RemoveEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
	EventDispatcher.RemoveEventListener(EventID.UpdateFormationTeam, self.DelegateOnUpdateFormation)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function FormationUI:OnPause()
	return
end

function FormationUI:OnResume()
	return
end

function FormationUI:OnCover()
	return
end

function FormationUI:OnReveal()
	return
end

function FormationUI:OnRefocus(userData)
	return
end

function FormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FormationUI:OnDestroy()
	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:Dispose()
	end

	self.SoulCells = nil
end

function FormationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)

	if self.OnConfirmCallback ~= nil then
		self.OnConfirmCallback(self.FormationIndex)
	end
end

function FormationUI:OnTabToggleValueChanged(toggleIndex)
	local formationIndex = self:GetFormationIndexByToggle(toggleIndex)

	self:ShowFormation(formationIndex)
end

function FormationUI:ShowFormation(index)
	self.FormationIndex = index

	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	UGUIUtil.SetText(self.NameText, FormationUIApi:GetString("DefaultFormationName", self.FormationIndex, formationPOD.name))

	local soulList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		soulList[prefabIndex] = prefabId
	end

	local power = 0

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:SetData(soulList[i], self.FormationIndex)

		if cell.SoulPrefabData.power ~= nil then
			power = power + cell.SoulPrefabData.power
		end
	end

	UGUIUtil.SetText(self.PowerText, power)
	UGUIUtil.SetText(self.FormationIndexText, FormationUIApi:GetString("FormationIndexText", self.FormationIndex))
end

function FormationUI:UpdateView(formationIndex, onConfirm)
	if formationIndex <= 0 and formationIndex > #PlayerModule.PlayerInfo.formations then
		logError("TabIndex out of bounds. " .. formationIndex .. " range: 1-" .. #PlayerModule.PlayerInfo.formations)

		formationIndex = 1
	end

	self.OnConfirmCallback = onConfirm
	self.CopyToggle:GetComponent("Toggle").isOn = false

	self:RefreshTogglePageShow(formationIndex)

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:ResetInfoView()
	end
end

function FormationUI:OnSoulPrefabUpdate()
	self:ShowFormation(self.FormationIndex)
end

function FormationUI:OnUpdateFormation()
	self:ShowFormation(self.FormationIndex)
end

function FormationUI:OnClickEditNameBtn()
	UIModule.Open(Constant.UIControllerName.InputTextUI, Constant.UILayer.UI, {
		yes = function(text)
			if text == "" or string.getUTF8Length(text) > 6 then
				NoticeModule.ShowNotice(21046000)

				return
			end

			local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

			FormationModule.SendChangeName(formationPOD.id, text)
		end,
		defaultTxt = FormationUIApi:GetString("InputNameNoticeText")
	})
end

function FormationUI:OnClickBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 6000)
end

function FormationUI:OnClickUnloadAllSoulBtn()
	local hasSoul = false
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			hasSoul = true

			break
		end
	end

	if not hasSoul then
		self.UnloadAllToggle:GetComponent("Toggle").isOn = false

		return
	end

	NoticeModule.ShowNotice(21046003, function()
		local lFormationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

		for prefabId, prefabIndex in pairs(lFormationPOD.formation) do
			SoulPrefabModule.SendChangeSoulPrefab(prefabId, 0, 0, nil, 0)
		end

		self.UnloadAllToggle:GetComponent("Toggle").isOn = false
	end)
end

function FormationUI:OnClickUnloadAllEquipBtn()
	local hasEquip = false
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		if not hasEquip then
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			for i, v in pairs(soulPrefabData.equipItemDatum) do
				hasEquip = true

				break
			end

			for i, v in pairs(soulPrefabData.newJewelrySpeeds) do
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
		local lFormationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

		for prefabId, prefabIndex in pairs(lFormationPOD.formation) do
			EquipModule.ReqCoverEquipments(prefabId, {})
		end

		self.UnloadAllToggle:GetComponent("Toggle").isOn = false
	end)
end

function FormationUI:OnClickPrevBtn()
	local formationIndex = self.FormationIndex - 1

	if formationIndex <= 0 then
		formationIndex = #PlayerModule.PlayerInfo.formations
	end

	self:RefreshTogglePageShow(formationIndex)
end

function FormationUI:OnClickNextBtn()
	local formationIndex = self.FormationIndex + 1

	if formationIndex > #PlayerModule.PlayerInfo.formations then
		formationIndex = 1
	end

	self:RefreshTogglePageShow(formationIndex)
end

function FormationUI:OnClickSwitchInfoViewBtn()
	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:NextInfoView()
	end
end

function FormationUI:OnUpdateItem()
	self:ShowFormation(self.FormationIndex)
end

function FormationUI:OnCopyToggleValueChanged(isOn)
	if isOn then
		self.Clipboard = {
			index = self.FormationIndex
		}
	else
		self.Clipboard = nil
	end
end

function FormationUI:OnClickPasteBtn()
	NoticeModule.ShowNotice(21046012, function()
		if self.Clipboard == nil then
			logError("粘贴板为空")

			return
		end

		if self.Clipboard.index == self.FormationIndex then
			return
		end

		FormationModule.CopyTo(self.Clipboard.index, self.FormationIndex)

		self.CopyToggle:GetComponent("Toggle").isOn = false
	end)
end

function FormationUI:GetToggleIndexByFormation(formationIndex)
	return (formationIndex - 1) % 10 + 1
end

function FormationUI:GetFormationIndexByToggle(toggleIndex)
	return (self.TogglePage - 1) * 10 + toggleIndex
end

function FormationUI:OnClickSwitchTogglePageBtn()
	local togglePage = math.ceil(#PlayerModule.PlayerInfo.formations / 10)

	self.TogglePage = self.TogglePage % togglePage + 1

	local toggleIndex = self:GetToggleIndexByFormation(self.FormationIndex)
	local newFormationIndex = self:GetFormationIndexByToggle(toggleIndex)

	self:RefreshTogglePageShow(newFormationIndex)
end

function FormationUI:RefreshTogglePageShow(formationIndex)
	if formationIndex ~= nil then
		self.TogglePage = math.floor((formationIndex - 1) / 10) + 1

		local toggleIndex = self:GetToggleIndexByFormation(formationIndex)
		local tabToggle = self.TabToggles[toggleIndex]:GetComponent("Toggle")
		local oldToggleIsOn = tabToggle.isOn

		tabToggle.isOn = true

		if oldToggleIsOn then
			self:ShowFormation(formationIndex)
		end
	end

	local togglePage = math.ceil(#PlayerModule.PlayerInfo.formations / 10)

	UGUIUtil.SetTextInChildren(self.SwitchPageBtn, FormationUIApi:GetString("SwitchPageBtnText", self.TogglePage, togglePage))
end

return FormationUI
