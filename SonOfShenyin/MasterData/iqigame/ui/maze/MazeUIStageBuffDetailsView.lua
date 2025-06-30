-- chunkname: @IQIGame\\UI\\Maze\\MazeUIStageBuffDetailsView.lua

local MazeUIFormationElement = require("IQIGame/UI/Maze/MazeUIFormationElement")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local ItemCell = {}

function ItemCell.New(view)
	local obj = Clone(ItemCell)

	obj:__Init(view)

	return obj
end

function ItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ItemCell:SetData(buffCid)
	self.buffCid = buffCid

	if self.buffCid == nil then
		LuaUtility.SetGameObjectShow(self.lockParent, true)
		LuaUtility.SetGameObjectShow(self.unLockParent, false)
	else
		LuaUtility.SetGameObjectShow(self.lockParent, false)
		LuaUtility.SetGameObjectShow(self.unLockParent, true)

		local buffCfg = CfgBuffTable[buffCid]

		AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(buffCfg.Icon), self.buffImg:GetComponent("Image"))
		UGUIUtil.SetText(self.textElement, buffCfg.Describe)
	end

	LuaUtility.SetGameObjectShow(self.NewTag, false)
end

function ItemCell:Show()
	self.gameObject:SetActive(true)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local m = {
	buffItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.wrapContent = self.buffListScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function m:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function m:SetData(buffGourp)
	self.buffGroups = buffGourp

	self.wrapContent:Refresh(#self.buffGroups)
end

function m:OnRenderItem(cell)
	local buffCid = self.buffGroups[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.buffItems[instanceId]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject)
		self.buffItems[instanceId] = itemCell
	end

	itemCell:Show()
	itemCell:SetData(buffCid)
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	for k, v in pairs(self.buffItems) do
		v:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
