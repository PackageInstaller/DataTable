-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyAttrCell.lua

local m = {}

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

function m:SetData(data)
	local attributeID = data
	local value = MonsterAcademyModule.SaveDataDetailPOD.basePOD.baseProps[attributeID]

	if value == nil then
		value = 0
	end

	local cfgAttr = CfgGalgameMonsterAttributeTable[attributeID]

	UGUIUtil.SetText(self.TextValue, MonsterAcademyPlayerUIApi:GetString("Attribute", value))

	if cfgAttr.Icon ~= nil and cfgAttr.Icon ~= "" then
		local path = UIGlobalApi.GetImagePath(cfgAttr.Icon)

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
