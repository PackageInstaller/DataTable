-- chunkname: @modules/logic/dungeon/view/DungeonMapLevelView_bake.lua

module("modules.logic.dungeon.view.DungeonMapLevelView_bake", package.seeall)

local DungeonMapLevelView_bake = class("DungeonMapLevelView_bake", BaseView)

function DungeonMapLevelView_bake:onInitView()
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._gonormal = gohelper.findChild(self.viewGO, "anim/right/#go_normal")
	self._btnhardmode = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_hard/go/#btn_hardmode")
	self._btnhardmodetip = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_hard/go/#btn_hardmodetip")
	self._gohard = gohelper.findChild(self.viewGO, "anim/right/#go_hard")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "anim/bgmask/#simage_normalbg")
	self._simagehardbg = gohelper.findChildSingleImage(self.viewGO, "anim/bgmask/#simage_hardbg")
	self._imagehardstatus = gohelper.findChildImage(self.viewGO, "anim/right/#go_hard/#image_hardstatus")
	self._btnnormalmode = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_normal/#btn_normalmode")
	self._txtpower = gohelper.findChildText(self.viewGO, "anim/right/power/#txt_power")
	self._simagepower1 = gohelper.findChildSingleImage(self.viewGO, "anim/right/power/#simage_power1")
	self._txtrule = gohelper.findChildText(self.viewGO, "anim/right/condition/#go_additionRule/#txt_rule")
	self._goruletemp = gohelper.findChild(self.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "anim/right/condition/#go_additionRule/#go_rulelist")
	self._godefault = gohelper.findChild(self.viewGO, "anim/right/condition/#go_default")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "anim/right/reward/#scroll_reward")
	self._gooperation = gohelper.findChild(self.viewGO, "anim/right/#go_operation")
	self._gostart = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_operation/#go_start/#btn_start")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_equipmap/#btn_equip")
	self._txtchallengecountlimit = gohelper.findChildText(self.viewGO, "anim/right/#go_operation/#go_start/#txt_challengecountlimit")
	self._gonormal2 = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_normal2")
	self._goticket = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket")
	self._btnshowtickets = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#btn_showtickets")
	self._goticketlist = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketlist")
	self._goticketItem = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem")
	self._goticketinfo = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo")
	self._simageticket = gohelper.findChildSingleImage(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#simage_ticket")
	self._txtticket = gohelper.findChildText(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#txt_ticket")
	self._gonoticket = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket")
	self._txtnoticket1 = gohelper.findChildText(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket1")
	self._txtnoticket2 = gohelper.findChildText(self.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket2")
	self._golock = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_lock")
	self._goequipmap = gohelper.findChild(self.viewGO, "anim/right/#go_equipmap")
	self._txtcostcount = gohelper.findChildText(self.viewGO, "anim/right/#go_equipmap/#btn_equip/#txt_num")
	self._gofightcountbg = gohelper.findChild(self.viewGO, "anim/right/#go_equipmap/fightcount/#go_fightcountbg")
	self._txtfightcount = gohelper.findChildText(self.viewGO, "anim/right/#go_equipmap/fightcount/#txt_fightcount")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#go_operation/#go_lock/#btn_lock")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#btn_story")
	self._btnviewstory = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/#btn_viewstory")
	self._txtget = gohelper.findChildText(self.viewGO, "anim/right/reward_container/#go_reward/#txt_get")
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self._gorewarditem = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_rewarditem")
	self._goreward = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward")
	self._gorewardList = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward/rewardList")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/reward_container/#go_reward/#btn_reward")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title1")
	self._txttitle3 = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title3")
	self._txtchapterindex = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title3/#txt_chapterindex")
	self._txttitle4 = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title1/#txt_title4")
	self._txtdesc = gohelper.findChildText(self.viewGO, "anim/right/#txt_desc")
	self._gorecommond = gohelper.findChild(self.viewGO, "anim/right/recommend")
	self._txtrecommondlv = gohelper.findChildText(self.viewGO, "anim/right/recommend/#txt_recommendlv")
	self._simagepower2 = gohelper.findChildSingleImage(self.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#simage_power2")
	self._txtusepower = gohelper.findChildText(self.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#txt_usepower")
	self._simagepower3 = gohelper.findChildSingleImage(self.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#simage_power3")
	self._txtusepowerhard = gohelper.findChildText(self.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#txt_usepowerhard")
	self._gostartnormal = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal")
	self._gostarthard = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start/#go_starthard")
	self._gohardmodedecorate = gohelper.findChild(self.viewGO, "anim/right/title/#txt_title1/#go_hardmodedecorate")
	self._gostar = gohelper.findChild(self.viewGO, "anim/right/title/#go_star")
	self._gonoreward = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_noreward")
	self._gostoryline = gohelper.findChild(self.viewGO, "anim/right/#go_storyline")
	self._goselecthardbg = gohelper.findChild(self.viewGO, "anim/right/#go_hard/go/#go_selecthardbg")
	self._gounselecthardbg = gohelper.findChild(self.viewGO, "anim/right/#go_hard/go/#go_unselecthardbg")
	self._goselectnormalbg = gohelper.findChild(self.viewGO, "anim/right/#go_normal/#go_selectnormalbg")
	self._gounselectnormalbg = gohelper.findChild(self.viewGO, "anim/right/#go_normal/#go_unselectnormalbg")
	self._golockbg = gohelper.findChild(self.viewGO, "anim/right/#go_hard/go/#go_lockbg")
	self._txtLockTime = gohelper.findChildTextMesh(self.viewGO, "anim/right/#go_hard/go/#go_lockbg/#txt_locktime")
	self._gonormalrewardbg = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward/#go_normalrewardbg")
	self._gohardrewardbg = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward/#go_hardrewardbg")
	self._gonormallackpower = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#go_normallackpower")
	self._gohardlackpower = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#go_hardlackpower")
	self._goboss = gohelper.findChild(self.viewGO, "anim/right/#go_boss")
	self._gonormaleye = gohelper.findChild(self.viewGO, "anim/right/#go_boss/#go_normaleye")
	self._gohardeye = gohelper.findChild(self.viewGO, "anim/right/#go_boss/#go_hardeye")
	self._goTurnBackAddition = gohelper.findChild(self.viewGO, "anim/right/turnback_tips")
	self._txtTurnBackAdditionTips = gohelper.findChildText(self.viewGO, "anim/right/turnback_tips/#txt_des")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapLevelView_bake:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnhardmode:AddClickListener(self._btnhardmodeOnClick, self)
	self._btnhardmodetip:AddClickListener(self._btnhardmodetipOnClick, self)
	self._btnnormalmode:AddClickListener(self._btnnormalmodeOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnshowtickets:AddClickListener(self._btnshowticketsOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshTurnBack, self)
end

function DungeonMapLevelView_bake:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
	self._btnhardmodetip:RemoveClickListener()
	self._btnnormalmode:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnshowtickets:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshTurnBack, self)
end

DungeonMapLevelView_bake.AudioConfig = {
	[DungeonEnum.ChapterListType.Story] = {
		onOpen = AudioEnum.UI.play_ui_checkpoint_pagesopen,
		onClose = AudioEnum.UI.UI_role_introduce_close
	},
	[DungeonEnum.ChapterListType.Resource] = {
		onOpen = AudioEnum.UI.play_ui_checkpoint_sources_open,
		onClose = AudioEnum.UI.UI_role_introduce_close
	},
	[DungeonEnum.ChapterListType.Insight] = {
		onOpen = AudioEnum.UI.UI_checkpoint_Insight_open,
		onClose = AudioEnum.UI.UI_role_introduce_close
	}
}

function DungeonMapLevelView_bake:_btncloseviewOnClick()
	TaskDispatcher.runDelay(self.closeThis, self, 0)
end

function DungeonMapLevelView_bake:_btnrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self._config)
end

function DungeonMapLevelView_bake:_btnshowrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self._config)
end

function DungeonMapLevelView_bake:_btnhardmodeOnClick()
	self:_showHardMode(true, true)
end

function DungeonMapLevelView_bake:_btnhardmodetipOnClick()
	if self._config == self._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		local openEpisodeId = lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId
		local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openEpisodeId)

		GameFacade.showToast(ToastEnum.DungeonMapLevel, episodeDisplay)

		return
	end

	local hardEpisode = DungeonConfig.instance:getHardEpisode(self._episodeId)

	if hardEpisode and DungeonModel.instance:episodeIsInLockTime(hardEpisode.id) then
		GameFacade.showToastString(self._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(self._config.id) or self._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function DungeonMapLevelView_bake:_btnnormalmodeOnClick()
	self:_showHardMode(false, true)
end

function DungeonMapLevelView_bake:_showHardMode(hardMode, manually)
	if hardMode then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

			return
		end

		self._config = self._hardEpisode
	else
		if not self._hardEpisode then
			return
		end

		self._config = DungeonConfig.instance:getEpisodeCO(self._hardEpisode.preEpisode)
	end

	self._episodeItemParam.index = self._levelIndex
	self._episodeItemParam.isHardMode = hardMode

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, self._episodeItemParam)
	self:_updateEpisodeInfo()
	self:onUpdate(hardMode, manually)

	if manually then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function DungeonMapLevelView_bake:_updateEpisodeInfo()
	self._episodeInfo = DungeonModel.instance:getEpisodeInfo(self._config.id)
	self._curSpeed = 1
end

function DungeonMapLevelView_bake:_btnlockOnClick()
	local toastParam = DungeonModel.instance:getCantChallengeToast(self._config)

	if toastParam then
		GameFacade.showToast(ToastEnum.CantChallengeToast, toastParam)
	end
end

function DungeonMapLevelView_bake:_btnstoryOnClick()
	local hasAllPass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(self._config.afterStory, param, function()
		self:onStoryStatus()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		local allPass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)

		if allPass and allPass ~= hasAllPass then
			DungeonController.instance:showUnlockContentToast(self._config.id)
		end

		ViewMgr.instance:closeView(self.viewName)
	end, self)
end

function DungeonMapLevelView_bake:_showStoryPlayBackBtn(storyId, go, txt)
	local visible = storyId > 0 and StoryModel.instance:isStoryFinished(storyId)

	gohelper.setActive(go, visible)

	if visible then
		DungeonLevelItem.showEpisodeName(self._config, self._chapterIndex, self._levelIndex, txt)
	end
end

function DungeonMapLevelView_bake:_showMiddleStoryPlayBackBtn(go, txt)
	local list = StoryConfig.instance:getEpisodeFightStory(self._config)
	local visible = #list > 0

	for i, storyId in ipairs(list) do
		if not StoryModel.instance:isStoryFinished(storyId) then
			visible = false

			break
		end
	end

	gohelper.setActive(go, visible)

	if visible then
		DungeonLevelItem.showEpisodeName(self._config, self._chapterIndex, self._levelIndex, txt)
	end
end

function DungeonMapLevelView_bake:_btnshowticketsOnClick()
	return
end

function DungeonMapLevelView_bake:_playMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(self._config.beforeStory, param, self.onStoryFinished, self)
end

function DungeonMapLevelView_bake:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(self.viewName)
end

function DungeonMapLevelView_bake:_btnequipOnClick()
	self:_enterFight()
end

function DungeonMapLevelView_bake:_btnstartOnClick()
	if self._config.type == DungeonEnum.EpisodeType.Story then
		self:_playMainStory()

		return
	end

	local limitType, limitCount, challengeCount = DungeonModel.instance:getEpisodeChallengeCount(self._episodeId)

	if limitType > 0 and limitCount > 0 and limitCount <= challengeCount then
		GameFacade.showToast(ToastEnum.DungeonMapLevel3, limitType == DungeonEnum.ChallengeCountLimitType.Daily and luaLang("time_day2") or limitType == DungeonEnum.ChallengeCountLimitType.Weekly and luaLang("time_week") or luaLang("time_month"))

		return
	end

	if not self._hardMode and limitType > 0 and limitCount > 0 and limitCount < challengeCount then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	if chapterCo.type == DungeonEnum.ChapterType.RoleStory then
		self:_startRoleStory()

		return
	end

	if self._config.beforeStory > 0 then
		if self._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(self._config.afterStory) then
				self:_playStoryAndEnterFight(self._config.beforeStory)

				return
			end
		elseif self._episodeInfo.star <= DungeonEnum.StarType.None then
			self:_playStoryAndEnterFight(self._config.beforeStory)

			return
		end
	end

	self:_enterFight()
end

function DungeonMapLevelView_bake:_startRoleStory()
	if self._config.beforeStory > 0 then
		self:_playStoryAndEnterFight(self._config.beforeStory, true)

		return
	end

	self:_enterFight()
end

function DungeonMapLevelView_bake:_playStoryAndEnterFight(storyId, noCheckFinish)
	if not noCheckFinish and StoryModel.instance:isStoryFinished(storyId) then
		self:_enterFight()

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(storyId, param, self._enterFight, self)
end

function DungeonMapLevelView_bake:_enterFight()
	if self._enterConfig then
		DungeonModel.instance:setLastSelectMode(self._hardMode, self._enterConfig.id)
	end

	local config = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if self._hardMode then
		DungeonFightController.instance:enterFight(config.chapterId, self._episodeId, self._curSpeed)
	else
		DungeonFightController.instance:enterFight(config.chapterId, self._episodeId, self._curSpeed)
	end
end

function DungeonMapLevelView_bake:_editableInitView()
	self._hardMode = false

	local animGO = gohelper.findChild(self.viewGO, "anim")

	self._animator = animGO and animGO:GetComponent(typeof(UnityEngine.Animator))
	self._simageList = self:getUserDataTb_()

	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	self._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)

	self._rewarditems = self:getUserDataTb_()
	self._enemyitems = self:getUserDataTb_()
	self._episodeItemParam = self:getUserDataTb_()

	gohelper.removeUIClickAudio(self._btncloseview.gameObject)
	gohelper.removeUIClickAudio(self._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(self._btnhardmode.gameObject)
	gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.UI.Play_UI_General_OK)
	self:_initStar()
end

function DungeonMapLevelView_bake:_initStar()
	gohelper.setActive(self._gostar, true)

	self._starImgList = self:getUserDataTb_()

	local transform = self._gostar.transform
	local itemCount = transform.childCount

	for i = 1, itemCount do
		local child = transform:GetChild(i - 1)
		local img = child:GetComponent(gohelper.Type_Image)

		table.insert(self._starImgList, img)
	end
end

function DungeonMapLevelView_bake:showStatus()
	local normalEpisodeId = self._config.id
	local hardOpen = DungeonModel.instance:isOpenHardDungeon(self._config.chapterId)

	if normalEpisodeId then
		::label_27_0::

		local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)
		local normalEpisodeInfo = self._episodeInfo
		local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(self._config.id)

		if hardEpisodeConfig then
			::label_27_1::

			local hardEpisodeInfo = DungeonModel.instance:getEpisodeInfo(hardEpisodeConfig.id)
			local starImg4 = self._starImgList[4]
			local starImg3 = self._starImgList[3]
			local starImg2 = self._starImgList[2]

			self:_setStar(self._starImgList[1], normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory, 1)

			if not string.nilorempty(advancedConditionText) then
				self:_setStar(starImg2, normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory, 2)

				if hardEpisodeConfig then
					local inLock = DungeonModel.instance:episodeIsInLockTime(hardEpisodeConfig.id)

					gohelper.setActive(starImg3, not inLock)
					gohelper.setActive(starImg4, not inLock)
				end

				if hardEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and hardOpen and passStory then
					self:_setStar(starImg3, hardEpisodeInfo.star >= DungeonEnum.StarType.Normal, 3)
					self:_setStar(starImg4, hardEpisodeInfo.star >= DungeonEnum.StarType.Advanced, 4)
				end
			end
		end
	end
end

function DungeonMapLevelView_bake:_setStar(image, light, index)
	local color = "#9B9B9B"

	if light then
		color = index > 2 and "#FF4343" or "#F97142"
		image.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(image, color)
end

function DungeonMapLevelView_bake:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:refreshCostPower()
end

function DungeonMapLevelView_bake:onUpdateParam()
	TaskDispatcher.cancelTask(self.closeThis, self)
	self:_initInfo()
	self.viewContainer:refreshHelp()
	self:showStatus()
	self:_doUpdate()
end

function DungeonMapLevelView_bake:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function DungeonMapLevelView_bake:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local go = gohelper.clone(self._goruleitem, self._goruleDescList, ruleCo.id)

	gohelper.setActive(go, true)

	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local line = gohelper.findChild(go, "line")

	table.insert(self._rulesimagelineList, line)

	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")
	local targetName = luaLang("dungeon_add_rule_target_" .. targetId)

	desc.text = string.format("<color=%s>[%s]</color>%s", tagColor[targetId], targetName, ruleCo.desc)
end

function DungeonMapLevelView_bake:onOpen()
	self:_initInfo()
	self:showStatus()
	self:_doUpdate()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUnlockNewChapter, self._OnUnlockNewChapter, self)
	self:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, self.viewContainer.refreshHelp, self.viewContainer)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, self._btncloseOnClick, self)
