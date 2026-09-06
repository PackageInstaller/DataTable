-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cashback/view/CashBackLuckyView.lua

module("logic.extensions.cashback.view.CashBackLuckyView", package.seeall)

local CashBackLuckyView = class("CashBackLuckyView", ViewComponent)

function CashBackLuckyView:buildUI()
	CashBackLuckyView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._btnOneKey = self:getGo("btnOneKey")
	self._btnGoTo = self:getGo("btnGoTo")
	self._goTable = self:getGo("prize/tableview")
	self._goCell = self:getGo("prize/cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRect = self._goTable:GetComponent(ComponentType.ScrollRect)
	self._txtCurCash = self:getTxt("curCash/txt")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtLuckyTime = self:getTxt("luckyTime/txtTime")
end

function CashBackLuckyView:bindEvents()
	CashBackLuckyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnGoTo, self._onClickGoTo, self)
end

function CashBackLuckyView:unbindEvents()
	CashBackLuckyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnGoTo)
end

function CashBackLuckyView:onEnter()
	CashBackLuckyView.super.onEnter(self)

	self._loopRoller = self._loopRoller or LoopRoller.New(self:getGo("luckyRankGo"))

	self._loopRoller:init({
		margin = 4,
		speed = 0.2,
		updateCellFunc = self._updateRollerCell,
		removeCellFunc = self._removeRollerCell,
		thisArg = self,
		direction = LoopRoller.Direction_B2T,
		weekAlign = LoopRoller.WeekAlign_MiddleOrCenter
	})

	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CashBackLucky)

	if actTimeCfg then
		self._actId = actTimeCfg.activityId
		self._curActEndTime = GameUtil.string2time(actTimeCfg.endTime)
		self._curActStartTime = GameUtil.string2time(actTimeCfg.startTime)

		self:refreshViewByCfg()
		CashBackController.instance:getInfo(self._actId)
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	GlobalDispatcher:addListener(GlobalNotify.CashBackUpdateInfo, self.refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.CashBackUpdatePrizeState, self.refreshPrizeState, self)
end

function CashBackLuckyView:onExit()
	CashBackLuckyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CashBackUpdateInfo, self.refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.CashBackUpdatePrizeState, self.refreshPrizeState, self)
	self._tableView:dispose()
	self._loopRoller:dispose()
	removetimer(self.onCountDown, self)
end

function CashBackLuckyView:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "cashbackluckyrule")
end

function CashBackLuckyView:_onClickOneKey()
	CashBackController.instance:gainPrize(self._actId, -1)
end

function CashBackLuckyView:_onClickGoTo()
	local goToStr = self._actCfg.gotoStr

	if string.nilorempty(goToStr) then
		return
	end

	GotoMgr.gotoByString(goToStr)
end

function CashBackLuckyView:refreshViewByCfg()
	self._prizeCfgs = CashBackConfig.instance:getPrizeCfgByActId(self._actId)
	self._actCfg = CashBackConfig.instance:getActCfgById(self._actId)
end

function CashBackLuckyView:refreshViewByInfo()
	self._curLuckyValue = CashBackModel.instance:getCurLuckyValue()
	self._curConsume = CashBackModel.instance:getCurConsume()

	local userInfoList = CashBackModel.instance:getCurLuckyInfoList()

	self._loopRoller:reload(userInfoList)
	self._loopRoller:play()
	self:refreshPrizeState()

	self._txtCurCash.text = self._curConsume

	self:_setTimePart()
end

function CashBackLuckyView:refreshPrizeState()
	local dataList = self:getCurDataList()

	self._tableView:reloadData(dataList)

	if self._showId then
		self._tableView:MoveCellInView(self._showId - 1)
	end
end

function CashBackLuckyView:getCurDataList()
	local dataList = {}

	self._showId = nil

	for k, v in ipairs(self._prizeCfgs) do
		table.insert(dataList, v)

		if not self._showId and self._curConsume >= v.progressReq and not CashBackModel.instance:isGainPrizeId(v.prizeId) then
			self._showId = k
		end
	end

	return dataList
end

