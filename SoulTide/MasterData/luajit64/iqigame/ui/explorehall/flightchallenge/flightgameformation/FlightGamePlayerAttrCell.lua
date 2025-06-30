-- chunkname: @IQIGame\\UI\\ExploreHall\\FlightChallenge\\FlightGameFormation\\FlightGamePlayerAttrCell.lua

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

function m:SetData(attrID, value)
	UGUIUtil.SetText(self.AttrTitle, CfgFlightChallengeAttributeTable[attrID].AttName)
	UGUIUtil.SetText(self.AttrValue, string.format("%.2f", value))

	local path = UIGlobalApi.GetImagePath(CfgFlightChallengeAttributeTable[attrID].ImageIcon)

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