end

function DungeonMapLevelView_bake:_onUpdateDungeonInfo()
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	self:showFree(chapterCo)
end

function DungeonMapLevelView_bake:_OnUnlockNewChapter()
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView_bake)
end

function DungeonMapLevelView_bake:_doUpdate()
	local hard = self.viewParam[5]

	if hard == nil then
		local lastMode, episodeId = DungeonModel.instance:getLastSelectMode()

		if self._enterConfig and episodeId == self._enterConfig.id then
			hard = DungeonModel.instance:getLastSelectMode()
		end
	end

	DungeonModel.instance:setLastSelectMode(nil, nil)

	if hard and self._episodeInfo.star == DungeonEnum.StarType.Advanced then
		self._hardEpisode = DungeonConfig.instance:getHardEpisode(self._config.id)

		if self._hardEpisode then
			self:_showHardMode(true)
			self._animator:Play("dungeonlevel_in_hard", 0, 0)

			return
		end
	end

	self:onUpdate()
	self._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function DungeonMapLevelView_bake:_initInfo()
	self._hardEpisode = nil
	self._enterConfig = self.viewParam[1]
	self._config = self.viewParam[1]
	self._chapterIndex = self.viewParam[3]
	self._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(self._config.chapterId, self._config.id)

	self:_updateEpisodeInfo()

	local isJumpOpen = self.viewParam[6]

	if isJumpOpen then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, self._config.id)
	end
