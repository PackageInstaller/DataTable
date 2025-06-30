-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMain\\AmusementParkMainIncomeCell.lua

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
	local showValue = value
	local cfgData = CfgAmusementParkAttributeTable[cid]

	if cfgData then
		local timeStr = "m"

		if cfgData.Tpye == 14 then
			timeStr = "h"
		end

		UGUIUtil.SetText(self.TextContent, AmusementParkMainUIApi:GetString("TextContent", showValue, timeStr))

		local path = UIGlobalApi.GetImagePath(cfgData.ImageIcon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
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
