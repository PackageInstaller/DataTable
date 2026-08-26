-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsView.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsView", package.seeall)

local SportsNewsView = class("SportsNewsView", BaseView)

function SportsNewsView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrolltablist = gohelper.findChildScrollRect(self.viewGO, "#scroll_tablist")
	self._simagepaperbg = gohelper.findChildSingleImage(self.viewGO, "#simage_paperbg")
	self._simageTitleName = gohelper.findChildSingleImage(self.viewGO, "#simage_TitleName")
	self._itemList = gohelper.findChild(self.viewGO, "List")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Reward/#btn_Reward")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._goreddot = gohelper.findChild(self.viewGO, "Reward/#go_redpoint")
	self._gotabitemcontent = gohelper.findChild(self.viewGO, "#scroll_tablist/Viewport/content")
	self._txttime = gohelper.findChildText(self.viewGO, "#simage_TitleName/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsView:addEvents()
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
end

function SportsNewsView:removeEvents()
	self._btnReward:RemoveClickListener()
end

function SportsNewsView:_btnRewardOnClick()
	local actId = ActivityWarmUpModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.SportsNewsTaskView, {
		actId = actId,
		index = ActivityWarmUpModel.instance:getSelectedDay()
	})
end

SportsNewsView.OrderMaxPos = 4

function SportsNewsView:_editableInitView()
	self._pageTabs = self:getUserDataTb_()
	self._newsItems = self:getUserDataTb_()
	self._newsPos = self:getUserDataTb_()

	for i = 1, SportsNewsView.OrderMaxPos do
		self._newsPos[i] = gohelper.findChild(self._itemList, i)
	end
end

function SportsNewsView:onDestroyView()
	for _, v in ipairs(self._newsItems) do
		v:onDestroyView()
	end

	for _, v in ipairs(self._pageTabs) do
		v:onDestroyView()
	end
end

function SportsNewsView:onOpen()
	self.actId = self.viewParam.actId

	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.OnInfosReply, self.onInfosReply, self)
	ActivityWarmUpController.instance:init(self.actId)

	self.jumpTab = SportsNewsModel.instance:getJumpToTab(self.actId)

	if self.jumpTab then
		ActivityWarmUpController.instance:switchTab(self.jumpTab)
	end

	Activity106Rpc.instance:sendGet106InfosRequest(self.actId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_open_1)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.v1a5NewsTaskBonus)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function SportsNewsView:onClose()
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, self.refreshUI, self)
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, self.refreshUI, self)
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.OnInfosReply, self.onInfosReply, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function SportsNewsView:refreshUI()
	self:refreshAllTabBtns()
	self:refreshAllOrder()
	self:refreshRemainTime()
end

function SportsNewsView:onInfosReply()
	if self.jumpTab then
		return
	end

	local _hasCanFinishOrder = SportsNewsModel.instance:hasCanFinishOrder()
	local day = ActivityWarmUpModel.instance:getSelectedDay()

	for i, v in pairs(_hasCanFinishOrder) do
		day = Mathf.Min(i, day)
	end

	ActivityWarmUpController.instance:switchTab(day)
end

function SportsNewsView:refreshAllTabBtns()
	local totalDay = ActivityWarmUpModel.instance:getTotalContentDays()
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()

	for day = 1, totalDay do
		self:refreshTabBtn(day)
	end

	self:dayTabRedDot()
end

function SportsNewsView:refreshTabBtn(index)
	local item = self:getOrCreateTabItem(index)

	item:onRefresh()
end

function SportsNewsView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local remainTime = actInfoMo:getRemainTimeStr2ByEndTime()

		self._txttime.text = string.format(luaLang("remain"), remainTime)
	end
end

function SportsNewsView:getOrCreateTabItem(index)
	local item = self._pageTabs[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[3]
		local childGO = self:getResInst(path, self._gotabitemcontent, "tab_item" .. tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, SportsNewsPageTabItem)

		item:initData(index, childGO)

		self._pageTabs[index] = item
	end

	return item
end

function SportsNewsView:dayTabRedDot()
	local redDotInfos = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.v1a5NewsOrder).infos
	local dayRedDotInfo = {}

	if redDotInfos then
		for _, info in pairs(redDotInfos) do
			local id = info.uid
			local tab = SportsNewsModel.instance:getDayByOrderId(self.actId, id)

			if not dayRedDotInfo[tab] and tab then
				dayRedDotInfo[tab] = {
					id = id
				}
			end
		end
	end

	local totalDay = ActivityWarmUpModel.instance:getTotalContentDays()

	for day = 1, totalDay do
		if dayRedDotInfo[day] then
			local redDot = dayRedDotInfo[day].id
			local item = self:getOrCreateTabItem(day)

			item:enableRedDot(redDot, RedDotEnum.DotNode.v1a5NewsOrder, redDot)
		end
	end
end

function SportsNewsView:refreshAllOrder()
	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if orders then
		for i, orderMO in ipairs(orders) do
			self:refreshOrder(i, orderMO)
		end
	end
end

function SportsNewsView:refreshOrder(index, orderMO)
	local item = self:getOrCreateOrderItem(index)

	item:onRefresh(orderMO)
end

function SportsNewsView:getOrCreateOrderItem(index)
	local item = self._newsItems[index]

	if not item then
		local pos = self._newsPos[index]

		if not pos then
			return
		end

		local resIndex = index > 1 and 2 or 1
		local path = self.viewContainer:getSetting().otherRes[resIndex]
		local go = self:getResInst(path, pos, "news_" .. tostring(index))

		item = resIndex == 1 and MonoHelper.addNoUpdateLuaComOnceToGo(go, SportsNewsMainReadItem) or MonoHelper.addNoUpdateLuaComOnceToGo(go, SportsNewsMainTaskItem)

		item:initData(go, index)

		self._newsItems[index] = item
	end

	return item
end

return SportsNewsView