end

DungeonMapLevelView_bake.BtnOutScreenTime = 0.3

function DungeonMapLevelView_bake:onUpdate(hardModeArg, manually)
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)
	local hardMode = chapterCo.type == DungeonEnum.ChapterType.Hard

	if self._hardMode ~= hardMode and self._animator then
		local animName = hardMode and "hard" or "normal"

		self._animator:Play(animName, 0, 0)
		self._animator:Update(0)
	end

	self._hardMode = hardMode

	self._gonormal2:SetActive(false)

	if manually then
		TaskDispatcher.cancelTask(self._delayToSwitchStartBtn, self)
		TaskDispatcher.runDelay(self._delayToSwitchStartBtn, self, DungeonMapLevelView_bake.BtnOutScreenTime)
	else
		self:_delayToSwitchStartBtn()
	end

	gohelper.setActive(self._simagenormalbg.gameObject, not self._hardMode)
	gohelper.setActive(self._simagehardbg.gameObject, self._hardMode)
	gohelper.setActive(self._gohardmodedecorate, self._hardMode)
	gohelper.setActive(self._goselecthardbg, self._hardMode)
	gohelper.setActive(self._gounselecthardbg, not self._hardMode)
	gohelper.setActive(self._goselectnormalbg, not self._hardMode)
	gohelper.setActive(self._gounselectnormalbg, self._hardMode)
	gohelper.setActive(self._gonormalrewardbg, not self._hardMode)
	gohelper.setActive(self._gohardrewardbg, self._hardMode)

	self._episodeId = self._config.id

	local power = CurrencyModel.instance:getPower()
	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")

	self._simagepower2:LoadImage(powerIcon)
	self._simagepower3:LoadImage(powerIcon)
	gohelper.setActive(self._goboss, self:_isBossTypeEpisode())
	gohelper.setActive(self._gonormaleye, not self._hardMode)
	gohelper.setActive(self._gohardeye, self._hardMode)

	if self._config.battleId ~= 0 then
		gohelper.setActive(self._gorecommond.gameObject, true)

		local recommendLv = FightHelper.getEpisodeRecommendLevel(self._episodeId)

		if recommendLv ~= 0 then
			gohelper.setActive(self._gorecommond.gameObject, true)

			self._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(recommendLv)
		else
			gohelper.setActive(self._gorecommond.gameObject, false)
		end
	else
		gohelper.setActive(self._gorecommond.gameObject, false)
	end

	self:setTitle()
	self:showFree(chapterCo)

	self._txttitle3.text = string.format("%02d", self._levelIndex)
	self._txtchapterindex.text = chapterCo.chapterIndex
	self._txtdesc.text = self._config.desc or ""

	if manually then
		TaskDispatcher.cancelTask(self.refreshCostPower, self)
		TaskDispatcher.runDelay(self.refreshCostPower, self, DungeonMapLevelView_bake.BtnOutScreenTime)
	else
		self:refreshCostPower()
	end

	self:refreshChallengeLimit()
	self:refreshTurnBackAdditionTips()
	self:showReward()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.refreshChallengeLimit, self)
	self:onStoryStatus()
