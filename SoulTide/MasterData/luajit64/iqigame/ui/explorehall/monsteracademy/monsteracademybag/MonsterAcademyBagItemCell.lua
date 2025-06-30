-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyBag\\MonsterAcademyBagItemCell.lua

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

	self.monsterAcademyItemCell = MonsterAcademyItemCell.New(self.MonsterAcademyCommonSlot)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.monsterAcademyItemData = data

	self.monsterAcademyItemCell:SetData(data)
	UGUIUtil.SetText(self.ItemNumText, self.monsterAcademyItemData.num)
	self:SetRedPoint(false)
end

function m:SetRedPoint(top)
	self.RedPoint:SetActive(top)
end

function m:Dispose()
	self.monsterAcademyItemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
