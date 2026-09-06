-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotteryView.lua

module("logic.extensions.petcardlottery.view.PetCardLotteryView", package.seeall)

local PetCardLotteryView = class("PetCardLotteryView", ViewComponent)

function PetCardLotteryView:ctor()
	PetCardLotteryView.super.ctor(self)
end

function PetCardLotteryView:unbindEvents()
	PetCardLotteryView.super.unbindEvents(self)

	for i = 1, #self._petGroupList do
		GameUtil.rmClickHandler(self._petGroupList[i].btnAdd)
	end

	GameUtil.rmClickHandler(self._btnRecord)
end

function PetCardLotteryView:bindEvents()
	PetCardLotteryView.super.bindEvents(self)

	for i = 1, #self._petGroupList do
		GameUtil.addClickHandler(self._petGroupList[i].btnAdd, self._onClickSelect, self)
	end

	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
end

function PetCardLotteryView:buildUI()
	PetCardLotteryView.super.buildUI(self)

	self._prizeView = self:getGo("prizeView")
	self._prizeCell = self:getGo("prizeView/prizeCell")
	self._tablewViewList = {}

	for i = 1, 3 do
		local tableviewGo = self:getGo("prizeView/prize_" .. i .. "/tableview")
		local tableView = ScrollerList.create(tableviewGo, self._prizeCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

		table.insert(self._tablewViewList, tableView)
	end

	self._redPoint = self:getGo("prizeView/redPoint")
	self._nextTimeGo = self:getGo("lotteryView/nextTime")
	self._petGroup = self:getGo("lotteryView/petGroup")
	self._lockTip = self:getGo("lock")
	self._lotteryTip = self:getGo("lotteryTip")
	self._type = self:getGo("lotteryView/type")
	self._txtType = self:getTxt("lotteryView/type/txt")
	self._txtTime = self:getTxt("time/txt")
	self._txtNextTime = self:getTxt("lotteryView/nextTime/txt")
	self._txtLotteryTip = self:getTxt("lotteryTip/txt")
	self._txtlockTip = self:getTxt("lock/txt")
	self._btnRecord = self:getBtn("prizeView/btnRecord")
	self._btnTip = self:getBtn("btnTip")
	self._petGroupList = {}

	for i = 1, 5 do
		local cell = {}

		cell.btnAdd = self:getBtn("lotteryView/petGroup/headCell_" .. i)
		cell.imgAdd = self:getGo("lotteryView/petGroup/headCell_" .. i .. "/imgAdd")
		cell.head = self:getGo("lotteryView/petGroup/headCell_" .. i .. "/head")

		table.insert(self._petGroupList, cell)
		GameUtil.SetActive(cell.head, false)
	end
end

function PetCardLotteryView:onExit()
	PetCardLotteryView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	GlobalDispatcher:removeListener(GlobalNotify.PetCardLotteryGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetCardLotterySelectCardRes, self._sendGetInfoReq, self)
	removetimer(self._timerCountDown, self)

	for id = 1, #self._tablewViewList do
		self._tablewViewList[id]:dispose()
	end

	if #self._selectPetIds > 0 then
		for i = 1, #self._petGroupList do
			uGuiUtil.clearImage(self._petGroupList[i].head)
		end
	end

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)
	end
end

function PetCardLotteryView:onEnter()
	PetCardLotteryView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PetCardLottery)
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PetCardLottery, self._activityId)
	self._lotteryCfg = PetCardLotteryConfig.instance:getCfgById(self._activityId)
	self._cardCfg = PetCardLotteryConfig.instance:getCardCfg(self._activityId)

	PetCardLotteryModel.instance:setActivityId(self._activityId)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_PETCARDLOTTERY_PRIZE)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_PETCARDLOTTERY_DAILY)

	if self._activityId > 0 then
		PetCardLotteryController.instance:sendPM_PetCardLotteryGetInfoReq(self._activityId)
	end

	GlobalDispatcher:addListener(GlobalNotify.PetCardLotteryGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PetCardLotterySelectCardRes, self._sendGetInfoReq, self)

	for id, v in ipairs(self._tablewViewList) do
		local cfg = PetCardLotteryConfig.instance:getPrizeCfgById(self._activityId, id) or {}
		local prizeList = string.split(cfg.prize, "#")

		v:reloadData(prizeList)
	end

	self._selectPetIds = PetCardLotteryModel.instance:getTodaySelectPetIds()
	self._timeWday = 1
	self._nextTime = 0

	self:_setTimeUI()
	self:_playEffect()
end

function PetCardLotteryView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function PetCardLotteryView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function PetCardLotteryView:_setTimeUI()
	if not self._actTimeCfg then
		self._txtTime.text = "未到活动时间"

		return
	end

	local startTime, endTime = GameUtil.string2time(self._actTimeCfg.startTime), GameUtil.string2time(self._actTimeCfg.endTime)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
end

