-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamAttrController.lua

local m = {}
local MazeTeamBattleAttrItem = require("IQIGame.UI.MazeTeam.MazeTeamBattleAttrItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.HpAttrItem = MazeTeamBattleAttrItem.New(UnityEngine.Object.Instantiate(self.BottomAttrItemPrefab))

	self.HpAttrItem.View.transform:SetParent(self.BottomAttrGrid.transform, false)

	self.SpAttrItem = MazeTeamBattleAttrItem.New(UnityEngine.Object.Instantiate(self.BottomAttrItemPrefab))

	self.SpAttrItem.View.transform:SetParent(self.BottomAttrGrid.transform, false)

	self.BattleAttrIds = {}

	local battleAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #battleAttrIds do
		local attrId = battleAttrIds[i]

		if attrId ~= Constant.Attribute.TYPE_HP and attrId ~= Constant.Attribute.TYPE_HP_MAX and attrId ~= Constant.Attribute.TYPE_SKILL_ENERGY then
			table.insert(self.BattleAttrIds, attrId)
		end
	end

	self.BattleAttrItems = {}

	for i = 1, #self.BattleAttrIds do
		local attrItem = MazeTeamBattleAttrItem.New(UnityEngine.Object.Instantiate(self.BottomAttrItemPrefab))

		attrItem.View.transform:SetParent(self.BottomAttrGrid.transform, false)
		attrItem.UnderLine:SetActive(i < #self.BattleAttrIds)

		self.BattleAttrItems[i] = attrItem
	end
end

function m:SetData(dollPOD)
	local hpValue = SoulUIApi:GetString("attViewAttName", AttributeModule.GetAttShowValue(Constant.Attribute.TYPE_HP, dollPOD.finalAttributes[Constant.Attribute.TYPE_HP]))
	local maxHpValue = SoulUIApi:GetString("attViewAttName", AttributeModule.GetAttShowValue(Constant.Attribute.TYPE_HP_MAX, dollPOD.finalAttributes[Constant.Attribute.TYPE_HP_MAX]))

	self.HpAttrItem:SetData(Constant.Attribute.TYPE_HP, hpValue .. "/" .. maxHpValue)

	local spValue = SoulUIApi:GetString("attViewAttName", AttributeModule.GetAttShowValue(Constant.Attribute.TYPE_SKILL_ENERGY, dollPOD.finalAttributes[Constant.Attribute.TYPE_SKILL_ENERGY]))

	self.SpAttrItem:SetData(Constant.Attribute.TYPE_SKILL_ENERGY, spValue .. "/" .. CfgDiscreteDataTable[6506027].Data[1])

	for i = 1, #self.BattleAttrIds do
		local attrId = self.BattleAttrIds[i]
		local attrItem = self.BattleAttrItems[i]
		local attrValue = SoulUIApi:GetString("attViewAttName", AttributeModule.GetAttShowValue(attrId, dollPOD.finalAttributes[attrId]))

		attrItem:SetData(attrId, attrValue)
	end
end

function m:Dispose()
	self.HpAttrItem:Dispose()
	self.SpAttrItem:Dispose()

	for i = 1, #self.BattleAttrItems do
		local attrItem = self.BattleAttrItems[i]

		attrItem:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
