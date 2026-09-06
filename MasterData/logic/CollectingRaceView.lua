-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/view/CollectingRaceView.lua

module("logic.extensions.collectingrace.view.CollectingRaceView", package.seeall)

local CollectingRaceView = class("CollectingRaceView", ViewComponent)

function CollectingRaceView:ctor()
	CollectingRaceView.super.ctor(self)
end

function CollectingRaceView:unbindEvents()
	CollectingRaceView.super.unbindEvents(self)
end

function CollectingRaceView:bindEvents()
	CollectingRaceView.super.bindEvents(self)
end

function CollectingRaceView:buildUI()
	CollectingRaceView.super.buildUI(self)

	self._emptyTip = self:getGo("emptyTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._tableviewScrollRect = goutil.findChild(self.mainGO, "tableview"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollerList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._scrollerList:setCenterMode(true)
end

function CollectingRaceView:onExit()
	CollectingRaceView.super.onExit(self)
	CollectingRaceController.instance:unregisterLocalNotify(CollectingRaceController.E_InfoRes, self._updateData, self)
	CollectingRaceController.instance:unregisterLocalNotify(CollectingRaceController.E_GainPrizeRes, self._updateData, self)
	self._scrollerList:dispose()
end

function CollectingRaceView:onEnter()
	CollectingRaceView.super.onEnter(self)
	CollectingRaceController.instance:registerLocalNotify(CollectingRaceController.E_InfoRes, self._updateData, self)
	CollectingRaceController.instance:registerLocalNotify(CollectingRaceController.E_GainPrizeRes, self._updateData, self)

	self._cell2PrizeList = {}
	self._cell2Effect = {}

	self:_initActivityTimeText()
	CollectingRaceAgent.instance:sendPM_CollectingRaceInfoReq()
end

function CollectingRaceView:_initActivityTimeText()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.COLLECTING_RACE)
	local earliestTime, latestTime

	for i, cfg in ipairs(cfgs) do
		if ActivityDefineController.instance:isRelateServerBy(cfg.relatedAreaIds) == true and (cfg.processType == 4 or cfg.processType == 3) then
			local timeStart = GameUtil.string2time(cfg.startTime)
			local timeEnd = GameUtil.string2time(cfg.endTime)

			if earliestTime == nil or timeStart < earliestTime then
				earliestTime = timeStart
			end

			if latestTime == nil or latestTime < timeEnd then
				latestTime = timeEnd
			end
		end
	end

	local startDate = GameUtil.time2date(earliestTime)
	local endDate = GameUtil.time2date(latestTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

local SortOrder = {
	[GameUtil.inTimePeriod] = 1,
	[GameUtil.beforeTimePeriod] = 2,
	[GameUtil.afterTimePeriod] = 3,
	[GameUtil.errorTimePeriod] = 4
}

function CollectingRaceView:_updateData()
	local actDefineInstance = ActivityDefineController.instance
	local actType = GameEnum.ActivityType.COLLECTING_RACE
	local array = CollectingRaceConfig.instance:getShowRaceArray(self._viewPresentor.viewName)

	table.sort(array, function(a, b)
		local periodA = SortOrder[actDefineInstance:getActTimePeriod(actType, a.activityId)]
		local periodB = SortOrder[actDefineInstance:getActTimePeriod(actType, b.activityId)]

		if periodA == periodB then
			return checknumber(a.sortId) < checknumber(b.sortId)
		else
			return periodA < periodB
		end
	end)
	self._scrollerList:reloadData(array)
end

function CollectingRaceView:_updateCell(view, cell, data)
	local model = CollectingRaceModel.instance
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(data.skinId)
	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(data.skinId)
	local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.COLLECTING_RACE, data.activityId)
	local periodType = GameUtil.getTimePeriodTypeBySec(startTimeStamp, endTimeStamp)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1
	local imgPath = GameUrl.getBigbgFolderUrl("collectingrace", data.bgPath)
	local skinId = data.skinId
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local isSkin = raceId ~= data.skinId

	self:_setQualityCell(cell, data)

	local btnObj = goutil.findChild(cell, "container")

	GameUtil.asBtn(btnObj):AddClickListener(function()
		if periodType == GameUtil.inTimePeriod then
			if checknumber(data.behaviour) > 0 then
				SurveyController.instance:reportBehavior(checknumber(data.behaviour))
			end

			if isSkin then
				MaterialMgr.openGetSource(MatType.PET_SKIN, data.skinId)
			else
				MaterialMgr.openGetSource(MatType.Pet, data.skinId)
			end
		end
	end, self)

	local redPoint = goutil.findChild(btnObj, "redPoint")
	local bCanGainPrize = model:isPrizeRed(data)

	goutil.setActive(redPoint, bCanGainPrize)

	local wishRedPoint = goutil.findChild(btnObj, "btnWish/redPoint")

	goutil.setActive(wishRedPoint, model:isFightRed(data.skinId))

	local imageObj = goutil.findChild(btnObj, "role")

	uGuiUtil.setSpriteToImage(imageObj, uGuiUtil.SpriteType.BigBg, imgPath)

	goutil.findChildTextComponent(btnObj, "namebg/txt").text = infoPet.skinName

	local attrObj = goutil.findChild(btnObj, "imgattribute")

	GameUtil.getUIImageSpriteChange(attrObj):SetState(race)

	local btnBook = goutil.findChild(btnObj, "btnBook")

	GameUtil.asBtn(btnBook).enabled = isOpen

	GameUtil.asBtn(btnBook):RemoveClickListener()
	GameUtil.asBtn(btnBook):AddClickListener(function()
		if isSkin then
			PetbookController.instance:openSkinViewNoSetAttr(skinId)
		else
			PetbookController.instance:openPetinfoView(raceId)
		end
	end, self)

	local openDateStr = ""
	local dateTimeGo = goutil.findChild(btnObj, "showDate")

	if periodType == GameUtil.beforeTimePeriod then
		local day = GameUtil.getDaysByTimestamp(ServerTime.now(), startTimeStamp) - 1

		goutil.findChildTextComponent(btnObj, "openTime/txt").text = string.format("%s天后开始", day)
	elseif periodType == GameUtil.afterTimePeriod then
		goutil.findChildTextComponent(btnObj, "openTime/txt").text = "已结束"
	elseif periodType == GameUtil.inTimePeriod then
		local leftTime = endTimeStamp - ServerTime.now()

		openDateStr = self:_getOpenDateStr(leftTime)
	end

	goutil.setActive(dateTimeGo, periodType == GameUtil.inTimePeriod)

	goutil.findChildTextComponent(btnObj, "txtShowDate").text = openDateStr

	goutil.findChild(btnObj, "openTime"):SetActive(periodType ~= GameUtil.inTimePeriod)
	goutil.findChild(btnObj, "noGet"):SetActive(not isGet)

	local btnWish = goutil.findChild(btnObj, "btnWish")

	GameUtil.asBtn(btnWish):RemoveClickListener()
	GameUtil.asBtn(btnWish):AddClickListener(function()
		model:saveFightRed(data.skinId)
		goutil.setActive(wishRedPoint, model:isFightRed(data.skinId))
		TipsFacade.instance:openTipWindow(lang("tip"), data.buffDesc, nil, lang("confirm"))
	end, self)

	local prizeItemListGo = goutil.findChild(btnObj, "itemview")
	local prizeItemGo = goutil.findChild(btnObj, "item")
	local txtReward = goutil.findChild(btnObj, "txtreward")

	if periodType == GameUtil.inTimePeriod then
		goutil.setActive(prizeItemListGo, true)
		goutil.setActive(txtReward, true)
		goutil.setActive(btnWish.gameObject, not string.nilorempty(data.buffDesc))

		local prizeArray = string.split(data.prize, "#") or {}
		local bGot = model:isGainPrize(data.activityId)

		self:_clearPrizeCells(cell)

		local list = ScrollerList.create(prizeItemListGo, prizeItemGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		self._cell2PrizeList[cell] = list

		local prizeInfos = {}

		for i, prize in ipairs(prizeArray) do
			table.insert(prizeInfos, {
				bGot = bGot,
				prize = prize,
				bCanGainPrize = bCanGainPrize,
				activityId = data.activityId
			})
		end

		list:reloadData(prizeInfos)
		list:refresh()
	else
		goutil.setActive(btnWish.gameObject, false)
		goutil.setActive(prizeItemListGo, false)
		goutil.setActive(txtReward, false)
	end
end

function CollectingRaceView:_clearTableview(cell)
	local btnObj = goutil.findChild(cell, "container")
	local btnBook = goutil.findChild(btnObj, "btnBook")
	local imageObj = goutil.findChild(btnObj, "role")
	local btnWish = goutil.findChild(btnObj, "btnWish")

	GameUtil.asBtn(btnBook):RemoveClickListener()
	GameUtil.asBtn(btnWish):RemoveClickListener()
	uGuiUtil.clearImage(imageObj)
	self:_clearPrizeCells(cell)
end

function CollectingRaceView:_clearPrizeCells(cell)
	local list = self._cell2PrizeList[cell]

	if list then
		list:dispose()
	end

	self._cell2PrizeList[cell] = nil
end

function CollectingRaceView:_getOpenDateStr(leftTime)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime > 0 and leftTime or 0)

	return day > 0 and string.format("活动剩余：%d天 %d小时", day, hour) or hour > 0 and string.format("活动剩余：%d小时", hour) or "活动剩余：1小时"
