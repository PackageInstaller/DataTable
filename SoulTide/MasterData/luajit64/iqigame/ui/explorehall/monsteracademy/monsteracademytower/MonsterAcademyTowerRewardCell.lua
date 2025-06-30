-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyTower\\MonsterAcademyTowerRewardCell.lua

local m = {}
local MonsterAcademyItemCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyBag.MonsterAcademyItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = MonsterAcademyItemCell.New(self.CommonSlotUI)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.itemCell:SetMonsterItemDataByID(data.itemId, data.itemNum)
	self.itemCell:ShowNum(true)
	UGUIUtil.SetText(self.TextName, MonsterAcademySelectPanelUIApi:GetString("RewardText", CfgGalgameMonsterItemTable[data.itemId].Name))
end

function m:Dispose()
	self.itemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
