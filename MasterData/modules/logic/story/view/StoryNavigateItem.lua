-- chunkname: @modules/logic/story/view/StoryNavigateItem.lua

module("modules.logic.story.view.StoryNavigateItem", package.seeall)

local StoryNavigateItem = class("StoryNavigateItem")

function StoryNavigateItem:init(go)
	self._go = go
	self._gobg = gohelper.findChild(go, "bg")
	self._goepisode = gohelper.findChild(go, "#go_episode")
	self._goepisodevideo = gohelper.findChild(go, "#go_episode/#go_episodevideo")
	self._goepisodeicon = gohelper.findChild(go, "#go_episode/#go_episodeicon")
	self._txtepisode = gohelper.findChildText(go, "#go_episode/#txt_episode")
	self._txtepisodeEn = gohelper.findChildText(go, "#go_episode/#txt_episodeEn")
	self._txtepisodeNum = gohelper.findChildText(go, "#go_episode/#txt_episodeNum")
	self._gochapter = gohelper.findChild(go, "#go_chapter")
	self._goopen = gohelper.findChild(go, "#go_chapter/#go_open")
	self._gochapteropenvideo = gohelper.findChild(go, "#go_chapter/#go_open/#go_chapteropenvideo")
	self._txtchapterName = gohelper.findChildText(go, "#go_chapter/#go_open/#txt_chapterName")
	self._txtchapterNameEn = gohelper.findChildText(go, "#go_chapter/#go_open/#txt_chapterNameEn")
	self._txtchapterNum = gohelper.findChildText(go, "#go_chapter/#go_open/#txt_chapterNum")
	self._goclose = gohelper.findChild(go, "#go_chapter/#go_close")
	self._gochapterclosevideo = gohelper.findChild(go, "#go_chapter/#go_close/#go_chapterclosevideo")
	self._txtchaptercloseNum = gohelper.findChildText(go, "#go_chapter/#go_close/icon/#txt_chaptercloseNum")
	self._gomap = gohelper.findChild(go, "#go_map")
	self._txtmapname = gohelper.findChildText(go, "#go_map/#txt_mapname")
	self._txtmapnameen = gohelper.findChildText(go, "#go_map/#txt_mapnameen")
	self._mapAnimator = self._gomap:GetComponent(typeof(UnityEngine.Animator))
	self._goActivityChapter = gohelper.findChild(go, "#go_activity_chapter")
	self._gostorm = gohelper.findChild(go, "#go_storm")
	self._stormAnim = self._gostorm:GetComponent(typeof(UnityEngine.Animator))
	self._txtTimeNum1 = gohelper.findChildText(go, "#go_storm/txt_Time2/txt_TimeNum1")
	self._txtTimeNum2 = gohelper.findChildText(go, "#go_storm/txt_Time2/txt_TimeNum2")
	self._txtTimeEn1 = gohelper.findChildText(go, "#go_storm/#txt_TimeEn")
	self._txtTimeEn2 = gohelper.findChildText(go, "#go_storm/#txt_TimeEn1")
	self._showFunc = {
		[StoryEnum.NavigateType.Map] = self.showMap,
		[StoryEnum.NavigateType.Episode] = self.showEpisode,
		[StoryEnum.NavigateType.ChapterStart] = self.showChapterStart,
		[StoryEnum.NavigateType.ChapterEnd] = self.showChapterEnd,
		[StoryEnum.NavigateType.ActivityStart] = self.showActivityChapterStart,
		[StoryEnum.NavigateType.ActivityEnd] = self.showActivityChapterEnd,
		[StoryEnum.NavigateType.RoleStoryStart] = self.showRoleStoryStart,
		[StoryEnum.NavigateType.StormDeadline] = self.showStormDeadline,
		[StoryEnum.NavigateType.FullScreenCountdown] = self.showFullScreenCountdown,
		[StoryEnum.NavigateType.StormTimerStart] = self.showStormTimerStart,
		[StoryEnum.NavigateType.StormTimerEnd] = self.showStormTimerEnd,
		[StoryEnum.NavigateType.FullScreenCountdownEnd] = self.showCloseFullScreenCountdown,
		[StoryEnum.NavigateType.ScoreCard] = self.showV3A9StoryScoreCard
	}