function CashBackLuckyView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local prizeArr = string.split(data.prize or "", "#")

	for i = 1, 3 do
		if not string.nilorempty(prizeArr and prizeArr[i]) then
			MaterialMgr.setCellByCfg(prizeArr and prizeArr[i], cell.itemList[i])
		end
	end

	cell.txtTip.text = langPara("%s神钻", data.progressReq)

	if self._curConsume >= data.progressReq then
		if CashBackModel.instance:isGainPrizeId(data.prizeId) then
			goutil.setActive(cell.markFinish, true)
		else
			goutil.setActive(cell.btnGain, true)
			self:_playCellEff(cell.btnGain)
			GameUtil.addClickHandler(cell.btnGain, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
		end
	end
end

function CashBackLuckyView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtTip = goutil.findChildTextComponent(cell.go, "goldCon/txtTip")
	cell.itemList = {}

	for i = 1, 3 do
		local itemGo = goutil.findChild(cell.go, "itemList/item_" .. i)

		MaterialMgr.resetAll(itemGo)

		cell.itemList[i] = itemGo
	end

	cell.btnGain = goutil.findChild(cell.go, "btnGain")

	GameUtil.rmClickHandler(cell.btnGain)
	goutil.setActive(cell.btnGain, false)

	cell.markFinish = goutil.findChild(cell.go, "markFinish")

	goutil.setActive(cell.markFinish, false)
	self:_removeCellEff(cell.btnGain)

	return cell
end

function CashBackLuckyView:_onClickGainPrize(prizeId)
	CashBackController.instance:gainPrize(self._actId, prizeId)
end

function CashBackLuckyView:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		self._effs[go]:setScrollRectClipping(self._scrollRect)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScale(1)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

function CashBackLuckyView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function CashBackLuckyView:_updateRollerCell(item, data, index)
	local info = goutil.findChild(item, "info")
	local txtArea = goutil.findChildTextComponent(info, "txtArea")

	txtArea.text = langPara("%s服-", data.areaName)

	local txtName = goutil.findChildTextComponent(info, "txtName")

	txtName.text = data.name

	local txtAdd = goutil.findChildTextComponent(info, "txtAdd")

	txtAdd.text = langPara("消费<color=#ffffff>%s神钻</color>抽中了返利", data.consume)

	local btn = goutil.findChild(item, "info/txtName/btn")

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		if userId ~= nil then
			FriendController.instance:showInfoView(data.userId, btn)
		end
	end, self)
end

function CashBackLuckyView:_removeRollerCell(item)
	local btn = goutil.findChild(item, "info/txtName/btn")

	GameUtil.rmClickHandler(btn)
end

function CashBackLuckyView:_setTimePart()
	self:_updateLuckyTime()
	removetimer(self.onCountDown, self)
	settimer(1, self.onCountDown, self)
end

function CashBackLuckyView:onCountDown()
	local timeNow = ServerTime.now()
	local timeLeft = self._curActEndTime - timeNow

	if timeLeft > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()

		return
	end

	if self.isInLuckyTime then
		local nextTimeLeft = self._nextLuckyTimeStamp - timeNow

		if nextTimeLeft > 0 then
			self._txtLuckyTime.text = langPara("距离下次开奖还剩：\n%s", GameUtil.FormatTimeSymbol(nextTimeLeft))
		else
			CashBackController.instance:getInfo(self._actId)
		end
	end
end

function CashBackLuckyView:_updateLuckyTime()
	local timeTable = GameUtil.time2date(ServerTime.now())

	if not timeTable.hour then
		local curHour = 0

		for i = 1, 24 do
			curHour = timeTable.hour + 1

			if self:checkIsLuckyTime(timeTable.hour) then
				break
			end
		end

		if timeTable.hour >= 24 then
			curHour = timeTable.hour - 24
			timeTable.day = timeTable.day + 1
		end

		self._nextLuckyTimeStamp = GameUtil.date2time(timeTable.year, timeTable.month, timeTable.day, timeTable.hour, 0, 0)
		self.isInLuckyTime = true

		if self._actCfg.drawEndDays > 0 then
			local luckEndTime = self._curActStartTime + self._actCfg.drawEndDays * 3600 * 24

			if luckEndTime < ServerTime.now() or luckEndTime < self._nextLuckyTimeStamp then
				self.isInLuckyTime = false
				self._txtLuckyTime.text = lang("抽奖已结束")
			end
		end
	end
end

function CashBackLuckyView:checkIsLuckyTime(hour)
	local temHour = hour

	if temHour >= 24 then
		temHour = 0
	end

	if self._actCfg and self._actCfg.drawHourRanges then
		for k, v in ipairs(self._actCfg.drawHourRanges) do
			if temHour >= v[1] and temHour <= v[2] then
				return true
			end
		end
	end

	return false
end

return CashBackLuckyView
