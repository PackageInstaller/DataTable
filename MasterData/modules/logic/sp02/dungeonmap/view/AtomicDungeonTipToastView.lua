-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonTipToastView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonTipToastView", package.seeall)

local AtomicDungeonTipToastView = class("AtomicDungeonTipToastView", AtomicDungeonToastBaseView)

function AtomicDungeonTipToastView:onInitView()
	self._gotipToastContent = gohelper.findChild(self.viewGO, "root/#go_tipToastContent")
	self._gotipToastItem = gohelper.findChild(self.viewGO, "root/#go_tipToastContent/#go_tipToastItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

local OutSidePos = -10000

function AtomicDungeonTipToastView:_editableInitView()
	AtomicDungeonTipToastView.super._editableInitView(self)
	gohelper.setActive(self._gotipToastItem, false)
	recthelper.setAnchor(self._gotipToastItem.transform, OutSidePos, 0)
end

function AtomicDungeonTipToastView:onOpen()
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.ShowTipToast, self.addToastMsg, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.RecycleTipToast, self._doRecycleAnimation, self)

	local checkSameShowMap = {}
	local showToastList = {}

	for index, msg in ipairs(AtomicDungeonModel.instance.showTipToastList) do
		if not checkSameShowMap[msg] then
			table.insert(showToastList, msg)
		end

		checkSameShowMap[msg] = true
	end

	tabletool.addValues(self._cacheMsgList, showToastList)
	AtomicDungeonModel.instance:cleanTipToastList()

	local lastEleFightParam = AtomicDungeonModel.instance:getLastElementFightParam()
	local curFightEpisodeId = AtomicDungeonModel.instance:getCurFightEpisodeId()
	local newElements = AtomicDungeonModel.instance:getNewElementList()

	if #newElements == 0 then
		if lastEleFightParam and lastEleFightParam.lastElementId > 0 and curFightEpisodeId ~= lastEleFightParam.lastEpisodeId then
			TaskDispatcher.runDelay(self.addToastMsg, self, 1.5)
		else
			self:addToastMsg()
		end
	end
end

function AtomicDungeonTipToastView:createToastItem()
	local go = gohelper.clone(self._gotipToastItem, self._gotipToastContent, "tipToastItem")

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicTipToastItem, {
		notSetX = true,
		toastView = self
	}))
end

function AtomicDungeonTipToastView:_recycleToast(item)
	AtomicDungeonTipToastView.super._recycleToast(self, item)

	if not self.hadTask and #self._usingList == 0 then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.ShowTipToastFinish)
	end
end

function AtomicDungeonTipToastView:onClose()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.ShowTipToast, self.addToastMsg, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.RecycleTipToast, self._doRecycleAnimation, self)
	TaskDispatcher.cancelTask(self._showToast, self)
	TaskDispatcher.cancelTask(self.addToastMsg, self)

	self.hadTask = false
end

return AtomicDungeonTipToastView
