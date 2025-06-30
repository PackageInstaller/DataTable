-- chunkname: @IQIGame\\UI\\Maze\\EndlessMazeEntryRenderCell.lua

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

function m:SetData(cid)
	self.cid = cid

	local cfgMazeInstanceData = CfgMazeInstanceTable[self.cid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgMazeInstanceData.BackgroundRes), self.Icon:GetComponent("Image"))
end

function m:SetSelect(isOn)
	self.View:GetComponent("Toggle").isOn = isOn
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
