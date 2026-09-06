-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/KingArenaMainView.lua

module("logic.extensions.kingarena.view.KingArenaMainView", package.seeall)

local KingArenaMainView = class("KingArenaMainView", ViewComponent)

function KingArenaMainView:ctor()
	KingArenaMainView.super.ctor(self)
end

function KingArenaMainView:buildUI()
	KingArenaMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnRecord = goutil.findChild(self.mainGO, "btnCol/btnRecord")
	self._btnFmt = goutil.findChild(self.mainGO, "btnCol/btnFmt")
	self._btnShop = goutil.findChild(self.mainGO, "btnCol/btnShop")
	self._btnRank = goutil.findChild(self.mainGO, "btnCol/btnRank")
	self._btnShow = goutil.findChild(self.mainGO, "btnCol/btnShow")
	self._btnPrize = goutil.findChild(self.mainGO, "btnCol/btnPrize")
	self._redBtnPrize = goutil.findChild(self.mainGO, "btnCol/btnPrize/redPoint")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._blackMaskInReset = goutil.findChild(self.mainGO, "btnReset/blackMask")
	self._txtBlackMaskInReset = goutil.findChildTextComponent(self.mainGO, "btnReset/blackMask/txt")
	self._imgTakeOffBtnProgress = self._blackMaskInReset:GetComponent(ComponentType.Image)
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._txtLeftSeasonTime = goutil.findChildTextComponent(self.mainGO, "txtLeftSeasonTime/txt")
	self._txtLeftFightTimes = goutil.findChildTextComponent(self.mainGO, "rightCol/leftFightTimes/txt")
	self._btnAddLeftFightTimes = goutil.findChild(self.mainGO, "rightCol/leftFightTimes/btnAdd")
	self._txtLeftPrizeTimes = goutil.findChildTextComponent(self.mainGO, "rightCol/leftPrizeTimes/txt")
	self._btnUseMax = goutil.findChild(self.mainGO, "rightCol/useMax/btn")
	self._imgSelectUseMax = goutil.findChild(self.mainGO, "rightCol/useMax/btn/imgSelect")
	self._txtZone = goutil.findChildTextComponent(self.mainGO, "topCol/zone/txt")
	self._btnChange = goutil.findChild(self.mainGO, "topCol/zone/btnChange")
	self._imgZoneTitle = goutil.findChild(self.mainGO, "topCol/zone/imgTitle")
	self._leftPeriodTime = goutil.findChild(self.mainGO, "topCol/leftPeriodTime")
	self._txtLeftPeriodTime = goutil.findChildTextComponent(self.mainGO, "topCol/leftPeriodTime/txt")
	self._nextPeriodTime = goutil.findChild(self.mainGO, "topCol/nextPeriodTime")
	self._txtNextPeriodTime = goutil.findChildTextComponent(self.mainGO, "topCol/nextPeriodTime/txt")
	self._emptyFirstInPrize = goutil.findChild(self.mainGO, "topCol/prizeCol/emptyFirst")
	self._emptyInPrize = goutil.findChild(self.mainGO, "topCol/prizeCol/empty")
	self._prizeScrView = goutil.findChild(self.mainGO, "topCol/prizeCol/scrView")
	self._prizeScrCell = goutil.findChild(self.mainGO, "topCol/prizeCol/scrCell")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, self._prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:setCenterMode(true)

	self._playerView = goutil.findChild(self.mainGO, "playerCol/playerView")
	self._playerCell = goutil.findChild(self.mainGO, "playerCol/playerCell")
	self._playerViewRecordPos = self._playerView:GetComponent(ComponentType.TestRecordPos)

	GameUtil.SetActive(self._playerCell, false)

	self._myPlayerCell = goutil.findChild(self.mainGO, "playerCol/myPlayerCell")
	self._headRootInMy = goutil.findChild(self._myPlayerCell, "headRoot")
	self._txtNameInMy = goutil.findChildTextComponent(self._myPlayerCell, "name/txt")
	self._txtFightInMy = goutil.findChildTextComponent(self._myPlayerCell, "fight/txt")
	self._txtRankInMy = goutil.findChild(self._myPlayerCell, "rank/txt"):GetComponent(ComponentType.UIImgNumeralText)
	self._fightInMy = goutil.findChild(self._myPlayerCell, "fight")
	self._rankInMy = goutil.findChild(self._myPlayerCell, "rank")
	self._nameInMy = goutil.findChild(self._myPlayerCell, "name")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._strTxtTips = self._txtTips.text
	self._btnBuff = self:getGo("btnBuff")
