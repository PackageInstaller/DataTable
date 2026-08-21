-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSoulCell.lua

local m = {
	IgnorePosToggleChangeOnce = false,
	PosToggleEnabled = true,
	ShowMode = false,
	Index = 0,
	FormationIndex = 0,
	ShowViewIndex = 1,
	EquipCells = {},
	AttrItems = {}
}
local FormationEquipSmallCell = require("IQIGame.UI.FormationUI.FormationEquipSmallCell")
local FormationSoulCellAttrItem = require("IQIGame.UI.FormationUI.FormationSoulCellAttrItem")
local FormationCellSpiritCell = require("IQIGame.UI.FormationUI.FormationSoulCellSpiritCell")

function m.New(view, index, host)
	local obj = Clone(m)

	obj:Init(view, index, host)

	return obj
end

function m:Init(view, index, host)
	self.View = view
	self.Index = index
	self.Host = host

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

	function self.DelegateOnClickMoodBtn()
		self:OnClickMoodBtn()
	end

	function self.DelegateOnClickSpiritCell()
		self:OnClickChangeSoul()
	end

	function self.DelegateOnBtnJewelry()
		self:OnBtnJewelry()
	end

	self.SpiritCell = FormationCellSpiritCell.New(self.SpiritView, self.DelegateOnClickSpiritCell)

	for i = 1, 3 do
		local cell = FormationEquipSmallCell.New(UnityEngine.Object.Instantiate(self.EquipPrefab))

		cell.View.transform:SetParent(self.EquipGrid.transform, false)

		self.EquipCells[i] = cell
	end

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = FormationSoulCellAttrItem.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.AttrItems[i] = item
	end

	self.InfoView1:GetComponent("LongButton").repeatCall = false

	UGUIUtil.SetText(self.SkillGroupLabel, FormationUIApi:GetString("SoulCellSkillGroupLabel"))
	UGUIUtil.SetText(self.EquipLabel, FormationUIApi:GetString("SoulCellEquipLabel"))
	UGUIUtil.SetText(self.PowerLabel, FormationUIApi:GetString("SoulCellPowerLabel"))

	self.JewelryItemCell = ItemCell.New(self.JewelryNode.transform:GetChild(0).gameObject, false, false)

	self:AddListeners()
end

function m:AddListeners()
	self.InfoView1:GetComponent("LongButton").onClick:AddListener(self.DelegateOnClickChangeSoul)
	self.SkillGroupBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeSoul)
	self.InfoView1:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateOnLongClickSoul)
	self.EmptyView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddSoul)
	self.PosToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnPosToggleValueChanged)
	self.ChangeEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeEquipBtn)
	self.MoodBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMoodBtn)
	self.BtnJewelry:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnJewelry)
end

function m:RemoveListeners()
	self.InfoView1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeSoul)
	self.SkillGroupBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeSoul)
	self.InfoView1:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateOnLongClickSoul)
	self.EmptyView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddSoul)
	self.PosToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnPosToggleValueChanged)
	self.ChangeEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeEquipBtn)
	self.MoodBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMoodBtn)
	self.BtnJewelry:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnJewelry)
end

