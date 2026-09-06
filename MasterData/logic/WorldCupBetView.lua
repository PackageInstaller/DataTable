-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupBetView.lua

module("logic.extensions.worldcup.view.WorldCupBetView", package.seeall)

local WorldCupBetView = class("WorldCupBetView", ViewComponent)
local ODDS_TYPE_MAIN_WIN = "WIN"
local ODDS_TYPE_AWAY_WIN = "LOSE"
local ODDS_TYPE_DROW = "TIE"
local ODDS_TYPE_SCORE = "SCORE"

function WorldCupBetView:ctor()
	WorldCupBetView.super.ctor(self)

	self._maxNum = 0
	self._inputClampLock = false
end

function WorldCupBetView:unbindEvents()
	WorldCupBetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnMs)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnM10)
	GameUtil.rmClickHandler(self._btnA10)
	self._inputField:RemoveOnValueChanged()
	self._inputField:RemoveOnEndEdit()
end

function WorldCupBetView:bindEvents()
	WorldCupBetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnMs, GameUtil.handler(self._onClickAdjust, self, -1))
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._onClickAdjust, self, 1))
	GameUtil.addClickHandler(self._btnM10, GameUtil.handler(self._onClickAdjust, self, -100))
	GameUtil.addClickHandler(self._btnA10, GameUtil.handler(self._onClickAdjust, self, 100))
	self._inputField:AddOnValueChanged(self._onInputValueChanged, self)
	self._inputField:AddOnEndEdit(self._onInputOnEndEdit, self)
end

function WorldCupBetView:buildUI()
	WorldCupBetView.super.buildUI(self)

	self._txtType = self:getTxt("txtType")
	self._txtResult = self:getTxt("result/txtResult")
	self._txtOdds = self:getTxt("result/txtOdds")
	self._txtSupportCount = self:getTxt("txtSupportCount")
	self._txtMySupport = self:getTxt("txtMySupport")
	self._supportTag = self:getGo("result/supportTag")
	self._btnClose = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
	self._txtTitle = self:getTxt("txtTitle")
	self._inputField = self:getInput("IptItem")
	self._txtAddScore = self:getTxt("txtMySupport/txtAddScore")
	self._btnSure = self:getGo("btnSure")
	self._btnMs = self:getGo("Marks/BtnMs")
	self._btnAdd = self:getGo("Marks/BtnAdd")
	self._btnM10 = self:getGo("Marks/BtnM10")
	self._btnA10 = self:getGo("Marks/BtnA10")
	self._goldBar = self:getGo("goldBar")
end

function WorldCupBetView:_getBetAmount()
	local num = Mathf.Clamp(math.floor(checknumber(self._inputField:GetText())), 0, self:_getInputMaxNum())

	num = self:_fixNumHandredTimes(num)

	return num
end

function WorldCupBetView:_onClickAdjust(delta)
	local v = Mathf.Clamp(self:_getBetAmount() + delta, 0, self:_getInputMaxNum())

	self._inputField:SetText(tostring(v))
end

function WorldCupBetView:_onClickSure()
	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._matchId)
	local matchStartTime = checknumber(matchInfo.startTime) / 1000

	if matchStartTime <= ServerTime.now() then
		FloatWordMgr.instance:show(lang("比赛已开始，不可应援"))

		return
	end

	local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, matchInfo.stageId)
	local stageBetStartTime = GameUtil.string2time(stageCfg.betTime)

	if stageBetStartTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到应援时间"))

		return
	end

	local amount = self:_getBetAmount()

	if amount <= 0 then
		FloatWordMgr.instance:show(lang("请输入有效的应援数量"))

		return
	end

	WorldCupAgent.instance:sendPM_WorldCupBetReq(self._activityId, self._matchId, matchInfo.stageId, matchInfo.homeTeamId, self._defineId, self._oddsData.odds, amount)
	FloatWordMgr.instance:show(lang("应援成功"))
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.WorldCup_Close_Bet_View)
end

function WorldCupBetView:onExit()
	WorldCupBetView.super.onExit(self)
end

