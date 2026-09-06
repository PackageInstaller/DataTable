-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterSummaryView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterSummaryView", package.seeall)

local DreamTeamChapterSummaryView = class("DreamTeamChapterSummaryView", ViewComponent)

DreamTeamChapterSummaryView.CHAPTER_NUM = 3

function DreamTeamChapterSummaryView:ctor()
	DreamTeamChapterSummaryView.super.ctor(self)
end

function DreamTeamChapterSummaryView:unbindEvents()
	DreamTeamChapterSummaryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
end

function DreamTeamChapterSummaryView:bindEvents()
	DreamTeamChapterSummaryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChapter1, GameUtil.handler(self._onClickBtnChapter, self, 1))
	GameUtil.addClickHandler(self._btnChapter2, GameUtil.handler(self._onClickBtnChapter, self, 2))
	GameUtil.addClickHandler(self._btnChapter3, GameUtil.handler(self._onClickBtnChapter, self, 3))
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
end

function DreamTeamChapterSummaryView:buildUI()
	DreamTeamChapterSummaryView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._imgRedPoint1 = self:getGo("btnChapter1/imgRedPoint")
	self._imgRedPoint2 = self:getGo("btnChapter2/imgRedPoint")
	self._imgRedPoint3 = self:getGo("btnChapter3/imgRedPoint")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnChapter1 = self:getGo("btnChapter1")
	self._btnChapter2 = self:getGo("btnChapter2")
	self._btnChapter3 = self:getGo("btnChapter3")
	self._timeGoList = {}
	self._txtTimeList = {}
	self._txtNameList = {}

	for i = 1, DreamTeamChapterSummaryView.CHAPTER_NUM do
		local timeGo = self:getGo("btnChapter" .. i .. "/time")
		local txtTime = self:getTxt("btnChapter" .. i .. "/time/txtTime")
		local txtName = self:getTxt("btnChapter" .. i .. "/txtName")

		table.insert(self._timeGoList, timeGo)
		table.insert(self._txtTimeList, txtTime)
		table.insert(self._txtNameList, txtName)
	end
end

function DreamTeamChapterSummaryView:onExit()
	DreamTeamChapterSummaryView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._imgRedPoint1)
end

function DreamTeamChapterSummaryView:onEnter()
	DreamTeamChapterSummaryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterFirstClickRes, self._onFirstClickRes, self)
	self.addGEvent(self, GlobalNotify.AfterRedPointUpdate, self._updateRedPoint, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)

	self:_onSetUI()

	local storyId = self._actCfg.chap1StoryId

	if checknumber(storyId) > 0 then
		local key = string.format("DreamTeamChapterSummaryView%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	RedPointController.instance:regRedPoint(self._imgRedPoint1, 474)
	DreamTeamChapterController.instance:sendPM_DreamTeamChapterGetInfoReq(self._activityId)
end

function DreamTeamChapterSummaryView:_onSetUI()
	local chapterCfgs = DreamTeamChapterConfig.instance:getChapterCfgs(self._activityId)
	local curTime = ServerTime.now()

	for i, cfg in ipairs(chapterCfgs) do
		local openTime = cfg.openTime
		local openTimeStamp = GameUtil.string2time(openTime)
		local timeGo = self._timeGoList[i]
		local txtTime = self._txtTimeList[i]
		local txtName = self._txtNameList[i]

		txtTime.text = GameUtil.formatTimeStamp(lang("%m.%d %H:%M后开启"), openTimeStamp)
		txtName.text = cfg.chapterName

		GameUtil.SetActive(timeGo, curTime <= openTimeStamp)
	end
end

function DreamTeamChapterSummaryView:_onUpdate()
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId)
	self._chapterMap = DreamTeamChapterModel.instance:gethasClickChapterMap(self._activityId)

	self:_updateRedPoint()
end