end

function DungeonMapLevelView_bake:_isBossTypeEpisode()
	if self._hardMode then
		if self._config.preEpisode then
			local normalEpisodeId = self._config.preEpisode
			local config = DungeonConfig.instance:getEpisodeCO(normalEpisodeId)

			return config.displayMark == 1
		end

		return self._config.displayMark == 1
	else
		return self._config.displayMark == 1
	end
end

function DungeonMapLevelView_bake:_delayToSwitchStartBtn()
	gohelper.setActive(self._gostartnormal, not self._hardMode)
	gohelper.setActive(self._gostarthard, self._hardMode)
end

function DungeonMapLevelView_bake:showFree(chapterCo)
	local enterAfterFreeLimit = chapterCo.enterAfterFreeLimit > 0

	gohelper.setActive(self._gorighttop, not enterAfterFreeLimit)

	self._enterAfterFreeLimit = enterAfterFreeLimit

	if not enterAfterFreeLimit then
		return
	end

	local freeNum = DungeonModel.instance:getChapterRemainingNum(chapterCo.type)

	if freeNum <= 0 then
		enterAfterFreeLimit = false
	end

	gohelper.setActive(self._goequipmap, enterAfterFreeLimit)
	gohelper.setActive(self._gooperation, not enterAfterFreeLimit)
	gohelper.setActive(self._gorighttop, not enterAfterFreeLimit)

	self._enterAfterFreeLimit = enterAfterFreeLimit

	if not enterAfterFreeLimit then
		return
	end

	self._txtfightcount.text = freeNum == 0 and string.format("<color=#b3afac>%s</color>", freeNum) or freeNum

	gohelper.setActive(self._gofightcountbg, freeNum ~= 0)
	self:_refreshFreeCost()
