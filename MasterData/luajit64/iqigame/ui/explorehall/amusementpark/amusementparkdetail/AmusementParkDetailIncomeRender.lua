-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDetail\\AmusementParkDetailIncomeRender.lua

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
	UGUIUtil.SetText(self.TextCome, AmusementParkDetailUIApi:GetString("TextCome", value, cid))

	local path = UIGlobalApi.GetImagePath(CfgAmusementParkAttributeTable[cid].ImageIcon)

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