function DreamTeamChapterSummaryView:_updateRedPoint()
	self._progressIdWorld = 1
	self._progressWorldActCfg = WorldProgressPrizeConfig.instance:getActData(self._activityId) or {}

	if checknumber(self._progressWorldActCfg.redPointId) > 0 then
		self._progressWorldRedPointId = self._progressWorldActCfg.redPointId or 738
	end

	local chap2OpenCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_TWO_OPEN)
	local kingMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_KING_MM_DAY_CLICK)
	local darkMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_DARK_MM_DAY_CLICK)
	local hotMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_HOT_MM_DAY_CLICK)
	local duoLaMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_DUOLA_MM_DAY_CLICK)
	local alchemyMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_DAY_CLICK)
	local loveMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_LOVE_MM_DAY_CLICK)
	local alchemyMMPrizeCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_CAN_GET_PRIZE)
	local allMMoneKeyAwakeCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_AWAKE_ALL_MM)
	local chap3OpenCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_THREE_OPEN)
	local chap3PrizeCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_THREE_CAN_REWARD)

	GameUtil.SetActive(self._imgRedPoint2, chap2OpenCanActive or kingMMCanActive or darkMMCanActive or hotMMCanActive or duoLaMMCanActive or alchemyMMCanActive or loveMMCanActive or alchemyMMPrizeCanActive or allMMoneKeyAwakeCanActive)
	GameUtil.SetActive(self._imgRedPoint3, chap3OpenCanActive or chap3PrizeCanActive or RedPointModel.instance:isActive(self._progressWorldRedPointId))
end

function DreamTeamChapterSummaryView:_onClickBtnJump(jumpIdx)
	if jumpIdx == 1 then
		UIStateManager.instance:push(ViewName.DreamTeamChapter3RankView, self._activityId)
	else
		local jumpStr = self._actCfg["jumpTo" .. jumpIdx]

		GotoMgr.gotoByString(jumpStr)
	end
end

function DreamTeamChapterSummaryView:_onClickBtnChapter(chapIdx)
	if self._info == nil then
		FloatWordMgr.instance:show(lang("数据同步中，请稍候"))

		return
	end

	local cfg = DreamTeamChapterConfig.instance:getChapterCfg(self._activityId, chapIdx)
	local openTime = cfg.openTime
	local openTimeStamp = GameUtil.string2time(openTime)
	local timeStr = GameUtil.formatTimeStamp("%m.%d %H:%M", openTimeStamp)

	if openTimeStamp > ServerTime.now() then
		FloatWordMgr.instance:show(string.format(lang("尚未到达开启时间，请在%s后进入"), timeStr))

		return
	end

	if self._chapterMap then
		if chapIdx == 1 and true or checkbool(self._chapterMap[chapIdx - 1]) then
			if cfg then
				local viewName = cfg.jumpViewName

				if not self._chapterMap[chapIdx] then
					DreamTeamChapterController.instance:sendPM_DreamTeamChapterFirstClickReq(self._activityId, chapIdx)
				elseif chapIdx == 1 then
					UIStateManager.instance:push(viewName, self._actCfg.chap1ActId, 1, self._activityId)
				else
					UIStateManager.instance:push(viewName, self._activityId)
				end
			end
		else
			FloatWordMgr.instance:show(lang("点击上一章后，才可进入"))

			return
		end
	end
end

function DreamTeamChapterSummaryView:_onFirstClickRes(chapIdx)
	local cfg = DreamTeamChapterConfig.instance:getChapterCfg(self._activityId, chapIdx)
	local viewName = cfg.jumpViewName

	if chapIdx == 1 then
		UIStateManager.instance:push(viewName, self._actCfg.chap1ActId, 1, self._activityId)
	else
		UIStateManager.instance:push(viewName, self._activityId)
	end
end

function DreamTeamChapterSummaryView:_onClickBtnTip()
	local key = self._actCfg.ruleKeySummary

	TipsFacade.instance:openRulesView(key)
end

return DreamTeamChapterSummaryView
