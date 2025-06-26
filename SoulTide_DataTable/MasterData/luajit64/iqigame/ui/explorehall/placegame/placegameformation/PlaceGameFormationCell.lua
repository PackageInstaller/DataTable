-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameFormationCell.lua

local m = {
	showViewIndex = 1,
	showMode = false,
	ignorePosToggleChangeOnce = false,
	formationIndex = 0,
	posToggleEnabled = true,
	attrItems = {},
	equipCells = {}
}
local PlaceGameFormationAttrCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationAttrCell")
local PlaceGameFormationEquipCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationEquipCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickChangeSoul()
		self:OnClickChangeSoul()
	end

	function self.DelegateOnLongClickSoul()
		self:OnLongClickSoul()
	end

	function self.DelegateOnClickAddSoul()
		self:OnClickAddSoul()
	end

	function self.DelegateOnPosToggleValueChanged(isOn)
		self:OnPosToggleValueChanged(isOn)
	end

	function self.DelegateOnClickChangeEquipBtn()
		self:OnClickChangeEquipBtn()
	end

	self.equipCells = {}

	for i = 1, 3 do
		local cell = PlaceGameFormationEquipCell.New(UnityEngine.Object.Instantiate(self.EquipPrefab), i)

		cell.View.transform:SetParent(self.EquipGrid.transform, false)

		self.equipCells[i] = cell
	end

	self.attrItems = {}

	local showAttrIds = PlaceGamePlayerFormationUIApi:GetString("FightAttSort")

	for i = 1, #showAttrIds do
		local item = PlaceGameFormationAttrCell.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.attrItems[i] = item
	end

	self.InfoView1:GetComponent("LongButton").repeatCall = false

	self:AddListener()
end

function m:AddListener()
	self.InfoView1:GetComponent("LongButton").onClick:AddListener(self.DelegateOnClickChangeSoul)
	self.SkillGroupBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeSoul)
	self.InfoView1:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateOnLongClickSoul)
	self.EmptyView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddSoul)
	self.PosToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnPosToggleValueChanged)
	self.ChangeEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeEquipBtn)
end

function m:RemoveListener()
	self.InfoView1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeSoul)
	self.SkillGroupBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeSoul)
	self.InfoView1:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateOnLongClickSoul)
	self.EmptyView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddSoul)
	self.PosToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnPosToggleValueChanged)
	self.ChangeEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeEquipBtn)
end

function m:SetData(prefabData, formationIndex)
	self.prefabData = prefabData
	self.formationIndex = formationIndex

	local placeSoulData

	if self.prefabData.placeGameSoulPrefabPOD.soulCid ~= nil then
		placeSoulData = PlaceGameModule.GetPlaceGameSoulDataByCid(self.prefabData.placeGameSoulPrefabPOD.soulCid)
	end

	local isUnlock = true

	self.LockView:SetActive(not isUnlock)
	self.EmptyView:SetActive(isUnlock and placeSoulData == nil)
	self.NormalView:SetActive(isUnlock and placeSoulData ~= nil)

	if placeSoulData then
		UGUIUtil.SetText(self.LevelText, self.prefabData.placeGameSoulPrefabPOD.lv)
		UGUIUtil.SetText(self.PowerText, self.prefabData.placeGameSoulPrefabPOD.power)

		local cfgSoulResData = CfgSoulResTable[placeSoulData:GetCfgPlaceGameSoulData().SoulResID]
		local iconPath = UIGlobalApi.GetHarmoniousImagePath(cfgSoulResData.SoulSitImage)

		AssetUtil.LoadImage(self, iconPath, self.Icon:GetComponent("Image"))

		local cfgSkillGroupData = CfgSkillGroupTable[placeSoulData:GetCfgPlaceGameSoulData().DefaultSkill]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.SkillGroupIcon:GetComponent("Image"))

		local skillGroupIndexText = PlaceGamePlayerFormationUIApi:GetString("SkillGroupIndexText", cfgSkillGroupData.GroupQuality)

		UGUIUtil.SetText(self.View2SkillGroupIndexText, skillGroupIndexText)
		UGUIUtil.SetText(self.View2NameText, placeSoulData:GetCfgSoulData().Name)
		UGUIUtil.SetText(self.View3NameText, placeSoulData:GetCfgSoulData().Name)
		UGUIUtil.SetText(self.View2EngNameText, placeSoulData:GetCfgSoulData().EnglishName)
		UGUIUtil.SetText(self.View3EngNameText, placeSoulData:GetCfgSoulData().EnglishName)

		local showAttrIds = PlaceGamePlayerFormationUIApi:GetString("FightAttSort")

		for i = 1, #showAttrIds do
			local item = self.attrItems[i]
			local attrId = showAttrIds[i]

			item:SetData(attrId, self.prefabData.placeGameSoulPrefabPOD.attr[attrId])
		end
	end

	self:UpdateEquips()

	local isBack = self.prefabData.placeGameSoulPrefabPOD.position == Constant.SoulPrefab.PositionBack

	self:SetToggleOn(self.PosToggle, isBack, true)
	self:ChangePosToggleText(isBack)
