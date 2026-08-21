-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/BackpackEchoItemCell.lua

module("logic.extensions.backpack.cell.BackpackEchoItemCell", package.seeall)

local M = class("BackpackEchoItemCell", BackpackItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("operate", BackpackOperateComponent)
	self:_addComponent("lock", LockComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("CanvasGroup", BackpackCanvasGroupComponet)
	self:_addComponent("echo", BackpackEchoItemCellComponet)
	self:_addComponent("preset", PresetComponent)
	self:_addComponent("levelNum", LevelHideComponent)
	self:_addComponent("holeCount", HoleCountHideComponent)
	self:_addComponent("discard", DiscardHideComponent)
	self:_addComponent("sign", BackpackSignHideComponent)

	local normalComp = self:getComponent("normal")

	normalComp:setRedPointType(CommEnum.RedPointIconType.New)
end

function M:onSelect(isPreview, isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isPreview or isSelected)

	local operateComp = self:getComponent("operate")

	operateComp:setImgOperateGoVisible(isSelected)
	operateComp:setBtnCutGoVisible(isSelected)
end

function M:unSelect()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_ITEM_SUB_CLICK, self._data)
end

function M:refreshRed()
	local item = self._data

	if not item then
		return false
	end

	self:getComponent("normal"):setRedPointType(CommEnum.RedPointIconType.New)

	local redPoint = self:getComponent("normal"):getRedPoint()
	local isRed = item:getRedPointIsNew()

	goutil.setActive(redPoint, isRed)

	if item:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem and item:isShowRedPoint() then
		self:getComponent("normal"):setRedPointType(CommEnum.RedPointIconType.Strong)

		redPoint = self:getComponent("normal"):getRedPoint()

		goutil.setActive(redPoint, true)
	end
end

return M
