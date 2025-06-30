-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildPanelInfoView.lua

local m = {
	BuildConditions = false,
	LevelUpConditions = false,
	ParkAttrCells = {},
	ConditionCells = {},
	BuildEffectCells = {},
	BuildAttrType = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkAttrCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkAttrCell")
local AmusementParkMainBuildConditionCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildConditionCell")
local AmusementParkMainBuildEffectCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildEffectCell")

function m.New(view, RootUI)
	local obj = Clone(m)

	obj:Init(view, RootUI)

	return obj
end

function m:Init(view, RootUI)
	self.View = view
	self.RootUI = RootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	self.BuildAttrType = {
		AmusementParkConstant.BuildAttrType.BuildAttrType_4,
		AmusementParkConstant.BuildAttrType.BuildAttrType_5,
		AmusementParkConstant.BuildAttrType.BuildAttrType_7
	}

	function self.DelegateBtnShowTip()
		self:OnBtnShowTip()
	end

	function self.DelegateBtnUpGrade()
		self:OnBtnUpGrade()
	end

	function self.DelegateBtnBuild()
		self:OnBtnBuild()
	end

	self.BuildPlayerAttrMould:SetActive(false)

	self.ParkAttrCellPool = UIObjectPool.New(6, function()
		return AmusementParkAttrCell.New(UnityEngine.Object.Instantiate(self.BuildPlayerAttrMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.ConditionMould:SetActive(false)

	self.ConditionCellPool = UIObjectPool.New(6, function()
		return AmusementParkMainBuildConditionCell.New(UnityEngine.Object.Instantiate(self.ConditionMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.BuildFeatureMould:SetActive(false)

	self.BuildEffectCellPool = UIObjectPool.New(6, function()
		return AmusementParkMainBuildEffectCell.New(UnityEngine.Object.Instantiate(self.BuildFeatureMould))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnShowTip:GetComponent("Button").onClick:AddListener(self.DelegateBtnShowTip)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGrade)
	self.BtnBuild:GetComponent("Button").onClick:AddListener(self.DelegateBtnBuild)
end

function m:RemoveListener()
	self.BtnShowTip:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShowTip)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGrade)
	self.BtnBuild:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBuild)
end

function m:UpdateView()
	local isMaxLv = self.BuildData.parkBuildPOD.level >= self.BuildData:GetMaxLevel()

	self.MaxLv:SetActive(isMaxLv)
	self.LvNode:SetActive(not isMaxLv)
	self.BtnBuild:SetActive(self.ShowType == 1)
	self.BtnUpGrade:SetActive(self.ShowType == 2 and not isMaxLv)
	UGUIUtil.SetText(self.BuildLv, AmusementParkMainBuildUIApi:GetString("BuildLv", self.BuildData.parkBuildPOD.level, self.BuildData:GetMaxLevel()))
	UGUIUtil.SetText(self.BuildName, self.BuildData:GetCfgData().Name)
	UGUIUtil.SetText(self.BuildDes, self.BuildData:GetCfgData().Describe)

	local UIController = self.View:GetComponentInParent(typeof(UIController))

	for i, v in pairs(self.ParkAttrCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(UIController.transform, false)
		self.ParkAttrCellPool:Release(v)
	end

	self.ParkAttrCells = {}

	local attrs = self.BuildData:GetBuildPlayerAttrs()
	local cfgBuildingLevelData = self.BuildData:GetCfgBuildLevelData()

	for i = 1, #cfgBuildingLevelData.SoulAttType do
		local id = cfgBuildingLevelData.SoulAttType[i]

		if id > 0 then
			local value = attrs[id] or 0
			local cell = self.ParkAttrCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.BuildPlayerAttrSort.transform, false)
			cell:SetData(id, value)
			table.insert(self.ParkAttrCells, cell)
		end
	end

	for i, v in pairs(self.ConditionCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(UIController.transform, false)
		self.ConditionCellPool:Release(v)
	end

	self.ConditionCells = {}

	if self.ShowType == 1 then
		self:RefreshBuildCondition()
	elseif self.ShowType == 2 then
		self:RefreshLevelUpCondition()
	end

	for i, v in pairs(self.BuildEffectCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(UIController.transform, false)
		self.BuildEffectCellPool:Release(v)
	end

	self.BuildEffectCells = {}

	local cfgLevelData = self.BuildData:GetCfgBuildLevelData()

	if cfgLevelData then
		for i = 1, #cfgLevelData.IntEffect, 2 do
			local attrID = cfgLevelData.IntEffect[i]
			local value = cfgLevelData.IntEffect[i + 1]
			local cell = self.BuildEffectCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.BuildFeatureGrid.transform, false)
			cell:SetData(attrID, value, 1)
			table.insert(self.BuildEffectCells, cell)
		end

		for i = 1, #cfgLevelData.PercentageEffect, 2 do
			local attrID = cfgLevelData.PercentageEffect[i]
			local value = cfgLevelData.PercentageEffect[i + 1]
			local cell = self.BuildEffectCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.BuildFeatureGrid.transform, false)
			cell:SetData(attrID, value, 2)
			table.insert(self.BuildEffectCells, cell)
		end
	end

	self.Empty:SetActive(#self.BuildEffectCells == 0)

	for i = 1, #self.BuildAttrType do
		local type = self.BuildAttrType[i]
		local attrValue = self.BuildData.parkBuildPOD.property[type] or 0

		UGUIUtil.SetText(self["BuildAttr_" .. type], AmusementParkMainBuildUIApi:GetString("BuildAttr", attrValue, type))
	end
end

function m:RefreshBuildCondition()
	self.BuildConditions = true

	local conditionID = self.BuildData:GetCfgData().BuildCondition
	local success = true

	if conditionID > 0 then
		success = ConditionModule.Check(conditionID)

		if self.BuildConditions then
			self.BuildConditions = success
		end

		local cell = self.ConditionCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ConditionNode.transform, false)
		cell:SetData(CfgConditionTable[conditionID].Name, nil, success)
		table.insert(self.ConditionCells, cell)
	end

	for i = 1, #self.BuildData:GetCfgData().BuildNeedAtt, 2 do
		local attrID = self.BuildData:GetCfgData().BuildNeedAtt[i]
		local needAttrNum = self.BuildData:GetCfgData().BuildNeedAtt[i + 1]
		local attrNum = 0

		success, attrNum = AmusementParkModule.CheckParkAttr(CfgAmusementParkAttributeTable[attrID].Tpye, needAttrNum)

		if self.BuildConditions then
			self.BuildConditions = success
		end

		local cfgData = CfgAmusementParkAttributeTable[attrID]
		local cell = self.ConditionCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ConditionNode.transform, false)

		local str = AmusementParkMainBuildUIApi:GetString("BuildNeedAttrCondition", cfgData.AttName, attrNum, needAttrNum)

		cell:SetData(str, UIGlobalApi.GetImagePath(cfgData.ImageIcon), success)
		table.insert(self.ConditionCells, cell)
	end

	for i = 1, #self.BuildData:GetCfgData().BuildNeedBuildingLevel, 2 do
		local buildID = self.BuildData:GetCfgData().BuildNeedBuildingLevel[i]
		local needBuildLv = self.BuildData:GetCfgData().BuildNeedBuildingLevel[i + 1]
		local buildLv = 0
		local buildData = AmusementParkModule.GetAmusementParkBuildData(buildID)

		if buildData then
			buildLv = buildData.parkBuildPOD.level
		end

		success = needBuildLv <= buildLv

		if self.BuildConditions then
			self.BuildConditions = success
		end

		local cell = self.ConditionCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ConditionNode.transform, false)

		local str = AmusementParkMainBuildUIApi:GetString("BuildNeedBuildLvCondition", CfgAmusementParkBuildingTable[buildID].Name, buildLv, needBuildLv)

		cell:SetData(str, nil, success)
		table.insert(self.ConditionCells, cell)
	end

	local buildCost = true

	for i = 1, #self.BuildData:GetCfgData().BuildCost, 2 do
		local itemID = self.BuildData:GetCfgData().BuildCost[i]
		local needNum = self.BuildData:GetCfgData().BuildCost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)

		success = needNum <= haveNum

		if self.BuildConditions then
			self.BuildConditions = success
		end

		buildCost = buildCost and success

		UGUIUtil.SetText(self.BuildCost, AmusementParkMainBuildUIApi:GetString("BuildCost", needNum, haveNum))
	end

	self.BuildCostOK:SetActive(buildCost)
end

function m:RefreshLevelUpCondition()
	self.LevelUpConditions = true

	local cfgBuildLevelData = self.BuildData:GetCfgBuildLevelData()

	if cfgBuildLevelData then
		local conditionID = cfgBuildLevelData.LevelUpCondition
		local success = false

		if conditionID > 0 then
			success = ConditionModule.Check(conditionID)

			if self.LevelUpConditions then
				self.LevelUpConditions = success
			end

			local cell = self.ConditionCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ConditionNode.transform, false)
			cell:SetData(CfgConditionTable[conditionID].Name, nil, success)
			table.insert(self.ConditionCells, cell)
		end

		for i = 1, #cfgBuildLevelData.LevelUpNeedAtt, 2 do
			local attrID = cfgBuildLevelData.LevelUpNeedAtt[i]
			local needAttrNum = cfgBuildLevelData.LevelUpNeedAtt[i + 1]
			local attrNum = 0

			success, attrNum = AmusementParkModule.CheckParkAttr(CfgAmusementParkAttributeTable[attrID].Tpye, needAttrNum)

			if self.LevelUpConditions then
				self.LevelUpConditions = success
			end

			local cfgData = CfgAmusementParkAttributeTable[attrID]
			local cell = self.ConditionCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ConditionNode.transform, false)

			local str = AmusementParkMainBuildUIApi:GetString("BuildNeedAttrCondition", cfgData.AttName, attrNum, needAttrNum)

			cell:SetData(str, UIGlobalApi.GetImagePath(cfgData.ImageIcon), success)
			table.insert(self.ConditionCells, cell)
		end

		for i = 1, #cfgBuildLevelData.LevelUpCost, 2 do
			local itemID = cfgBuildLevelData.LevelUpCost[i]
			local needNum = cfgBuildLevelData.LevelUpCost[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)

			success = needNum <= haveNum

			if self.LevelUpConditions then
				self.LevelUpConditions = success
			end

			UGUIUtil.SetText(self.BtnUpGradeCost, AmusementParkMainBuildUIApi:GetString("BuildCost", needNum, haveNum))
		end

		self.BuildUpGradeOK:SetActive(success)
	end
