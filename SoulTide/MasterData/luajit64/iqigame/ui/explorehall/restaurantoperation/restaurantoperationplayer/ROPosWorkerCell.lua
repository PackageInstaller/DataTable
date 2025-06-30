-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationPlayer\\ROPosWorkerCell.lua

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

function m:SetData(data, attrValue)
	self.workerData = data
	self.attrValue = attrValue

	self:UpdateView()
end

function m:UpdateView()
	local path = UIGlobalApi.GetImagePath(self.workerData:GetCfgData().HeadIcon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextMainAttr, self.attrValue)
	self:SetSelect(false)
end

function m:SetSelect(top)
	if self.Check then
		self.Check:SetActive(top)
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
