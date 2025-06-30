-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkOneConnectGame\\AmusementParkSelectLevelCell.lua

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

function m:SetData(levelData)
	self.LevelData = levelData

	local unlock = self.LevelData:IsUnlock()

	self.Unlock:SetActive(unlock)
	self.Lock:SetActive(not unlock)

	local isGray = levelData:GetCfgData().Level > AmusementParkOneConnectGameModule.maxLevel + 1

	self.Gray:SetActive(isGray)
	UGUIUtil.SetText(self.TextUnlock, self.LevelData:GetCfgData().Level)
	UGUIUtil.SetText(self.TextCheck, self.LevelData:GetCfgData().Level)
end

function m:SetSelect(top)
	self.Check:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
