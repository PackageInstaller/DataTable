-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestMainView.lua

module("logic.extensions.magiccontest.view.MagicContestMainView", package.seeall)

local MagicContestMainView = class("MagicContestMainView", ViewComponent)
local BatType

function MagicContestMainView:ctor()
	MagicContestMainView.super.ctor(self)
end

function MagicContestMainView:buildUI()
	MagicContestMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._redBtnJumps = {
		self._redBtnJump1,
		self._redBtnJump2,
		self._redBtnJump3
	}
	self._redDataFields = {
		"jumpRedIdOne",
		"jumpRedIdTwo",
		"jumpRedIdThree"
	}
	self._btnFmt = self:getGo("btnFmt")
	self._btnBattleOne = self:getGo("btnBattleOne")
	self._btnExtOne = self:getGo("btnBattleOne/btnExt")
	self._btnNorOne = self:getGo("btnBattleOne/btnNor")
	self._btnBattleTwo = self:getGo("btnBattleTwo")
	self._btnExtTwo = self:getGo("btnBattleTwo/btnExt")
	self._btnNorTwo = self:getGo("btnBattleTwo/btnNor")
	self._txtTips = self:getTxt("tips/txt")
	self._strTxtTips = self._txtTips.text

	local whiteTeam = self:getGo("teamCol/white")
	local blackTeam = self:getGo("teamCol/black")
	local teamGos = {
		[MagicContestEnum.CampId_Black] = blackTeam,
		[MagicContestEnum.CampId_White] = whiteTeam
	}

	self._teamCells = {}

	for _, campId in ipairs(MagicContestEnum.CampIdList) do
		self._teamCells[campId] = {}

		local cell = self._teamCells[campId]
		local mainGo = teamGos[campId]

		cell._mainGo = mainGo
		cell._content = goutil.findChild(mainGo, "content")
		cell._txtTeamScore = goutil.findChildTextComponent(mainGo, "txtTeamScore")
		cell._tagWin = goutil.findChild(mainGo, "tagWin")
		cell._txtBattleTimes = goutil.findChildTextComponent(mainGo, "content/txtBattleTimes")
		cell._txtWinCount = goutil.findChildTextComponent(mainGo, "content/txtWinCount")
		cell._txtComboWin = goutil.findChildTextComponent(mainGo, "content/txtComboWin")
		cell._txtScoreInExt = goutil.findChildTextComponent(mainGo, "content/txtScoreInExt")
		cell._txtScoreInNor = goutil.findChildTextComponent(mainGo, "content/txtScoreInNor")
		cell._tagMyTeam = goutil.findChild(mainGo, "content/tagMyTeam")
		cell._btnBuff = goutil.findChild(mainGo, "content/tagMyTeam/btnBuff")
	end

	local winPrizeScrCell = self:getGo("prizeCol/win/scrCell")
	local winPrizeScrView = self:getGo("prizeCol/win/scrView")

	self._winPrizeScrollerList = ScrollerList.create(winPrizeScrView, winPrizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._winPrizeScrollerList:setCenterMode(true)

	local losePrizeScrCell = self:getGo("prizeCol/lose/scrCell")
	local losePrizeScrView = self:getGo("prizeCol/lose/scrView")

	self._losePrizeScrollerList = ScrollerList.create(losePrizeScrView, losePrizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._losePrizeScrollerList:setCenterMode(true)
end

function MagicContestMainView:bindEvents()
	MagicContestMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickFmt, self)
	GameUtil.addClickHandler(self._btnExtOne, GameUtil.handler(self._onClickBattle, self, MagicContestEnum.BatType_Ext), self)
	GameUtil.addClickHandler(self._btnNorOne, GameUtil.handler(self._onClickBattle, self, MagicContestEnum.BatType_Nor), self)
	GameUtil.addClickHandler(self._btnExtTwo, GameUtil.handler(self._onClickBattle, self, MagicContestEnum.BatType_Ext), self)
	GameUtil.addClickHandler(self._btnNorTwo, GameUtil.handler(self._onClickBattle, self, MagicContestEnum.BatType_Nor), self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
end

function MagicContestMainView:unbindEvents()
	MagicContestMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnExtOne)
	GameUtil.rmClickHandler(self._btnNorOne)
	GameUtil.rmClickHandler(self._btnExtTwo)
	GameUtil.rmClickHandler(self._btnNorTwo)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
end

function MagicContestMainView:onEnter()
	MagicContestMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MagicContestController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = MagicContestController.instance:getSubMo(self._activityId)
	self._actData = MagicContestConfig.instance:getActivityData(self._activityId)
	self._batType = BatType or MagicContestEnum.BatType_Nor

	self.addGEvent(self, GlobalNotify.HandlePM_MagicContestGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolJoinCampRes, self._handlePM_MagicSchoolJoinCampRes, self)
	self:_onSetUI()
	self:_onUpdate()

	local function successCallBack()
		MagicContestController.instance:sendPM_MagicContestGetInfoReq(self._activityId)
	end

	local failCallBack

	local function cancelCallBack()
		self:close()
	end

	MagicSchoolController.instance:canPlayAfterFinishChooseCamp(self._activityId, successCallBack, failCallBack, cancelCallBack)
end

function MagicContestMainView:onExit()
	MagicContestMainView.super.onExit(self)

	BatType = self._batType

	for k, cell in pairs(self._teamCells) do
		GameUtil.rmClickHandler(cell._btnBuff)
	end

	self:_onClearPrizeCol()
	self:_unregisterRedPoints()
end

function MagicContestMainView:_handlePM_MagicSchoolJoinCampRes()
	MagicContestController.instance:sendPM_MagicContestGetInfoReq(self._activityId)
end

function MagicContestMainView:_onSetUI()
	self:_registerRedPoints()

	local goldInfo = {
		showAdd = false,
		id = self._actData.goldItem
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	})

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdatePrizeCol()
end

