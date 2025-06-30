-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationDetail\\RODetailAttributeRender.lua

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
	self.posData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.posData then
		UGUIUtil.SetText(self.TextName, RestaurantOperationDetailUIApi:GetString("PostName", self.posData:GetCfgData().PostName, self.posData.postPOD.number))
		UGUIUtil.SetText(self.TextAttr, RestaurantOperationDetailUIApi:GetString("PostMainAttr", self.posData:GetCfgMainAttributeData().AttName, self.posData.postPOD.value))
		UGUIUtil.SetText(self.TextValue, RestaurantOperationDetailUIApi:GetString("PostBuildingAttr", self.posData.postPOD.restaurantMarkUp))
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
