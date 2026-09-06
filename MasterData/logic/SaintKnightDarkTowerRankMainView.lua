-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/saintknight/SaintKnightDarkTowerRankMainView.lua

module("logic.extensions.waterdraktower.view.saintknight.SaintKnightDarkTowerRankMainView", package.seeall)

local SaintKnightDarkTowerRankMainView = class("SaintKnightDarkTowerRankMainView", ViewComponent)

function SaintKnightDarkTowerRankMainView:buildUI()
	SaintKnightDarkTowerRankMainView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._btnDetail = goutil.findChild(self.mainGO, "btnDetail")
	self._btnChallenge = goutil.findChild(self.mainGO, "btnChallenge")
	self._btnChallengeRed = goutil.findChild(self.mainGO, "btnChallenge/redPoint")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function SaintKnightDarkTowerRankMainView:bindEvents()
	SaintKnightDarkTowerRankMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickBtnDetail, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function SaintKnightDarkTowerRankMainView:unbindEvents()
	SaintKnightDarkTowerRankMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SaintKnightDarkTowerRankMainView:onEnter()
	SaintKnightDarkTowerRankMainView.super.onEnter(self)
	WaterdraktowerConfig.instance:getOpenTowerActivityId()

	self._actType = WaterdraktowerModel.instance.openActType

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SaintKnightCard)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerGetRankInfo, self._handleInfoRes, self)
	self:_sendInfoReq()
end

function SaintKnightDarkTowerRankMainView:onExit()
	SaintKnightDarkTowerRankMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerGetRankInfo, self._handleInfoRes, self)
	RedPointController.instance:unregRedPoint(self._btnChallengeRed)
	self:_onClearRankCol()
end

function SaintKnightDarkTowerRankMainView:_sendInfoReq()
	WaterdraktowerController.instance:csGetWaterDarkTowerGetRankInfoReq()
end

function SaintKnightDarkTowerRankMainView:_handleInfoRes(rankInfos, myRank)
	self._rankInfos = rankInfos
	self._myRank = myRank

	self:_onUpdate()
end

function SaintKnightDarkTowerRankMainView:_onSetUI()
	RedPointController.instance:regRedPoint(self._btnChallengeRed, SaintKnightTaskConfig.instance:getSktWaterDarkDayRed())
end

function SaintKnightDarkTowerRankMainView:_onUpdate()
	self:_onUpdatePlaneUI()
	self:_onUpdateRankColUI()
end

function SaintKnightDarkTowerRankMainView:_onUpdatePlaneUI()
	return
end

function SaintKnightDarkTowerRankMainView:_onUpdateRankColData()
	return
end

function SaintKnightDarkTowerRankMainView:_onUpdateRankColUI()
	self._rankScrollList:reloadData(self._rankInfos)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #self._rankInfos <= 0)
end

function SaintKnightDarkTowerRankMainView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function SaintKnightDarkTowerRankMainView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtProgress.text = string.format("%s-%s", info.tier, info.stage)

	local timeStr = ""
	local timeSec = checknumber(info.submitTime)

	if timeSec > 0 then
		local timeDate = os.date("*t", timeSec / 1000)

		timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
	end

	txtTime.text = timeStr
end

function SaintKnightDarkTowerRankMainView:_clearRankCell(cell)
	return
end

function SaintKnightDarkTowerRankMainView:_onClickBtnDetail()
	UIStateManager.instance:push(ViewName.WLTowerRank)
end

function SaintKnightDarkTowerRankMainView:_onClickBtnChallenge()
	GotoMgr.gotoByString("func#301")
	SurveyController.instance:reportBehavior(201099)
end

return SaintKnightDarkTowerRankMainView
