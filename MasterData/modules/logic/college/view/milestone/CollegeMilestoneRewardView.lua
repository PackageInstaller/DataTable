-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneRewardView.lua

module("modules.logic.college.view.milestone.CollegeMilestoneRewardView", package.seeall)

local CollegeMilestoneRewardView = class("CollegeMilestoneRewardView", BaseView)
local FirstStageWidth = 100
local StageItemWidth = 275
local StageItemHeight = 180

function CollegeMilestoneRewardView:onInitView()
	self._goProgress = gohelper.findChild(self.viewGO, "root/Progress")
	self._goBonusNode = gohelper.findChild(self.viewGO, "root/Progress/#go_bonusNode")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "root/Progress/#btn_Reward")
	self._txtProgress = gohelper.findChildTextMesh(self.viewGO, "root/Progress/#btn_Reward/numbg/#txt_progress")
	self._btnCloseReward = gohelper.findChildButtonWithAudio(self.viewGO, "root/Progress/#go_bonusNode/#btn_CloseReward")
	self._goScrollReward = gohelper.findChild(self.viewGO, "root/Progress/#go_bonusNode/#scroll_reward")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/Progress/#go_bonusNode/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._goNormalLine = gohelper.findChild(self.viewGO, "root/Progress/#go_bonusNode/#scroll_reward/Viewport/#go_content/#go_normalline")
	self._goContent = gohelper.findChild(self.viewGO, "root/Progress/#go_bonusNode/#scroll_reward/Viewport/#go_content")
	self._goRewardRedDot = gohelper.findChild(self.viewGO, "root/Progress/#btn_Reward/#go_RewardReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeMilestoneRewardView:addEvents()
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnCloseReward:AddClickListener(self._btnCloseRewardOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateMilestoneInfo, self.refreshAll, self)
end

function CollegeMilestoneRewardView:removeEvents()
	self._btnReward:RemoveClickListener()
	self._btnCloseReward:RemoveClickListener()
end

function CollegeMilestoneRewardView:_btnRewardOnClick()
	self:setContainerVisible(not self._isVisible)
end

function CollegeMilestoneRewardView:_btnCloseRewardOnClick()
	self:setContainerVisible(false)
end

function CollegeMilestoneRewardView:_onCloseView(viewName)
	if viewName == ViewName.CommonPropView and self._waitRefresh then
		self:refreshAll()
	end
end

function CollegeMilestoneRewardView:_editableInitView()
	self._tranNormalLine = self._goNormalLine.transform
	self._tranContent = self._goContent.transform
	self._tranNormalLine.anchorMin = Vector2(0, 0.5)
	self._tranNormalLine.anchorMax = Vector2(0, 0.5)

	RedDotController.instance:addRedDot(self._goRewardRedDot, RedDotEnum.DotNode.CollegeMileStoneReward)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self._goProgress)
	self._bonusCanvasGroup = gohelper.onceAddComponent(self._goBonusNode, gohelper.Type_CanvasGroup)

	self:initData()

	local hasReward = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CollegeMileStoneReward, 0)

	self:setContainerVisible(hasReward)
end

function CollegeMilestoneRewardView:onOpen()
	self:refreshAll()
end

function CollegeMilestoneRewardView:refreshAll()
	self._waitRefresh = false

	self:refreshEntry()

	if not self._isVisible then
		return
	end

	self:refreshList()
end

function CollegeMilestoneRewardView:initData()
	self._mileStoneBox = CollegeModel.instance:getSceneMo().milestoneBox
	self._rewardCoList = tabletool.copy(lua_college_reward.configList)

	SortUtil.tableKeyLower(self._rewardCoList, {
		"score",
		"id"
	})

	self._maxScore = self._rewardCoList[#self._rewardCoList].score
end

function CollegeMilestoneRewardView:refreshEntry()
	self._txtProgress.text = string.format("<#E2A14D>%s</color>/%s", self._mileStoneBox.score, self._maxScore)
end

function CollegeMilestoneRewardView:refreshList()
	if not self._rewardListComp then
		local listParam = SimpleListParam.New()

		listParam.cellClass = CollegeMilestoneRewardItem
		listParam.lineCount = 1
		listParam.cellWidth = StageItemWidth
		listParam.cellHeight = StageItemHeight
		listParam.startSpace = FirstStageWidth
		listParam.scrollDir = ScrollEnum.ScrollDirH

		local scrollParam = {
			listParam = listParam,
			viewContainer = self.viewContainer
		}

		self._rewardListComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goScrollReward, SimpleListComp, scrollParam)

		self._rewardListComp:setRes(self._goRewardItem)
		self._rewardListComp:onCreate()
	end

	self._rewardListComp:setData(self._rewardCoList)
	TaskDispatcher.cancelTask(self.refreshLine, self)
	TaskDispatcher.runDelay(self.refreshLine, self, 0.01)
