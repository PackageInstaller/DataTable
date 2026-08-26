-- chunkname: @modules/logic/season/view/SeasonStoreView.lua

module("modules.logic.season.view.SeasonStoreView", package.seeall)

local SeasonStoreView = class("SeasonStoreView", BaseView)

function SeasonStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttime = gohelper.findChildText(self.viewGO, "title/#txt_time")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonStoreView:addEvents()
	return
end

function SeasonStoreView:removeEvents()
	return
end

function SeasonStoreView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getSeasonIcon("full/img_saiji_store_bg.png"))
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
end

function SeasonStoreView:onUpdateParam()
	return
end

function SeasonStoreView:onOpen()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, self._onGet107GoodsInfo, self)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._onBuyGoodsSuccess, self)

	self.actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:updateView()
end

function SeasonStoreView:_onGet107GoodsInfo(actId)
	if actId ~= self.actId then
		return
	end

	self:updateView()
end

function SeasonStoreView:_onBuyGoodsSuccess(actId)
	if actId ~= self.actId then
		return
	end

	self:updateView()
end

function SeasonStoreView:updateView()
	self:refreshStoreContent()
end

function SeasonStoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)
	local list = {}

	for _, storelist in pairs(storeGroupDict) do
		for _, v in pairs(storelist) do
			table.insert(list, v)
		end
	end

	table.sort(list, SeasonStoreView.sortGoods)

	for i = 1, math.max(#list, #self.storeItemList) do
		local storeItem = self.storeItemList[i]

		if not storeItem then
			storeItem = SeasonStoreItem.New(self:getItemGo(i))
			self.storeItemList[i] = storeItem
		end

		storeItem:setData(list[i])
	end
end

function SeasonStoreView.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(goodCo1.activityId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(goodCo2.activityId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

function SeasonStoreView:getItemGo(index)
	local setting = self.viewContainer:getSetting()
	local resPath = setting.otherRes.itemPath

	return (self.viewContainer:getResInst(resPath, self._goContent, string.format("item%s", index)))
end

function SeasonStoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day, hour, minute = TimeUtil.secondsToDDHHMMSS(offsetSecond)

	self._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), day, hour, minute)
end

function SeasonStoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self.removeEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, self._onGet107GoodsInfo, self)
	self.removeEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._onBuyGoodsSuccess, self)
end

function SeasonStoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:destory()
	end

	self.storeItemList = nil
end

return SeasonStoreView
