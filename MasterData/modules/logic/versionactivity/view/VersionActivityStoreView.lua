-- chunkname: @modules/logic/versionactivity/view/VersionActivityStoreView.lua

module("modules.logic.versionactivity.view.VersionActivityStoreView", package.seeall)

local VersionActivityStoreView = class("VersionActivityStoreView", BaseView)

function VersionActivityStoreView:onInitView()
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

function VersionActivityStoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
end

function VersionActivityStoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
end

function VersionActivityStoreView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/img_bg"))
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
end

function VersionActivityStoreView:onUpdateParam()
	return
end

function VersionActivityStoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		for k, v in ipairs(self.storeItemList) do
			if k == 1 then
				v:refreshTagClip(self._scrollstore)
			end
		end
	end
end

function VersionActivityStoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:refreshStoreContent()
	self:_onScrollValueChanged()
end

function VersionActivityStoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivityEnum.ActivityId.Act107)
	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not self.storeItemList[i] then
			storeItem = VersionActivityStoreItem.New()

			storeItem:onInitView(gohelper.cloneInPlace(self._gostoreItem))
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end
end

function VersionActivityStoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act107]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

	self._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), day, hour, minute)
end

function VersionActivityStoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivityStoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return VersionActivityStoreView
