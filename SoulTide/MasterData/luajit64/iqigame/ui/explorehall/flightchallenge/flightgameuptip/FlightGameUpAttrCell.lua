-- chunkname: @IQIGame\\UI\\ExploreHall\\FlightChallenge\\FlightGameUpTip\\FlightGameUpAttrCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.Effect:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(attrID, oldValue, newValue)
	UGUIUtil.SetText(self.AttrName, FlightGameUpTipUIApi:GetString("AttrName", CfgFlightChallengeAttributeTable[attrID].AttName))
	UGUIUtil.SetText(self.OldValue, string.format("%.2f", oldValue))
	UGUIUtil.SetText(self.NewValue, string.format("%.2f", newValue))

	local path = UIGlobalApi.GetImagePath(CfgFlightChallengeAttributeTable[attrID].ImageIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	self.Effect:SetActive(false)
	self.Effect:SetActive(true)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
