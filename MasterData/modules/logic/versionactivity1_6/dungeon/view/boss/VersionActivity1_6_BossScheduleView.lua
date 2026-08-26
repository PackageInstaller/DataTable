-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6_BossScheduleView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleView", package.seeall)

local VersionActivity1_6_BossScheduleView = class("VersionActivity1_6_BossScheduleView", BaseView)
local kOpenTweenSecond = 1.5
local OpenTweenEnum = {
	Content = 2,
	ProgressBar = 1
}

function VersionActivity1_6_BossScheduleView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_Reward")
	self._goContent = gohelper.findChild(self.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	self._goGrayLine = gohelper.findChild(self.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	self._goNormalLine = gohelper.findChild(self.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	self._txtProgress = gohelper.findChildText(self.viewGO, "Root/ProgressTip/#txt_Progress")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self._txtbestProgress = gohelper.findChildText(self.viewGO, "Root/#txt_Progress")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6_BossScheduleView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function VersionActivity1_6_BossScheduleView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function VersionActivity1_6_BossScheduleView:_btnCloseOnClick()
	self:closeThis()
end

function VersionActivity1_6_BossScheduleView:onClickModalMask()
	self:closeThis()
end

function VersionActivity1_6_BossScheduleView:_editableInitView()
	self._scrollRewardGo = self._scrollReward.gameObject
	self._goGraylineTran = self._goGrayLine.transform
	self._goNormallineTran = self._goNormalLine.transform
	self._goContentTran = self._goContent.transform
	self._rectViewPortTran = gohelper.findChild(self._scrollRewardGo, "Viewport").transform
	self._hLayoutGroup = self._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._goGraylinePosX = recthelper.getAnchorX(self._goGraylineTran)

	self._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollRewardGo)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollRewardGo, DungeonMapEpisodeAudio, self._scrollReward)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollRewardGo)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)
	self._scrollReward:AddOnValueChanged(self._onScrollChange, self)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(self._goContentTran, 0)

	self._listStaticData = {}
end

function VersionActivity1_6_BossScheduleView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function VersionActivity1_6_BossScheduleView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function VersionActivity1_6_BossScheduleView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function VersionActivity1_6_BossScheduleView:_onScrollChange(value)
	return
end

function VersionActivity1_6_BossScheduleView:onUpdateParam()
	return
end

function VersionActivity1_6_BossScheduleView:onOpen()
	self:_setListStaticData(0, 0, 0)
	VersionActivity1_6ScheduleViewListModel.instance:setStaticData(self._listStaticData)

	local curScore = VersionActivity1_6DungeonBossModel.instance:getTotalScore()

	self._isAutoClaim, self._lastRewardIndex, self._claimRewardIndex = VersionActivity1_6DungeonBossModel.instance:checkAbleGetReward(curScore)

	if self._isAutoClaim then
		self:_setListStaticData(0, self._lastRewardIndex + 1, self._claimRewardIndex)
	end

	self:_refresh()
end

function VersionActivity1_6_BossScheduleView:_setListStaticData(cur, from, to)
	self._listStaticData.curIndex = cur or 0
	self._listStaticData.fromIndex = from or 0
	self._listStaticData.toIndex = to or 0
end

function VersionActivity1_6_BossScheduleView:onOpenFinish()
	self:_openTweenStart()
end

function VersionActivity1_6_BossScheduleView:onClose()
	if self._isAutoClaim then
		self:_openTweenFinishInner()
	end
end

function VersionActivity1_6_BossScheduleView:onDestroyView()
	self._simagePanelBG:UnLoadImage()
	self._scrollReward:RemoveOnValueChanged()
	self:_deleteProgressTween()
	self:_deleteContentTween()
	GameUtil.onDestroyViewMemberList(self, "_itemList")

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end

	self._drag = nil

	if self._touch then
		self._touch:RemoveClickDownListener()
	end

	self._touch = nil

	if self._audioScroll then
		self._audioScroll:onDestroy()
	end

	self._audioScroll = nil
end

function VersionActivity1_6_BossScheduleView:_deleteProgressTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_progressBarTweenId")
end

function VersionActivity1_6_BossScheduleView:_deleteContentTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_contentTweenId")
end

