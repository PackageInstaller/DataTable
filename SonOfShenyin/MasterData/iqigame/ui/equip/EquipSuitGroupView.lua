-- chunkname: @IQIGame\\UI\\Equip\\EquipSuitGroupView.lua

local EquipSuitGroupView = {
	suitCellList = {}
}
local EquipWearSuitView = require("IQIGame.UI.Equip.EquipWearSuitView")

function EquipSuitGroupView.New(go)
	local o = Clone(EquipSuitGroupView)

	o:Initialize(go)

	return o
end

function EquipSuitGroupView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.SuitAttributeTitleText:GetComponent("Text").text = EquipApi:GetTextFoldSuitAttribute()
	self.EmptySuitAttributeText:GetComponent("Text").text = EquipApi:GetTextNoSuitDescribe()

	LuaUtility.SetGameObjectShow(self.SuitAttributeGroupItemPrefab, false)
end

function EquipSuitGroupView:OnDestroy()
	for _, cell in pairs(self.suitCellList) do
		cell:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipSuitGroupView:Refresh(warlockData)
	local effectiveSets = EquipModule.GetHeroEffectiveSetsWithEquipDataAttr(warlockData.EquipDataArr)
	local index = 1

	for id, count in pairs(effectiveSets) do
		local isAwake = false
		local cfgEquipSuitArray = CfgUtil.GetCfgEquipSuitDataLimitCount(id, isAwake and Constant.Equip.SuitType.Awaken or Constant.Equip.SuitType.Normal, count)

		table.sort(cfgEquipSuitArray, function(a, b)
			return a.Id < b.Id
		end)

		if #cfgEquipSuitArray > 0 then
			local cell = self:_GetCell(index)

			cell:Refresh(cfgEquipSuitArray, id, count, not isAwake)
			cell:Show()

			index = index + 1
		end
	end

	LuaUtility.SetGameObjectShow(self.effectAwaken, index > 1)
	LuaUtility.SetGameObjectShow(self.SuitAttributeGroupContent, index > 1)
	LuaUtility.SetGameObjectShow(self.EmptySuitStateParent, index == 1)

	local len = #self.suitCellList

	for i = index, len do
		self.suitCellList[i]:Hide()
	end
end

function EquipSuitGroupView:_GetCell(index)
	local cell = self.suitCellList[index]

	if not cell then
		local gameObject = GameObject.Instantiate(self.SuitAttributeGroupItemPrefab, self.SuitAttributeGroupContent.transform)

		cell = EquipWearSuitView.New(gameObject)
		self.suitCellList[index] = cell
	end

	return cell
end

return EquipSuitGroupView
