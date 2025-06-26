-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationUpdate\\ROUpdateRoleAttrCell.lua

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

function m:SetData(id, value, addValue)
	self.id = id
	self.value = value
	self.addValue = addValue

	UGUIUtil.SetText(self.AttrTitle, CfgRestaurantOperationAttributeTable[self.id].AttName)
	UGUIUtil.SetText(self.AttrValue, self.value)
	UGUIUtil.SetText(self.AddValue, string.format("+%s", addValue))
	self:RefreshAddValue(self.addValue > 0)

	local path = UIGlobalApi.GetImagePath(CfgRestaurantOperationAttributeTable[self.id].ImageIcon)

	if self.AttrIcon then
		AssetUtil.LoadImage(self, path, self.AttrIcon:GetComponent("Image"))
	end
end

function m:RefreshAddValue(top)
	self.AddValue:SetActive(top)

	if top then
		local timer = Timer.New(function()
			self.AddValue:SetActive(false)
		end, 1)

		timer:Start()
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
