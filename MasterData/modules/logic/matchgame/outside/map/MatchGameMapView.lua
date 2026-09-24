-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapView.lua

module("modules.logic.matchgame.outside.map.MatchGameMapView", package.seeall)

local MatchGameMapView = class("MatchGameMapView", BaseView)

function MatchGameMapView:onInitView()
	self._scrollMap = gohelper.findChildScrollRect(self.viewGO, "#go_mapnav/#scroll_Map")
	self._goList = gohelper.findChild(self.viewGO, "#go_mapnav/#scroll_Map/Viewport/#go_List")
	self._goMapItem = gohelper.findChild(self.viewGO, "#go_mapnav/#scroll_Map/Viewport/#go_List/#go_MapItem")
	self._txtFloor = gohelper.findChildText(self.viewGO, "#go_title/#txt_Floor")
	self._txtMapName = gohelper.findChildText(self.viewGO, "#go_title/#txt_MapName")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._txtRewardProgress = gohelper.findChildText(self.viewGO, "#btn_reward/#txt_rewardprogress")
	self._goRewardRedDot = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardredpoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameMapView:addEvents()
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnClickSelectMap, self._onClickSelectMap, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateEpisodeInfo, self._onUpdateEpisodeInfo, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.PlaySwitchMapAnim, self._onPlaySwitchMapAnim, self)
end

function MatchGameMapView:removeEvents()
	self._btnReward:RemoveClickListener()
end

function MatchGameMapView:_btnRewardOnClick()
	MatchGameController.instance:openRewardView(MatchGameEnum.RewardType.Normal)
end

function MatchGameMapView:_editableInitView()
	self._actId = MatchGameModel.instance:getCurActId()
	self._goScrollMap = self._scrollMap.gameObject
	self._viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._animReward = gohelper.onceAddComponent(self._btnReward.gameObject, gohelper.Type_Animation)

	RedDotController.instance:addRedDot(self._goRewardRedDot, RedDotEnum.DotNode.MatchGameNormalReward)

	self._ignoreViewList = {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.ToastView,
		ViewName.GuideStepEditor
	}
end

function MatchGameMapView:onOpen()
	self:refreshUI()
end

function MatchGameMapView:refreshUI()
	self:refreshMapItemList()
	self:refreshRewardEntry()
end

function MatchGameMapView:refreshMapItemList()
	if not self._mapListComp then
		local listParam = SimpleListParam.New()

		listParam.cellClass = MatchGameMapListItem
		listParam.lineCount = 1
		listParam.cellWidth = 100
		listParam.cellHeight = 100
		listParam.startSpace = 0
		listParam.scrollDir = ScrollEnum.ScrollDirV

		local scrollParam = {
			listParam = listParam,
			viewContainer = self.viewContainer
		}

		self._mapListComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goScrollMap, SimpleListComp, scrollParam)

		self._mapListComp:setRes(self._goMapItem)
		self._mapListComp:onCreate()
	end

	local chapterList = MatchGameLevelModel.instance:getCurChapterCos()
	local selectIndex = MatchGameLevelModel.instance:getCurChapterIndex()

	self._mapListComp:setData(chapterList)
	self._mapListComp:setSelect(selectIndex)

	local curEpisodeCo = MatchGameLevelModel.instance:getCurEpisodeCo()
	local curChapterId = curEpisodeCo and curEpisodeCo.chapterId
	local curChapterCo = curChapterId and lua_activity244_chapter.configDict[curChapterId]

	self._txtMapName.text = curEpisodeCo and curEpisodeCo.levelName
	self._txtFloor.text = curChapterCo and curChapterCo.chapterName
end

function MatchGameMapView:_onClickSelectMap()
	self:refreshUI()
end

function MatchGameMapView:_onUpdateEpisodeInfo()
	self:refreshUI()
end

function MatchGameMapView:refreshRewardEntry()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MatchGameNormalReward) then
		self._animReward:Play("btn_tipreward_loop")
	else
		self._animReward:Play("btn_tipreward")
	end

	local maxRewardScore = MatchGameConfig.instance:getRewardTotalScore(self._actId, MatchGameEnum.RewardType.Normal)
	local curRewardScore = MatchGameModel.instance:getCurRewardScore(MatchGameEnum.RewardType.Normal)

	self._txtRewardProgress.text = string.format("%s/%s", curRewardScore, maxRewardScore)
end

function MatchGameMapView:_onCloseView(viewName)
	if viewName == ViewName.MatchGameRewardView then
		self:refreshRewardEntry()
	end
end

function MatchGameMapView:_onCloseViewFinish(viewName)
	if viewName ~= self.viewName then
		self:checkStartSwitch()
	end
end

function MatchGameMapView:_onPlaySwitchMapAnim(chapterId)
	self._isNeedSwitch = true
	self._nextChapterId = chapterId

	self:checkStartSwitch()
end

function MatchGameMapView:checkStartSwitch()
	if not self._isNeedSwitch or not self._nextChapterId then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, self._ignoreViewList) then
		return
	end

	self._chapterId = self._nextChapterId
	self._isNeedSwitch = false
	self._nextChapterId = nil

	self._viewAnimator:Play("switch", 0, 0)
	AudioMgr.instance:trigger(MatchGameAudioEnum.SwitchMap)
	UIBlockHelper.instance:startBlock(self.viewName, MatchGameEnum.DelaySwitchTime, self.viewName)
	TaskDispatcher.cancelTask(self._reallyStartSwitchChapter, self)
	TaskDispatcher.runDelay(self._reallyStartSwitchChapter, self, MatchGameEnum.DelaySwitchTime)
end

function MatchGameMapView:_reallyStartSwitchChapter()
	self._isNeedSwitch = false

	UIBlockHelper.instance:endBlock(self.viewName)
	MatchGameLevelModel.instance:switchChapter(self._chapterId)
end

function MatchGameMapView:onClose()
	TaskDispatcher.cancelTask(self._reallyStartSwitchChapter, self)
	UIBlockHelper.instance:endBlock(self.viewName)
end

function MatchGameMapView:onDestroyView()
	return
end

return MatchGameMapView