function VersionActivity1_6_BossScheduleView:_refresh()
	local dataList = VersionActivity1_6DungeonBossModel.instance:getScheduleViewRewardList()
	local notGotDisplayIndexes = {}
	local bossRewardCfgList = Activity149Config.instance:getBossRewardCfgList()
	local getAleadyGotBonusIds = VersionActivity1_6DungeonBossModel.instance:getAleadyGotBonusIds()

	for idx, rewardCfg in ipairs(bossRewardCfgList) do
		local mo = dataList[idx]

		if not mo.isGot then
			notGotDisplayIndexes[#notGotDisplayIndexes + 1] = idx
		end
	end

	self._dataList = dataList

	recthelper.setWidth(self._goContentTran, self:_calcHLayoutContentMaxWidth(#dataList))
	self:_initItemList(dataList)
	self:_refreshContentOffset(self._lastRewardIndex)
	self:_refreshBestProgress()
end

function VersionActivity1_6_BossScheduleView:_createScheduleItem()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local itemClass = listScrollParam.cellClass
	local go = self.viewContainer:getResInst(listScrollParam.prefabUrl, self._goContent, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function VersionActivity1_6_BossScheduleView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	for i, mo in ipairs(dataList) do
		local item = self:_createScheduleItem()

		item._index = i

		item:setData(mo)
		table.insert(self._itemList, item)
	end
end

function VersionActivity1_6_BossScheduleView:_openTweenStart()
	self._openedTweens = {
		[OpenTweenEnum.ProgressBar] = true,
		[OpenTweenEnum.Content] = true
	}

	self:_tweenContent()
	self:_tweenProgress()
end

function VersionActivity1_6_BossScheduleView:_tweenContent()
	self:_deleteContentTween()

	if not self._isAutoClaim then
		self:_openTweenFinish(OpenTweenEnum.Content)

		return
	end

	local claimRewardIndex = self._claimRewardIndex
	local from = -recthelper.getAnchorX(self._goContentTran)
	local to = self:_calcHorizontalLayoutPixel(claimRewardIndex)

	if math.abs(from - to) < 0.1 then
		self:_openTweenFinish(OpenTweenEnum.Content)

		return
	end

	self._contentTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, kOpenTweenSecond, self._contentTweenUpdateCb, self._contentTweenFinishedCb, self, nil, EaseType.Linear)
end

function VersionActivity1_6_BossScheduleView:_openTweenFinish(eOpenTweenEnum)
	self._openedTweens[eOpenTweenEnum] = nil

	if next(self._openedTweens) then
		return
	end

	self:_openTweenFinishInner()
end

function VersionActivity1_6_BossScheduleView:_contentTweenUpdateCb(value)
	recthelper.setAnchorX(self._goContentTran, -value)
end

function VersionActivity1_6_BossScheduleView:_contentTweenFinishedCb()
	self:_openTweenFinish(OpenTweenEnum.Content)
end

function VersionActivity1_6_BossScheduleView:_tweenProgress()
	self:_deleteProgressTween()

	local model = VersionActivity1_6DungeonBossModel.instance
	local from = model:getScorePrefValue()
	local to = model:getTotalScore()

	if to == 0 then
		self:_progressBarTweenUpdateCb(0)
	end

	if math.abs(from - to) < 0.1 then
		local maxScore = Activity149Config.instance:getBossRewardMaxScore()

		self:_refreshProgress(to, maxScore)
		self:_openTweenFinish(OpenTweenEnum.ProgressBar)

		return
	end

	model:setScorePrefValue(to)

	self._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, kOpenTweenSecond, self._progressBarTweenUpdateCb, self._progressBarTweenFinishedCb, self, nil, EaseType.Linear)
end

function VersionActivity1_6_BossScheduleView:_progressBarTweenUpdateCb(value)
	value = math.floor(value)

	local maxScore = Activity149Config.instance:getBossRewardMaxScore()

	self:_refreshProgress(value, maxScore)
end

function VersionActivity1_6_BossScheduleView:_progressBarTweenFinishedCb()
	self:_openTweenFinish(OpenTweenEnum.ProgressBar)
end

function VersionActivity1_6_BossScheduleView:_openTweenFinishInner()
	if not self._isAutoClaim then
		return
	end

	self._isAutoClaim = false

	VersionActivity1_6DungeonRpc.instance:sendAct149GetScoreRewardsRequest()
end

function VersionActivity1_6_BossScheduleView:_refreshProgress(cur, max)
	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = self:_getCellSpaceH()
	local startPosX = self._goGraylinePosX
	local padding = self._hLayoutGroup.padding
	local left = padding.left
	local firstStep = left + cellWidth / 2
	local normalStep = cellSpaceH + cellWidth
	local width, maxWidth = Activity149Config.instance:calRewardProgressWidth(cur, cellSpaceH, cellWidth, firstStep, normalStep, startPosX, -startPosX)

	recthelper.setWidth(self._goGraylineTran, maxWidth)
	recthelper.setWidth(self._goNormallineTran, width)

	self._txtProgress.text = string.format("<color=#b34a16>%s</color>/%s", cur, max)
end

function VersionActivity1_6_BossScheduleView:_refreshBestProgress()
	self._txtbestProgress.text = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()
end

function VersionActivity1_6_BossScheduleView:_refreshContentOffset(index)
	local scrollPixel = self:_calcHorizontalLayoutPixel(index)

	recthelper.setAnchorX(self._goContentTran, -scrollPixel)
end

local kCellWidth = 200

function VersionActivity1_6_BossScheduleView:_calcHorizontalLayoutPixel(index)
	local cellSpaceH = self:_getCellSpaceH()
	local padding = self._hLayoutGroup.padding
	local left = padding.left
	local maxWidth = recthelper.getWidth(self._goContentTran)
	local maxScrollPosX = math.max(0, maxWidth)

	if index <= 1 then
		return 0
	end

	return math.min(maxScrollPosX, (index - 1) * (cellSpaceH + kCellWidth) + left)
end

function VersionActivity1_6_BossScheduleView:_getCellSpaceH()
	return self._hLayoutGroup.spacing
end

function VersionActivity1_6_BossScheduleView:_calcHLayoutContentMaxWidth(count)
	count = count or #self._dataList

	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local endSpace = listScrollParam.endSpace
	local cellSpaceH = self:_getCellSpaceH()
	local padding = self._hLayoutGroup.padding
	local left = padding.left

	return (cellWidth + cellSpaceH) * math.max(0, count) - left - cellWidth / 2 + endSpace
end

return VersionActivity1_6_BossScheduleView
