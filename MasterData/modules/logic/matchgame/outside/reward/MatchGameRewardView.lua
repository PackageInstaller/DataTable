-- chunkname: @modules/logic/matchgame/outside/reward/MatchGameRewardView.lua

module("modules.logic.matchgame.outside.reward.MatchGameRewardView", package.seeall)

local MatchGameRewardView = class("MatchGameRewardView", BaseView)

function MatchGameRewardView:onInitView()
	self._txtScore = gohelper.findChildText(self.viewGO, "Bg/title/#txt_score")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goreward = gohelper.findChild(self.viewGO, "Bg/#go_reward")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Bg/#go_reward/#btn_reward")
	self._rectnormalline = self._gonormalline.transform
	self.startSpace = 22
	self.cellWidth = 268
	self.space = 39

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateBonusInfo, self.onGainReward, self)
end

function MatchGameRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function MatchGameRewardView:_btncloseOnClick()
	self:closeThis()
end

function MatchGameRewardView:onClickModalMask()
	self:_btncloseOnClick()
end

function MatchGameRewardView:_btnrewardOnClick()
	local skinId = MatchGameConfig.instance:getConstValue(self.actId, MatchGameEnum.ConstId.NormalRewardSkinId, true)

	if not skinId or skinId == 0 then
		return
	end

	CharacterController.instance:openCharacterSkinTipView({
		isShowHomeBtn = false,
		skinId = skinId
	})
end

function MatchGameRewardView:_editableInitView()
	self:initScrollView()
end

function MatchGameRewardView:onGainReward()
	self:refreshView()
end

function MatchGameRewardView:onOpen()
	self.actId = MatchGameModel.instance:getCurActId()
	self.rewardType = MatchGameEnum.RewardType.Normal
	self.rewardCoList = lua_activity244_star_reward.configDict[self.actId]

	self:refreshView()
end

function MatchGameRewardView:initScrollView()
	if self.scrollView then
		return
	end

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Left/progress/#scroll_view/Viewport/Content/#go_RewardItem"
	scrollParam1.cellClass = MatchGameRewardItem
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

function MatchGameRewardView:refreshView()
	self:refreshSkin()
	self:refreshReward()
	self:refreshScore()
	self:refreshProgress()
end

function MatchGameRewardView:refreshProgress()
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

function MatchGameRewardView:getRewardScore(rewardCo)
	if not rewardCo then
		return 0
	end

	return rewardCo.star or rewardCo.score
end

function MatchGameRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
end

function MatchGameRewardView:refreshReward()
	self.rewardListModel:setList(self.rewardCoList)
end

function MatchGameRewardView:refreshScore()
	self._curScore = MatchGameModel.instance:getCurRewardScore(self.rewardType)
	self._maxScore = MatchGameConfig.instance:getRewardTotalScore(self.actId, self.rewardType)
	self._txtScore.text = string.format("%s/%s", self._curScore, self._maxScore)
end

function MatchGameRewardView:refreshSkin()
	local skinId = MatchGameConfig.instance:getConstValue(self.actId, MatchGameEnum.ConstId.NormalRewardSkinId, true)
	local hasSkin = skinId and skinId ~= 0

	gohelper.setActive(self._goreward, hasSkin)
end

function MatchGameRewardView:onClose()
	return
end

function MatchGameRewardView:onDestroyView()
	return
end

return MatchGameRewardView
