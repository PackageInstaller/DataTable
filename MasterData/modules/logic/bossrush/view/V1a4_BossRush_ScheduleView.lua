-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScheduleView.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleView", package.seeall)

local V1a4_BossRush_ScheduleView = class("V1a4_BossRush_ScheduleView", BaseView)

function V1a4_BossRush_ScheduleView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_Reward")
	self._goContent = gohelper.findChild(self.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	self._goGrayLine = gohelper.findChild(self.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	self._goNormalLine = gohelper.findChild(self.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	self._goTarget = gohelper.findChild(self.viewGO, "Root/#go_Target")
	self._simageTargetBG = gohelper.findChildSingleImage(self.viewGO, "Root/#go_Target/#simage_TargetBG")
	self._goTargetContent = gohelper.findChild(self.viewGO, "Root/#go_Target/#go_TargetContent")
	self._txtProgress = gohelper.findChildText(self.viewGO, "Root/ProgressTip/#txt_Progress")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_ScheduleView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function V1a4_BossRush_ScheduleView:removeEvents()
	self._btnClose:RemoveClickListener()
end

local sf = string.format
local UIDragListener = SLFramework.UGUI.UIDragListener
local UIClickListener = SLFramework.UGUI.UIClickListener
local kViewPortOffsetRight = 425
local kOpenTweenSecond = 1.5
local OpenTweenEnum = {
	Content = 2,
	ProgressBar = 1
}

function V1a4_BossRush_ScheduleView:_btnCloseOnClick()
	self:closeThis()
end

function V1a4_BossRush_ScheduleView:onClickModalMask()
	self:closeThis()
end

function V1a4_BossRush_ScheduleView:_editableInitView()
	self._scrollRewardGo = self._scrollReward.gameObject
	self._goGraylineTran = self._goGrayLine.transform
	self._goNormallineTran = self._goNormalLine.transform
	self._goContentTran = self._goContent.transform
	self._rectViewPortTran = gohelper.findChild(self._scrollRewardGo, "Viewport").transform
	self._hLayoutGroup = self._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._goGraylinePosX = recthelper.getAnchorX(self._goGraylineTran)

	self:_initTargetItem()
	self._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))
	self._simageTargetBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulerightbg"))

	self._drag = UIDragListener.Get(self._scrollRewardGo)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollRewardGo, DungeonMapEpisodeAudio, self._scrollReward)
	self._touch = UIClickListener.Get(self._scrollRewardGo)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)
	self._scrollReward:AddOnValueChanged(self._onScrollChange, self)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(self._goContentTran, 0)

	self._listStaticData = {}
end

function V1a4_BossRush_ScheduleView:_initTargetItem()
	local itemClass = V1a4_BossRush_ScheduleItem
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_scheduleitem, self._goTargetContent, itemClass.__cname)

	self._targetItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self:_setTargetActive(false)
end

function V1a4_BossRush_ScheduleView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function V1a4_BossRush_ScheduleView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function V1a4_BossRush_ScheduleView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function V1a4_BossRush_ScheduleView:_onScrollChange(value)
	if self._isGetAllDisplay then
		return
	end

	self:_showTarget()
end

function V1a4_BossRush_ScheduleView:onUpdateParam()
	return
end

function V1a4_BossRush_ScheduleView:_getStage()
	return self.viewParam.stage
end

function V1a4_BossRush_ScheduleView:onOpen()
	self:_setListStaticData(0, 0, 0)
	V1a4_BossRush_ScheduleViewListModel.instance:setStaticData(self._listStaticData)

	local stage = self:_getStage()
	local lastPointInfo = BossRushModel.instance:getLastPointInfo(stage)
	local _, lastRewardIndex = BossRushModel.instance:calcRewardClaim(stage, lastPointInfo.last)

	self._isAutoClaim, self._claimRewardIndex = BossRushModel.instance:calcRewardClaim(stage, lastPointInfo.cur)
	self._lastPointInfo = lastPointInfo
	self._lastRewardIndex = lastRewardIndex
	self._displayAllIndexes = BossRushConfig.instance:getStageRewardDisplayIndexesList(stage)

	if self._isAutoClaim then
		self:_setListStaticData(0, lastRewardIndex + 1, self._claimRewardIndex)
	end

	self:_refresh()
	self:_showTarget()
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveAct128GetTotalRewardsReply, self._refresh, self)
end

function V1a4_BossRush_ScheduleView:_setListStaticData(cur, from, to)
	self._listStaticData.curIndex = cur or 0
	self._listStaticData.fromIndex = from or 0
	self._listStaticData.toIndex = to or 0
