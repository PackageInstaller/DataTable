-- chunkname: @IQIGame\\UI\\GhostGame\\GhostGameBuffGridView.lua

local ghostGameBuffItem = require("IQIGame.UI.GhostGame.GhostGameBuffItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnAddBuffEvent(buff)
		self:OnAddBuffEvent(buff)
	end

	self.buffItemPool = UIViewObjectPool.New(self.BuffItem, self.BuffGrid.transform, function(_view)
		return ghostGameBuffItem.New(_view, self)
	end)

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.GhostGameAddBuff, self.delegateOnAddBuffEvent)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.GhostGameAddBuff, self.delegateOnAddBuffEvent)
end

function m:SetData()
	return
end

function m:OnAddBuffEvent(buff)
	if buff.type == Constant.GhostGameBuffType.ChangeAttackNum then
		return
	end

	local buffItem = self:GetBuffItemByType(buff.type)

	if buffItem then
		buffItem:SetData(buff)

		return
	end

	self.buffItemView = self.buffItemPool:GetFree(function(_item)
		return not _item.View.activeSelf
	end)

	self.buffItemView:SetData(buff)
end

function m:RecoveryBuffItem(type)
	self.buffItemPool:ForItems(function(_item)
		if _item.buffData.type == type then
			return _item:Hide()
		end
	end)
end

function m:GetBuffItemByType(type)
	local buffItem

	self.buffItemPool:ForItems(function(_item)
		if _item.buffData.type == type then
			buffItem = _item

			return true
		end
	end)

	return buffItem
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.buffItemPool:ForItems(function(_item)
		if _item.View.activeSelf then
			_item:Update(elapseSeconds, realElapseSeconds)
		end
	end)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.buffItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.buffItemPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
