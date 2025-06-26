-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleBuffGroupTipsElement.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local BuffGroupItemCell = require("IQIGame.UI.Maze.ItemCell.BuffGroupItemCell")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local BuffGroupTitleItemView = require("IQIGame.UI.Maze.ItemCell.BuffGroupTitleItemView")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickCloseBtn()
		self:__OnClickCloseBtn()
	end

	self.buffGroupItemPool = UIViewObjectPool.New(self.buffGroupItem, self.buffGroupRoot.transform, function(_view)
		return BuffGroupItemCell.New(_view)
	end)
	self.buffGroupTitleItemView = BuffGroupTitleItemView.New(self.BuffGroupTitle)

	self:AddListeners()
end

function m:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function m:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function m:SetData(buffPoolId)
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
	self:__ResetPosition()
end

function m:__ResetPosition()
	local worldPos = GameEntry.UICamera:ScreenToWorldPoint(UnityEngine.Input.mousePosition)
	local contentRectTrans = self.contentRoot:GetComponent("RectTransform")
	local localPosition = CommonTipsHelper.CalculationRTSLocalPositionByWorldPosition(contentRectTrans, worldPos, Vector2.New(1334, 750), Vector4.New(0, 0, 0, 0))

	contentRectTrans.localPosition = localPosition
end

function m:__OnClickCloseBtn()
	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.buffGroupItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.buffGroupItemPool = nil

	self.buffGroupTitleItemView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