function MagicContestMainView:_onUpdate()
	self._myCampId = self._subMo:getCampId()

	local lastTermWinCampId = self._subMo:getLastTermWinCampId()

	for idx, campId in ipairs(MagicContestEnum.CampIdList) do
		local cell = self._teamCells[campId]

		cell._txtTeamScore.text = MmUtil.formatNumberWithComma(self._subMo:getCampScores(campId))
		cell._txtBattleTimes.text = self._subMo:getTodayChallengeTimes()
		cell._txtWinCount.text = self._subMo:getTodayWinCount(self._batType)
		cell._txtComboWin.text = self._subMo:getTodayWinStreak(self._batType)
		cell._txtScoreInNor.text = self._subMo:getScorePair(MagicContestEnum.BatType_Nor)
		cell._txtScoreInExt.text = self._subMo:getScorePair(MagicContestEnum.BatType_Ext)

		GameUtil.SetActive(cell._tagMyTeam, campId == self._myCampId)
		GameUtil.SetActive(cell._content, campId == self._myCampId)
		GameUtil.SetActive(cell._tagWin, campId == lastTermWinCampId)
		GameUtil.addClickHandler(cell._btnBuff, function()
			UIStateManager.instance:push(ViewName.MagicContestBuffPreView, self._activityId)
		end)
	end

	local leftTimes = self._subMo:getLeftChallengeTimes()
	local maxTimes = self._subMo:getMaxChallengeTimes()

	self._txtTips.text = string.format(self._strTxtTips, leftTimes, maxTimes)

	self:_updateBtnBattleUI()
end

function MagicContestMainView:_registerRedPoints()
	for idx, redGo in ipairs(self._redBtnJumps) do
		local redField = self._redDataFields[idx]
		local redIdStr = self._actData[redField]

		if not goutil.isNil(redGo) and not string.nilorempty(redIdStr) then
			local redIdList = string.split(redIdStr, "#")
			local validRedIds = {}

			for _, redId in ipairs(redIdList) do
				if not string.nilorempty(redId) and checknumber(redId) ~= 0 then
					table.insert(validRedIds, redId)
				end
			end

			if #validRedIds > 0 then
				RedPointController.instance:regRedPoint(redGo, unpack(validRedIds))
			else
				RedPointController.instance:unregRedPoint(redGo)
			end
		end
	end
end

function MagicContestMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function MagicContestMainView:_onUpdatePrizeCol()
	local prize = self._actData.termWinPrize

	self._winPrizeScrollerList:reloadData((not string.nilorempty(prize) or nil) and string.split(prize, "#"))

	local losePrize = self._actData.termLosePrize

	self._losePrizeScrollerList:reloadData((not string.nilorempty(losePrize) or nil) and string.split(losePrize, "#"))
end

function MagicContestMainView:_onClearPrizeCol()
	self._winPrizeScrollerList:dispose()
	self._losePrizeScrollerList:dispose()
end

function MagicContestMainView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function MagicContestMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function MagicContestMainView:_onClickTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function MagicContestMainView:_onClickRank()
	MagicContestController.instance:openCommonTabRankView(self._activityId)
end

function MagicContestMainView:_onClickBattle(batType)
	self._batType = batType

	self:_onUpdate()

	local isInBattleTime = MagicContestController.instance:isInBattleTime(self._activityId)

	if not isInBattleTime then
		FloatWordMgr.instance:show("不在挑战时间内，请稍后再来")

		return
	end

	local simpleForm = self._subMo:getDefenseForms(self._batType)

	if simpleForm then
		UIStateManager.instance:push(ViewName.MagicContestMatchView, self._activityId, self._batType)
	else
		MagicContestController.instance:enterFormation(self._activityId, self._batType)
	end
end

function MagicContestMainView:_updateBtnBattleUI()
	GameUtil.SetActive(self._btnBattleOne, self._batType == MagicContestEnum.BatType_Ext)
	GameUtil.SetActive(self._btnBattleTwo, self._batType == MagicContestEnum.BatType_Nor)
end

function MagicContestMainView:_onClickFmt()
	MagicContestController.instance:enterFormation(self._activityId, self._batType)
end

function MagicContestMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

return MagicContestMainView