function WorldCupBetView:_onInputValueChanged()
	local raw = self._inputField:GetText() or ""

	if raw == "" then
		return
	end

	if self._inputClampLock then
		return
	end

	self._inputClampLock = true

	self._inputField:RemoveOnValueChanged()

	local num = math.floor(checknumber(raw))

	num = Mathf.Clamp(num, 0, self:_getInputMaxNum())

	self._inputField:SetText(tostring(num))
	self._inputField:AddOnValueChanged(self._onInputValueChanged, self)

	self._inputClampLock = false
	self._txtAddScore.text = ""
	self._txtMySupport.text = num == 0 and langPara("当前已应援：%s/%s", self._myBetScore, self._maxSingleBet) or langPara("当前已应援：%s<color=#01B524FF>+%s</color>/%s", self._myBetScore, tostring(num), self._maxSingleBet)
end

function WorldCupBetView:_onInputOnEndEdit(str)
	local num = math.floor(checknumber(str))

	num = Mathf.Clamp(num, 0, self:_getInputMaxNum())
	num = self:_fixNumHandredTimes(num)

	self._inputField:SetText(tostring(num))
end

function WorldCupBetView:_fixNumHandredTimes(num)
	return math.floor(num / 100) * 100
end

function WorldCupBetView:_getInputMaxNum()
	return math.min(self._maxNum, math.max(self._maxSingleBet - self._myBetScore, 0))
end

function WorldCupBetView:onEnter()
	WorldCupBetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._matchId = checknumber(params[2])
	self._oddsData = params[3]
	self._defineId = self._oddsData.defineId

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._matchId)
	local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, matchInfo.stageId, self._defineId)
	local mainTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, matchInfo.homeTeamId)
	local awayTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, matchInfo.awayTeamId)
	local mainTeamName = WorldCupController.instance:getTeamName(mainTeamCfg)
	local awayTeamName = WorldCupController.instance:getTeamName(awayTeamCfg)

	self._txtType.text = langPara("(主)%s-(客)%s", mainTeamName, awayTeamName)

	if oddsCfg.type == ODDS_TYPE_SCORE then
		local oddScoreArr = string.split(oddsCfg.param, "-")

		self._txtResult.text = string.format("%s:%s", oddScoreArr[1], oddScoreArr[2])
	elseif oddsCfg.type == ODDS_TYPE_MAIN_WIN then
		self._txtResult.text = lang("主场<color=#FE5F5D>胜</color>")
	elseif oddsCfg.type == ODDS_TYPE_AWAY_WIN then
		self._txtResult.text = lang("客场<color=#FE5F5D>胜</color>")
	elseif oddsCfg.type == ODDS_TYPE_DROW then
		self._txtResult.text = lang("平局")
	end

	self._txtOdds.text = langPara("%0.2f倍", self._oddsData.odds / 100)

	local myBetInfo = WorldCupModel.instance:getBetInfo(self._activityId, self._matchId, self._defineId)

	if myBetInfo then
		self._myBetScore = myBetInfo.score or 0
	end

	local actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)

	self._maxSingleBet = checknumber(actCfg.maxSingleBet)
	self._txtMySupport.text = langPara("当前已应援：%s/%s", self._myBetScore, self._maxSingleBet)

	if myBetInfo then
		GameUtil.SetActive(self._supportTag, true)
	else
		GameUtil.SetActive(self._supportTag, false)
	end

	self._txtSupportCount.text = langPara("当前应援人数：%s", checknumber(self._oddsData.hot))

	local activityCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)
	local matType, matId, _ = MaterialMgr.getMatParams(activityCfg.betItemKey)

	self._maxNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	self._txtAddScore.text = ""

	self._inputField:SetText("0")
	self:_setTopGoldBar()
end

function WorldCupBetView:_setTopGoldBar()
	local btn_list = {}
	local actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)
	local itemArry = string.split(actCfg.betItemKey, "#")

	for i, v in ipairs(itemArry) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btn_list, false)
end

function WorldCupBetView:_onClickClose()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.WorldCup_Close_Bet_View)
end

return WorldCupBetView
