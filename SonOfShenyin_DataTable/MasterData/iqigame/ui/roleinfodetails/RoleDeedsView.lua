-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleDeedsView.lua

local m = {
	deedsList = {},
	Items = {},
	poolList = {},
	cellList = {}
}
local RoleDeedsItemCell = require("IQIGame.UI.RoleInfoDetails.RoleDeedsItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(heroCid)
	self.heroCid = heroCid
	self.deedsList = RoleInfoDetailsModule.GetHeroAllDeeds(heroCid)

	for i = 1, #self.poolList do
		self.poolList[i]:Hide()
	end

	for i = 1, #self.deedsList do
		local itemCell = self:GetItemCell(i)

		itemCell:SetData(self.deedsList[i], self.heroCid)
		itemCell:Show()
	end
end

function m:GetItemCell(i)
	local rect = self.poolList[i]

	if rect == nil then
		local obj = UnityEngine.GameObject.Instantiate(self.Item)

		obj.transform:SetParent(self.ItemContent.transform, false)

		rect = RoleDeedsItemCell.New(obj.gameObject)
		self.poolList[i] = rect
	end

	return rect
end

function m:SelectItemCell()
	for i = 1, #self.cellList do
		self.cellList[i]:OnUnSelect()
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	for _, v in pairs(self.poolList) do
		v:Dispose()
	end

	self.poolList = {}
	self.View = nil
end

return m
