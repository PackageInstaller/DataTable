-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationDetail\\RODetailIncomeRender.lua

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

function m:SetData(cid, value)
	local name = CfgRestaurantOperationIncomeTable[cid].AttName
	local showValue = value

	if cid == 7 then
		showValue = string.format("%.3f", value)
	end

	UGUIUtil.SetText(self.TextCome, RestaurantOperationDetailUIApi:GetString("TextCome", name, showValue, cid))

	local path = UIGlobalApi.GetImagePath(CfgRestaurantOperationIncomeTable[cid].ImageIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