end

function DungeonMapLevelView_bake:_refreshFreeCost()
	self._txtcostcount.text = -1 * self._curSpeed
end

function DungeonMapLevelView_bake:showViewStory()
	local storyIds = StoryConfig.instance:getEpisodeStoryIds(self._config)
	local isShow = false

	for i, storyId in ipairs(storyIds) do
		if StoryModel.instance:isStoryFinished(storyId) then
			isShow = true

			break
		end
	end

	if not isShow then
		return
	end
end

function DungeonMapLevelView_bake:refreshChallengeLimit()
	local limitType, limitCount, challengeCount = DungeonModel.instance:getEpisodeChallengeCount(self._episodeId)

	self._txtchallengecountlimit.text = limitType > 0 and limitCount > 0 and string.format("%s%s (%d/%d)", limitType == DungeonEnum.ChallengeCountLimitType.Daily and luaLang("daily") or limitType == DungeonEnum.ChallengeCountLimitType.Weekly and luaLang("weekly") or luaLang("monthly"), luaLang("times"), math.max(0, limitCount - self._episodeInfo.challengeCount), limitCount) or ""
	self._isCanChallenge, self._challengeLockCode = DungeonModel.instance:isCanChallenge(self._config)

	gohelper.setActive(self._gostart, self._isCanChallenge)
	gohelper.setActive(self._golock, not self._isCanChallenge)
