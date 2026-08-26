-- chunkname: @modules/logic/backpack/view/BackpackPropListItem.lua

module("modules.logic.backpack.view.BackpackPropListItem", package.seeall)

local BackpackPropListItem = class("BackpackPropListItem", ListScrollCellExtend)

function BackpackPropListItem:init(go)
	self.go = go

	gohelper.setActive(go, false)

	self._itemIcon = IconMgr.instance:getCommonItemIcon(go)
end

function BackpackPropListItem:addEvents()
	BackpackController.instance:registerCallback(BackpackEvent.SelectCategory, self._categorySelected, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function BackpackPropListItem:removeEvents()
	BackpackController.instance:unregisterCallback(BackpackEvent.SelectCategory, self._categorySelected, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BackpackPropListItem:_categorySelected()
	if self._itemIcon then
		self._itemIcon:setAutoPlay(false)
		TaskDispatcher.cancelTask(self._showItem, self)

		local canvasGroup = self._itemIcon.go:GetComponent(typeof(UnityEngine.CanvasGroup))

		canvasGroup.alpha = 1

		BackpackModel.instance:setItemAniHasShown(true)
	end
end

function BackpackPropListItem:_onViewClose(viewName)
	if not self._mo or not self._itemIcon then
		return
	end

	local data = self._mo.config

	self._itemIcon:setRecordFarmItem({
		type = data.type,
		id = data.id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function BackpackPropListItem:_showItem()
	gohelper.setActive(self.go, true)

	if not BackpackModel.instance:getItemAniHasShown() then
		self._itemIcon:playAnimation("backpack_common_in")
	end

	if self._index >= 24 then
		BackpackModel.instance:setItemAniHasShown(true)
	end
end

function BackpackPropListItem:onUpdateMO(mo)
	self._mo = mo

	if self._index <= 24 then
		TaskDispatcher.runDelay(self._showItem, self, 0.03 * math.floor((self._index - 1) / 6))
	else
		self._itemIcon:setAutoPlay(false)
		TaskDispatcher.cancelTask(self._showItem, self)
		self:_showItem()
		BackpackModel.instance:setItemAniHasShown(true)
	end

	local data = mo.config

	self._itemIcon:setInPack(true)
	self._itemIcon:setMOValue(data.type, data.id, data.quantity, data.uid)
	self._itemIcon:isShowName(false)
	self._itemIcon:isShowCount(data.isStackable ~= 0)
	self._itemIcon:isShowEffect(true)
	self._itemIcon:setRecordFarmItem({
		type = data.type,
		id = data.id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function BackpackPropListItem:onDestroyView()
	TaskDispatcher.cancelTask(self._showItem, self)
end

return BackpackPropListItem
