-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaView.lua

module("logic.extensions.funarena.view.FunArenaView", package.seeall)

local FunArenaView = class("FunArenaView", ViewComponent)

function FunArenaView:ctor()
	FunArenaView.super.ctor(self)

	self._activityId = 0
	self._challengeCfg = nil
end

function FunArenaView:buildUI()
	FunArenaView.super.buildUI(self)

	self._leftTop = goutil.findChild(self.mainGO, "leftTop")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._scoreIcon = goutil.findChild(self.mainGO, "score/icon")
	self._txtScoreNum = goutil.findChildTextComponent(self.mainGO, "score/txtNum")
	self._openTime = goutil.findChild(self.mainGO, "openTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._itemBubble = goutil.findChild(self.mainGO, "bubble/itemcell/item")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txt")
	self._txtSession = goutil.findChildTextComponent(self.mainGO, "session/txtSession")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._btnRankingList = goutil.findChild(self.mainGO, "btnRankingList")
	self._btnSpRewards = goutil.findChild(self.mainGO, "btnSpRewards")
	self._btnSpRewardsRed = goutil.findChild(self.mainGO, "btnSpRewards/imgPoint")
	self._btnLottery = goutil.findChild(self.mainGO, "btnLottery")
	self._btnLotteryRed = goutil.findChild(self.mainGO, "btnLottery/imgPoint")
	self._btnEntryChallenge = goutil.findChild(self.mainGO, "btnEntryChallenge")
end

function FunArenaView:bindEvents()
	FunArenaView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRankingList, self._onClickBtnRankingList, self)
	GameUtil.addClickHandler(self._btnSpRewards, self._onClickBtnSpRewards, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnEntryChallenge, self._onClickBtnEntryChallenge, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefresh, self)
end

function FunArenaView:unbindEvents()
	FunArenaView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRankingList)
	GameUtil.rmClickHandler(self._btnSpRewards)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnEntryChallenge)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._TickDailyRefresh, self)
end

function FunArenaView:onEnter()
	FunArenaView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
	GlobalDispatcher:addListener(FunArenaAgent.PM_BigCastChallengeGetInfoRes, self.onMsgHandler, self)
	FunArenaController.instance:onSendGetInfoReq()
end

function FunArenaView:onExit()
	FunArenaView.super.onExit(self)
	GlobalDispatcher:removeListener(FunArenaAgent.PM_BigCastChallengeGetInfoRes, self.onMsgHandler, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
	MaterialMgr.resetAll(self._itemBubble)
end

function FunArenaView:onMsgHandler(status, msg)
	if status == 0 then
		-- block empty
	else
		self:_onClickBtnClose()
	end
end

function FunArenaView:_setUI()
	return
end

function FunArenaView:_onUpdateUI()
	self._activityId = FunArenaModel.instance.activityId
	self._challengeCfg = FunArenaConfig.instance:getChallengeCfgById(self._activityId)

	if self._activityId == 0 or #self._challengeCfg == 0 then
		self:_onClickBtnClose()

		return
	end

	if self._txtSession then
		self._txtSession.text = self._challengeCfg.title or ""
	end

	local funCfg = FuncOpenConfig.instance:getFunctionOpenById(442)
	local openTimeStr = funCfg.openTime
	local arr = string.split(openTimeStr, "#")
	local startTime, endTime = GameUtil.string2time(arr[1]), GameUtil.string2time(arr[2])
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = langPara("FunArena_HallView_Tips_1", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	local lotteryCfgs = FunArenaConfig.instance:getLotteryCfgsById(self._activityId)
	local prize = ""

	for _, cfg in pairs(lotteryCfgs) do
		for _, data in ipairs(cfg) do
			if data.prizeType == 1 then
				prize = data.prize
			end
		end
	end

	if self._itemBubble and not string.nilorempty(prize) then
		local matInfo = string.split(prize, ":")
		local matType = checknumber(matInfo[1])
		local cfgId = checknumber(matInfo[2])

		MaterialMgr.setIcon(self._itemBubble, matType, cfgId)

		local function handler()
			CommonTipsMgr.instance:openTipsByConfStr(self._itemBubble, prize)
		end

		GameUtil.addClickHandler(self._itemBubble, GameUtil.handler(handler, self))
	end

	if self._txtBubble then
		local matCfg = MaterialMgr.getMatCfgByStr(prize)

		self._txtBubble.text = matCfg.name or "大奖"
	end

	local curFightTimes = FunArenaModel.instance._infoRes.fightTimes
	local totalFightTimes = self._challengeCfg.fightTimes
	local fightRound = FunArenaModel.instance._infoRes.fightRound

	if fightRound > 0 then
		curFightTimes = curFightTimes + 1
	end

	local remainTimes = math.max(totalFightTimes - curFightTimes, 0)

	self._txtCount.text = langPara("aceteammainview__11", remainTimes, totalFightTimes)

	GameUtil.SetGray(self._btnEntryChallenge, remainTimes == 0 and fightRound == 0)

	local isCanLotter = FunArenaController.instance:isCanLotter()

	GameUtil.SetActive(self._btnLotteryRed, isCanLotter)

	local isCanGetSpecialReward = FunArenaController.instance:isCanGetSpecialReward()

	GameUtil.SetActive(self._btnSpRewardsRed, isCanGetSpecialReward)

	if self._scoreIcon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", self._challengeCfg.res)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(self._scoreIcon, spriteType, spriteName, func)
	end

	if self._txtScoreNum then
		self._txtScoreNum.text = FunArenaModel.instance._infoRes.lotteryScore
	end
end

function FunArenaView:_TickDailyRefresh()
	FunArenaController.instance:onSendGetInfoReq()
end

function FunArenaView:_onClickBtnClose()
	self:close()
end

function FunArenaView:_onClickBtnTip()
	local key = "winnermatch"

	TipsFacade.instance:openRulesView(key)
end

function FunArenaView:_onClickBtnRankingList()
	UIStateManager.instance:push(ViewName.FunArenaRankView)
end

function FunArenaView:_onClickBtnSpRewards()
	UIStateManager.instance:push(ViewName.FunSpecialRewardView)
end

function FunArenaView:_onClickBtnLottery()
	UIStateManager.instance:push(ViewName.FunLotteryView)
end

function FunArenaView:_onClickBtnEntryChallenge()
	local isHasOutLimitChallenge = FunArenaController.instance:isHasOutLimitChallenge()

	if isHasOutLimitChallenge then
		FloatWordMgr.instance:show(lang("FunArenaView_Tips_1"))

		return
	end

	UIStateManager.instance:push(ViewName.FunArenaHallView)
end

return FunArenaView
