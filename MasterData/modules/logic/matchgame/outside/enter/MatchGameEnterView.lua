-- chunkname: @modules/logic/matchgame/outside/enter/MatchGameEnterView.lua

module("modules.logic.matchgame.outside.enter.MatchGameEnterView", package.seeall)

local MatchGameEnterView = class("MatchGameEnterView", BaseView)

function MatchGameEnterView:onInitView()
	self._btnDevelop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_develop")
	self._btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_talent")
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_normal")
	self._btnChallenge = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_challenge")
	self._txtLevel = gohelper.findChildText(self.viewGO, "entrance/#btn_normal/normal/#txt_level")
	self._txtTime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._goNormalChallenge = gohelper.findChild(self.viewGO, "entrance/#btn_challenge/#go_normalchallenge")
	self._goChallengeScore = gohelper.findChild(self.viewGO, "entrance/#btn_challenge/#go_normalchallenge/#go_challengescore")
	self._txtScore = gohelper.findChildText(self.viewGO, "entrance/#btn_challenge/#go_normalchallenge/#go_challengescore/#txt_score")
	self._goLockChallenge = gohelper.findChild(self.viewGO, "entrance/#btn_challenge/#go_lockchallenge")
	self._goDevelopRedDot = gohelper.findChild(self.viewGO, "#btn_develop/#go_reddot")
	self._goTalentRedDot = gohelper.findChild(self.viewGO, "#btn_talent/#go_reddot")
	self._goNormalRedDot = gohelper.findChild(self.viewGO, "entrance/#btn_normal/#go_normalreddot")
	self._goChallengeRedDot = gohelper.findChild(self.viewGO, "entrance/#btn_challenge/#go_challegereddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameEnterView:addEvents()
	self._btnDevelop:AddClickListener(self._btnDevelopOnClick, self)
	self._btnTalent:AddClickListener(self._btnTalentOnClick, self)
	self._btnNormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnChallenge:AddClickListener(self._btnChallengeOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateEpisodeInfo, self._onUpdateEpisodeInfo, self)
end

function MatchGameEnterView:removeEvents()
	self._btnDevelop:RemoveClickListener()
	self._btnTalent:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function MatchGameEnterView:_btnDevelopOnClick()
	if self:checkIsActOpen() then
		MatchGameController.instance:openCharacterView(MatchGameEnum.CharacterTabType.Develop)
		MatchGameStatHelper.instance:statEntryClick(self.viewName, MatchGameEnum.StatClickType.Develop)
	end
end

function MatchGameEnterView:_btnTalentOnClick()
	if self:checkIsActOpen() then
		MatchGameController.instance:openCharacterView(MatchGameEnum.CharacterTabType.Talent)
		MatchGameStatHelper.instance:statEntryClick(self.viewName, MatchGameEnum.StatClickType.Talent)
	end
end

function MatchGameEnterView:_btnNormalOnClick()
	if self:checkIsActOpen() then
		MatchGameController.instance:enterMap(MatchGameEnum.LevelType.Normal)
		MatchGameStatHelper.instance:statEntryClick(self.viewName, MatchGameEnum.StatClickType.Normal)
	end
end

function MatchGameEnterView:_btnChallengeOnClick()
	if self:checkIsActOpen() then
		local unlock, toastId, toastParam = MatchGameModel.instance:isChallengeUnlock()

		if not unlock then
			if toastId then
				GameFacade.showToast(toastId, toastParam)
			end

			return
		end

		MatchGameController.instance:enterMap(MatchGameEnum.LevelType.Challenge)
		MatchGameStatHelper.instance:statEntryClick(self.viewName, MatchGameEnum.StatClickType.Challenge)
	end
end

function MatchGameEnterView:checkIsActOpen()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	return true
end

function MatchGameEnterView:_editableInitView()
	RedDotController.instance:addRedDot(self._goDevelopRedDot, RedDotEnum.DotNode.MatchGameCharacterEntry)
	RedDotController.instance:addRedDot(self._goTalentRedDot, RedDotEnum.DotNode.MatchGameTalentEntry)
	RedDotController.instance:addRedDot(self._goNormalRedDot, RedDotEnum.DotNode.MatchGameNormalLevelEntry)
	RedDotController.instance:addRedDot(self._goChallengeRedDot, RedDotEnum.DotNode.MatchGameChallengeLevelEntry)
end

function MatchGameEnterView:onOpen()
	self._actId = MatchGameModel.instance:getCurActId()

	MatchGameLevelModel.instance:initMapType()
	self:refreshUI()
end

function MatchGameEnterView:refreshUI()
	self:refreshNormalEntry()
	self:refreshChallengeEntry()
	self:tickRefresh()
end

function MatchGameEnterView:refreshNormalEntry()
	local maxUnlockEpisodeId = MatchGameModel.instance:getMaxUnlockEpisodeId()
	local maxUnlockEpisodeCo = lua_activity244_episode.configDict[maxUnlockEpisodeId]

	self._txtLevel.text = maxUnlockEpisodeCo and maxUnlockEpisodeCo.levelName
end

function MatchGameEnterView:refreshChallengeEntry()
	local isChallengeUnlock = MatchGameModel.instance:isChallengeUnlock()

	gohelper.setActive(self._goLockChallenge, not isChallengeUnlock)
	gohelper.setActive(self._goNormalChallenge, isChallengeUnlock)

	if not isChallengeUnlock then
		return
	end

	local curScore = MatchGameModel.instance:getCurRewardScore(MatchGameEnum.RewardType.Challenge)
	local hasScore = curScore and curScore > 0

	gohelper.setActive(self._goChallengeScore, hasScore)

	if not hasScore then
		return
	end

	self._txtScore.text = curScore
end

function MatchGameEnterView:tickRefresh()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runDelay(self.refreshRemainTime, self, 30)
end

function MatchGameEnterView:refreshRemainTime()
	self._txtTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function MatchGameEnterView:_onUpdateEpisodeInfo()
	self:refreshUI()
end

function MatchGameEnterView:onClose()
	MatchGameController.instance:clearResultFlow()
end

function MatchGameEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return MatchGameEnterView
