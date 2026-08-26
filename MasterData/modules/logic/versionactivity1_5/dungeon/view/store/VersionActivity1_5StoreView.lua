-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/store/VersionActivity1_5StoreView.lua

module("modules.logic.versionactivity1_5.dungeon.view.store.VersionActivity1_5StoreView", package.seeall)

local VersionActivity1_5StoreView = class("VersionActivity1_5StoreView", BaseView)

function VersionActivity1_5StoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttime = gohelper.findChildText(self.viewGO, "title/#txt_time")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5StoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
end

function VersionActivity1_5StoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
end

function VersionActivity1_5StoreView:_editableInitView()
	self._simagebg:LoadImage("singlebg/v1a5_enterview_singlebg/v1a5_store_fullbg.png")
	gohelper.setActive(self._gostoreItem, false)

	self.actId = VersionActivity1_5Enum.ActivityId.DungeonStore
	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
end

function VersionActivity1_5StoreView:onUpdateParam()
	return
end

function VersionActivity1_5StoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		for k, v in ipairs(self.storeItemList) do
			if k == 1 then
				v:refreshTagClip(self._scrollstore)
			end
		end
	end
end

function VersionActivity1_5StoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:refreshStoreContent()
	self:_onScrollValueChanged()
	self:scrollToFirstNoSellOutStore()
end

function VersionActivity1_5StoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity1_5Enum.ActivityId.DungeonStore)
	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not self.storeItemList[i] then
			storeItem = VersionActivity1_5StoreItem.New()

			storeItem:onInitView(gohelper.cloneInPlace(self._gostoreItem))
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end
end

function VersionActivity1_5StoreView:scrollToFirstNoSellOutStore()
	local index = self:getFirstNoSellOutGroup()

	if index <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local viewPortTr = gohelper.findChildComponent(self.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform)
	local viewPortHeight = recthelper.getHeight(viewPortTr)
	local contentHeight = recthelper.getHeight(self.rectTrContent)
	local maxAnchorY = contentHeight - viewPortHeight
	local height = 0

	for _index, storeItem in ipairs(self.storeItemList) do
		if index <= _index then
			break
		end

		height = height + storeItem:getHeight()
	end

	recthelper.setAnchorY(self.rectTrContent, math.min(height, maxAnchorY))
end

function VersionActivity1_5StoreView:getFirstNoSellOutGroup()
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

function VersionActivity1_5StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.DungeonStore]
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

function VersionActivity1_5StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivity1_5StoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return VersionActivity1_5StoreView