end

function m:UpdateEquips()
	for i = 1, #self.equipCells do
		local cell = self.equipCells[i]
		local itemID = self.prefabData.placeGameSoulPrefabPOD.equipments[i]
		local itemData

		if itemID then
			itemData = WarehouseModule.GetItemDataById(itemID)
		end

		cell:SetData(itemData)
	end
end

function m:SetToggleOn(toggleGo, value, ignoreChangeOnce)
	if not self.posToggleEnabled then
		return
	end

	if toggleGo:GetComponent("Toggle").isOn ~= value then
		self.ignorePosToggleChangeOnce = ignoreChangeOnce
		toggleGo:GetComponent("Toggle").isOn = value
	end
end

function m:ResetInfoView()
	self.showViewIndex = 1

	self:UpdateInfoView()
end

function m:NextInfoView()
	self.showViewIndex = self.showViewIndex + 1

	if self.showViewIndex > 3 then
		self.showViewIndex = 1
	end

	self:UpdateInfoView()
end

function m:UpdateInfoView()
	for i = 1, 3 do
		self["InfoView" .. i]:SetActive(i == self.showViewIndex)
	end
end

function m:OnClickChangeSoul()
	if self.customClickHandler ~= nil then
		self.customClickHandler(self)

		return
	end

	if self.showMode then
		return
	end

	self:OpenSoulListUI()
end

function m:OnLongClickSoul()
	if self.showMode then
		return
	end

	if self.prefabData.placeGameSoulPrefabPOD.soulCid == nil then
		return
	end

	local soulData = PlaceGameModule.GetPlaceGameSoulDataByCid(self.prefabData.placeGameSoulPrefabPOD.soulCid)
	local switchList = {}
	local soulIndexMap = {}
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(self.formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		if soulPrefabData.soulCid ~= nil then
			table.insert(switchList, PlaceGameModule.GetPlaceGameSoulDataByCid(soulPrefabData.placeGameSoulPrefabPOD.soulCid))

			soulIndexMap[soulPrefabData.placeGameSoulPrefabPOD.soulCid] = prefabIndex
		end
	end

	table.sort(switchList, function(soulData1, soulData2)
		return soulIndexMap[soulData1.placeGameSoulPOD.soulCid] < soulIndexMap[soulData2.placeGameSoulPOD.soulCid]
	end)
	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerUpdateUI, Constant.UILayer.UI)
end

function m:OnClickAddSoul()
	if self.showMode then
		return
	end

	self:OpenSoulListUI()
end

function m:OpenSoulListUI()
	UIModule.Open(Constant.UIControllerName.PlaceGameFormationChooseSoulUI, Constant.UILayer.UI, {
		FormationIndex = self.formationIndex,
		PrefabId = self.prefabData.id
	})
end

function m:OnPosToggleValueChanged(isBack)
	if self.showMode then
		return
	end

	if not self.posToggleEnabled then
		return
	end

	if self.ignorePosToggleChangeOnce then
		self.ignorePosToggleChangeOnce = false

		return
	end

	self:ChangePosToggleText(isBack)
	PlaceGameModule.ChangePosition(self.prefabData.id, isBack and Constant.SoulPrefab.PositionBack or Constant.SoulPrefab.PositionFront)
	GameEntry.Effect:PlayUIMountPointEffect(9009001, 50000, 0, self.View, self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas").sortingOrder + 1)
end

function m:OnClickChangeEquipBtn()
	if self.showMode then
		return
	end

	UIModule.Open(Constant.UIControllerName.PlaceGameFormationChooseEquipUI, Constant.UILayer.UI, {
		PrefabId = self.prefabData.id,
		FormationIndex = self.formationIndex
	})
end

function m:ChangePosToggleText(isBack)
	local posTextZh, posTextEn = PlaceGamePlayerFormationUIApi:GetString("SoulPositionLabelText", not isBack)

	self.PosToggle:GetComponent("ToggleHelperComponent").text = posTextZh
end

function m:SetCustomClickHandler(handler)
	self.customClickHandler = handler
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.customClickHandler = nil

	for i, v in pairs(self.attrItems) do
		v:Dispose()
	end

	for i, v in pairs(self.equipCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