end

function CollegeMilestoneRewardView:refreshLine()
	local _, finishStageNum, curStageProgress = self:calcCurTotalProgress()
	local finishStageWidth = self:getStageItemPosX(finishStageNum)

	if curStageProgress > 0 then
		local nextStageWidth = self:getStageItemWidth(finishStageNum + 1)

		finishStageWidth = finishStageWidth + nextStageWidth * curStageProgress
	end

	self:setLineWidth(finishStageWidth)

	if not self._isFirstEnter then
		self._isFirstEnter = true

		self:moveToDefaultPos()
	end
end

function CollegeMilestoneRewardView:setLineWidth(width)
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")

	if self._lineWith and self._lineWith ~= width then
		self._lineWith = width
		self._moveTweenId = ZProj.TweenHelper.DOWidth(self._tranNormalLine, width, 2)
	else
		self._lineWith = width

		recthelper.setWidth(self._tranNormalLine, width)
	end
end

function CollegeMilestoneRewardView:calcCurTotalProgress()
	local totalProgress = 0
	local curScore = self._mileStoneBox.score
	local lastScore = 0

	for _, v in ipairs(self._rewardCoList) do
		local score = v.score

		if curScore < score then
			totalProgress = totalProgress + (curScore - lastScore) / (score - lastScore)

			break
		end

		totalProgress = totalProgress + 1
		lastScore = score
	end

	local finishStageNum = math.floor(totalProgress)
	local curStageProgress = totalProgress - finishStageNum

	return totalProgress, finishStageNum, curStageProgress
end

function CollegeMilestoneRewardView:getStageItemPosX(index)
	if index <= 0 then
		return 0
	end

	return FirstStageWidth + (index - 1) * StageItemWidth
end

function CollegeMilestoneRewardView:getStageItemWidth(index)
	local lastItemPosX = self:getStageItemPosX(index - 1)
	local curItemPosX = self:getStageItemPosX(index)

	return curItemPosX - lastItemPosX
end

function CollegeMilestoneRewardView:moveToDefaultPos()
	local focusIndex = 1

	for i, config in ipairs(self._rewardCoList) do
		local status = self._mileStoneBox:getRewardStatus(config.id)

		if status ~= CollegeEnum.RewardStatus.Hasget then
			focusIndex = i

			break
		end
	end

	self:moveToTargetIndex(focusIndex)
end

function CollegeMilestoneRewardView:moveToTargetIndex(index)
	if not index or index <= 0 then
		return
	end

	self._rewardListComp:moveTo(index)
end

function CollegeMilestoneRewardView:setContainerVisible(isVisible)
	if self._isVisible == isVisible then
		return
	end

	self._isVisible = isVisible

	self:refreshAll()

	local animName = self._isVisible and "open" or "close"

	GameUtil.setActiveUIBlock("CollegeMilestoneRewardView", true, false)
	self._animatorPlayer:Play(animName, self._onPlayAnimDone, self)
end

function CollegeMilestoneRewardView:_onPlayAnimDone()
	self._bonusCanvasGroup.blocksRaycasts = self._isVisible

	GameUtil.setActiveUIBlock("CollegeMilestoneRewardView", false, true)
end

function CollegeMilestoneRewardView:onClose()
	GameUtil.setActiveUIBlock("CollegeMilestoneRewardView", false, true)
end

function CollegeMilestoneRewardView:onDestroyView()
	self._rewardListComp = nil

	TaskDispatcher.cancelTask(self.refreshLine, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")
end

return CollegeMilestoneRewardView