end

function StoryNavigateItem:show(co)
	self:clear()

	self._navigateCo = co

	for _, v in pairs(self._navigateCo) do
		self:showNavigate(v.navigateType, v)
	end
end

function StoryNavigateItem:showNavigate(navigateType, co)
	local func = self._showFunc[navigateType]

	if not func then
		return
	end

	func(self, co)
end

function StoryNavigateItem:showMap(mapCo)
	gohelper.setActive(self._gomap, true)

	self._txtmapname.text = tonumber(mapCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) and luaLang(mapCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) or mapCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	self._txtmapnameen.text = mapCo.navigateTxts[LanguageEnum.LanguageStoryType.EN]

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	self._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(self._mapOut, self)
	TaskDispatcher.runDelay(self._mapOut, self, 3)
end

function StoryNavigateItem:_mapOut()
	self._mapAnimator:Play("go_mapname_out")
	TaskDispatcher.cancelTask(self._mapOut, self)
end

function StoryNavigateItem:showEpisode(episodeCo)
	gohelper.setActive(self._goepisode, true)

	if self._episodeIconLoader then
		self._episodeIconLoader:dispose()

		self._episodeIconLoader = nil

		SLFramework.GameObjectHelper.DestroyAllChildren(self._iconGo)
	end

	if self._episodeVideoPlayer then
		self._episodeVideoPlayer:stop()
		self._episodeVideoPlayer:clear()
	end

	if gohelper.isNil(self._episodeVideoGO) then
		self._episodeVideoPlayer, self._episodeVideoGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._goepisodevideo)
	end

	if self._episodeVideoPlayer then
		self._episodeVideoPlayer:play("story_rian_bg", true, nil, nil)
	end

	self._episodeIconLoader = PrefabInstantiate.Create(self._goepisodeicon)

	self._episodeIconLoader:startLoad(ResUrl.getStoryEpisodeIcon(episodeCo.navigateLogo), function(loader)
		self._iconGo = loader:getInstGO()
	end)

	self._txtepisode.text = tonumber(episodeCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) and luaLang(episodeCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) or episodeCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	self._txtepisodeEn.text = episodeCo.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	self._txtepisodeNum.text = episodeCo.navigateChapterEn

	TaskDispatcher.cancelTask(self._episodeOut, self)
	TaskDispatcher.runDelay(self._episodeOut, self, 5.667)
end

function StoryNavigateItem:_episodeOut()
	if self._episodeVideoPlayer then
		self._episodeVideoPlayer:stop()
		self._episodeVideoPlayer:clear()

		self._episodeVideoPlayer = nil
	end

	gohelper.setActive(self._goepisode, false)
	TaskDispatcher.cancelTask(self._episodeOut, self)
end

function StoryNavigateItem:showChapterStart(chapterCo)
	gohelper.setActive(self._gochapter, true)
	gohelper.setActive(self._goopen, true)
	gohelper.setActive(self._goclose, false)

	self._txtchapterName.text = chapterCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	self._txtchapterNameEn.text = chapterCo.navigateTxts[LanguageEnum.LanguageStoryType.EN]

	if LangSettings.instance:isJp() and self._txtchapterNameEn.text == "Aleph" then
		self._txtchapterNameEn.text = ""
	end

	self._txtchapterNum.text = chapterCo.navigateChapterEn

	if self._chapterOpenVideoPlayer then
		self._chapterOpenVideoPlayer:stop()
		self._chapterOpenVideoPlayer:clear()
	end

	if gohelper.isNil(self._chapterOpenVideoGO) then
		self._chapterOpenVideoPlayer, self._chapterOpenVideoGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._gochapteropenvideo)
	end

	if self._chapterOpenVideoPlayer then
		self._chapterOpenVideoPlayer:play("story_rian_bg", true, nil, nil)
	end

	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	TaskDispatcher.cancelTask(self._chapterStartOut, self)
	TaskDispatcher.runDelay(self._chapterStartOut, self, 5.333)
