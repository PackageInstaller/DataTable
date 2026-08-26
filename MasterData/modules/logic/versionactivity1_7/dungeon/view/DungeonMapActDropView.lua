-- chunkname: @modules/logic/versionactivity1_7/dungeon/view/DungeonMapActDropView.lua

module("modules.logic.versionactivity1_7.dungeon.view.DungeonMapActDropView", package.seeall)

local DungeonMapActDropView = class("DungeonMapActDropView", BaseView)

function DungeonMapActDropView:onInitView()
	self._goact = gohelper.findChild(self.viewGO, "#go_act")
	self._bg1 = gohelper.findChild(self.viewGO, "#go_act/bg")
	self._bg2 = gohelper.findChild(self.viewGO, "#go_act/bg2")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_act/layout/#btn_store")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_act/layout/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "#go_act/layout/#btn_task/#go_reddot")
	self._txtshop = gohelper.findChildText(self.viewGO, "#go_act/layout/#btn_store/normal/txt_shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_act/layout/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "#go_act/layout/#btn_store/#go_time/#txt_time")
	self._goStoreTime = gohelper.findChild(self.viewGO, "#go_act/layout/#btn_store/#go_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapActDropView:addEvents()
	self._btnstore:AddClickListener(self.onClickStore, self)
	self._btntask:AddClickListener(self.onClickTask, self)
end

function DungeonMapActDropView:removeEvents()
	self._btnstore:RemoveClickListener()
	self._btntask:RemoveClickListener()
end

DungeonMapActDropView.ActBtnPosY = {
	Resource = 345,
	Equip = 236,
	Normal = 160
}

function DungeonMapActDropView:onClickStore()
	VersionActivityMainFixedHelper.getVersionActivityDungeonController().instance:openStoreView()
end

function DungeonMapActDropView:onClickTask()
	VersionActivityMainFixedHelper.getVersionActivityDungeonController().instance:openTaskView()
end

function DungeonMapActDropView:_editableInitView()
	self.rectTrLayout = gohelper.findChildComponent(self.viewGO, "#go_act/layout", gohelper.Type_RectTransform)

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
end

function DungeonMapActDropView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._goact, false)
	end
end

function DungeonMapActDropView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:_showActNode(self:checkCanShowAct())
	end
end

function DungeonMapActDropView:onOpen()
	self.chapterId = self.viewParam.chapterId
	self.chapterCo = DungeonConfig.instance:getChapterCO(self.chapterId)

	RedDotController.instance:addRedDot(self._gotaskreddot, VersionActivityMainFixedHelper.getDungeonTaskReddot())
	self:_showActNode(self:checkCanShowAct())
end

function DungeonMapActDropView:onUpdateParam()
	self.chapterId = self.viewParam.chapterId
	self.chapterCo = DungeonConfig.instance:getChapterCO(self.chapterId)

	self:_showActNode(self:checkCanShowAct())
end

function DungeonMapActDropView:_showActNode(canShow)
	canShow = canShow and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)

	gohelper.setActive(self._goact, canShow)
	TaskDispatcher.cancelTask(self._frameHandler, self)

	if canShow then
		self:refreshLayout()
		self:refreshStoreCurrency()
		self:refreshRemainTime()
		TaskDispatcher.runRepeat(self._frameHandler, self, 0)
	end
end

function DungeonMapActDropView:_frameHandler()
	self:refreshRemainTime()
end

function DungeonMapActDropView:refreshLayout()
	local type = self.chapterCo.type
	local anchor = DungeonMapActDropView.ActBtnPosY.Normal

	if DungeonModel.instance:chapterListIsNormalType(type) then
		anchor = DungeonMapActDropView.ActBtnPosY.Normal
	elseif type == DungeonEnum.ChapterType.Equip then
		anchor = DungeonMapActDropView.ActBtnPosY.Equip
	elseif DungeonModel.instance:chapterListIsResType(type) or DungeonModel.instance:chapterListIsBreakType(type) then
		anchor = DungeonMapActDropView.ActBtnPosY.Resource
	end

	gohelper.setActive(self._gobg1, anchor == DungeonMapActDropView.ActBtnPosY.Normal)
	gohelper.setActive(self._gobg2, anchor ~= DungeonMapActDropView.ActBtnPosY.Normal)
	recthelper.setAnchorY(self.rectTrLayout, anchor)
end

function DungeonMapActDropView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(VersionActivityMainFixedHelper.getActivityCurrency())

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtnum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function DungeonMapActDropView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityMainFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore]

	if not actInfoMo then
		gohelper.setActive(self._goStoreTime, false)

		return
	end

	gohelper.setActive(self._goStoreTime, true)

	self._txtStoreTime.text = actInfoMo:getRemainTimeStr2ByEndTime(true)
	self._txtshop.text = actInfoMo.config.name
end

function DungeonMapActDropView:checkCanShowAct()
	return self:checkHadAct155Drop() and self:checkActActive()
end

function DungeonMapActDropView:checkHadAct155Drop()
	local allActIds = {}

	for _, co in ipairs(lua_activity155_drop.configList) do
		if co.chapterId == self.chapterId then
			allActIds[co.activityId] = true
		end
	end

	for actId in pairs(allActIds) do
		if ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal then
			self.actId = actId

			return true
		end
	end

	return false
end

function DungeonMapActDropView:checkActActive()
	if not self.actId then
		return false
	end

	local status = ActivityHelper.getActivityStatus(self.actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function DungeonMapActDropView:setEpisodeListVisible(value)
	gohelper.setActive(self._goact, value and self:checkCanShowAct())
end

function DungeonMapActDropView:onRefreshActivityState()
	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		return
	end

	gohelper.setActive(self._goact, self:checkCanShowAct())
end

function DungeonMapActDropView:onDestroyView()
	TaskDispatcher.cancelTask(self._frameHandler, self)
end

return DungeonMapActDropView
