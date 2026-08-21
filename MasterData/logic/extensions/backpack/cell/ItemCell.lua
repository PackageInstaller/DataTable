-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/ItemCell.lua

module("logic.extensions.backpack.cell.ItemCell", package.seeall)

local M = class("ItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._isShowTips = true
	self._isShowSelectedEffect = true
	self._showTipsPassEvent = true
	self._isHideGetWay = false
	self._isHideLock = false
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("lock", LockComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("levelNum", LevelComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("career", CareerComponent)
end

function M:getNormalComp()
	return self:getComponent("normal")
end

function M:getGo()
	return self._go
end

function M:setIsShowTips(showTips)
	self._isShowTips = showTips
end

function M:setIsHideGetWay(isHide)
	self._isHideGetWay = isHide
end

function M:setShowTipsPassEvent(isPassEvent)
	self._showTipsPassEvent = isPassEvent
end

function M:setShowSelectedEffect(isShow)
	self._isShowSelectedEffect = isShow
end

function M:setIsHideLock(isHide)
	self._isHideLock = isHide
end

function M:onSelect(isSelected)
	if self._isShowSelectedEffect then
		local normalComp = self:getNormalComp()

		normalComp:setItemSelect(isSelected)
	end
end

function M:dealSelect()
	local normalComp = self:getNormalComp()

	self:onSelect(not normalComp:getItemSelect())
	GlobalDispatcher:dispatchEvent(self._data:getItemMarkType(), self._data, self._go, self._cellIndex, self._isShowTips, self._showTipsPassEvent, self._isHideGetWay, self._isHideLock)
end

function M:setNumVisibleInGainItem()
	local numCom = self:getComponent("num")

	if numCom then
		numCom:setNumVisibleInGainItem()
	end
end

return M
