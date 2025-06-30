-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Enhance\\LunaBattleEnhanceSoulAttrPanel.lua

local m = {
	AttrItems = {}
}
local FormationSoulCellAttrItem = require("IQIGame.UI.FormationUI.FormationSoulCellAttrItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = FormationSoulCellAttrItem.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.AttrItems[i] = item
	end
end

function m:SetData(soulPrefab)
	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = self.AttrItems[i]
		local attrId = showAttrIds[i]
		local prefabAttrValue = soulPrefab.attr[attrId]

		item:SetData(attrId, prefabAttrValue)
	end
end

function m:Dispose()
	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
