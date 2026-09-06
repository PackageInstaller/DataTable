-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter2View.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter2View", package.seeall)

local DreamTeamChapter2View = class("DreamTeamChapter2View", ViewComponent)

DreamTeamChapter2View.MM_NUM = 6

function DreamTeamChapter2View:ctor()
	DreamTeamChapter2View.super.ctor(self)
end

function DreamTeamChapter2View:unbindEvents()
	DreamTeamChapter2View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnOneKeyAwake)
end

function DreamTeamChapter2View:bindEvents()
	DreamTeamChapter2View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnOneKeyAwake, self._onClickBtnOneKeyAwake, self)
end

function DreamTeamChapter2View:buildUI()
	DreamTeamChapter2View.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnOneKeyAwake = self:getGo("btnOneKeyAwake")
	self._imgRedPointOneKeyAwake = self:getGo("btnOneKeyAwake/imgRedPoint")
	self._clgGoList = {}
	self._redPointGoList = {}

	for i = 1, DreamTeamChapter2View.MM_NUM do
		local clg = self:getGo("clg" .. i)
		local rdGo = self:getGo("clg" .. i .. "/imgRedPoint")

		table.insert(self._clgGoList, clg)
		table.insert(self._redPointGoList, rdGo)
	end

	self._geted = self:getGo("reward/geted")
	self._btnReward = self:getGo("reward/btnReward")
	self._imgReward = self:getGo("reward/imgReward")
	self._txtNum = self:getTxt("reward/num/txtNum")
end

function DreamTeamChapter2View:onExit()
	DreamTeamChapter2View.super.onExit(self)
	MaterialMgr.clearIcon(self._imgReward)

	for i, clgGo in ipairs(self._clgGoList) do
		local btnAwake = goutil.findChild(clgGo, "btnAwake")

		GameUtil.rmClickHandler(btnAwake)
	end
end

function DreamTeamChapter2View:onEnter()
	DreamTeamChapter2View.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterAwakenMengMengRes, self._onAwakeRes, self)
	self.addGEvent(self, GlobalNotify.EndStory, self._tryShowChangeSetId, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId) or {}
	self._awakeMMCfgs = DreamTeamChapterConfig.instance:getAwakeMMCfgs(self._activityId) or {}
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId) or {}
	self._hasAwakenMengMeng = checkbool(self._info.hasAwakenMengMeng)

	local storyId = self._actCfg.chap2StoryId

	if checknumber(storyId) > 0 then
		local key = string.format("DreamTeamChapter2View%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_onSetUI()
	self:_onUpdate()
end

function DreamTeamChapter2View:_onSetUI()
	local isAllAwake = self._hasAwakenMengMeng
	local matStr = self._actCfg.awakenMengMengPrize
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	self._txtNum.text = matNum

	MaterialMgr.setIcon(self._imgReward, matType, matId, nil, nil)

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	for id, clgGo in ipairs(self._clgGoList) do
		local btnAwake = goutil.findChild(clgGo, "btnAwake")
		local txtAwake = goutil.findChildTextComponent(clgGo, "img/txtAwake")
		local awakeMMCfg = DreamTeamChapterConfig.instance:getAwakeMMCfgById(self._activityId, id)

		if awakeMMCfg then
			local awakenCost = awakeMMCfg.awakenCost
			local matType, matId, matNum = MaterialMgr.getMatParams(awakenCost)
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			txtAwake.text = string.format(lang("唤醒：%s/%s"), hasNum, matNum)
		end

		if self._hasAwakenMengMeng then
			txtAwake.text = "已唤醒"
		end

		GameUtil.SetActive(btnAwake, not isAllAwake)
		GameUtil.addClickHandler(btnAwake, function()
			local chapterCfg = DreamTeamChapterConfig.instance:getChapterCfg(self._activityId, 2)
			local openTime = chapterCfg and chapterCfg.openTime

			if openTime then
				local openTimeStamp = GameUtil.string2time(openTime)

				if openTimeStamp > ServerTime.now() then
					local timeStr = GameUtil.formatTimeStamp("%Y-%m-%d %H: %M:%S", openTimeStamp)

					FloatWordMgr.instance:show(lang("%s后可挑战"), timeStr)

					return
				end
			end

			if awakeMMCfg then
				UIStateManager.instance:push(awakeMMCfg.jumpViewName, self._activityId, id)
			end
		end, self)
	end

	GameUtil.SetActive(self._geted, isAllAwake)
end

function DreamTeamChapter2View:_onUpdate()
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId)
	self._hasAwakenMengMeng = checkbool(self._info.hasAwakenMengMeng)

	local isAllAwake = self._hasAwakenMengMeng

	GameUtil.SetActive(self._geted, isAllAwake)

	for i, clgGo in ipairs(self._clgGoList) do
		local btnAwake = goutil.findChild(clgGo, "btnAwake")
		local txtBtnAwake = goutil.findChildTextComponent(clgGo, "btnAwake/txt")
		local awakeMMCfg = DreamTeamChapterConfig.instance:getAwakeMMCfgById(self._activityId, i)
		local canAwake = false

		if awakeMMCfg then
			local awakenCost = awakeMMCfg.awakenCost
			local matType, matId, matNum = MaterialMgr.getMatParams(awakenCost)
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			canAwake = matNum <= hasNum
		end

		GameUtil.SetActive(btnAwake, not isAllAwake)
	end

	self:_updateRedPoint()
