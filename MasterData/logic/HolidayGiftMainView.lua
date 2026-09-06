-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holidaygift/view/HolidayGiftMainView.lua

module("logic.extensions.holidaygift.view.HolidayGiftMainView", package.seeall)

local HolidayGiftMainView = class("HolidayGiftMainView", TableViewComponent)

function HolidayGiftMainView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function HolidayGiftMainView:ctor()
	HolidayGiftMainView.super.ctor(self)
end

function HolidayGiftMainView:unbindEvents()
	HolidayGiftMainView.super.unbindEvents(self)
end

function HolidayGiftMainView:bindEvents()
	HolidayGiftMainView.super.bindEvents(self)
end

function HolidayGiftMainView:buildUI()
	HolidayGiftMainView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
end

function HolidayGiftMainView:onExit()
	HolidayGiftMainView.super.onExit(self)
	HolidayGiftController.instance:unregisterLocalNotify(HolidayGiftController.E_GetInfoRes, self._updateData, self)
	HolidayGiftController.instance:unregisterLocalNotify(HolidayGiftController.E_GainPrizeRes, self._updateData, self)
end

function HolidayGiftMainView:onEnter()
	HolidayGiftMainView.super.onEnter(self)
	HolidayGiftController.instance:registerLocalNotify(HolidayGiftController.E_GetInfoRes, self._updateData, self)
	HolidayGiftController.instance:registerLocalNotify(HolidayGiftController.E_GainPrizeRes, self._updateData, self)

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.HOLIDAY_GIFT)

	if cfg then
		self._activityId = cfg.activityId
	end

	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.HOLIDAY_GIFT, self._activityId)

	if not activityConf or not GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	self:_initActivityTimeText()
	HolidayGiftAgent.instance:sendPM_HolidayGiftGetInfoReq(self._activityId)
end

function HolidayGiftMainView:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.HOLIDAY_GIFT, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function HolidayGiftMainView:_updateData()
	local holidayGiftActConfig = HolidayGiftConfig.instance:getActConfig(self._activityId)
	local prizeConfs = HolidayGiftConfig.instance:getPrizeConfigs(holidayGiftActConfig.planId)

	self:updateListData(prizeConfs)
end

function HolidayGiftMainView:_cellSize(view, index)
	return 236, 500
end

function HolidayGiftMainView:_updateCell(view, cell, conf)
	local itemContainer = goutil.findChild(cell, "itemContainer")
	local txtName = goutil.findChildTextComponent(cell, "name/txt")
	local txtCondition = goutil.findChildTextComponent(cell, "txtCondition")
	local notOpen = goutil.findChild(cell, "notOpen")
	local txtNotOpen = goutil.findChildTextComponent(cell, "notOpen/txtNotOpen")
	local receivedGo = goutil.findChild(cell, "receivedGo")
	local btnSure = goutil.findChild(cell, "btnSure")
	local bg = goutil.findChild(cell, "bg")
	local periodType = GameUtil.getTimePeriodType(conf.startTime, conf.endTime)
	local imgPath = GameUrl.getBigbgFolderUrl("holidaygift", conf.bgPath)

	uGuiUtil.clearImage(bg)
	uGuiUtil.setSpriteToImage(bg, uGuiUtil.SpriteType.BigBg, imgPath)

	txtCondition.text = conf.timeTitle or ""
	txtName.text = conf.title

	local bGainPrize = HolidayGiftModel.instance:isGainPrize(self._activityId, conf.giftId)

	if bGainPrize then
		GameUtil.SetActive(txtNotOpen, false)
		GameUtil.SetActive(notOpen, false)
		GameUtil.SetActive(btnSure, false)
		GameUtil.SetActive(receivedGo, true)
	elseif periodType == GameUtil.beforeTimePeriod then
		GameUtil.SetActive(txtNotOpen, true)
		GameUtil.SetActive(notOpen, true)
		GameUtil.SetActive(btnSure, false)
		GameUtil.SetActive(receivedGo, false)

		txtNotOpen.text = lang("未到可领取时间")
	elseif periodType == GameUtil.inTimePeriod then
		GameUtil.SetActive(txtNotOpen, false)
		GameUtil.SetActive(notOpen, false)
		GameUtil.SetActive(btnSure, true)
		GameUtil.SetActive(receivedGo, false)
	else
		GameUtil.SetActive(txtNotOpen, true)
		GameUtil.SetActive(notOpen, true)
		GameUtil.SetActive(btnSure, false)
		GameUtil.SetActive(receivedGo, false)

		txtNotOpen.text = lang("已结束")
	end

	MaterialMgr.resetAll(itemContainer)
	MaterialMgr.setCellListByCfg(conf.prize, itemContainer)

	local groupLayout = itemContainer:GetComponent(ComponentType.UILayoutSingleLine)

	if groupLayout then
		groupLayout:Layout()
	end

	GameUtil.addClickHandler(GameUtil.asBtn(btnSure), function()
		if not bGainPrize and periodType == GameUtil.inTimePeriod then
			HolidayGiftAgent.instance:sendPM_HolidayGiftGainPrizeReq(self._activityId, conf.giftId)
		end
	end)
end

function HolidayGiftMainView:_clearTableview(cell)
	local itemContainer = goutil.findChild(cell, "itemContainer")
	local btnSure = goutil.findChild(cell, "btnSure")
	local bg = goutil.findChild(cell, "bg")

	MaterialMgr.resetAll(itemContainer)
	GameUtil.rmClickHandler(GameUtil.asBtn(btnSure))
	uGuiUtil.clearImage(bg)
end

return HolidayGiftMainView