end

function KingArenaMainView:bindEvents()
	KingArenaMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnUseMax, self._onClickBtnUseMax, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickBtnRecord, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickBtnShow, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnAddLeftFightTimes, self._onClickBtnAddLeftFightTimes, self)
end

function KingArenaMainView:unbindEvents()
	KingArenaMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnUseMax)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnShow)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnAddLeftFightTimes)
end

function KingArenaMainView:onEnter()
	KingArenaMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	KingArenaController.instance:enterInStepMgr()

	if not KingArenaController.instance:isInTimeOfSeason(self._seasonId) then
		self:close()

		return
	end

	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)
	self._stepMgr = KingArenaController.instance:getStepMgr()
	self._periodId = self._stepMgr:getNewestPeriodId()
	self._seasonData = KingArenaConfig.instance:getSeasonData(self._seasonId)

	local periodData = KingArenaConfig.instance:getPeriodData(self._seasonId, self._periodId)

	self._seasonEndTimeStamp = 0
	self._periodEndTimeStamp = 0

	if periodData then
		self._periodEndTimeStamp = GameUtil.string2time(periodData.endTime)
	end

	if self._seasonData then
		self._seasonEndTimeStamp = GameUtil.string2time(self._seasonData.endTime)
	end

	self._resetCdMs = KingArenaConfig.instance:getCommonValue("REFRESH_OP_COUNT", true) * 1000
	self._resetClgCdMs = KingArenaConfig.instance:getCommonValue("FIGHT_CD", true) * 1000

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGetInfoRes, self._handlePM_KingArenaGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaRefreshOpRes, self._handlePM_KingArenaRefreshOpRes, self)
	self.addGEvent(self, GlobalNotify.KingArenaStepChange, self._handleKingArenaStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaFightRes, self._handlePM_KingArenaFightRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, self._onUpdateUI, self)
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

	settimer(1, self._onTickingLeftTime, self, true)
	self:_onTickingLeftTime()
	self:_onUpdate()
	KingArenaController.instance:sendPM_KingArenaGetInfoReq(self._seasonId)
end

function KingArenaMainView:onExit()
	KingArenaMainView.super.onExit(self)
	KingArenaController.instance:exitInStepMgr()
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, self._tryStartFight, self)
	RedPointController.instance:unregRedPoint(self._redBtnPrize)
	removetimer(self._onTickingLeftTime, self)
	uGuiUtil.clearImage(self._imgZoneTitle)
	self:_endStartBtnResetCdAnim()
	self:_onClear()
end

function KingArenaMainView:_handlePM_KingArenaGetInfoRes(status)
	if status ~= 0 then
		return
	end

	self:_onUpdate()
	self:_tryShowFirstZoneBuffTips()
end

function KingArenaMainView:_handlePM_KingArenaFightRes(status)
	if status == -2410 then
		FloatWordMgr.instance:show("对手已刷新")
		KingArenaController.instance:sendPM_KingArenaGetInfoReq(self._seasonId)
	elseif status == 0 then
		self:_onUpdate()
	end
end

function KingArenaMainView:_handlePM_KingArenaRefreshOpRes(status)
	if status ~= 0 then
		self._forbitRefreshOp = false

		return
	end

	self:_onUpdate()
end

function KingArenaMainView:_handleKingArenaStepChange(stepChangeState)
	if stepChangeState == KingArenaEnum.StepChangeState_Season then
		FloatWordMgr.instance:show("赛季已结束")
		self:close()

		return
	else
		self:_onUpdate()
	end
end

function KingArenaMainView:_onUpdate()
	if not KingArenaController.instance:isInTimeOfSeason(self._seasonId) then
		self:close()

		return
	end

	self:_onUpdateData()
	self:_onUpdateUI()
end

function KingArenaMainView:_onUpdateData()
	self._zoneId = self._kingArenaMo:getZoneId()
	self._periodId = self._stepMgr:getNewestPeriodId()
end

function KingArenaMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePlayerUI()
	self:_tryStartBtnResetCdAnim()
	self:_tryStartBtnResetClgCdAnim()
end

function KingArenaMainView:_onClear()
	self:_onClearPlaneUI()
	self:_onClearPlayer()