end

function DungeonMapLevelView_bake:refreshTurnBackAdditionTips()
	local isShowAddition = TurnbackModel.instance:isShowTurnBackAddition(self._config.chapterId)

	if isShowAddition then
		local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
		local strCount = string.format("%s/%s", remainCount, totalCount)

		self._txtTurnBackAdditionTips.text = formatLuaLang("turnback_addition_times", strCount)
	end

	gohelper.setActive(self._goTurnBackAddition, isShowAddition)
end

function DungeonMapLevelView_bake:onStoryStatus()
	local showStory = false
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	if self._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(self._config.afterStory) and self._episodeInfo.star > DungeonEnum.StarType.None then
		showStory = true
	end

	self._gooperation:SetActive(not showStory and not self._enterAfterFreeLimit)
	self._btnstory.gameObject:SetActive(showStory)

	if showStory then
		self:refreshHardMode()
		self._btnhardmode.gameObject:SetActive(false)
	elseif not self._hardMode then
		self:refreshHardMode()
	else
		self._btnHardModeActive = false

		TaskDispatcher.cancelTask(self._delaySetActive, self)
		TaskDispatcher.runDelay(self._delaySetActive, self, 0.2)
	end

	self:showViewStory()

	local isNormalType, isResourceType, isBreakType = DungeonModel.instance:getChapterListTypes()
	local isRoleStory = DungeonModel.instance:chapterListIsRoleStory()
	local isNeedShowSwitch = (not isNormalType or self._config.type ~= DungeonEnum.EpisodeType.Story) and not isResourceType and not isBreakType and not isRoleStory

	gohelper.setActive(self._gonormal, isNeedShowSwitch)
	gohelper.setActive(self._gohard, isNeedShowSwitch)
	gohelper.setActive(self._gostar, isNeedShowSwitch)
	recthelper.setAnchorY(self._txtdesc.transform, isNeedShowSwitch and 56.6 or 129.1)
	recthelper.setAnchorY(self._gorecommond.transform, isNeedShowSwitch and 87.3 or 168.4)
	TaskDispatcher.cancelTask(self._checkLockTime, self)
	TaskDispatcher.runRepeat(self._checkLockTime, self, 1)
end

function DungeonMapLevelView_bake:_checkLockTime()
	local hardEpisode = DungeonConfig.instance:getHardEpisode(self._episodeId)
	local lastState = not not self.isInLockTime

	self.isInLockTime = not not (hardEpisode and DungeonModel.instance:episodeIsInLockTime(hardEpisode.id))

	if lastState ~= self.isInLockTime then
		self:showStatus()
		self:onStoryStatus()
	elseif self.isInLockTime then
		local nowTime = ServerTime.now()
		local timeParam = string.splitToNumber(hardEpisode.lockTime, "#")

		self._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(timeParam[2] / 1000 - ServerTime.now())))
	end
end

function DungeonMapLevelView_bake:refreshHardMode()
	if self._hardMode then
		return
	end

	self._hardEpisode = DungeonConfig.instance:getHardEpisode(self._episodeId)

	local hardActive = false

	if self._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local hardOpen = DungeonModel.instance:isOpenHardDungeon(self._config.chapterId)

		hardActive = self._hardEpisode ~= nil and hardOpen
	end

	if self._hardEpisode and DungeonModel.instance:episodeIsInLockTime(self._hardEpisode.id) then
		hardActive = false

		gohelper.setActive(self._txtLockTime, true)

		local nowTime = ServerTime.now()
		local timeParam = string.splitToNumber(self._hardEpisode.lockTime, "#")

		self._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(timeParam[2] / 1000 - ServerTime.now())))
		self._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(self._txtLockTime, false)

		self._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	self._btnhardmode.gameObject:SetActive(hardActive)
	gohelper.setActive(self._golockbg, not hardActive)

	self._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = hardActive and 1 or 0.3
	self._btnHardModeActive = hardActive
end

function DungeonMapLevelView_bake:_delaySetActive()
	self._btnhardmode.gameObject:SetActive(self._btnHardModeActive)
end

