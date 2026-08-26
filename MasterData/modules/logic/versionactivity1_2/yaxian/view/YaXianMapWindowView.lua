-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianMapWindowView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapWindowView", package.seeall)

local YaXianMapWindowView = class("YaXianMapWindowView", BaseView)

function YaXianMapWindowView:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "window/bottom/node1/#go_select")
	self._txtindex = gohelper.findChildText(self.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_index")
	self._txtnodenameen = gohelper.findChildText(self.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_nodename_en")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "window/title/#simage_title")
	self._txttime = gohelper.findChildText(self.viewGO, "window/title/#txt_time")

	gohelper.setActive(self._txttime, false)

	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "window/bottom/#simage_bottom")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianMapWindowView:addEvents()
	return
end

function YaXianMapWindowView:removeEvents()
	return
end

YaXianMapWindowView.UnlockKey = "YaXianMapWindowViewUnlockKey"

function YaXianMapWindowView:onRewardClick()
	ViewMgr.instance:openView(ViewName.YaXianRewardView)
end

function YaXianMapWindowView:onCollectClick()
	ViewMgr.instance:openView(ViewName.YaXianCollectView)
end

function YaXianMapWindowView:_editableInitView()
	self._simagebottom:LoadImage(ResUrl.getYaXianImage("img_quyu_bg"))

	self.txtReward = gohelper.findChildText(self.viewGO, "window/righttop/reward/#txt_reward")
	self.txtCollect = gohelper.findChildText(self.viewGO, "window/righttop/collect/#txt_collect")
	self.collectClick = gohelper.findChildClick(self.viewGO, "window/righttop/collect/clickArea")

	self.collectClick:AddClickListener(self.onCollectClick, self)

	self.rewardClick = gohelper.findChildClick(self.viewGO, "window/righttop/reward/clickArea")

	self.rewardClick:AddClickListener(self.onRewardClick, self)

	self.goRedDot = gohelper.findChild(self.viewGO, "window/righttop/reward/reddot")

	RedDotController.instance:addRedDot(self.goRedDot, RedDotEnum.DotNode.YaXianReward)

	self.chapterNodeList = {}
	self.chapterAnimatorList = self:getUserDataTb_()

	for i = 1, 3 do
		local nodeTab = self:getUserDataTb_()

		nodeTab.index = i
		nodeTab.go = gohelper.findChild(self.viewGO, "window/bottom/node" .. i)
		nodeTab.goSelect = gohelper.findChild(nodeTab.go, "#go_select")
		nodeTab.goLock = gohelper.findChild(nodeTab.go, "#go_lock")
		nodeTab.txtChapterName = gohelper.findChildText(nodeTab.go, "info/#txt_nodename")
		nodeTab.txtChapterNameEn = gohelper.findChildText(nodeTab.go, "info/#txt_nodename/#txt_nodename_en")
		nodeTab.txtChapterIndex = gohelper.findChildText(nodeTab.go, "info/#txt_nodename/#txt_index")
		nodeTab.click = gohelper.findChildClick(nodeTab.go, "clickarea")

		nodeTab.click:AddClickListener(self.onClickChapterItem, self, nodeTab)
		table.insert(self.chapterAnimatorList, nodeTab.go:GetComponent(typeof(UnityEngine.Animator)))
		table.insert(self.chapterNodeList, nodeTab)
	end

	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnUpdateEpisodeInfo, self.onUpdateEpisodeInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function YaXianMapWindowView:onUpdateParam()
	return
end

function YaXianMapWindowView:onOpen()
	self.lastCanFightChapterId = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId
	self.chapterCoList = YaXianConfig.instance:getChapterConfigList()

	self:refreshUI()
end

function YaXianMapWindowView:refreshUI()
	self.chapterId = self.viewContainer.chapterId

	self:refreshTxt()
	self:refreshChapterUI()
end

function YaXianMapWindowView:refreshTxt()
	self.txtReward.text = YaXianModel.instance:getScore() .. "/" .. YaXianConfig.instance:getMaxBonusScore()
	self.txtCollect.text = YaXianModel.instance:getHadToothCount() - 1 .. "/" .. #lua_activity115_tooth.configList - 1
end

function YaXianMapWindowView:refreshChapterUI()
	for i, chapterCo in ipairs(self.chapterCoList) do
		self:refreshChapterItem(chapterCo, self.chapterNodeList[i])
	end

	if self:isPlayedChapterUnlockAnimation(self.chapterId) then
		return
	end

	self:playChapterUnlockAnimation(self.chapterId, self.unlockAnimationDone)
end

function YaXianMapWindowView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[YaXianEnum.ActivityId]
	local remainTime, remainTimeSuffix = actInfoMo:getRemainTime()

	self._txttime.text = string.format(luaLang("remain"), string.format("<nbsp>%s<nbsp>%s", remainTime, remainTimeSuffix))
end

function YaXianMapWindowView:refreshChapterItem(chapterCo, nodeTab)
	gohelper.setActive(nodeTab.goSelect, self.chapterId == chapterCo.id)
	gohelper.setActive(nodeTab.goLock, not YaXianController.instance:checkChapterIsUnlock(chapterCo.id))

	nodeTab.txtChapterName.text = chapterCo.name
	nodeTab.txtChapterNameEn.text = chapterCo.name_En
	nodeTab.txtChapterIndex.text = chapterCo.id
end

function YaXianMapWindowView:onClickChapterItem(nodeTab)
	local chapterCo = self.chapterCoList[nodeTab.index]

	if self.chapterId == chapterCo.id then
		return
	end

	local chapterStatus = YaXianController.instance:getChapterStatus(chapterCo.id)

	if chapterStatus == YaXianEnum.ChapterStatus.notOpen then
		local toastId, paramList = OpenHelper.getToastIdAndParam(chapterCo.openId)

		GameFacade.showToastWithTableParam(toastId, paramList)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)

		return
	end

	if chapterStatus == YaXianEnum.ChapterStatus.Lock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
	self.viewContainer:changeChapterId(chapterCo.id)
