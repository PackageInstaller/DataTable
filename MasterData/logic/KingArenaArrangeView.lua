-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/KingArenaArrangeView.lua

module("logic.extensions.kingarena.view.KingArenaArrangeView", package.seeall)

local KingArenaArrangeView = class("KingArenaArrangeView", ViewComponent)

function KingArenaArrangeView:ctor()
	KingArenaArrangeView.super.ctor(self)
end

function KingArenaArrangeView:buildUI()
	KingArenaArrangeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._txtLeftSeasonTime = goutil.findChildTextComponent(self.mainGO, "leftSeasonTime/txt")
	self._leftChangeTimes = goutil.findChild(self.mainGO, "leftChangeTimes")
	self._txtLeftChangeTimes = goutil.findChildTextComponent(self.mainGO, "leftChangeTimes/txt")
	self._nextPeriodTime = goutil.findChild(self.mainGO, "nextPeriodTime")
	self._txtNextPeriodTime = goutil.findChildTextComponent(self.mainGO, "nextPeriodTime/txt")
	self._btnRecord = goutil.findChild(self.mainGO, "btnCol/btnRecord")
	self._btnFmt = goutil.findChild(self.mainGO, "btnCol/btnFmt")
	self._btnShop = goutil.findChild(self.mainGO, "btnCol/btnShop")
	self._btnRank = goutil.findChild(self.mainGO, "btnCol/btnRank")
	self._btnShow = goutil.findChild(self.mainGO, "btnCol/btnShow")
	self._btnPrize = goutil.findChild(self.mainGO, "btnCol/btnPrize")
	self._redBtnPrize = goutil.findChild(self.mainGO, "btnCol/btnPrize/redPoint")

	local zoneScrView = goutil.findChild(self.mainGO, "zoneCol/scrView")
	local zoneScrCell = goutil.findChild(self.mainGO, "zoneCol/scrCell")

	self._zoneScrollerList = ScrollerList.create(zoneScrView, zoneScrCell, GameUtil.handler(self._updateZoneCell, self), GameUtil.handler(self._clearZoneCell, self))

	self._zoneScrollerList:setCenterMode(true)

	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._strTxtTips = self._txtTips.text
end

function KingArenaArrangeView:bindEvents()
	KingArenaArrangeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickBtnRecord, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickBtnShow, self)
end

function KingArenaArrangeView:unbindEvents()
	KingArenaArrangeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnShow)
end