function PetCardLotteryView:_playEffect()
	local effectPath = "20230428/daletou/fx_ui_daletou_jiemian.prefab"
	local parent = self.mainGO

	self._effect = UIEffectManager.instance:playEffect(self, effectPath, parent, 0, 0, loop, nil, nil, nil, self)

	self._effect:setParent(parent.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
end

function PetCardLotteryView:_refreshUI()
	self:lotteryPetCardInfo()
	PetCardLotteryController.instance:setRdInfo()
end

function PetCardLotteryView:lotteryPetCardInfo()
	self._isOpen = false

	local nowTimeDate = ServerTime.nowDate()
	local day = nowTimeDate.day

	self._timeWday = nowTimeDate.wday - 1

	if nowTimeDate.hour < 5 then
		day = day - 1
		self._timeWday = self._timeWday - 1
	end

	self._nowTimeStamp = GameUtil.date2time(nowTimeDate.year, nowTimeDate.month, day, 5, 0, 0)
	self._dateInt = PetCardLotteryController.instance:getTodayDateInt()

	if self._timeWday <= 0 then
		self._timeWday = 7
	end

	local isHasCfg = checkbool(PetCardLotteryConfig.instance:getLotteryPeriodCfg(self._activityId, self._timeWday))

	if isHasCfg then
		local daysOfWeek = PetCardLotteryConfig.instance:getDaysOfWeek(self._activityId, self._timeWday)
		local lotteryDay = daysOfWeek[#daysOfWeek] + 1
		local timeStamp = (lotteryDay - self._timeWday) * 24 * 60 * 60

		self._nextTimeStamp = self._nowTimeStamp + timeStamp

		local isInTime = GameUtil.getTimePeriodTypeBySec(self._nowTimeStamp, self._nextTimeStamp) == GameUtil.inTimePeriod

		self._isOpen = isHasCfg and isInTime
	end

	GameUtil.SetActive(self._lockTip, not self._isOpen)
	GameUtil.SetActive(self._petGroup, self._isOpen)
	GameUtil.SetActive(self._lotteryTip, self._isOpen)
	GameUtil.SetActive(self._nextTimeGo, self._isOpen)
	GameUtil.SetActive(self._type, self._isOpen)

	if not self._isOpen then
		self._txtlockTip.text = self._lotteryCfg.lockDesc

		return
	end

	local count = PetCardLotteryModel.instance:getCountOfPrizeGetter()
	local yesterday = PetCardLotteryModel.instance:getYesterdayDateInt(self._dateInt)
	local isLottery, selectedPetIds, prizePetIds = PetCardLotteryController.instance:isLottery(yesterday)
	local hasPrizeId = #prizePetIds > 0
	local cfg = PetCardLotteryController.instance:lottryPrizeType(selectedPetIds, prizePetIds)
	local desc = "即将开奖，敬请期待"

	if isLottery and hasPrizeId then
		local month, day = PetCardLotteryController.instance:timeDateToWday(yesterday)

		desc = string.format("恭喜你在%02d月%02d日获得了<color=#f6da5e>%s</color>!\n全服共有<color=#f6da5e>%d</color>名玩家获得了一等奖！", month, day, cfg.dec, count)
	elseif hasPrizeId then
		desc = string.format("上一次开奖时，全服共有<color=#f6da5e>%d</color>名玩家获得了一等奖！", count)
	end

	self._txtLotteryTip.text = desc
	self._txtType.text = string.format("类型：%s", PetCardLotteryConfig.instance:getTypeName(self._activityId, self._timeWday))

	self:_setCountTimerByCfg(self._timeWday)
	self:_refreshPetIds()
end

function PetCardLotteryView:_refreshPetIds()
	self._selectPetIds = PetCardLotteryModel.instance:getTodaySelectPetIds()

	local petIdsCount = #self._selectPetIds
	local isSelected = petIdsCount > 0

	for i = 1, #self._petGroupList do
		GameUtil.SetActive(self._petGroupList[i].imgAdd, not isSelected)
		GameUtil.SetActive(self._petGroupList[i].head, isSelected)

		if isSelected then
			uGuiUtil.setSpriteToImage(self._petGroupList[i].head, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl("2zhounian", self._cardCfg[self._selectPetIds[i]].icon))
		end
	end
end

function PetCardLotteryView:_sendGetInfoReq()
	PetCardLotteryController.instance:sendPM_PetCardLotteryGetInfoReq(self._activityId)
end

function PetCardLotteryView:_setCountTimerByCfg(wday)
	self:_timerCountDown()
	settimer(1, self._timerCountDown, self)
end

function PetCardLotteryView:_timerCountDown()
	local time = self._nextTimeStamp - ServerTime.nowServerLook()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(time)

	self._txtNextTime.text = time > 0 and string.format("距离下次开奖：%s", GameUtil.FormatTimeWords(time)) or "开奖中"
end

function PetCardLotteryView:_onClickSelect()
	if #self._selectPetIds > 0 then
		FloatWordMgr.instance:show("今日卡牌已选择，明日再来吧")

		return
	end

	UIStateManager.instance:push(ViewName.PetCardLotterySelectView)
end

function PetCardLotteryView:_onClickRecord()
	UIStateManager.instance:push(ViewName.PetCardLotteryRecordView)
end

function PetCardLotteryView:_onClickRule()
	UIStateManager.instance:push(ViewName.PetCardLotteryRuleView)
end

return PetCardLotteryView
