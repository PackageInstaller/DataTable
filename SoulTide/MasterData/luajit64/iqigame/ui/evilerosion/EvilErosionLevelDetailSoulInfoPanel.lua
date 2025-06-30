-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionLevelDetailSoulInfoPanel.lua

local FormationSoulCellAttrItem = require("IQIGame.UI.FormationUI.FormationSoulCellAttrItem")
local EvilErosionEquipCell = require("IQIGame.UI.EvilErosion.EvilErosionEquipCell")
local EvilErosionSkillCell = require("IQIGame.UI.EvilErosion.EvilErosionSkillCell")
local m = {
	AttrItems = {},
	EquipCells = {},
	SkillCells = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnPositionToggleChanged(isOn)
		self:OnPositionToggleChanged(isOn)
	end

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = FormationSoulCellAttrItem.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.AttrItems[i] = item
	end

	for i = 1, 3 do
		local cell = EvilErosionEquipCell.New(UnityEngine.Object.Instantiate(self.EquipCellPrefab), i, function(index)
			self:OnClickEquipCell(index)
		end)

		cell.View.transform:SetParent(self.EquipCellGrid.transform, false)

		self.EquipCells[i] = cell
	end

	for i = 1, 4 do
		local cell = EvilErosionSkillCell.New(UnityEngine.Object.Instantiate(self.SkillCellPrefab), i, function(index)
			self:OnChangeSkill(index)
		end)

		cell.View.transform:SetParent(self.SkillGrid.transform, false)

		self.SkillCells[i] = cell
	end

	UGUIUtil.SetTextInChildren(self.NoSoulView, EvilErosionLevelDetailUIApi:GetString("SoulInfoView_NoSoulViewText"))

	local frontText, backText = EvilErosionLevelDetailUIApi:GetString("SoulInfoView_PositionToggleText")
	local toggleHelperComponent = self.PositionToggle:GetComponent("ToggleHelperComponent")

	toggleHelperComponent:SetTexts({
		frontText,
		backText
	})
	self:AddListeners()
end

function m:AddListeners()
	self.PositionToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnPositionToggleChanged)
end

function m:RemoveListeners()
	self.PositionToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnPositionToggleChanged)
end

function m:SetData(soulPrefabPOD)
	self.SoulPrefabPOD = soulPrefabPOD

	self.NoSoulView:SetActive(soulPrefabPOD == nil)
	self.SoulInfoView:SetActive(soulPrefabPOD ~= nil)

	if soulPrefabPOD == nil then
		return
	end

	local cfgSoulData = CfgSoulTable[soulPrefabPOD.soulCid]

	UGUIUtil.SetText(self.NameText, cfgSoulData.Name)
	UGUIUtil.SetText(self.LevelText, EvilErosionLevelDetailUIApi:GetString("SoulInfoView_LevelText", soulPrefabPOD.lv))

	local cfgSoulQualityData = CfgSoulQualityTable[soulPrefabPOD.qualityId]
	local starComponent = self.StartView:GetComponent("SimpleStarComponent")

	starComponent:UpdateView(5, cfgSoulQualityData.Quality)

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]
		local attrId = showAttrIds[i]
		local prefabAttrValue = soulPrefabPOD.attr[attrId]

		item:SetData(attrId, prefabAttrValue)
	end

	self:RefreshEquips()
	self:RefreshSkills()
	self:RefreshPosition()
end

function m:RefreshEquips()
	local equipCount = 0
	local minQuality = 5

	for i = 1, #self.EquipCells do
		local cell = self.EquipCells[i]
		local equipId = self.SoulPrefabPOD.equipments[i]
		local itemData

		if equipId ~= nil and equipId ~= 0 then
			itemData = WarehouseModule.GetItemDataById(equipId)
			minQuality = math.min(minQuality, itemData:GetCfg().Quality)
			equipCount = equipCount + 1
		end

		cell:SetData(itemData)
	end

	local isSuitActive = equipCount >= #self.EquipCells

	if not isSuitActive then
		minQuality = 0
	end

	self.SuitActiveIcon:SetActive(isSuitActive)
	self.SuitInActiveIcon:SetActive(not isSuitActive)
	UGUIUtil.SetText(self.SuitTipText, EvilErosionLevelDetailUIApi:GetString("SoulInfoView_SuitTipText", isSuitActive, minQuality))
end

function m:RefreshSkills()
	local skillCids = self:GetSkills()

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]
		local skillCid = skillCids[i]

		cell:SetData(skillCid, self.SoulPrefabPOD.allSkillStrengths)
	end
end

function m:GetSkills()
	if self.SoulPrefabPOD.customSkills ~= nil and #self.SoulPrefabPOD.customSkills > 0 then
		return self.SoulPrefabPOD.customSkills
	end

	local cfgSoulData = CfgSoulTable[self.SoulPrefabPOD.soulCid]
	local cfgSkillGroupData = CfgSkillGroupTable[cfgSoulData.DefaultSkill[1]]

	return cfgSkillGroupData.GroupSkills
end

function m:RefreshPosition()
	local toggle = self.PositionToggle:GetComponent("Toggle")
	local isBack = toggle.isOn
	local curPosition = isBack and 2 or 1

	if curPosition ~= self.SoulPrefabPOD.position then
		toggle.isOn = not toggle.isOn
	end
end

function m:OnChangeSkill(index)
	local currentSkillCids = table.clone(self:GetSkills())
	local cfgSoulData = CfgSoulTable[self.SoulPrefabPOD.soulCid]
	local targetSkillCid

	for i = 1, 2 do
		local skillGroupCid = cfgSoulData.DefaultSkill[i]
		local cfgSkillGroupData = CfgSkillGroupTable[skillGroupCid]
		local skillCid = cfgSkillGroupData.GroupSkills[index]
		local currentSkillCid = currentSkillCids[index]

		if currentSkillCid ~= skillCid then
			local cfgSkillData = CfgSkillTable[skillCid]
			local currentCfgSkillData = CfgSkillTable[currentSkillCid]

			if currentCfgSkillData.ShowType == cfgSkillData.ShowType then
				targetSkillCid = skillCid

				break
			end
		end
	end

	currentSkillCids[index] = targetSkillCid

	EvilErosionModule.SendChangeCustomSkill(self.SoulPrefabPOD.id, currentSkillCids)
end

function m:OnPositionToggleChanged(isOn)
	local isBack = isOn
	local curPosition = isBack and 2 or 1

	if curPosition ~= self.SoulPrefabPOD.position then
		EvilErosionModule.SendChangePosition(self.SoulPrefabPOD.id, curPosition)
	end
end

function m:OnClickEquipCell(index)
	UIModule.Open(Constant.UIControllerName.EvilErosionEquipListUI, Constant.UILayer.UI, {
		soulPrefabPOD = self.SoulPrefabPOD,
		curIndex = index
	})
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	for i = 1, #self.EquipCells do
		local cell = self.EquipCells[i]

		cell:Dispose()
	end

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SoulPrefabPOD = nil
end

return m