end

function DreamTeamChapter2View:_onClickBtnTip()
	local key = self._actCfg.ruleKeyChap2

	TipsFacade.instance:openRulesView(key)
end

function DreamTeamChapter2View:_onClickBtnReward()
	local matStr = self._actCfg.awakenMengMengPrize

	TipsFacade.instance:openItemSourceView(matStr)
end

function DreamTeamChapter2View:_onClickBtnOneKeyAwake()
	local canAllAwake = DreamTeamChapterController.instance:canAwakeAllMM(self._activityId)

	if self._hasAwakenMengMeng then
		FloatWordMgr.instance:show(lang("已全部唤醒，无需重复唤醒"))

		return
	end

	if not canAllAwake then
		FloatWordMgr.instance:show(lang("还有部分梦梦的唤醒道具未集齐，先去集齐吧"))

		return
	end

	DreamTeamChapterController.instance:sendPM_DreamTeamChapterAwakenMengMengReq(self._activityId)
end

function DreamTeamChapter2View:_updateRedPoint()
	local chap2OpenCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_TWO_OPEN)
	local kingMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_KING_MM_DAY_CLICK)
	local darkMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_DARK_MM_DAY_CLICK)
	local hotMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_HOT_MM_DAY_CLICK)
	local duoLaMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_DUOLA_MM_DAY_CLICK)
	local alchemyMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_DAY_CLICK)
	local loveMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_LOVE_MM_DAY_CLICK)
	local alchemyMMPrizeCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_CAN_GET_PRIZE)
	local oneKeyAwakeAllMMCanActive = DreamTeamChapterController.instance:checkRedPointActive(self._activityId, RedPointModel.ID_DREAM_TEAM_CHAP_AWAKE_ALL_MM)

	GameUtil.SetActive(self._redPointGoList[DreamTeamChapterController.awakeMMId.KingMM], kingMMCanActive)
	GameUtil.SetActive(self._redPointGoList[DreamTeamChapterController.awakeMMId.DarkMM], darkMMCanActive)
	GameUtil.SetActive(self._redPointGoList[DreamTeamChapterController.awakeMMId.HotMM], hotMMCanActive)
	GameUtil.SetActive(self._redPointGoList[DreamTeamChapterController.awakeMMId.DuoLaMM], duoLaMMCanActive)
	GameUtil.SetActive(self._redPointGoList[DreamTeamChapterController.awakeMMId.AlchemyMM], alchemyMMCanActive or alchemyMMPrizeCanActive)
	GameUtil.SetActive(self._redPointGoList[DreamTeamChapterController.awakeMMId.LoveMM], loveMMCanActive)
	GameUtil.SetActive(self._imgRedPointOneKeyAwake, oneKeyAwakeAllMMCanActive)
end

function DreamTeamChapter2View:_tryShowChangeSetId()
	local changeSetId = DreamTeamChapterModel.instance:popChangeSetList()

	if checknumber(changeSetId) > 0 then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function DreamTeamChapter2View:_onAwakeRes()
	FloatWordMgr.instance:show(lang("唤醒成功！"))
	self:_onUpdate()
	self:_tryPlayEndStory()
end

function DreamTeamChapter2View:_tryPlayEndStory()
	local hasAwakeAll = checkbool(self._info.hasAwakenMengMeng)

	if hasAwakeAll then
		local storyId = self._actCfg.chap2EndStoryId

		if checknumber(storyId) > 0 then
			local key = string.format("DreamTeamChapter2View_end_%s", self._activityId)

			local function firstCallback()
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			end

			GameUtil.doCallbackWhenFirst(key, firstCallback)
		end
	end
end

function DreamTeamChapter2View:_saveCurRedPointState(mmId)
	local key = ""

	if mmId == DreamTeamChapterController.awakeMMId.KingMM then
		key = string.format(DreamTeamChapterController.KING_MM_DAY_KEY, self._activityId)
	elseif mmId == DreamTeamChapterController.awakeMMId.DarkMM then
		key = string.format(DreamTeamChapterController.DARK_MM_DAY_KEY, self._activityId)
	elseif mmId == DreamTeamChapterController.awakeMMId.HotMM then
		key = string.format(DreamTeamChapterController.HOT_MM_DAY_KEY, self._activityId)
	elseif mmId == DreamTeamChapterController.awakeMMId.DuoLaMM then
		key = string.format(DreamTeamChapterController.DUOLA_MM_DAY_KEY, self._activityId)
	elseif mmId == DreamTeamChapterController.awakeMMId.AlchemyMM then
		key = string.format(DreamTeamChapterController.ALCHEMY_MM_DAY_KEY, self._activityId)
	elseif mmId == DreamTeamChapterController.awakeMMId.LoveMM then
		key = string.format(DreamTeamChapterController.LOVE_MM_DAY_KEY, self._activityId)
	end

	GameUtil.saveUserDayData(key, true)
end

return DreamTeamChapter2View
