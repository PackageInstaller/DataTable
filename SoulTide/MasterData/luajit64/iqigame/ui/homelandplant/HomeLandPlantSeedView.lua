-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantSeedView.lua

local HomeLandPlantSeedView = {
	EntityId = 0,
	plantItemCells = {}
}
local toggleTitles = HomeLandPlantUIApi:GetString("ToggleTitle")
local HomeLandPlantSeedCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantSeedCell")
local HomeLandPlantItemCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantItemCell")

function HomeLandPlantSeedView.__New(ui)
	local o = Clone(HomeLandPlantSeedView)

	o:InitView(ui)

	return o
end

function HomeLandPlantSeedView:InitView(ui)
	self.goView = ui

	self.goView:SetActive(false)
	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.TextSeedTitle, HomeLandPlantUIApi:GetString("TextFinishMsg"))
	UGUIUtil.SetText(self.TextSeedTime, HomeLandPlantUIApi:GetString("TextSeedTime"))
	UGUIUtil.SetText(self.TextBtnPlant, HomeLandPlantUIApi:GetString("TextBtnPlant"))

	self.btnPlantComponent = self.BtnPlant:GetComponent("Button")
	self.scrollComponent = self.Scroll:GetComponent("ScrollAreaList")

	function self.scrollComponent.onSelectedCell(cell)
		self:OnSelectSeedCell(cell)
	end

	function self.scrollComponent.onRenderCell(cell)
		self:OnRenderSeedCell(cell)
	end

	function self.delegateToggleIngredient(isOn)
		self:OnTogIngredient(isOn)
	end

	function self.delegateBtnPlant()
		self:OnBtnPlant()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self:InitTog()
end

function HomeLandPlantSeedView:AddEventListener()
	self.btnPlantComponent.onClick:AddListener(self.delegateBtnPlant)

	for i, v in pairs(self.toggleIngredients) do
		v.onValueChanged:AddListener(self.delegateToggleIngredient)
	end

	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandPlantSeedView:RemoveEventListener()
	self.btnPlantComponent.onClick:RemoveListener(self.delegateBtnPlant)

	for i, v in pairs(self.toggleIngredients) do
		v.onValueChanged:RemoveListener(self.delegateToggleIngredient)
	end

	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandPlantSeedView:InitTog()
	self.toggleIngredients = {}

	local toggle

	for i = 1, #toggleTitles do
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.Toggles.transform, false)
		obj:SetActive(true)

		obj:GetComponent("ToggleHelperComponent").text = toggleTitles[i][2]
		toggle = obj:GetComponent("Toggle")
		toggle.isOn = false
		toggle.group = self.Toggles:GetComponent("ToggleGroup")
		self.toggleIngredients[i] = toggle
	end
end

function HomeLandPlantSeedView:OnTogIngredient(isOn)
	if isOn then
		for i = 1, #self.toggleIngredients do
			local toggle = self.toggleIngredients[i]

			if toggle.isOn == true and self.curIngredient ~= i then
				self.curIngredient = i
				self.selectCfgData = nil

				self:ShowIngredient()

				break
			end
		end
	end
end

function HomeLandPlantSeedView:ShowIngredient()
	local type = toggleTitles[self.curIngredient][1]

	self.seedTable = self:GetSeedsByType(type)

	self.scrollComponent:Refresh(#self.seedTable)
	self:ShowSelectMsg()
end

function HomeLandPlantSeedView:GetSeedsByType(type)
	local tab = {}

	for i, v in pairsCfg(CfgHomeLandPlantTable) do
		if type == 0 then
			table.insert(tab, v)
		elseif type == v.ItemLevel then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.Id < b.Id
	end)

	return tab
end

function HomeLandPlantSeedView:UpdateView(buildingData, selectPlantData)
	self.homeBuildingData = buildingData
	self.selectPlantData = selectPlantData

	self:ShowIngredient()
end

function HomeLandPlantSeedView:OnSelectSeedCell(cell)
	local cfgData = self.seedTable[cell.index + 1]
	local plantSeedCell = HomeLandPlantSeedCell.PackageOrReuseView(self, cell.gameObject)

	plantSeedCell:SetDate(cfgData)

	self.selectCfgData = cfgData

	if self.selectSeedCell then
		self.selectSeedCell:SetSelect(false)
	end

	self.selectSeedCell = plantSeedCell

	self.selectSeedCell:SetSelect(true)
	self:ShowSelectMsg()
end