function KingArenaArrangeView:onEnter()
	KingArenaArrangeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	KingArenaController.instance:enterInStepMgr()

	if not KingArenaController.instance:isInTimeOfSeason(self._seasonId) then
		self:close()

		return
	end

	self._stepMgr = KingArenaController.instance:getStepMgr()
	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)
	self._seasonData = KingArenaConfig.instance:getSeasonData(self._seasonId)
	self._seasonEndTimeStamp = GameUtil.string2time(self._seasonData.endTime)
	self._periodId = self._stepMgr:getNewestPeriodId()

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaResetZoneRes, self._handlePM_KingArenaResetZoneRes, self)
	self.addGEvent(self, GlobalNotify.KingArenaStepChange, self._handleKingArenaStepChange, self)
	RedPointController.instance:regRedPoint(self._redBtnPrize, RedPointModel.ID_KINGARENA_SEASON_PRIZE)

	local matStr = self._seasonData.exchangeItem

	if not string.nilorempty(matStr) then
		local list = {}

		list[1] = {
			showAdd = false,
			id = matStr
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	self._txtTips.text = string.format(self._strTxtTips, self._seasonId)

	self:_onUpdate()
	settimer(1, self._onTickingLeftTime, self, true)
	self:_onTickingLeftTime()
end

function KingArenaArrangeView:onExit()
	KingArenaArrangeView.super.onExit(self)
	KingArenaController.instance:exitInStepMgr()
	RedPointController.instance:unregRedPoint(self._redBtnPrize)
	self._zoneScrollerList:dispose()
	removetimer(self._onTickingLeftTime, self)
end

function KingArenaArrangeView:_handlePM_KingArenaResetZoneRes(status, msg)
	if status ~= 0 then
		return
	end

	if not msg.resetSuc then
		FloatWordMgr.instance:show("该战区已满员，加入战区失败")

		return
	end

	if self._zoneId <= 0 then
		KingArenaController.instance:doCallbackWhenFirstZoneBuffTips(self._seasonId, nil, nil)
	end

	self:close()
	KingArenaController.instance:sendPM_KingArenaGetInfoReq(self._seasonId)
	UIStateManager.instance:push(ViewName.KingArenaMainView, msg.seasonId)
end

function KingArenaArrangeView:_handleKingArenaStepChange(stepChangeState)
	if stepChangeState == KingArenaEnum.StepChangeState_Season then
		FloatWordMgr.instance:show("赛季已结束")
		self:close()

		return
	else
		self:_onUpdate()
	end
end

function KingArenaArrangeView:_onUpdate()
	if not KingArenaController.instance:isInTimeOfSeason(self._seasonId) then
		self:close()

		return
	end

	self._zoneId = self._kingArenaMo:getZoneId()
	self._periodId = self._stepMgr:getNewestPeriodId()

	local isInTimeOfPeriod = KingArenaController.instance:isInTimeOfSeasonPeriod(self._seasonId, self._periodId)
	local cfg = KingArenaConfig.instance:getZoneCfg(self._seasonId)

	self._zoneScrollerList:reloadData(cfg or {})

	local curTimes = self._kingArenaMo:getChangeZoneTimes()
	local freeTimes = self._kingArenaMo:getFreeChangeZoneTimes()

	self._txtLeftChangeTimes.text = Mathf.Max(freeTimes - curTimes, 0)

	local nextPeriodId = self._periodId + 1
	local nextPeriodData = KingArenaConfig.instance:getPeriodData(self._seasonId, nextPeriodId)

	if nextPeriodData then
		local sStamp = GameUtil.string2time(nextPeriodData.openTime)
		local formatTime = GameUtil.getFormatTimeByStamp(sStamp, nil)

		self._txtNextPeriodTime.text = string.format("%s 开启", formatTime)
	else
		self._txtNextPeriodTime.text = "无"
	end

	GameUtil.SetActive(self._leftChangeTimes, isInTimeOfPeriod)
	GameUtil.SetActive(self._nextPeriodTime, not isInTimeOfPeriod)
end

function KingArenaArrangeView:_onTickingLeftTime()
	local now = ServerTime.now()
	local left = Mathf.Max(self._seasonEndTimeStamp - now, 0)
	local formatTime = KingArenaController.instance:FormatTimeWords(left)

	self._txtLeftSeasonTime.text = string.format("赛季剩余：%s", formatTime)
end

function KingArenaArrangeView:_updateZoneCell(view, cell, data, tag)
	local zoneId = data.zoneId
	local zoneData = KingArenaConfig.instance:getZoneData(self._seasonId, zoneId)
	local result, _ = self:getTryJoinZoneResultAndTips(self._seasonId, self._periodId, zoneId)
	local mainGo = cell.gameObject
	local bgGo = goutil.findChild(mainGo, "bg")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtPeopleNum = goutil.findChildTextComponent(mainGo, "peopleNum/txt")
	local btnJoin = goutil.findChild(mainGo, "btnJoin")
	local txtJoin = goutil.findChildTextComponent(mainGo, "btnJoin/txt")
	local imgBuff = goutil.findChild(mainGo, "buff/imgBuff")

	txtName.text = zoneData.name

	local path = zoneData.bgPath

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	local buffPath = zoneData.buffPath

	if not string.nilorempty(buffPath) and imgBuff then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", buffPath)

		local function func()
			imgBuff:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end

		uGuiUtil.setSpriteToImage(imgBuff, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(imgBuff)
	end

	local cur = self._kingArenaMo:getZonePlayerNum(zoneId)
	local max = self._kingArenaMo:getMaxZonePlayerNum()

	txtPeopleNum.text = string.format("<color=#60ee85>%s</color>/%s", cur, max)

	GameUtil.SetGray(btnJoin, result ~= GameEnum.ResultCode.Success)

	txtJoin.text = result == GameEnum.ResultCode.HasSure and "已加入" or "加入"

	GameUtil.addClickHandler(btnJoin, GameUtil.handler(self._onClickZoneCellJoin, self, zoneId))
	GameUtil.addClickHandler(imgBuff, function()
		TipsFacade.instance:openTipWindow(zoneData.name, zoneData.desc, nil, "确定")
	end)
end

function KingArenaArrangeView:_clearZoneCell(cell)
	local mainGo = cell.gameObject
	local btnJoin = goutil.findChild(mainGo, "btnJoin")
	local imgBuff = goutil.findChild(mainGo, "buff/imgBuff")
	local bgGo = goutil.findChild(mainGo, "bg")

	GameUtil.rmClickHandler(btnJoin)
	GameUtil.rmClickHandler(imgBuff)
	uGuiUtil.clearImage(bgGo)
end

function KingArenaArrangeView:_onClickZoneCellJoin(zoneId)
	local result, tips = self:getTryJoinZoneResultAndTips(self._seasonId, self._periodId, zoneId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local curTimes = self._kingArenaMo:getChangeZoneTimes()
	local data = KingArenaConfig.instance:getSelectCostData(self._seasonId, curTimes + 1)
	local costMat = data and data.cost
	local isFree = string.nilorempty(costMat)

	local function successCallBack()
		local result, tips = self:getTryJoinZoneResultAndTips(self._seasonId, self._periodId, zoneId)

		FloatWordMgr.instance:show(tips)

		if result == GameEnum.ResultCode.Success then
			KingArenaController.instance:sendPM_KingArenaResetZoneReq(self._seasonId, zoneId)
		end
	end

	if isFree then
		local zoneData = KingArenaConfig.instance:getZoneData(self._seasonId, zoneId)
		local tipsContent = string.format("是否加入%s，加入后仍可更换\n<color=#eb4624>更换战区后需从新战区的最后一名开始挑战</color>", zoneData.name)

		TipsFacade.instance:openPopupWindow("提示", tipsContent, successCallBack, nil, "确定", "取消")
	else
		local freeTimes = self._kingArenaMo:getFreeChangeZoneTimes()
		local maxBuyTimes = self._kingArenaMo:getMaxBuyChangeZoneTimes(self._periodId)
		local leftBuyTimes = Mathf.Max(maxBuyTimes - Mathf.Max(curTimes - freeTimes, 0), 0)
		local matType, matId, matNum = MaterialMgr.getMatParams(costMat)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local content = string.format("是否花费%s%s购买变更次数，并立即进入战区？\n本赛季最多可购买%s次，还能购买%s次", matNum, matName, maxBuyTimes, leftBuyTimes)
		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter
		local otherCallBack, autoOpenSource

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	end
end

function KingArenaArrangeView:getTryJoinZoneResultAndTips(seasonId, periodId, zoneId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and self._zoneId == zoneId then
		result = GameEnum.ResultCode.HasSure
		tips = "你已加入此战区"
	end

	if result == GameEnum.ResultCode.Success and not KingArenaController.instance:isInTimeOfSeasonPeriod(seasonId, periodId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "竞技未开始"
	end

	if result == GameEnum.ResultCode.Success then
		local curTimes = self._kingArenaMo:getChangeZoneTimes()
		local maxTimes = self._kingArenaMo:getMaxChangeZoneTimes()

		if maxTimes <= curTimes then
			result = GameEnum.ResultCode.IsMaxLimitOfTimes
			tips = "已达重选赛区次数上限"
		end
	end

	if result == GameEnum.ResultCode.Success and self._kingArenaMo:isExceedsZonePlayerNum(zoneId) then
		result = GameEnum.ResultCode.IsMaxLimit
		tips = "该战区已满员，加入战区失败"
	end

	return result, tips
end

function KingArenaArrangeView:_onClickBtnTip()
	local key = KingArenaConfig.instance:getCommonValue("MAIN_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function KingArenaArrangeView:_onClickBtnRecord()
	UIStateManager.instance:push(ViewName.KingArenaBattleRecordView, self._seasonId)
end

function KingArenaArrangeView:_onClickBtnFmt()
	KingArenaController.instance:enterFormation(self._seasonId, self._periodId)
end

function KingArenaArrangeView:_onClickBtnShop()
	local jumpStr = self._seasonData.shopJump

	GotoMgr.gotoByString(jumpStr)
end

function KingArenaArrangeView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.KingArena, 1)
end

function KingArenaArrangeView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.KingArenaPrizeTabView, self._seasonId)
end

function KingArenaArrangeView:_onClickBtnShow()
	GotoMgr.gotoByString("func#1137#2")
end

return KingArenaArrangeView
