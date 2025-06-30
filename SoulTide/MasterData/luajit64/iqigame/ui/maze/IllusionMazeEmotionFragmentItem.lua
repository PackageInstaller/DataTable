-- chunkname: @IQIGame\\UI\\Maze\\IllusionMazeEmotionFragmentItem.lua

local m = {
	ItemCid = 0
}

function m.New(view, itemCid)
	local obj = Clone(m)

	obj:Init(view, itemCid)

	return obj
end

function m:Init(view, itemCid)
	self.View = view
	self.ItemCid = itemCid

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	local cfgItemData = CfgItemTable[self.ItemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.Icon:GetComponent("Image"))
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:Refresh()
	UGUIUtil.SetText(self.NumText, MazeDataModule.GetItemNumByCfgID(self.ItemCid))
end

function m:OnUpdateItem()
	self:Refresh()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