function HomeLandPlantSeedView:ShowSelectMsg()
	self.haveNum = 0

	if self.selectCfgData then
		local cfgItem = CfgItemTable[self.selectCfgData.CostItem]

		self.haveNum = WarehouseModule.GetItemNumByCfgID(self.selectCfgData.CostItem)

		local itemCell = ItemCell.PackageOrReuseView(self, self.Slot.transform:GetChild(0).gameObject)

		itemCell:SetItem(cfgItem)

		local cfItem = CfgItemTable[self.selectCfgData.PlantItem]

		UGUIUtil.SetText(self.TextSeedName, cfItem.Name)
		UGUIUtil.SetText(self.TextHaveNum, HomeLandPlantUIApi:GetString("TextHaveNum", self.haveNum, 1))
		UGUIUtil.SetText(self.TextSeedCD, GetFormatTime(self.selectCfgData.CostTime))
		self:ShowItems()
		self:ShowElement(self.selectCfgData.EntityID)
	end
end

function HomeLandPlantSeedView:ShowItems()
	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	self.plantItemCells = {}

	local itemId = self.selectCfgData.DropItem[1]

	if itemId > 0 then
		local obj = UnityEngine.Object.Instantiate(self.RewardMould)

		obj.transform:SetParent(self.RewardSlot.transform, false)
		obj:SetActive(true)

		local itemCell = HomeLandPlantItemCell:__New(obj)

		itemCell:SetDate(itemId, 1)
		table.insert(self.plantItemCells, itemCell)
	end

	local tab = {}

	for i = 1, #self.selectCfgData.RandomDropId do
		local dropTab = self.selectCfgData.RandomDropId[i]

		if #dropTab > 0 then
			local id = dropTab[1]

			if id > 0 and table.indexOf(tab, id) == -1 then
				table.insert(tab, id)

				local obj = UnityEngine.Object.Instantiate(self.RewardMould)

				obj.transform:SetParent(self.RewardSlot.transform, false)
				obj:SetActive(true)

				local itemCell = HomeLandPlantItemCell:__New(obj)

				itemCell:SetDate(id, 2)
				table.insert(self.plantItemCells, itemCell)
			end
		end
	end
end

function HomeLandPlantSeedView:OnRenderSeedCell(cell)
	local cfgData = self.seedTable[cell.index + 1]

	if cfgData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local itemGo = cell.gameObject

	itemGo:SetActive(true)

	local plantSeedCell = HomeLandPlantSeedCell.PackageOrReuseView(self, itemGo)

	plantSeedCell:SetDate(cfgData)
	plantSeedCell:SetSelect(false)

	if self.selectCfgData then
		if self.selectCfgData.Id == cfgData.Id then
			self.selectCfgData = cfgData

			plantSeedCell:SetSelect(true)

			self.selectSeedCell = plantSeedCell
		end
	else
		self.selectCfgData = cfgData

		plantSeedCell:SetSelect(true)

		self.selectSeedCell = plantSeedCell
	end
end

function HomeLandPlantSeedView:OnBtnPlant()
	if self.homeBuildingData ~= nil and self.selectCfgData ~= nil and self.selectPlantData ~= nil then
		if self.selectPlantData.landPOD.status ~= Constant.HomelandPlantType.landStatusIdle then
			NoticeModule.ShowNoticeByType(1, HomeLandPlantUIApi:GetString("ErrorMsg"))

			return
		end

		if self.haveNum <= 0 then
			NoticeModule.ShowNotice(21040078)

			return
		end

		HomeLandLuaModule.Plant(self.homeBuildingData.cfgBuildingID, self.selectPlantData.plantCid, self.selectCfgData.Id)
	end
end

function HomeLandPlantSeedView:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIHomelandElement(self.EntityId, elementEntityCid, 0, self.SpinePos.transform)
end

function HomeLandPlantSeedView:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function HomeLandPlantSeedView:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id and self.selectCfgData ~= nil then
		local spineState = args.Entity.gameObject

		spineState.transform.localScale = Vector3(self.selectCfgData.PrefabScale[1], self.selectCfgData.PrefabScale[2], self.selectCfgData.PrefabScale[3])
		spineState.transform.localPosition = Vector3(self.selectCfgData.PrefabPosition[1], self.selectCfgData.PrefabPosition[2], self.selectCfgData.PrefabPosition[3])

		local transforms = spineState:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		for i = 0, transforms.Length - 1 do
			transforms[i].gameObject.layer = LayerMask.NameToLayer("UI")
		end

		local skeletonAnimation = spineState:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if skeletonAnimation then
			skeletonAnimation.state:SetEmptyAnimation(0, 0)
			skeletonAnimation.state:SetAnimation(0, "ripe", true)
		end
	end
end

function HomeLandPlantSeedView:OnOpen()
	if self.curIngredient == nil then
		self.curIngredient = 1
	end

	self.toggleIngredients[self.curIngredient].isOn = true

	self:AddEventListener()
	self.goView:SetActive(true)
end

function HomeLandPlantSeedView:OnClose()
	self:HideEntity()
	self:RemoveEventListener()
	self.goView:SetActive(false)
end

function HomeLandPlantSeedView:OnDestroy()
	self:HideEntity()

	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	HomeLandPlantSeedCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandPlantSeedView
