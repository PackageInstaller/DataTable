-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyTower\\MonsterAcademyMonsterAttrCell.lua

local m = {
	attributeID = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(attributeID, value)
	self.attributeID = attributeID

	local cfg = CfgGalgameMonsterAttributeTable[self.attributeID]

	UGUIUtil.SetText(self.TextName, cfg.Name)
	UGUIUtil.SetText(self.TextValue, value)

	if cfg.Icon ~= nil and cfg.Icon ~= "" then
		local path = UIGlobalApi.GetImagePath(cfg.Icon)

		AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
