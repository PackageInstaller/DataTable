-- chunkname: @modules/common/others/simplelistcomp/SimpleListItem.lua

module("modules.common.others.simplelistcomp.SimpleListItem", package.seeall)

local SimpleListItem = class("SimpleListItem", LuaCompBase)

function SimpleListItem:ctor(param)
	self.viewContainer = param.viewContainer
	self.simpleListComp = param.simpleListComp
	self.cellParam = param.cellParam
end

function SimpleListItem:init(viewGO)
	self.viewGO = viewGO
	self.transform = viewGO.transform
	self._btnClickItem = gohelper.findButtonWithAudio(self.viewGO) or gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	self:onInit(viewGO)
end

function SimpleListItem:addEventListeners()
	if self._btnClickItem then
		self.addClickCb(self, self._btnClickItem, self._onClickItem, self)
	end

	self:onAddListeners()
end

function SimpleListItem:removeEventListeners()
	self:onRemoveListeners()
end

function SimpleListItem:_onClickItem()
	if self._onClickItemFunc then
		self._onClickItemFunc(self._onClickItemFuncContext, self)
	end
end

function SimpleListItem:showItem(data, index, isSelect, isLastItem, onClickItemFunc, onClickItemFuncContext)
	self.data = data
	self.itemIndex = index
	self.isSelectItem = isSelect
	self.isFirstItem = self.itemIndex == 1
	self.isLastItem = isLastItem
	self._onClickItemFunc = onClickItemFunc
	self._onClickItemFuncContext = onClickItemFuncContext

	self:onItemShow(data)
end

function SimpleListItem:hideItem()
	self:onItemHide()
end

function SimpleListItem:setSelect(isSelect)
	self.isSelectItem = isSelect

	self:onSelectChange(isSelect)
end

function SimpleListItem:getItemAnimators()
	if self._animators == nil then
		local animator = gohelper.findComponentAnim(self.viewGO)

		self._animators = {
			animator
		}
	end

	return self._animators
end

function SimpleListItem:getRootAnimator()
	return self:getItemAnimators()[1]
end

function SimpleListItem:getRootAnimatorPlayer()
	local animator = self:getItemAnimators()[1]

	return (SLFramework.AnimatorPlayer.Get(animator.gameObject))
end

function SimpleListItem:onInit(viewGO)
	return
end

function SimpleListItem:onAddListeners()
	return
end

function SimpleListItem:onRemoveListeners()
	return
end

function SimpleListItem:onItemShow(data)
	return
end

function SimpleListItem:onItemHide()
	return
end

function SimpleListItem:onSelectChange(isSelect)
	return
end

function SimpleListItem:rebuildListLayout()
	if self.simpleListComp then
		self.simpleListComp:rebuildLayout()
	end
end

return SimpleListItem
