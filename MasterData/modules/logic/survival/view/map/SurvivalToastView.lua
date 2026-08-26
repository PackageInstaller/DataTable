-- chunkname: @modules/logic/survival/view/map/SurvivalToastView.lua

module("modules.logic.survival.view.map.SurvivalToastView", package.seeall)

local SurvivalToastView = class("SurvivalToastView", BaseView)
local OutSidePos = 10000

function SurvivalToastView:onInitView()
	self._gotemplate = gohelper.findChild(self.viewGO, "#go_item")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_root")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalToastView:_editableInitView()
	self._usingList = {}
	self._freeList = {}
	self._cacheMsgList = {}
	self._maxCount = 3
	self._showNextToastInterval = 0.1
	self.hadTask = false

	recthelper.setAnchor(self._gotemplate.transform, OutSidePos, OutSidePos)
end

function SurvivalToastView:onOpen()
	tabletool.addValues(self._cacheMsgList, SurvivalMapModel.instance.showToastList)
	tabletool.clear(SurvivalMapModel.instance.showToastList)
	self:addToastMsg()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.ShowToast, self.addToastMsg, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.RecycleToast, self._doRecycleAnimation, self)
end

function SurvivalToastView:onClose()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.ShowToast, self.addToastMsg, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.RecycleToast, self._doRecycleAnimation, self)
	TaskDispatcher.cancelTask(self._showToast, self)

	self.hadTask = false
end

function SurvivalToastView:addToastMsg(msg)
	if msg then
		table.insert(self._cacheMsgList, msg)
	end

	if not self.hadTask and self._cacheMsgList[1] then
		self:_showToast()
		TaskDispatcher.runRepeat(self._showToast, self, self._showNextToastInterval)

		self.hadTask = true
	end
end

function SurvivalToastView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	local newItem = table.remove(self._freeList, 1)

	if not newItem then
		local go = gohelper.clone(self._gotemplate, self._gopoint)

		newItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalToastItem)
	end

	local item

	if #self._usingList >= self._maxCount then
		self:_doRecycleAnimation(self._usingList[1], true)
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
end

function SurvivalToastView:_doRecycleAnimation(item, isManualRecycle)
	local index = tabletool.indexOf(self._usingList, item)

	if index then
		table.remove(self._usingList, index)
	end

	item:clearAllTask()
	item:quitAnimation(self._recycleToast, self)
end

function SurvivalToastView:_recycleToast(item)
	item:reset()
	table.insert(self._freeList, item)
end

function SurvivalToastView:_refreshAllItemsAnimation()
	local anchorY = 0

	for i, item in ipairs(self._usingList) do
		local itemHeight = item:getHeight()

		if i == 1 then
			anchorY = anchorY - itemHeight / 2
		end

		if i == #self._usingList then
			recthelper.setAnchorY(item.tr, anchorY + itemHeight / 2)
		else
			item:upAnimation(anchorY + itemHeight / 2)
		end

		anchorY = anchorY + itemHeight + 10
	end
end

return SurvivalToastView