end

function StoryNavigateItem:_chapterStartOut()
	if self._chapterOpenVideoPlayer then
		self._chapterOpenVideoPlayer:stop()
		self._chapterOpenVideoPlayer:clear()

		self._chapterOpenVideoPlayer = nil
	end

	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	gohelper.setActive(self._goopen, false)
	TaskDispatcher.cancelTask(self._chapterStartOut, self)
end

function StoryNavigateItem:showChapterEnd(chapterCo)
	PostProcessingMgr.instance:setUIBlurActive(0)
	gohelper.setActive(self._goepisode, false)
	gohelper.setActive(self._gochapter, true)
	gohelper.setActive(self._goclose, true)
	gohelper.setActive(self._goopen, false)

	local chapterEndTxt = chapterCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	if chapterEndTxt == "" then
		chapterEndTxt = chapterCo.navigateChapterEn
	end

	self._txtchaptercloseNum.text = chapterEndTxt

	if self._chapterCloseVideoPlayer then
		self._chapterCloseVideoPlayer:stop()
		self._chapterCloseVideoPlayer:clear()
	end

	if gohelper.isNil(self._chapterCloseVideoGO) then
		self._chapterCloseVideoPlayer, self._chapterCloseVideoGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._gochapterclosevideo)
	end

	if self._chapterCloseVideoPlayer then
		self._chapterCloseVideoPlayer:play("story_rian_bg", true, nil, nil)
	end

	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(self._chapterEndOut, self)
	TaskDispatcher.runDelay(self._chapterEndOut, self, 3.2)
end

function StoryNavigateItem:_chapterEndOut()
	if self._chapterCloseVideoPlayer then
		self._chapterCloseVideoPlayer:stop()
		self._chapterCloseVideoPlayer:clear()

		self._chapterCloseVideoPlayer = nil
	end

	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(self._chapterEndOut, self)
end

function StoryNavigateItem:getActivityChapterPlayer()
	self.activityChapterPlayer = self.activityChapterPlayer or StoryActivityChapterPlayer.New(self._goActivityChapter)

	return self.activityChapterPlayer
end

function StoryNavigateItem:showV3A9StoryScoreCard(chapterCo)
	ViewMgr.instance:openView(ViewName.V3A9StoryScoreCardView, {
		data = chapterCo
	})
end

function StoryNavigateItem:closeV3A9StoryScoreCard()
	ViewMgr.instance:closeView(ViewName.V3A9StoryScoreCardView)
end

function StoryNavigateItem:showActivityChapterStart(chapterCo)
	local player = self:getActivityChapterPlayer()

	player:playStart(chapterCo)
end

function StoryNavigateItem:showActivityChapterEnd(chapterCo)
	gohelper.setActive(self._gobg, true)

	local player = self:getActivityChapterPlayer()

	player:playEnd(chapterCo)
end

function StoryNavigateItem:showRoleStoryStart(chapterCo)
	local player = self:getActivityChapterPlayer()

	player:playRoleStoryStart(chapterCo)
end

function StoryNavigateItem:showStormDeadline(stormCo)
	AudioMgr.instance:trigger(AudioEnum.Story.Play_Storm_Deadline)

	local deadlines = string.splitToNumber(stormCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "#")

	gohelper.setActive(self._gostorm, true)
	self._stormAnim:Play("open", 0, 0)

	self._txtTimeNum1.text = deadlines[1]
	self._txtTimeNum2.text = deadlines[1] - deadlines[2]

	local txt = "%s HOURS\nBEFORE THE STORM"

	self._txtTimeEn1.text = string.format(txt, deadlines[1])
	self._txtTimeEn2.text = string.format(txt, deadlines[1] - deadlines[2])
