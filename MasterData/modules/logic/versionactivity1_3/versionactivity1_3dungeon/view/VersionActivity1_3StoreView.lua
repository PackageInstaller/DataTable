-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3StoreView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3StoreView", package.seeall)

local VersionActivity1_3StoreView = class("VersionActivity1_3StoreView", BaseView)

function VersionActivity1_3StoreView:onInitView()
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

function VersionActivity1_3StoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
end

function VersionActivity1_3StoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
end

function VersionActivity1_3StoreView:_editableInitView()
	self._simagebg:LoadImage("singlebg/v1a3_store_singlebg/v1a3_store_fullbg.png")
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
end

function VersionActivity1_3StoreView:onUpdateParam()
	return
end

function VersionActivity1_3StoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		for k, v in ipairs(self.storeItemList) do
			if k == 1 then
				v:refreshTagClip(self._scrollstore)
			end
		end
	end
end

function VersionActivity1_3StoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:refreshStoreContent()
	self:_onScrollValueChanged()
end

function VersionActivity1_3StoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity1_3Enum.ActivityId.DungeonStore)
	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not self.storeItemList[i] then
			storeItem = VersionActivity1_3StoreItem.New()

			storeItem:onInitView(gohelper.cloneInPlace(self._gostoreItem))
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end
end

function VersionActivity1_3StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.DungeonStore]
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

function VersionActivity1_3StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivity1_3StoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return VersionActivity1_3StoreView