function DungeonMapLevelView_bake:refreshCostPower()
	local costs = string.split(self._config.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber((not cost1[3] or nil) and 0) * self._curSpeed

	self._txtusepower.text = "-" .. value
	self._txtusepowerhard.text = "-" .. value

	if value <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(self._gonormallackpower, false)
		gohelper.setActive(self._gohardlackpower, false)
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#C44945")
		gohelper.setActive(self._gonormallackpower, not self._hardMode)
		gohelper.setActive(self._gohardlackpower, self._hardMode)
	end
end

function DungeonMapLevelView_bake:showReward()
	local episodeInfo = self._episodeInfo
	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0

	self.listenerActDict = nil

	if episodeInfo.star == DungeonEnum.StarType.None then
		local rewards, actDict = Activity135Model.instance:getActivityShowReward(self._episodeId)

		self.listenerActDict = actDict

		if rewards and #rewards > 0 then
			tabletool.addValues(rewardList, rewards)
		end
	end

	if episodeInfo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeAdvancedBonus(self._episodeId))

		advancedRewardIndex = #rewardList
	end

	if episodeInfo.star == DungeonEnum.StarType.None then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(self._episodeId))

		firstRewardIndex = #rewardList
	end

	local flagCount = #rewardList
	local isFree
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	if chapterCo.enterAfterFreeLimit > 0 then
		local freeNum = DungeonModel.instance:getChapterRemainingNum(chapterCo.type)

		if freeNum > 0 then
			tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFreeDisplayList(self._episodeId))

			isFree = true
		end
	end

	self._txtget.text = luaLang(isFree and "p_dungeonmaplevelview_specialdrop" or "p_dungeonmaplevelview_get")

	local commonRewardList = {}
	local isResourceType = chapterCo.type == DungeonEnum.ChapterType.Gold or chapterCo.type == DungeonEnum.ChapterType.Exp

	if isResourceType then
		commonRewardList = DungeonModel.instance:getEpisodeBonus(self._episodeId)

		tabletool.addValues(rewardList, commonRewardList)
	else
		commonRewardList = DungeonModel.instance:getEpisodeRewardDisplayList(self._episodeId)

		tabletool.addValues(rewardList, commonRewardList)
	end

	local isShowAddition = TurnbackModel.instance:isShowTurnBackAddition(self._config.chapterId)

	if isShowAddition then
		local additionRewardList = TurnbackModel.instance:getAdditionRewardList(commonRewardList)

		tabletool.addValues(rewardList, additionRewardList)
	end

	gohelper.setActive(self._gonoreward, #rewardList == 0)

	local count = math.min(#rewardList, 3)

	for i = 1, count do
		local rewardTable = self._rewarditems[i]
		local reward = rewardList[i]

		if not rewardTable then
			rewardTable = self:getUserDataTb_()
			rewardTable.go = gohelper.clone(self._gorewarditem, self._gorewardList, "item" .. i)
			rewardTable.txtcount = gohelper.findChildText(rewardTable.go, "countbg/count")
			rewardTable.gofirst = gohelper.findChild(rewardTable.go, "rare/#go_rare2")
			rewardTable.goadvance = gohelper.findChild(rewardTable.go, "rare/#go_rare3")
			rewardTable.gofirsthard = gohelper.findChild(rewardTable.go, "rare/#go_rare4")
			rewardTable.gonormal = gohelper.findChild(rewardTable.go, "rare/#go_rare1")
			rewardTable.txtnormal = gohelper.findChildText(rewardTable.go, "rare/#go_rare1/txt")
			rewardTable.goAddition = gohelper.findChild(rewardTable.go, "turnback")
			rewardTable.gocount = gohelper.findChild(rewardTable.go, "countbg")
			rewardTable.itemIconGO = gohelper.findChild(rewardTable.go, "itemicon")
			rewardTable.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardTable.itemIconGO)

			rewardTable.itemIcon:isShowAddition(false)

			rewardTable.golimitfirst = gohelper.findChild(rewardTable.go, "limitfirst")
			rewardTable.txtlimittime = gohelper.findChildText(rewardTable.go, "limitfirst/#txt_time")

			function rewardTable.refreshLimitTime(rewardItemTable)
				if rewardItemTable.rewardData.isLimitFirstReward then
					local actInfo = ActivityModel.instance:getActMO(rewardItemTable.rewardData.activityId)

					if actInfo then
						local limitSec = actInfo:getRealEndTimeStamp() - ServerTime.now()

						rewardItemTable.txtlimittime.text = formatLuaLang("remain", string.format("%s%s", TimeUtil.secondToRoughTime(limitSec)))
					end
				else
					TaskDispatcher.cancelTask(rewardItemTable.refreshLimitTime, rewardItemTable)
				end
			end

			table.insert(self._rewarditems, rewardTable)
		end

		rewardTable.rewardData = reward

		rewardTable.itemIcon:setMOValue(reward[1], reward[2], reward[3], nil, true)
		gohelper.setActive(rewardTable.gofirst, false)
		gohelper.setActive(rewardTable.goadvance, false)
		gohelper.setActive(rewardTable.gofirsthard, false)
		gohelper.setActive(rewardTable.gonormal, false)
		gohelper.setActive(rewardTable.goAddition, false)
		gohelper.setActive(rewardTable.golimitfirst, false)
		TaskDispatcher.cancelTask(rewardTable.refreshLimitTime, rewardTable)

		if i <= flagCount or isResourceType and not isFree then
			if reward.isLimitFirstReward then
				gohelper.setActive(rewardTable.golimitfirst, true)
			elseif i <= advancedRewardIndex then
				gohelper.setActive(rewardTable.goadvance, true)
			elseif i <= firstRewardIndex then
				gohelper.setActive(rewardTable.gofirst, not self._hardMode)
				gohelper.setActive(rewardTable.gofirsthard, self._hardMode)
			end

			gohelper.setActive(rewardTable.gocount, true)

			if rewardTable.itemIcon:isEquipIcon() then
				rewardTable.itemIcon:ShowEquipCount(rewardTable.gocount, rewardTable.txtcount)
			else
				rewardTable.itemIcon:showStackableNum2(rewardTable.gocount, rewardTable.txtcount)
			end

			gohelper.setActive(rewardTable.goAddition, reward.isAddition)
			TaskDispatcher.runRepeat(rewardTable.refreshLimitTime, rewardTable, 1)
			rewardTable:refreshLimitTime()
		else
			if not reward.isAddition then
				local probabilityFlag = reward[3]

				gohelper.setActive(rewardTable.gonormal, true)

				rewardTable.txtnormal.text = luaLang("dungeon_prob_flag" .. probabilityFlag)
			end

			gohelper.setActive(rewardTable.gocount, false)
		end

		gohelper.setActive(rewardTable.goAddition, reward.isAddition)
		rewardTable.itemIcon:isShowEquipAndItemCount(false)
		rewardTable.itemIcon:setHideLvAndBreakFlag(true)
		rewardTable.itemIcon:setShowCountFlag(false)
		rewardTable.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(rewardTable.go, true)
	end

	for i = count + 1, #self._rewarditems do
		gohelper.setActive(self._rewarditems[i].go)
	end

	gohelper.setActive(self._goreward, count > 0)
end

function DungeonMapLevelView_bake:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
	AudioMgr.instance:trigger(self:getCurrentChapterListTypeAudio().onClose)

	self._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, self._episodeItemParam)

	if self._rewarditems then
		for i, v in ipairs(self._rewarditems) do
			TaskDispatcher.cancelTask(v.refreshLimitTime, v)
		end
	end