end

function YaXianMapWindowView:onSelectChapterChange()
	self:refreshUI()
end

function YaXianMapWindowView:onUpdateEpisodeInfo()
	self:refreshTxt()

	local newLastCanFightChapterId = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId

	if newLastCanFightChapterId == self.lastCanFightChapterId then
		self.nextChapterId = nil

		return
	end

	if not YaXianController.instance:checkChapterIsUnlock(newLastCanFightChapterId) then
		self.nextChapterId = nil

		return
	end

	self.nextChapterId = newLastCanFightChapterId
end

function YaXianMapWindowView:_onCloseViewFinish()
	if self.nextChapterId then
		self:playChapterUnlockAnimation(self.nextChapterId, self.unlockAnimationDoneNeedSwitchChapter)
	end
end

function YaXianMapWindowView:playChapterUnlockAnimation(chapterId, callback)
	if not chapterId then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self.nextChapterId = nil

	local nodeTab = self.chapterNodeList[chapterId]

	gohelper.setActive(nodeTab.goLock, true)

	self.playingUnlockAnimationChapterId = chapterId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

	local animator = self.chapterAnimatorList[chapterId]

	if animator then
		UIBlockMgr.instance:startBlock(YaXianMapWindowView.UnlockKey)
		animator:Play(UIAnimationName.Unlock)

		self.unlockCallback = callback

		TaskDispatcher.runDelay(self.unlockCallback, self, YaXianEnum.MapViewChapterUnlockDuration)
	elseif callback then
		callback(self)
	end
end

function YaXianMapWindowView:unlockAnimationDone()
	UIBlockMgr.instance:endBlock(YaXianMapWindowView.UnlockKey)
	self:recordPlayChapterUnlockAnimation(self.playingUnlockAnimationChapterId)

	self.playingUnlockAnimationChapterId = nil
	self.unlockCallback = nil
end

function YaXianMapWindowView:unlockAnimationDoneNeedSwitchChapter()
	local chapterId = self.playingUnlockAnimationChapterId

	self:unlockAnimationDone()
	self.viewContainer:changeChapterId(chapterId)
end

function YaXianMapWindowView:initPlayedChapterUnlockAnimationList()
	if self.playedChapterIdList then
		return
	end

	local unlockStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianChapterUnlockAnimationKey))

	if string.nilorempty(unlockStr) then
		self.playedChapterIdList = {}
	end

	self.playedChapterIdList = string.splitToNumber(unlockStr, ";")
end

function YaXianMapWindowView:isPlayedChapterUnlockAnimation(chapterId)
	self:initPlayedChapterUnlockAnimationList()

	return tabletool.indexOf(self.playedChapterIdList, chapterId)
end

function YaXianMapWindowView:recordPlayChapterUnlockAnimation(chapterId)
	if tabletool.indexOf(self.playedChapterIdList, chapterId) then
		return
	end

	table.insert(self.playedChapterIdList, chapterId)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianChapterUnlockAnimationKey), table.concat(self.playedChapterIdList, ";"))
end

function YaXianMapWindowView:onClose()
	return
end

function YaXianMapWindowView:onDestroyView()
	self._simagebottom:UnLoadImage()
	TaskDispatcher.cancelTask(self.refreshTime, self)

	if self.unlockCallback then
		TaskDispatcher.cancelTask(self.unlockCallback, self)
	end

	self.collectClick:RemoveClickListener()
	self.rewardClick:RemoveClickListener()

	for _, chapterNode in ipairs(self.chapterNodeList) do
		chapterNode.click:RemoveClickListener()
	end
end

return YaXianMapWindowView
