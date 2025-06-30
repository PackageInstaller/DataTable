-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Entry\\LunaBattleEntryUnfinishedTagItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data)
	self.View:SetActive(data ~= nil)

	if data == nil then
		return
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(LunaBattleLineEntryUIApi:GetString("UnfinishedMazeTagIcon", data.chapterType)), self.Icon:GetComponent("Image"))

	local cfgMazeInstanceData = CfgMazeInstanceTable[data.mazeCid]

	UGUIUtil.SetText(self.DescText, LunaBattleLineEntryUIApi:GetString("UnfinishedMazeTagText", cfgMazeInstanceData.Name, data.chapterType))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
