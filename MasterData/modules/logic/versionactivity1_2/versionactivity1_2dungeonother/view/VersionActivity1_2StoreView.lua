-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2StoreView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreView", package.seeall)

local VersionActivity1_2StoreView = class("VersionActivity1_2StoreView", BaseView)

function VersionActivity1_2StoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/time/#txt_time")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2StoreView:addEvents()
	return
end

function VersionActivity1_2StoreView:removeEvents()
	return
end

function VersionActivity1_2StoreView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("linzhonggelou_bj"))
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = {}
end

function VersionActivity1_2StoreView:onUpdateParam()
	return
end

function VersionActivity1_2StoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	self.actId = VersionActivity1_2Enum.ActivityId.DungeonStore

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(self.actId, self._onOpen, self)
end

function VersionActivity1_2StoreView:_onOpen()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:refreshStoreContent()
	self:scrollToFirstNoSellOutStore()
end

function VersionActivity1_2StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if day >= 1 then
		self._txttime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))

		return
	end

	if hour >= 1 then
		self._txttime.text = string.format(luaLang("remain"), hour .. luaLang("time_hour2"))

		return
	end

	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

	if minute >= 1 then
		self._txttime.text = string.format(luaLang("remain"), minute .. luaLang("time_minute2"))

		return
	end

	self._txttime.text = string.format(luaLang("remain"), "<1" .. luaLang("time_minute2"))
end

function VersionActivity1_2StoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)
	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not self.storeItemList[i] then
			storeItem = VersionActivity1_2StoreItem.New()

			storeItem:onInitView(gohelper.cloneInPlace(self._gostoreItem))
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end
end

function VersionActivity1_2StoreView:scrollToFirstNoSellOutStore()
	local index = self:getFirstNoSellOutGroup()

	if index <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)

	local scrollHeight = recthelper.getHeight(self._scrollstore.gameObject.transform)
	local height = 0

	for _index, storeItem in ipairs(self.storeItemList) do
		if index < _index then
			break
		end

		height = height + storeItem:getHeight()
	end

	self._scrollstore.verticalNormalizedPosition = 1 - (height - scrollHeight) / (recthelper.getHeight(self._goContent.transform) - scrollHeight)
end

function VersionActivity1_2StoreView:getFirstNoSellOutGroup()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

	for index, groupGoodsCoList in ipairs(storeGroupDict) do
		for _, goodsCo in ipairs(groupGoodsCoList) do
			if goodsCo.maxBuyCount == 0 then
				return index
			end

			if goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.actId, goodsCo.id) > 0 then
				return index
			end
		end
	end

	return 1
end

function VersionActivity1_2StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivity1_2StoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end

	self.storeItemList = nil
end

return VersionActivity1_2StoreView
