-- chunkname: @modules/logic/matchgame/outside/reward/MatchGameChallengeRewardView.lua

module("modules.logic.matchgame.outside.reward.MatchGameChallengeRewardView", package.seeall)

local MatchGameChallengeRewardView = class("MatchGameChallengeRewardView", BaseView)

function MatchGameChallengeRewardView:onInitView()
	self._txtScore = gohelper.findChildText(self.viewGO, "Bg/title/#txt_score")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._rectnormalline = self._gonormalline.transform
	self.startSpace = 22
	self.cellWidth = 268
	self.space = 39

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameChallengeRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateBonusInfo, self.onGainReward, self)
end

function MatchGameChallengeRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function MatchGameChallengeRewardView:_btncloseOnClick()
	self:closeThis()
end

function MatchGameChallengeRewardView:onClickModalMask()
	self:_btncloseOnClick()
end

function MatchGameChallengeRewardView:_editableInitView()
	self:initScrollView()
end

function MatchGameChallengeRewardView:onGainReward()
	self:refreshView()
end

function MatchGameChallengeRewardView:onOpen()
	self.actId = MatchGameModel.instance:getCurActId()
	self.rewardType = MatchGameEnum.RewardType.Challenge
	self.rewardCoList = lua_activity244_challenge_reward.configDict[self.actId]

	self:refreshView()
end

function MatchGameChallengeRewardView:initScrollView()
	if self.scrollView then
		return
	end

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Left/progress/#scroll_view/Viewport/Content/#go_RewardItem"
	scrollParam1.cellClass = MatchGameChallengeRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = self.cellWidth
	scrollParam1.cellHeight = 700
	scrollParam1.cellSpaceH = self.space
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = self.startSpace
	self.rewardListModel = ListScrollModel.New()
	self.scrollView = LuaListScrollViewWithAnimator.New(self.rewardListModel, scrollParam1)

	self:addChildView(self.scrollView)
end

function MatchGameChallengeRewardView:refreshScrollView()
	return
end

function MatchGameChallengeRewardView:refreshView()
	self:refreshReward()
	self:refreshScore()
	self:refreshProgress()
end

function MatchGameChallengeRewardView:refreshProgress()
	local moList = self.rewardListModel:getList()
	local curIndex = #moList
	local curShowIndex

	for i, mo in ipairs(moList) do
		local status = MatchGameModel.instance:getRewardStatus(self.rewardType, mo)

		if curShowIndex == nil and status == MatchGameEnum.RewardItemStatus.CanGet or status == MatchGameEnum.RewardItemStatus.Gained then
			curShowIndex = i
		end

		if self:getRewardScore(mo) > self._curScore then
			curIndex = i - 1

			break
		end
	end

	local curScore = self:getRewardScore(moList[curIndex])
	local nextScore = self:getRewardScore(moList[curIndex + 1]) or curScore
	local beginPos = 0
	local nodeWidth = self:getNodeWidth(curIndex, beginPos)
	local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth

	recthelper.setWidth(self._rectnormalline, nodeWidth + ((curScore < nextScore or nil) and (self._curScore - curScore) / (nextScore - curScore) * offsetWidth))

	if not self.isPlayMove then
		self.isPlayMove = true

		if curShowIndex ~= nil then
			self.scrollView:moveToByIndex(curShowIndex, 0.2)
		end
	end
end

function MatchGameChallengeRewardView:getRewardScore(rewardCo)
	if not rewardCo then
		return 0
	end

	return rewardCo.star or rewardCo.score
end

function MatchGameChallengeRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
end

function MatchGameChallengeRewardView:refreshReward()
	self.rewardListModel:setList(self.rewardCoList)
end

function MatchGameChallengeRewardView:refreshScore()
	self._curScore = MatchGameModel.instance:getCurRewardScore(self.rewardType)
	self._txtScore.text = self._curScore
end

function MatchGameChallengeRewardView:onClose()
	return
end

function MatchGameChallengeRewardView:onDestroyView()
	return
end

return MatchGameChallengeRewardView
