-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyGetPanelCell.lua

local m = {}
local monsterAcademyItemCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyBag.MonsterAcademyItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local itemCellGO = self.ItemCellParent.transform:GetChild(0).gameObject

	self.ItemCell = monsterAcademyItemCell.New(itemCellGO)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.View:SetActive(data ~= nil)

	if data == nil then
		return
	end

	self.ItemCell:SetMonsterItemDataByID(data.itemId, data.itemNum)
	self.ItemCell:ShowNum(true)

	self.ItemNameText:GetComponent("Text").text = MonsterAcademyGetPanelUIApi:GetString("ItemNameText", CfgGalgameMonsterItemTable[data.itemId].Name)
end

function m:Dispose()
	self.ItemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