end

function KingArenaMainView:_onTickingLeftTime()
	local now = ServerTime.now()
	local left = 0
	local formatTime

	left = self._stepMgr:getLeftSeasonTimeStamp()
	formatTime = KingArenaController.instance:FormatTimeWords(left)
	self._txtLeftSeasonTime.text = string.format("赛季剩余：%s", formatTime)
	left = self._stepMgr:getLeftPeriodTimeStamp()
	formatTime = KingArenaController.instance:FormatTimeWords(left)
	self._txtLeftPeriodTime.text = formatTime
end

function KingArenaMainView:_onUpdatePlaneUI()
	local zoneData = KingArenaConfig.instance:getZoneData(self._seasonId, self._zoneId)

	if zoneData then
		self._txtZone.text = zoneData.name or ""
	end

	local titlePath = zoneData and zoneData.titlePath
	local bgGo = self._imgZoneTitle

	if not string.nilorempty(titlePath) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", titlePath)

		local function func()
			bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	local curRank = self._kingArenaMo:getMyCurRank()
	local prizeData = KingArenaConfig.instance:getRankPrizeData(self._seasonId, self._zoneId, curRank)
	local prizeStrList = {}

	if prizeData and not string.nilorempty(prizeData.rankPrize) then
		prizeStrList = string.split(prizeData.rankPrize, "#")
	end

	self._prizeScrollerList:reloadData(prizeStrList)

	local isHavePrize = #prizeStrList > 0
	local isHasFight = self._kingArenaMo:isHasFight()
	local state = 0

	state = not isHasFight and 3 or not isHavePrize and 2 or 1

	GameUtil.SetActive(self._prizeScrView, state == 1)
	GameUtil.SetActive(self._emptyInPrize, state == 2)
	GameUtil.SetActive(self._emptyFirstInPrize, state == 3)

	local curTimes = self._kingArenaMo:getDailyFightTimes()
	local freeTimes = self._kingArenaMo:getFreeDailyFightTimes()
	local dailyBuyFightTimes = self._kingArenaMo:getDailyBuyFightTimes()

	self._txtLeftFightTimes.text = Mathf.Max(dailyBuyFightTimes - (curTimes - freeTimes), 0)
	self._txtLeftPrizeTimes.text = self._kingArenaMo:getLeftCanGainPrizeFightTimes()

	local isUseMaxZdl = KingArenaController.instance:isUseMaxZdl(self._seasonId)

	GameUtil.SetActive(self._imgSelectUseMax, isUseMaxZdl)

	local isInPeriodTime = KingArenaController.instance:isInTimeOfSeasonPeriod(self._seasonId, self._periodId)

	GameUtil.SetActive(self._leftPeriodTime, isInPeriodTime)
	GameUtil.SetActive(self._nextPeriodTime, not isInPeriodTime)

	local nextPeriodId = self._periodId + 1
	local nextPeriodData = KingArenaConfig.instance:getPeriodData(self._seasonId, nextPeriodId)

	if nextPeriodData then
		local sStamp = GameUtil.string2time(nextPeriodData.openTime)

		self._txtNextPeriodTime.text = GameUtil.getFormatTimeByStamp(sStamp, nil)
	else
		self._txtNextPeriodTime.text = "无"
	end
end

function KingArenaMainView:_onClearPlaneUI()
	self._prizeScrollerList:dispose()
end

function KingArenaMainView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function KingArenaMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function KingArenaMainView:_onUpdatePlayerUI()
	local preCount = KingArenaConfig.instance:getCommonValue("OP_COUNT_BEFORE_ME", true)
	local lastCount = KingArenaConfig.instance:getCommonValue("OP_COUNT_AFTER_ME", true)
	local totalCount = preCount + lastCount
	local opList = self._kingArenaMo:getOpList()

	table.sort(opList, function(a, b)
		return a.rank < b.rank
	end)

	local childCount = self._playerView.transform.childCount

	for index = 1, totalCount do
		local mainGo = index <= childCount and self._playerView.transform:GetChild(index - 1).gameObject or goutil.cloneAndSetParent(self._playerCell, self._playerView.transform, self._playerCell.name .. "_" .. index)
		local palyerInfo = opList[index]

		self:_updatePlayerCell(mainGo, palyerInfo)
	end

	self._playerViewRecordPos:LoadPlan(0)

	if self._myPlayerCell then
		local headInfo = RoleModel.instance:getHeadInfo()
		local areaId = self._kingArenaMo:getMyAreaId()

		self._txtNameInMy.text = string.format("%s-%s", areaId, headInfo.userName)
		self._txtFightInMy.text = RoleModel.instance:getMaxPower()

		self._txtRankInMy:SetNum(self._kingArenaMo:getMyCurRank())
		HeadItemController.instance:setHeadCellByInfo(self._headRootInMy, headInfo, false)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._fightInMy:GetComponent(goutil.Type_RectTransform))
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rankInMy:GetComponent(goutil.Type_RectTransform))
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._nameInMy:GetComponent(goutil.Type_RectTransform))
	end