function m:SetData(prefabId, formationIndex)
	self.FormationIndex = formationIndex
	self.SoulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

	local soulData

	if self.SoulPrefabData.soulCid ~= nil then
		soulData = SoulModule.GetSoulData(self.SoulPrefabData.soulCid)
	end

	local cfgDiscreteDataData = CfgDiscreteDataTable[6507081]
	local unlockLv = cfgDiscreteDataData.Data[self.Index]
	local isUnlock = unlockLv <= PlayerModule.PlayerInfo.baseInfo.pLv

	self.LockView:SetActive(not isUnlock)
	self.EmptyView:SetActive(isUnlock and soulData == nil)
	self.NormalView:SetActive(isUnlock and soulData ~= nil)

	if soulData ~= nil then
		UGUIUtil.SetText(self.LevelText, soulData.lv)
		UGUIUtil.SetText(self.PowerText, self.SoulPrefabData.power)

		local cfgSoulResData = soulData:GetCfgSoulRes2D()
		local iconPath = UIGlobalApi.GetHarmoniousImagePath(cfgSoulResData.SoulSitImage)

		AssetUtil.LoadImage(self, iconPath, self.Icon:GetComponent("Image"))
		self.StarGrid:GetComponent("SimpleStarComponent"):UpdateView(5, soulData:GetCfgSoulQuality().Quality)

		local cfgSkillGroupData = CfgSkillGroupTable[self.SoulPrefabData.skillGroupId]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.SkillGroupIcon:GetComponent("Image"))

		local skillGroupIndexText = FormationUIApi:GetString("SkillGroupIndexText", cfgSkillGroupData.GroupQuality)

		UGUIUtil.SetText(self.View1SkillGroupIndexText, skillGroupIndexText)
		UGUIUtil.SetText(self.View2SkillGroupIndexText, skillGroupIndexText)

		local cfgSoulData = soulData:GetCfgSoul()

		UGUIUtil.SetText(self.View2NameText, cfgSoulData.Name)
		UGUIUtil.SetText(self.View3NameText, cfgSoulData.Name)
		UGUIUtil.SetText(self.View2EngNameText, cfgSoulData.EnglishName)
		UGUIUtil.SetText(self.View3EngNameText, cfgSoulData.EnglishName)

		local status = SoulModule.GetMoodState(soulData.soulCid, soulData.mood)

		AssetUtil.LoadImage(self, MiscApi:GetString("SoulMoodImagePath", status), self.MoodBtn:GetComponentInChildren(typeof(UnityEngine.UI.Image)), nil, nil, nil, true)
		self.SpiritCell:SetData(self.SoulPrefabData.optionalSkill, soulData:HasAvailableOptionalSpSkill())

		local showAttrIds = SoulUIApi:GetString("fightAttSort")

		for i = 1, #showAttrIds do
			local item = self.AttrItems[i]
			local attrId = showAttrIds[i]

			item:SetData(attrId, self.SoulPrefabData.attrs[attrId], soulData.atts[attrId])
		end
	end

	if not isUnlock then
		UGUIUtil.SetText(self.LockNoticeText, FormationUIApi:GetString("PositionUnlockCondition", unlockLv))
	end

	self:UpdateEquips()

	local isBack = self.SoulPrefabData.position == Constant.SoulPrefab.PositionBack

	self:SetToggleOn(self.PosToggle, isBack, true)
	self:ChangePosToggleText(isBack)
	self:RefreshJewelryBlock()

	local isUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.JEWELRY)

	self.BtnJewelry:SetActive(isUnlock)
end

function m:SetToggleOn(toggleGo, value, ignoreChangeOnce)
	if not self.PosToggleEnabled then
		return
	end

	if toggleGo:GetComponent("Toggle").isOn ~= value then
		self.IgnorePosToggleChangeOnce = ignoreChangeOnce
		toggleGo:GetComponent("Toggle").isOn = value
	end
end

function m:ChangePosToggleText(isBack)
	local posTextZh, posTextEn = FormationUIApi:GetString("SoulPositionLabelText", not isBack)

	self.PosToggle:GetComponent("ToggleHelperComponent").text = posTextZh
end

function m:OnClickChangeSoul()
	if self.CustomClickHandler ~= nil then
		self.CustomClickHandler(self)

		return
	end

	if self.ShowMode then
		return
	end

	self:OpenSoulListUI()
end

function m:OnLongClickSoul()
	if self.ShowMode then
		return
	end

	if self.SoulPrefabData.soulCid == nil then
		return
	end

	local soulData = SoulModule.GetSoulData(self.SoulPrefabData.soulCid)
	local switchList = {}
	local soulIndexMap = {}
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			table.insert(switchList, SoulModule.GetSoulData(soulPrefabData.soulCid))

			soulIndexMap[soulPrefabData.soulCid] = prefabIndex
		end
	end

	table.sort(switchList, function(soulData1, soulData2)
		return soulIndexMap[soulData1.soulCid] < soulIndexMap[soulData2.soulCid]
	end)
	UIModule.Open(Constant.UIControllerName.SoulUI, Constant.UILayer.UI, {
		[UIParam.soulUI.soulData] = soulData,
		[UIParam.soulUI.switchList] = switchList
	})
end

function m:OnClickAddSoul()
	if self.ShowMode then
		return
	end

	self:OpenSoulListUI()
end

