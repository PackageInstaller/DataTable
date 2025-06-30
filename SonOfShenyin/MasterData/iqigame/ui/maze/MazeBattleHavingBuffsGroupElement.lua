-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleHavingBuffsGroupElement.lua

local BuffGroupTitleItemView = require("IQIGame.UI.Maze.ItemCell.BuffGroupTitleItemView")
local CommonBuffGroupItemCell = require("IQIGame.UI.Maze.ItemCell.BuffGroupItemCell")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local BuffGroupItemCell = {}

function BuffGroupItemCell.New(view)
	local obj = Clone(BuffGroupItemCell)

	obj:Init(view)

	return obj
end

function BuffGroupItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.buffGroupItemPool = UIViewObjectPool.New(self.buffGroupItemPrefab, self.buffGroupRoot.transform, function(_view)
		return CommonBuffGroupItemCell.New(_view)
	end)
	self.buffGroupTitleItemView = BuffGroupTitleItemView.New(self.buffGroupTitle)
end

function BuffGroupItemCell:SetData(buffPoolId)
	self.buffGroupItemPool:ForItems(function(_item)
		return _item:Hide()
	end)

	local buffGroupDataList = MazeModule.GetBuffGroupData(buffPoolId)

	for i = 1, #buffGroupDataList do
		local buffGroupItem = self.buffGroupItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		buffGroupItem:Show()
		buffGroupItem:SetData(buffGroupDataList[i])
	end

	self.buffGroupTitleItemView:SetData(buffPoolId)
end

function BuffGroupItemCell:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function BuffGroupItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function BuffGroupItemCell:Dispose()
	self.buffGroupItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.buffGroupItemPool = nil

	self.buffGroupTitleItemView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	buffGroupItemCellList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.buffGroupItemListPool = UIViewObjectPool.New(self.buffGroupItemPrefab, self.content.transform, function(_view)
		return BuffGroupItemCell.New(_view)
	end)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData()
	self.buffGroupDataList = MazeModule.GetActivedBuffGroupIdList()

	if self.buffGroupDataList == nil or table.len(self.buffGroupDataList) == 0 then
		LuaUtility.SetGameObjectShow(self.NormalParent, false)
		LuaUtility.SetGameObjectShow(self.EmptyParent, true)
	else
		LuaUtility.SetGameObjectShow(self.NormalParent, true)
		LuaUtility.SetGameObjectShow(self.EmptyParent, false)
	end

	self.buffGroupItemListPool:ForItems(function(_item)
		return _item:Hide()
	end)
	ForPairs(self.buffGroupDataList, function(_groupId, _buffPoolId)
		local buffGroupItem = self.buffGroupItemListPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		buffGroupItem:Show()
		buffGroupItem:SetData(_buffPoolId)
	end)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self.buffGroupItemListPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.buffGroupItemListPool = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