end

function CollectingRaceView:_updatePrizeCell(index, cell, data)
	local item = goutil.findChild(cell, "item")
	local receive = goutil.findChild(cell, "receive")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	goutil.setActive(receive, data.bGot)

	if data.bCanGainPrize then
		self:_playEffect(cell)
	else
		self:_clearEffect(cell)
	end

	if proxy and data.bCanGainPrize then
		proxy:setAutoTips(false)
		proxy:setCallBack(function()
			CollectingRaceController.instance:reqGainPrize(data.activityId)
		end)
	end
end

function CollectingRaceView:_clearPrizeCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	self:_clearEffect(cell)
end

function CollectingRaceView:_playEffect(cell)
	self:_clearEffect(cell)

	local effectGo = goutil.findChild(cell, "effect")
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self._view, effPath, effectGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setScrollRectClipping(self._tableviewScrollRect)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(effectGo) + 1)
	end)

	uiEffect:setParent(effectGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cell2Effect[cell] = uiEffect
end

function CollectingRaceView:_clearEffect(cell)
	if self._cell2Effect and self._cell2Effect[cell] then
		UIEffectManager.instance:stopEffect(self._cell2Effect[cell])

		self._cell2Effect[cell] = nil
	end
end

function CollectingRaceView:_setQualityCell(cell, data)
	return
end

return CollectingRaceView