function m:OpenSoulListUI()
	UIModule.Open(Constant.UIControllerName.FormationChooseSoulUI, Constant.UILayer.UI, {
		formationIndex = self.FormationIndex,
		prefabId = self.SoulPrefabData.id
	})
end

function m:OnPosToggleValueChanged(isBack)
	if self.ShowMode then
		return
	end

	if not self.PosToggleEnabled then
		return
	end

	if self.IgnorePosToggleChangeOnce then
		self.IgnorePosToggleChangeOnce = false

		return
	end

	self:ChangePosToggleText(isBack)
	SoulPrefabModule.SendChangeSoulPosition(self.SoulPrefabData.id, isBack and Constant.SoulPrefab.PositionBack or Constant.SoulPrefab.PositionFront)
	GameEntry.Effect:PlayUIMountPointEffect(9009001, 50000, 0, self.View, self.Host.UIController:GetComponent("Canvas").sortingOrder + 1)
end

function m:OnClickChangeEquipBtn()
	if self.ShowMode then
		return
	end

	UIModule.Open(Constant.UIControllerName.FormationChooseEquipUI, Constant.UILayer.UI, {
		prefabId = self.SoulPrefabData.id,
		formationIndex = self.FormationIndex
	})
end

function m:OnBtnJewelry()
	UIModule.Open(Constant.UIControllerName.FormationChooseEquipUI, Constant.UILayer.UI, {
		prefabId = self.SoulPrefabData.id,
		formationIndex = self.FormationIndex
	})
end

function m:UpdateEquips()
	for i = 1, #self.EquipCells do
		local cell = self.EquipCells[i]
		local itemData = self.SoulPrefabData.equipItemDatum[i]

		cell:SetData(itemData)

		local qualityIcon = self["EquipQualityIcon" .. i]
		local quality = 0

		if itemData ~= nil then
			quality = itemData:GetCfg().Quality
		end

		AssetUtil.LoadImage(self, FormationUIApi:GetString("EquipSmallCellQualityImage", quality), qualityIcon:GetComponent("Image"))
	end
end

function m:ResetInfoView()
	self.ShowViewIndex = 1

	self:__UpdateInfoView()
end

function m:NextInfoView()
	self.ShowViewIndex = self.ShowViewIndex + 1

	if self.ShowViewIndex > 3 then
		self.ShowViewIndex = 1
	end

	self:__UpdateInfoView()
end

function m:__UpdateInfoView()
	for i = 1, 3 do
		self["InfoView" .. i]:SetActive(i == self.ShowViewIndex)
	end
end

function m:OnClickMoodBtn()
	if self.ShowMode then
		return
	end

	local soulData = SoulModule.GetSoulData(self.SoulPrefabData.soulCid)

	UIModule.Open(Constant.UIControllerName.GirlMoodUI, Constant.UILayer.UI, soulData)
end

function m:SetToShowMode(value)
	self.ShowMode = value

	local position = self.NormalView.transform.anchoredPosition

	if value then
		position.y = -17
	else
		position.y = 0
	end

	self.NormalView.transform.anchoredPosition = position
end

function m:ShowPosToggle(value)
	self.PosToggleEnabled = value

	local toggleHelperComponent = self.PosToggle:GetComponent("ToggleHelperComponent")

	toggleHelperComponent.goShowByOn:SetActive(value)
	toggleHelperComponent.goShowByOff:SetActive(value)

	toggleHelperComponent.enabled = value
	self.PosToggle:GetComponent("Toggle").enabled = value
end

function m:SetCustomClickHandler(handler)
	self.CustomClickHandler = handler
end

function m:RefreshJewelryBlock()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.JEWELRY)

	self.JewelryNode:SetActive(false)

	if result and self.SoulPrefabData then
		local itemID, speed = self.SoulPrefabData:GetEquipJewelryAndSpeed()

		if itemID then
			self.JewelryNode:SetActive(true)

			local itemData = WarehouseModule.GetItemDataById(itemID)

			self.JewelryItemCell:SetItem(itemData)
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.JewelryItemCell:Dispose()
	self.SpiritCell:Dispose()

	for i = 1, #self.EquipCells do
		local cell = self.EquipCells[i]

		cell:Dispose()
	end

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
	self.SoulPrefabData = nil
end

return m