end

function m:OnBtnUpGrade()
	if not self.LevelUpConditions then
		NoticeModule.ShowNotice(21045114)

		return
	end

	if self.BuildData.parkBuildPOD.level >= self.BuildData:GetMaxLevel() then
		return
	end

	AmusementParkModule.ParkLevelUp(self.BuildData.parkBuildPOD.post)
end

function m:OnBtnBuild()
	if not self.BuildConditions then
		NoticeModule.ShowNotice(21045113)

		return
	end

	AmusementParkModule.Build(self.RootUI.BuildAreaData.pos, self.BuildData.cid)
end

function m:OnBtnShowTip()
	self.RootUI.BuildTipInfoView:Show(self.BuildData:GetCfgBuildLevelData())
end

function m:Show(type, buildData)
	self.ShowType = type
	self.BuildData = buildData

	self.View:SetActive(true)
	self:UpdateView()
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ParkAttrCells) do
		self.ParkAttrCellPool:Release(v)
	end

	self.ParkAttrCells = {}

	self.ParkAttrCellPool:Dispose()

	for i, v in pairs(self.ConditionCells) do
		self.ConditionCellPool:Release(v)
	end

	self.ConditionCells = {}

	self.ConditionCellPool:Dispose()

	for i, v in pairs(self.BuildEffectCells) do
		self.BuildEffectCellPool:Release(v)
	end

	self.BuildEffectCells = {}

	self.BuildEffectCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