end

function V1a4_BossRush_ScheduleView:onOpenFinish()
	self:_openTweenStart()
end

function V1a4_BossRush_ScheduleView:onClose()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveAct128GetTotalRewardsReply, self._refresh, self)

	if self._isAutoClaim then
		self:_openTweenFinishInner()
	end
end

function V1a4_BossRush_ScheduleView:onDestroyView()
	self._simagePanelBG:UnLoadImage()
	self._simageTargetBG:UnLoadImage()
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

function V1a4_BossRush_ScheduleView:_deleteProgressTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_progressBarTweenId")
end

function V1a4_BossRush_ScheduleView:_deleteContentTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_contentTweenId")
end

function V1a4_BossRush_ScheduleView:_refresh()
	local stage = self:_getStage()
	local lastPointInfo = self._lastPointInfo
	local lastTotalPoint = lastPointInfo.last
	local maxTotalPoint = lastPointInfo.max
	local dataList = BossRushModel.instance:getScheduleViewRewardList(stage)
	local notGotDisplayIndexes = {}
	local displayAllIndexCount = #self._displayAllIndexes

	if displayAllIndexCount > 0 and self._claimRewardIndex < self._displayAllIndexes[displayAllIndexCount] then
		for _, index in ipairs(self._displayAllIndexes) do
			local mo = dataList[index]

			if not mo.isGot then
				notGotDisplayIndexes[#notGotDisplayIndexes + 1] = index
			end
		end
	end

	self._dataList = dataList
	self._notGotDisplayIndexes = notGotDisplayIndexes
	self._isGetAllDisplay = #notGotDisplayIndexes == 0

	self:_refreshProgress(lastTotalPoint, maxTotalPoint)

	if self._isGetAllDisplay then
		self:_setTargetActive(false)

		self._rectViewPortTran.offsetMax = Vector2(kViewPortOffsetRight, 0)
	else
		self:_setTargetActive(true)

		self._rectViewPortTran.offsetMax = Vector2(0, 0)
	end

	recthelper.setWidth(self._goContentTran, self:_calcHLayoutContentMaxWidth(#dataList))
	self:_initItemList(dataList)
	self:_refreshContentOffset(self._lastRewardIndex)
end

function V1a4_BossRush_ScheduleView:_create_V1a4_BossRush_ScheduleItem()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local itemClass = listScrollParam.cellClass
	local go = self.viewContainer:getResInst(listScrollParam.prefabUrl, self._goContent, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function V1a4_BossRush_ScheduleView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	for i, mo in ipairs(dataList) do
		local item = self:_create_V1a4_BossRush_ScheduleItem()

		item._index = i

		item:setData(mo)
		table.insert(self._itemList, item)
	end
end

function V1a4_BossRush_ScheduleView:_tweenProgress()
	self:_deleteProgressTween()

	local lastPointInfo = self._lastPointInfo
	local from = lastPointInfo.last
	local to = lastPointInfo.cur

	if math.abs(from - to) < 0.1 then
		self:_openTweenFinish(OpenTweenEnum.ProgressBar)

		return
	end

	self._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, kOpenTweenSecond, self._progressBarTweenUpdateCb, self._progressBarTweenFinishedCb, self, nil, EaseType.Linear)
end

function V1a4_BossRush_ScheduleView:_progressBarTweenUpdateCb(value)
	value = math.floor(value)

	self:_refreshProgress(value, self._lastPointInfo.max)
end

function V1a4_BossRush_ScheduleView:_progressBarTweenFinishedCb()
	self:_openTweenFinish(OpenTweenEnum.ProgressBar)
end

function V1a4_BossRush_ScheduleView:_tweenContent()
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

function V1a4_BossRush_ScheduleView:_contentTweenUpdateCb(value)
	recthelper.setAnchorX(self._goContentTran, -value)
end

function V1a4_BossRush_ScheduleView:_contentTweenFinishedCb()
	self:_openTweenFinish(OpenTweenEnum.Content)
end

function V1a4_BossRush_ScheduleView:_openTweenStart()
	self._openedTweens = {
		[OpenTweenEnum.ProgressBar] = true,
		[OpenTweenEnum.Content] = true
	}

	self:_tweenContent()
	self:_tweenProgress()
end

function V1a4_BossRush_ScheduleView:_openTweenFinish(eOpenTweenEnum)
	self._openedTweens[eOpenTweenEnum] = nil

	if next(self._openedTweens) then
		return
	end

	self:_openTweenFinishInner()
end

function V1a4_BossRush_ScheduleView:_openTweenFinishInner()
	local stage = self:_getStage()
	local curTotalPoint = self._lastPointInfo.cur

	self._lastRewardIndex = self._claimRewardIndex
	self._lastPointInfo.last = curTotalPoint

	BossRushModel.instance:setStageLastTotalPoint(stage, curTotalPoint)

	if not self._isAutoClaim then
		return
	end

	self._isAutoClaim = false

	BossRushRpc.instance:sendAct128GetTotalRewardsRequest(stage)
end

function V1a4_BossRush_ScheduleView:_refreshProgress(cur, max)
	local stage = self:_getStage()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = self:_getCellSpaceH()
	local startPosX = self._goGraylinePosX
	local padding = self._hLayoutGroup.padding
	local left = padding.left
	local firstStep = left + cellWidth / 2
	local normalStep = cellSpaceH + cellWidth
	local width, maxWidth = BossRushConfig.instance:calcStageRewardProgWidth(stage, cur, cellSpaceH, cellWidth, firstStep, normalStep, startPosX, -startPosX)

	recthelper.setWidth(self._goGraylineTran, maxWidth)
	recthelper.setWidth(self._goNormallineTran, width)

	self._txtProgress.text = sf("<color=#b34a16>%s</color>/%s", cur, max)
end

function V1a4_BossRush_ScheduleView:_refreshContentOffset(index)
	local scrollPixel = self:_calcHorizontalLayoutPixel(index)

	recthelper.setAnchorX(self._goContentTran, -scrollPixel)
end

local kCellWidth = 200
local kScorllWidth = 1250

function V1a4_BossRush_ScheduleView:_calcHorizontalLayoutPixel(index)
	local cellSpaceH = self:_getCellSpaceH()
	local padding = self._hLayoutGroup.padding
	local left = padding.left
	local kViewPortWidth = kScorllWidth

	if self._isGetAllDisplay then
		kViewPortWidth = kViewPortWidth + kViewPortOffsetRight
	end

	local maxWidth = recthelper.getWidth(self._goContentTran)
	local maxScrollPosX = math.max(0, maxWidth - kViewPortWidth)

	if index <= 1 then
		return 0
	end

	return math.min(maxScrollPosX, (index - 1) * (cellSpaceH + kCellWidth) + left)
end

function V1a4_BossRush_ScheduleView:_getCellSpaceH()
	return self._hLayoutGroup.spacing
end

function V1a4_BossRush_ScheduleView:_calcHLayoutContentMaxWidth(count)
	count = count or #self._dataList

	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local endSpace = listScrollParam.endSpace
	local cellSpaceH = self:_getCellSpaceH()
	local padding = self._hLayoutGroup.padding
	local left = padding.left

	return (cellWidth + cellSpaceH) * math.max(0, count) - left - cellWidth / 2 + endSpace
end

local kSkipIndex = 2

function V1a4_BossRush_ScheduleView:_showTarget()
	local indexes = self._notGotDisplayIndexes

	if not indexes or #indexes == 0 then
		self:_setTargetActive(false)

		return
	end

	self:_setTargetActive(true)

	local contentPosX = recthelper.getAnchorX(self._goContentTran)
	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = listScrollParam.cellSpaceH
	local step = cellWidth + cellSpaceH
	local firstStep = cellWidth / 2
	local contentAbsPosX = math.abs(contentPosX)
	local startIndex, targetIndex

	startIndex = contentAbsPosX <= firstStep and 2 + kSkipIndex or 2 + math.floor((contentAbsPosX - firstStep) / step) + kSkipIndex

	for _, index in ipairs(indexes) do
		if startIndex <= index then
			targetIndex = index

			break
		end
	end

	if not targetIndex then
		local maxIndex = indexes[#indexes]

		targetIndex = math.min(startIndex, maxIndex)
	end

	local mo = self._dataList[targetIndex]

	mo._index = targetIndex

	self._targetItem:refreshByDisplayTarget(mo)
end

function V1a4_BossRush_ScheduleView:_showFirstTarget()
	local indexes = self._notGotDisplayIndexes

	if not indexes or #indexes == 0 then
		self:_setTargetActive(false)

		return
	end

	self:_setTargetActive(true)

	local targetIndex = indexes[1]
	local mo = self._dataList[targetIndex]

	mo._index = targetIndex

	self._targetItem:refreshByDisplayTarget(mo)
end

function V1a4_BossRush_ScheduleView:_setTargetActive(isActive)
	gohelper.setActive(self._goTarget, isActive)
end

return V1a4_BossRush_ScheduleView
