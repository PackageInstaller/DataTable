-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\FruitCleanGame\\FruitGameSelectLevelCell.lua

local m = {
	isMaxUnlock = false
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

function m:SetData(data, passData, isMaxUnlock)
	self.cfgData = data
	self.passData = passData
	self.isMaxUnlock = isMaxUnlock

	UGUIUtil.SetText(self.TextLevel1, self.cfgData.Level)
	UGUIUtil.SetText(self.TextLevel2, self.cfgData.Level)
	UGUIUtil.SetText(self.TextLevel3, self.cfgData.Level)

	if self.passData then
		UGUIUtil.SetText(self.TextValue, self.passData.time)
	end

	local isPass = self.passData ~= nil

	self.State1:SetActive(isPass)
	self.State2:SetActive(not isPass and self.isMaxUnlock)
	self.State3:SetActive(not isPass and not self.isMaxUnlock)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