end

function KingArenaMainView:_onClearPlayer()
	local childCount = self._playerView.transform.childCount

	for index = 1, childCount do
		local mainGo = self._playerView.transform:GetChild(index - 1).gameObject

		self:_clearPlayerCell(mainGo)
	end

	HeadItemController.instance:resetHeadCell(self._headRootInMy)
end

function KingArenaMainView:_updatePlayerCell(mainGo, playerInfo)
	local headInfo, userId
	local userName = ""
	local zdl = 0
	local rank = 0
	local areaId

	if playerInfo then
		areaId = playerInfo.areaId
		headInfo = playerInfo.headInfo
		userId = playerInfo.headInfo.userId
		userName = playerInfo.headInfo.userName
		zdl = playerInfo.zdl
		rank = playerInfo.rank
	end

	local isMuzhuang = checknumber(userId) == 0
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local muzhuang = goutil.findChild(mainGo, "muzhuang")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local txtFight = goutil.findChildTextComponent(mainGo, "fight/txt")
	local txtRank = goutil.findChild(mainGo, "rank/txt"):GetComponent(ComponentType.UIImgNumeralText)
	local fightGo = goutil.findChild(mainGo, "fight")
	local rankGo = goutil.findChild(mainGo, "rank")
	local btnFight = goutil.findChild(mainGo, "btnFight")

	txtName.text = (string.nilorempty(areaId) or checknumber(userId) <= 0) and userName or string.format("%s-%s", areaId, userName)
	txtFight.text = zdl

	txtRank:SetNum(rank)

	if isMuzhuang or headInfo == nil then
		txtName.text = "木桩"

		HeadItemController.instance:resetHeadCell(headRoot)
	else
		local isNeedShowInfo = checknumber(userId) > 0

		HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, isNeedShowInfo)
	end

	GameUtil.SetActive(headRoot, not isMuzhuang)
	GameUtil.SetActive(muzhuang, isMuzhuang)
	GameUtil.addClickHandler(btnFight, GameUtil.handler(self._onClickPlayerCellFight, self, playerInfo))
	GameUtil.SetActive(mainGo, true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(fightGo:GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rankGo:GetComponent(goutil.Type_RectTransform))
end

function KingArenaMainView:_clearPlayerCell(mainGo)
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local btnFight = goutil.findChild(mainGo, "btnFight")

	HeadItemController.instance:resetHeadCell(headRoot)
	GameUtil.rmClickHandler(btnFight)
end

function KingArenaMainView:_onClickPlayerCellFight(playerInfo)
	if playerInfo == nil then
		return
	end

	if self._forbitRefreshClgOp then
		FloatWordMgr.instance:show("操作太频繁了，请稍后再试")

		return
	end

	local result, tips = self:getTryEnterFightResultAndTips(self._seasonId, self._periodId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local isEmptyFmt = KingArenaModel.instance:isEmptyInMyFmt()

	if isEmptyFmt then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
			KingArenaController.instance:enterFormation(self._seasonId, self._periodId)
		end, lang("fight_goto_fmt"))

		return
	end

	local userId = playerInfo.headInfo.userId
	local rank = playerInfo.rank

	if checknumber(userId) <= 0 then
		local isRobet = checknumber(userId) < 0
		local curTimes = self._kingArenaMo:getDailyFightTimes()
		local freeTimes = self._kingArenaMo:getFreeDailyFightTimes()
		local buyTimes = Mathf.Max(curTimes - freeTimes, 0)
		local dailyBuyFightTimes = self._kingArenaMo:getDailyBuyFightTimes()
		local leftCanClgTimes = Mathf.Max(dailyBuyFightTimes - (curTimes - freeTimes), 0)

		if leftCanClgTimes > 0 then
			local function okFunc()
				local result, tips = self:getTryEnterFightResultAndTips(self._seasonId, self._periodId)

				FloatWordMgr.instance:show(tips)

				if result == GameEnum.ResultCode.Success then
					local fmo = FormationMO.New()
					local simpleForm = CustomFmtController.instance:createFormPb(fmo)

					KingArenaController.instance:sendPM_KingArenaFightReq(self._seasonId, rank, simpleForm, false)
				end
			end

			TipsFacade.instance:openPopupWindow("提示", (isRobet or nil) and "您所挑战的玩家为守卫，确认挑战后扣除1次挑战次数，且立即获胜并与其交换排名", okFunc, nil, "确定", "取消")
		else
			local maxBuyTimes = self._kingArenaMo:getMaxBuyFightTimes()
			local leftBuyTimes = self._kingArenaMo:getLeftDailyBuyFightTimes()

			if leftBuyTimes <= 0 then
				FloatWordMgr.instance:show("今日购买次数已用完")
			else
				local data = KingArenaConfig.instance:getBuyFightTimesData(self._seasonId, dailyBuyFightTimes + 1)

				if data and leftBuyTimes > 0 then
					local isEnough = KingArenaController.instance:checkMatEnough(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + 1, true)

					if isEnough then
						local descTxt

						local function sureCallBack(view)
							local times = view:getCurTimes()

							if KingArenaController.instance:checkMatEnough(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + times, true) then
								local result, tips = self:getTryEnterFightResultAndTips(self._seasonId, self._periodId)

								FloatWordMgr.instance:show(tips)

								if result == GameEnum.ResultCode.Success then
									self._targetRank = rank

									KingArenaController.instance:sendPM_KingArenaBuyFightTimesReq(self._seasonId, times)
									GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, self._tryStartFight, self)
								end
							end
						end

						local cancelCallBack, otherCallBack

						local function updateCoinTxtCallBack(view)
							view:getTxtCoin().text = ""
						end

						local function updateDescTxtCallBack(view)
							local times = view:getCurTimes()
							local cosMats = KingArenaConfig.instance:getCostMatsWithBuyTimes(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + times)
							local names = ""
							local index = 1

							for matKey, matNum in pairs(cosMats) do
								local matName = MaterialMgr.getMaterialsNameByCfg(matKey)

								names = index > 1 and names .. string.format(", <color=#eb4624>%s%s</color>", matNum, matName) or string.format("<color=#eb4624>%s%s</color>", matNum, matName)
								index = index + 1
							end

							view:getTxtDesc().text = string.format("确定花费%s购买挑战次数吗？\n<size=24>每天最多可购买%s次，还能购买%s次</size>", names, maxBuyTimes, leftBuyTimes)
						end

						TipsFacade.instance:openPopupCommonCostPopView(leftBuyTimes, 1, "提示", "确定", "取消", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
					end
				else
					FloatWordMgr.instance:show("今日挑战次数已用完")
				end
			end
		end
	else
		KingArenaController.instance:enterBattle(self._seasonId, self._periodId, userId, rank)
	end
end

function KingArenaMainView:_tryStartFight(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, self._tryStartFight, self)

	if status ~= 0 then
		return
	end

	local seasonId = msg.seasonId

	if self._seasonId ~= seasonId then
		return
	end

	if checknumber(self._targetRank) <= 0 then
		return
	end

	local rank = self._targetRank

	self._targetRank = nil

	local fmo = FormationMO.New()
	local simpleForm = CustomFmtController.instance:createFormPb(fmo)

	KingArenaController.instance:sendPM_KingArenaFightReq(self._seasonId, rank, simpleForm, false)
end

function KingArenaMainView:getTryEnterFightResultAndTips(seasonId, periodId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local kingArenaMo = KingArenaController.instance:getKingArenaMo(seasonId)

	if result == GameEnum.ResultCode.Success and not KingArenaController.instance:isInTimeOfSeasonPeriod(seasonId, periodId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "比赛未开始"
	end

	if result == GameEnum.ResultCode.Success then
		local zoneId = kingArenaMo:getZoneId()

		if zoneId <= 0 then
			result = GameEnum.ResultCode.HasSure
			tips = "未加入战区"
		end
	end

	return result, tips
end

function KingArenaMainView:_onClickBtnReset()
	local result, tips = self:getTryEnterFightResultAndTips(self._seasonId, self._periodId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._forbitRefreshOp then
		FloatWordMgr.instance:show("操作太频繁了，请稍后再试")

		return
	end

	self._forbitRefreshOp = true

	KingArenaController.instance:sendPM_KingArenaRefreshOpReq(self._seasonId)
end

function KingArenaMainView:_tryStartBtnResetCdAnim()
	local last = self._kingArenaMo:getLastRefreshtime()
	local now = ServerTime.nowMs()
	local leftCdMs = now - last

	if leftCdMs >= self._resetCdMs then
		GameUtil.SetActive(self._blackMaskInReset, false)
		self:_endStartBtnResetCdAnim()
	else
		self._forbitRefreshOp = true

		GameUtil.SetActive(self._blackMaskInReset, true)

		self._lastRefreshtime = last
		self._leftCdSec = Mathf.Ceil(Mathf.Max(self._resetCdMs - leftCdMs, 0) / 1000)

		settimer(1, self._onTickingInResetCd, self, true)
		self:_onTickingInResetCd()
	end
end

function KingArenaMainView:_endStartBtnResetCdAnim()
	GameUtil.SetActive(self._blackMaskInReset, false)

	self._lastRefreshtime = 0

	removetimer(self._onTickingInResetCd, self)

	self._forbitRefreshOp = false
end

function KingArenaMainView:_onTickingInResetCd()
	self._txtBlackMaskInReset.text = self._leftCdSec

	if self._leftCdSec <= 0 then
		self:_endStartBtnResetCdAnim()

		return
	end

	self._leftCdSec = self._leftCdSec - 1
end

function KingArenaMainView:_tryStartBtnResetClgCdAnim()
	local last = self._kingArenaMo:getLastFightTime()
	local now = ServerTime.nowMs()
	local leftCdMs = now - last

	if leftCdMs >= self._resetClgCdMs then
		self:_endStartBtnResetClgCdAnim()
	else
		self._forbitRefreshClgOp = true
		self._lastRefreshClgtime = last
		self._leftCdClgSec = Mathf.Ceil(Mathf.Max(self._resetClgCdMs - leftCdMs, 0) / 1000)

		settimer(1, self._onTickingInResetClgCd, self, true)
		self:_onTickingInResetClgCd()
	end
end

function KingArenaMainView:_endStartBtnResetClgCdAnim()
	self._lastRefreshClgtime = 0

	removetimer(self._onTickingInResetClgCd, self)

	self._forbitRefreshClgOp = false

	self:_updatePlayerCellClgMasks()
end

function KingArenaMainView:_updatePlayerCellClgMasks()
	local preCount = KingArenaConfig.instance:getCommonValue("OP_COUNT_BEFORE_ME", true)
	local lastCount = KingArenaConfig.instance:getCommonValue("OP_COUNT_AFTER_ME", true)
	local totalCount = preCount + lastCount
	local childCount = self._playerView.transform.childCount

	for index = 1, totalCount do
		local mainGo

		if index <= childCount then
			mainGo = self._playerView.transform:GetChild(index - 1).gameObject

			if mainGo then
				local blackMask = goutil.findChild(mainGo, "btnFight/blackMask")

				GameUtil.SetActive(blackMask, self._forbitRefreshClgOp)

				local txt = goutil.findChildTextComponent(mainGo, "btnFight/blackMask/txt")

				txt.text = self._leftCdClgSec
			end
		end
	end
end

function KingArenaMainView:_onTickingInResetClgCd()
	if self._leftCdClgSec <= 0 then
		self:_endStartBtnResetClgCdAnim()

		return
	end

	self._leftCdClgSec = self._leftCdClgSec - 1

	self:_updatePlayerCellClgMasks()
end

function KingArenaMainView:_onClickBtnUseMax()
	local isUse = KingArenaController.instance:isUseMaxZdl(self._seasonId)
	local key = string.format("KingArena_UseMax_%s", self._seasonId)

	if not isUse and not GameUtil.getUserData(key) then
		local togText = lang("本赛季不再提示")
		local title = lang("提示")
		local text = lang("勾选后，在挑战时，己方全体精灵将使用系统属性")

		local function successFunc()
			self:_useMax()
		end

		local function funcTog()
			GameUtil.saveUserData(key, true)
		end

		TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, successFunc, funcTog, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
	else
		self:_useMax()
	end
end

function KingArenaMainView:_useMax()
	local isUse = KingArenaController.instance:isUseMaxZdl(self._seasonId)

	KingArenaController.instance:setIsUseMaxZdl(self._seasonId, not isUse)
	GameUtil.SetActive(self._imgSelectUseMax, not isUse)
end

function KingArenaMainView:_onClickBtnChange()
	UIStateManager.instance:push(ViewName.KingArenaArrangeView, self._seasonId)
end

function KingArenaMainView:_onClickBtnTip()
	local key = KingArenaConfig.instance:getCommonValue("MAIN_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function KingArenaMainView:_onClickBtnRecord()
	UIStateManager.instance:push(ViewName.KingArenaBattleRecordView, self._seasonId)
end

function KingArenaMainView:_onClickBtnFmt()
	KingArenaController.instance:enterFormation(self._seasonId, self._periodId)
end

function KingArenaMainView:_onClickBtnShop()
	local jumpStr = self._seasonData.shopJump

	GotoMgr.gotoByString(jumpStr)
end

function KingArenaMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.KingArena, 1)
end

function KingArenaMainView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.KingArenaPrizeTabView, self._seasonId)
end

function KingArenaMainView:_onClickBtnShow()
	GotoMgr.gotoByString("func#1137#2")
end

function KingArenaMainView:_onClickBtnBuff()
	local zoneData = KingArenaConfig.instance:getZoneData(self._seasonId, self._zoneId)

	if zoneData then
		if not zoneData.name then
			local zoneName = ""

			if zoneData then
				if not zoneData.desc then
					local zoneDesc = ""

					TipsFacade.instance:openTipWindow(zoneName, zoneDesc, nil, "确定")
				end
			end
		end
	end
end

function KingArenaMainView:_tryShowFirstZoneBuffTips()
	local zoneData = KingArenaConfig.instance:getZoneData(self._seasonId, self._zoneId)

	if zoneData then
		if not zoneData.desc then
			local zoneDesc = ""

			if self._zoneId <= 0 or string.nilorempty(zoneDesc) then
				return
			end

			local function firstCallback()
				self:_onClickBtnBuff()
			end

			KingArenaController.instance:doCallbackWhenFirstZoneBuffTips(self._seasonId, firstCallback, nil)
		end
	end
end

function KingArenaMainView:_onClickBtnAddLeftFightTimes()
	local dailyBuyFightTimes = self._kingArenaMo:getDailyBuyFightTimes()
	local maxBuyTimes = self._kingArenaMo:getMaxBuyFightTimes()
	local leftBuyTimes = self._kingArenaMo:getLeftDailyBuyFightTimes()

	if leftBuyTimes <= 0 then
		FloatWordMgr.instance:show("今日购买次数已用完")

		return
	end

	local isEnough = KingArenaController.instance:checkMatEnough(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + 1, true)

	if isEnough then
		local descTxt

		local function sureCallBack(view)
			local times = view:getCurTimes()

			if KingArenaController.instance:checkMatEnough(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + times, true) then
				KingArenaController.instance:sendPM_KingArenaBuyFightTimesReq(self._seasonId, times)
			end
		end

		local function cancelCallBack(view)
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end

		local otherCallBack

		local function updateCoinTxtCallBack(view)
			view:getTxtCoin().text = ""
		end

		local function updateDescTxtCallBack(view)
			local times = view:getCurTimes()
			local cosMats = KingArenaConfig.instance:getCostMatsWithBuyTimes(self._seasonId, dailyBuyFightTimes + 1, dailyBuyFightTimes + times)
			local names = ""
			local index = 1

			for matKey, matNum in pairs(cosMats) do
				local matName = MaterialMgr.getMaterialsNameByCfg(matKey)

				names = index > 1 and names .. string.format(", <color=#eb4624>%s%s</color>", matNum, matName) or string.format("<color=#eb4624>%s%s</color>", matNum, matName)
				index = index + 1
			end

			view:getTxtDesc().text = string.format("确定花费%s购买挑战次数吗？\n<size=24>每天最多可购买%s次，还能购买%s次</size>", names, maxBuyTimes, leftBuyTimes)
		end

		TipsFacade.instance:openPopupCommonCostPopView(leftBuyTimes, 1, "提示", "确定", "取消", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
	end
end

return KingArenaMainView