end

function StoryNavigateItem:showFullScreenCountdown(stormCo)
	ViewMgr.instance:openView(ViewName.StoryFullScreenStormView, {
		data = stormCo
	})
end

function StoryNavigateItem:showCloseFullScreenCountdown(stormCo)
	self:realCloseFullScreenCountdown()
end

function StoryNavigateItem:realCloseFullScreenCountdown(isImmediate)
	ViewMgr.instance:closeView(ViewName.StoryFullScreenStormView, isImmediate)
end

function StoryNavigateItem:showStormTimerStart(stormCo)
	local player = self:getStormTimerPlayer()

	player:setData(stormCo)
end

function StoryNavigateItem:showStormTimerEnd(stormCo)
	if not self.stormTimerPlayer then
		return
	end

	local player = self:getStormTimerPlayer()

	player:playClose(stormCo)
end

function StoryNavigateItem:getStormTimerPlayer()
	if not self.stormTimerPlayer then
		local logicName = "StoryStormTimer"
		local logic = _G[logicName]
		local go = gohelper.findChild(self._go, "#go_storm_timer")

		self.stormTimerPlayer = logic.New(go)
	end

	return self.stormTimerPlayer
end

function StoryNavigateItem:clear()
	gohelper.setActive(self._goepisode, false)
	gohelper.setActive(self._gochapter, false)
	gohelper.setActive(self._gomap, false)
	gohelper.setActive(self._gobg, false)

	if self.activityChapterPlayer then
		self.activityChapterPlayer:hide()
	end
end

function StoryNavigateItem:onFadeOut()
	self:clear()

	if self.stormTimerPlayer then
		self.stormTimerPlayer:hide()
	end

	self:realCloseFullScreenCountdown(true)
	self:closeV3A9StoryScoreCard()
end

function StoryNavigateItem:onSkip()
	if self.stormTimerPlayer then
		self.stormTimerPlayer:hide()
	end

	self:realCloseFullScreenCountdown(true)
end

function StoryNavigateItem:destroy()
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(self._mapOut, self)
	TaskDispatcher.cancelTask(self._episodeOut, self)
	TaskDispatcher.cancelTask(self._chapterStartOut, self)
	TaskDispatcher.cancelTask(self._chapterEndOut, self)

	if self._episodeIconLoader then
		self._episodeIconLoader:dispose()

		self._episodeIconLoader = nil

		SLFramework.GameObjectHelper.DestroyAllChildren(self._iconGo)
	end

	if self._episodeVideoPlayer and not BootNativeUtil.isIOS() then
		self._episodeVideoPlayer:stop()
	end

	if self._episodeVideoGO then
		gohelper.destroy(self._episodeVideoGO)

		self._episodeVideoGO = nil
	end

	if self._chapterOpenVideoPlayer and not BootNativeUtil.isIOS() then
		self._chapterOpenVideoPlayer:stop()
	end

	if self._chapterOpenVideoGO then
		gohelper.destroy(self._chapterOpenVideoGO)

		self._chapterOpenVideoGO = nil
	end

	if self._chapterCloseVideoPlayer then
		if not BootNativeUtil.isIOS() then
			self._chapterCloseVideoPlayer:stop()
		end

		self._chapterCloseVideoPlayer:clear()

		self._chapterCloseVideoPlayer = nil
	end

	if self._chapterCloseVideoGO then
		gohelper.destroy(self._chapterCloseVideoGO)

		self._chapterCloseVideoGO = nil
	end

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	if self.activityChapterPlayer then
		self.activityChapterPlayer:dispose()

		self.activityChapterPlayer = nil
	end

	if self.stormTimerPlayer then
		self.stormTimerPlayer:onDestory()

		self.stormTimerPlayer = nil
	end

	self:realCloseFullScreenCountdown(true)
	self:closeV3A9StoryScoreCard()
	gohelper.setActive(self._go, false)
end

return StoryNavigateItem
