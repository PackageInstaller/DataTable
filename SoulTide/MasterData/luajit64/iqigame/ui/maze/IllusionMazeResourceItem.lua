-- chunkname: @IQIGame\\UI\\Maze\\IllusionMazeResourceItem.lua

local m = {
	ItemCID = 0
}

function m.New(view, itemCid, iconSprite)
	local obj = Clone(m)

	obj:Init(view, itemCid, iconSprite)

	return obj
end

function m:Init(view, itemCid, iconSprite)
	self.View = view
	self.ItemCID = itemCid

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self.Icon:GetComponent("Image").sprite = iconSprite

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
end

function m:UpdateNum()
	UGUIUtil.SetText(self.NumText, MazeDataModule.GetItemNumByCfgID(self.ItemCID))
end

function m:OnUpdateItem()
	self:UpdateNum()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
