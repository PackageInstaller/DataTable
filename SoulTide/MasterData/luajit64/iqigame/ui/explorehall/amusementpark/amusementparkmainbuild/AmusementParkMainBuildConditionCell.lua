-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildConditionCell.lua

local m = {
	ConditionsMet = false
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

function m:SetData(conditionText, conditionIconPath, conditionsMet)
	self.ConditionsMet = conditionsMet

	UGUIUtil.SetText(self.TextContent, AmusementParkMainBuildUIApi:GetString("TextContent", conditionText, self.ConditionsMet))

	if conditionIconPath ~= nil and conditionIconPath ~= "" then
		self.ImgIcon:SetActive(true)
		AssetUtil.LoadImage(self, conditionIconPath, self.ImgIcon:GetComponent("Image"))
	else
		self.ImgIcon:SetActive(false)
	end

	self.ImgCondition:SetActive(conditionsMet)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