end

function DungeonMapLevelView_bake:onCloseFinish()
	return
end

function DungeonMapLevelView_bake:clearRuleList()
	self._simageList = self:getUserDataTb_()

	for k, v in pairs(self._rulesimageList) do
		v:UnLoadImage()
	end

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()

	gohelper.destroyAllChildren(self._gorulelist)
	gohelper.destroyAllChildren(self._goruleDescList)
end

function DungeonMapLevelView_bake:onDestroyView()
	self._simagepower2:UnLoadImage()
	self._simagepower3:UnLoadImage()
	self._simagenormalbg:UnLoadImage()
	self._simagehardbg:UnLoadImage()

	for k, v in pairs(self._rulesimageList) do
		v:UnLoadImage()
	end

	for i = 1, #self._enemyitems do
		local enemyTable = self._enemyitems[i]

		enemyTable.simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self._delaySetActive, self)
	TaskDispatcher.cancelTask(self._delayToSwitchStartBtn, self)
	TaskDispatcher.cancelTask(self.refreshCostPower, self)
	TaskDispatcher.cancelTask(self._checkLockTime, self)
end

function DungeonMapLevelView_bake:setTitle()
	self._txttitle4.text = self._config.name_En

	local first = GameUtil.utf8sub(self._config.name, 1, 1)
	local sectionPosX

	self._txttitle1.text = first .. ((GameUtil.utf8len(self._config.name) >= 2 or nil) and string.format("<size=80>%s</size>", GameUtil.utf8sub(self._config.name, 2, GameUtil.utf8len(self._config.name) - 1)))

	ZProj.UGUIHelper.RebuildLayout(self._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(self._txttitle4.transform)
	recthelper.setAnchorX(self._txttitle3.transform, GameUtil.utf8len(self._config.name) > 2 and recthelper.getAnchorX(self._txttitle1.transform) + recthelper.getWidth(self._txttitle1.transform) or recthelper.getAnchorX(self._txttitle1.transform) + recthelper.getWidth(self._txttitle1.transform) + recthelper.getAnchorX(self._txttitle4.transform))
end

function DungeonMapLevelView_bake:getCurrentChapterListTypeAudio()
	local isNormalType, isResourceType, isBreakType = DungeonModel.instance:getChapterListTypes()
	local audio

	return isNormalType and DungeonMapLevelView_bake.AudioConfig[DungeonEnum.ChapterListType.Story] or isResourceType and DungeonMapLevelView_bake.AudioConfig[DungeonEnum.ChapterListType.Resource] or isBreakType and DungeonMapLevelView_bake.AudioConfig[DungeonEnum.ChapterListType.Insight] or DungeonMapLevelView_bake.AudioConfig[DungeonEnum.ChapterListType.Story]
end

function DungeonMapLevelView_bake:_onRefreshActivityState(actId)
	if not self.listenerActDict or not self.listenerActDict[actId] then
		return
	end

	self:showReward()
end

function DungeonMapLevelView_bake:_onDailyRefresh()
	self:_refreshTurnBack()
end

function DungeonMapLevelView_bake:_refreshTurnBack()
	self:refreshTurnBackAdditionTips()
	self:showReward()
end

return DungeonMapLevelView_bake
