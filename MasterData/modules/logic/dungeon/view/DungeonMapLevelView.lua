-- chunkname: @modules/logic/dungeon/view/DungeonMapLevelView.lua

module("modules.logic.dungeon.view.DungeonMapLevelView", package.seeall)

local DungeonMapLevelView = class("DungeonMapLevelView", BaseView)
local viewParamIdx = {
	isJumpOpen = 6
}

function DungeonMapLevelView:onInitView()
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
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self.titleList = {}

	local title1 = self:getUserDataTb_()

	title1._go = gohelper.findChild(self.viewGO, "anim/right/title")
	title1._txttitle1 = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title1")
	title1._txttitle3 = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title3")
	title1._txtchapterindex = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title3/#txt_chapterindex")
	title1._txttitle4 = gohelper.findChildText(self.viewGO, "anim/right/title/#txt_title1/#txt_title4")
	title1._gostar = gohelper.findChild(self.viewGO, "anim/right/title/#go_star")
	self.titleList[1] = title1

	local title2 = self:getUserDataTb_()

	title2._go = gohelper.findChild(self.viewGO, "anim/right/title2")
	title2._txttitle1 = gohelper.findChildText(self.viewGO, "anim/right/title2/#txt_title1")
	title2._txttitle3 = gohelper.findChildText(self.viewGO, "anim/right/title2/#txt_title3")
	title2._txtchapterindex = gohelper.findChildText(self.viewGO, "anim/right/title2/#txt_title3/#txt_chapterindex")
	title2._txttitle4 = gohelper.findChildText(self.viewGO, "anim/right/title2/#txt_title1/#txt_title4")
	title2._gostar = gohelper.findChild(self.viewGO, "anim/right/title2/#go_star")
	self.titleList[2] = title2
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
	self._gostoryline = gohelper.findChild(self.viewGO, "anim/right/#go_storyline")
	self._goselecthardbg = gohelper.findChild(self.viewGO, "anim/right/#go_hard/go/#go_selecthardbg")
	self._gounselecthardbg = gohelper.findChild(self.viewGO, "anim/right/#go_hard/go/#go_unselecthardbg")
	self._goselectnormalbg = gohelper.findChild(self.viewGO, "anim/right/#go_normal/#go_selectnormalbg")
	self._gounselectnormalbg = gohelper.findChild(self.viewGO, "anim/right/#go_normal/#go_unselectnormalbg")
	self._golockbg = gohelper.findChild(self.viewGO, "anim/right/#go_hard/go/#go_lockbg")
	self._txtLockTime = gohelper.findChildTextMesh(self.viewGO, "anim/right/#go_hard/go/#go_lockbg/#txt_locktime")
	self._gonormallackpower = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#go_normallackpower")
	self._gohardlackpower = gohelper.findChild(self.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#go_hardlackpower")
	self._goboss = gohelper.findChild(self.viewGO, "anim/right/#go_boss")
	self._gonormaleye = gohelper.findChild(self.viewGO, "anim/right/#go_boss/#go_normaleye")
	self._gohardeye = gohelper.findChild(self.viewGO, "anim/right/#go_boss/#go_hardeye")
	self._godoubletimes = gohelper.findChild(self.viewGO, "anim/right/#go_doubletimes")
	self._txtdoubletimes = gohelper.findChildTextMesh(self.viewGO, "anim/right/#go_doubletimes/#txt_doubletimes")
	self._goswitch = gohelper.findChild(self.viewGO, "anim/right/#go_switch")
	self._gostory = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_story")
	self._btnSimpleClick = gohelper.findChildButton(self.viewGO, "anim/right/#go_switch/#go_story/clickarea")
	self._goselectstorybg = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg")
	self._gounselectstorybg = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg")
	self._gonormalN = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_normal")
	self._btnNormalClick = gohelper.findChildButton(self.viewGO, "anim/right/#go_switch/#go_normal/clickarea")
	self._goselectnormalbgN = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg")
	self._gounselectnormalbgr = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right")
	self._gounselectnormalbgl = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left")
	self._gohardN = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_hard")
	self._btnHardClick = gohelper.findChildButton(self.viewGO, "anim/right/#go_switch/#go_hard/clickarea")
	self._goselecthardbgN = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg")
	self._gounselecthardbgN = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg")
	self._golockbgN = gohelper.findChild(self.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg")
	self._txtLockTimeN = gohelper.findChildTextMesh(self.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg/#txt_locktime")
	self._imgstorystar1s = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg/star1")
	self._imgstorystar1u = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg/star1")
	self._imgnormalstar1s = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star1")
	self._imgnormalstar2s = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star2")
	self._imgnormalstar1ru = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star1")
	self._imgnormalstar2ru = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star2")
	self._imgnormalstar1lu = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star1")
	self._imgnormalstar2lu = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star2")
	self._imghardstar1s = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star1")
	self._imghardstar2s = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star2")
	self._imghardstar1u = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star1")
	self._imghardstar2u = gohelper.findChildImage(self.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapLevelView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnhardmode:AddClickListener(self._btnhardmodeOnClick, self)
	self._btnhardmodetip:AddClickListener(self._btnhardmodetipOnClick, self)
	self._btnnormalmode:AddClickListener(self._btnnormalmodeOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnshowtickets:AddClickListener(self._btnshowticketsOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self._btnSimpleClick:AddClickListener(self._btnSimpleOnClick, self)
	self._btnNormalClick:AddClickListener(self._btnNormalOnClick, self)
	self._btnHardClick:AddClickListener(self._btnHardOnClick, self)
end

function DungeonMapLevelView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnhardmode:RemoveClickListener()
	self._btnhardmodetip:RemoveClickListener()
	self._btnnormalmode:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnshowtickets:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self._btnSimpleClick:RemoveClickListener()
	self._btnNormalClick:RemoveClickListener()
	self._btnHardClick:RemoveClickListener()
end

DungeonMapLevelView.AudioConfig = {
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

function DungeonMapLevelView:_btncloseviewOnClick()
	TaskDispatcher.runDelay(self.closeThis, self, 0)
end

function DungeonMapLevelView:_btnshowrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self._config)
end

function DungeonMapLevelView:_btnhardmodeOnClick()
	if self._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		self:_showHardDungeonOpenTip()

		return
	end

	local hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)

	if hardEpisode and DungeonModel.instance:episodeIsInLockTime(hardEpisode.id) then
		GameFacade.showToastString(self._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(self._enterConfig.id) or self._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	self._config = self._hardEpisode

	self:_showEpisodeMode(true, true)
end

function DungeonMapLevelView:_showHardDungeonOpenTip()
	local openEpisodeId = lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId
	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openEpisodeId)

	GameFacade.showToast(ToastEnum.DungeonMapLevel, episodeDisplay)
end

function DungeonMapLevelView:_btnhardmodetipOnClick()
	if self._config == self._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		self:_showHardDungeonOpenTip()

		return
	end

	local hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)

	if hardEpisode and DungeonModel.instance:episodeIsInLockTime(hardEpisode.id) then
		GameFacade.showToastString(self._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(self._config.id) or self._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function DungeonMapLevelView:_btnnormalmodeOnClick()
	if self._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	self._config = self._enterConfig

	self:_showEpisodeMode(false, true)
end

function DungeonMapLevelView:_showEpisodeMode(isHard, manually)
	self._episodeItemParam.index = self._levelIndex
	self._episodeItemParam.isHardMode = isHard
	self._episodeItemParam.episodeConfig = self._config
	self._episodeItemParam.immediately = not manually

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, self._episodeItemParam)
	self:_updateEpisodeInfo()
	self:onUpdate(isHard, manually)

	if manually then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function DungeonMapLevelView:_updateEpisodeInfo()
	self._episodeInfo = DungeonModel.instance:getEpisodeInfo(self._config.id)
	self._curSpeed = 1
end

function DungeonMapLevelView:_btnlockOnClick()
	local toastParam = DungeonModel.instance:getCantChallengeToast(self._config)

	if toastParam then
		GameFacade.showToast(ToastEnum.CantChallengeToast, toastParam)
	end
end

function DungeonMapLevelView:_btnstoryOnClick()
	if self._config.afterStory > 0 and StoryModel.instance:isStoryFinished(self._config.afterStory) and not DungeonMapModel.instance:checkStoryElementFinished(self._config.afterStory) then
		DungeonController.openStoryElementView(self._config.afterStory)
		ViewMgr.instance:closeView(self.viewName)

		return
	end

	if self._config.type == DungeonEnum.EpisodeType.Story then
		self:_playBeforeStoryElementView(true)

		return
	end

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

function DungeonMapLevelView:_showStoryPlayBackBtn(storyId, go, txt)
	local visible = storyId > 0 and StoryModel.instance:isStoryFinished(storyId)

	gohelper.setActive(go, visible)

	if visible then
		DungeonLevelItem.showEpisodeName(self._config, self._chapterIndex, self._levelIndex, txt)
	end
end

function DungeonMapLevelView:_showMiddleStoryPlayBackBtn(go, txt)
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

function DungeonMapLevelView:_btnshowticketsOnClick()
	return
end

function DungeonMapLevelView:_playMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	local extendStory = DungeonConfig.instance:getExtendStory(self._config.id)

	if extendStory then
		local storyList = {
			self._config.beforeStory,
			extendStory
		}

		StoryController.instance:playStories(storyList, param, self.onStoryFinished, self)
	else
		StoryController.instance:playStory(self._config.beforeStory, param, self.onStoryFinished, self)
	end
end

function DungeonMapLevelView:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(self.viewName)
	self:_playBeforeStoryElementView()
end

function DungeonMapLevelView:_playBeforeStoryElementView(openStoryElementView)
	if self._config.type == DungeonEnum.EpisodeType.Story and self._config.beforeStory > 0 and StoryModel.instance:isStoryFinished(self._config.beforeStory) and not DungeonMapModel.instance:checkStoryElementFinished(self._config.beforeStory) then
		if openStoryElementView then
			DungeonController.openStoryElementView(self._config.beforeStory)
		end

		ViewMgr.instance:closeView(self.viewName)

		return true
	end
end

function DungeonMapLevelView:_btnequipOnClick()
	if self:_checkEquipOverflow() then
		return
	end

	self:_enterFight()
end

function DungeonMapLevelView:_checkEquipOverflow()
	if self._chapterType == DungeonEnum.ChapterType.Equip then
		local equips = EquipModel.instance:getEquips()
		local count = tabletool.len(equips)
		local max = EquipConfig.instance:getEquipBackpackMaxCount()

		if max <= count then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.EquipOverflow, MsgBoxEnum.BoxType.Yes_No, luaLang("p_equipdecompose_decompose"), "DISSOCIATION", nil, nil, self._onChooseDecompose, self._onCancelDecompose, nil, self, self, nil)

			return true
		end
	end
end

function DungeonMapLevelView:_onChooseDecompose()
	EquipController.instance:openEquipDecomposeView()
end

function DungeonMapLevelView:_onCancelDecompose()
	self:_enterFight()
end

function DungeonMapLevelView:_btnstartOnClick()
	if DungeonEnum.MazeGamePlayEpisode[self._config.id] then
		self:_playStoryAndOpenMazePlayView()

		return
	end

	if DungeonMazeV3a7Enum.MazeGamePlayEpisode[self._config.id] then
		self:_playStoryAndOpenV3a7MazePlayView()

		return
	end

	if self._config.type == DungeonEnum.EpisodeType.Story then
		self:_playMainStory()

		return
	end

	local limitType, limitCount, challengeCount = DungeonModel.instance:getEpisodeChallengeCount(self._episodeId)

	if limitType > 0 and limitCount > 0 and limitCount <= challengeCount then
		GameFacade.showToast(ToastEnum.DungeonMapLevel3, limitType == DungeonEnum.ChallengeCountLimitType.Daily and luaLang("time_day2") or limitType == DungeonEnum.ChallengeCountLimitType.Weekly and luaLang("time_week") or luaLang("time_month"))

		return
	end

	if self._chapterType == DungeonEnum.ChapterType.Normal and limitType > 0 and limitCount > 0 and limitCount < challengeCount then
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

	if self:_checkEquipOverflow() then
		return
	end

	self:_enterFight()
end

function DungeonMapLevelView:_playStoryAndOpenV3a7MazePlayView()
	local storyId = self._config.beforeStory

	DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)

	local mazeGameProgress = DungeonMazeV3a7Model.instance:HasLocalProgress()

	if mazeGameProgress then
		self:_openV3a7MazePlayView(true)

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(storyId, param, self._openV3a7MazePlayView, self)
end

function DungeonMapLevelView:_openV3a7MazePlayView(existProgress)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self._config.id)

	local viewParams = {
		episodeCfg = self._config,
		existProgress = existProgress
	}

	DungeonMazeV3a7Controller.instance:openMazeGameView(viewParams)
end

function DungeonMapLevelView:_playStoryAndOpenMazePlayView()
	local storyId = self._config.beforeStory

	DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)

	local mazeGameProgress = DungeonMazeModel.instance:HasLocalProgress()

	if mazeGameProgress then
		self:_openMazePlayView(true)

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(storyId, param, self._openMazePlayView, self)
end

function DungeonMapLevelView:_openMazePlayView(existProgress)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self._config.id)

	local viewParams = {
		episodeCfg = self._config,
		existProgress = existProgress
	}

	DungeonMazeController.instance:openMazeGameView(viewParams)
end

function DungeonMapLevelView:_startRoleStory()
	if self._config.beforeStory > 0 then
		self:_playStoryAndEnterFight(self._config.beforeStory, true)

		return
	end

	self:_enterFight()
end

function DungeonMapLevelView:_playStoryAndEnterFight(storyId, noCheckFinish)
	if not noCheckFinish and StoryModel.instance:isStoryFinished(storyId) then
		self:_enterFight()

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(storyId, param, self._enterFight, self)
end

function DungeonMapLevelView:_enterFight()
	if CommandStationController.instance:chapterInCommandStation(self._enterChapterId) then
		CommandStationController.instance:setRecordEpisodeId(self._enterConfig.id)
	end

	if DungeonController.checkEpisodeFiveHero(self._episodeId) then
		local snapshotId = ModuleEnum.HeroGroupSnapshotType.FiveHero

		HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, self._onRecvMsg, self)
	else
		self:_reallyEnterFight()
	end
end

function DungeonMapLevelView:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		self:_reallyEnterFight()
	end
end

function DungeonMapLevelView:_reallyEnterFight()
	if self._enterConfig then
		DungeonModel.instance:setLastSelectMode(self._chapterType, self._enterConfig.id)
	end

	local config = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, self._episodeId, self._curSpeed)
end

function DungeonMapLevelView:_editableInitView()
	local animGO = gohelper.findChild(self.viewGO, "anim")

	self._animator = animGO and animGO:GetComponent(typeof(UnityEngine.Animator))
	self._simageList = self:getUserDataTb_()

	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	self._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._rewarditems = self:getUserDataTb_()
	self._enemyitems = self:getUserDataTb_()
	self._episodeItemParam = self:getUserDataTb_()

	gohelper.removeUIClickAudio(self._btncloseview.gameObject)
	gohelper.removeUIClickAudio(self._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(self._btnhardmode.gameObject)
	gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function DungeonMapLevelView:_initStar()
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

function DungeonMapLevelView:showStatus()
	local normalEpisodeId = self._config.id
	local hardOpen = DungeonModel.instance:isOpenHardDungeon(self._config.chapterId)

	if normalEpisodeId then
		::label_37_0::

		local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)
		local normalEpisodeInfo = self._episodeInfo
		local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(self._config.id)

		if hardEpisodeConfig then
			::label_37_1::

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

			if self._simpleConfig then
				local showNormal1Star = normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory

				self._setStarN(self._imgnormalstar1s, showNormal1Star, 2)
				self._setStarN(self._imgnormalstar1ru, showNormal1Star, 2)
				self._setStarN(self._imgnormalstar1lu, showNormal1Star, 2)

				local showNormal2Star = normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory

				self._setStarN(self._imgnormalstar2s, showNormal2Star, 2)
				self._setStarN(self._imgnormalstar2ru, showNormal2Star, 2)
				self._setStarN(self._imgnormalstar2lu, showNormal2Star, 2)

				local showSimpleStar = DungeonModel.instance:hasPassLevelAndStory(self._simpleConfig.id)

				self._setStarN(self._imgstorystar1s, showSimpleStar, 1)
				self._setStarN(self._imgstorystar1u, showSimpleStar, 1)

				if hardEpisodeConfig then
					local inLock = DungeonModel.instance:episodeIsInLockTime(hardEpisodeConfig.id)

					gohelper.setActive(self._imghardstar1s, not inLock)
					gohelper.setActive(self._imghardstar1u, not inLock)
					gohelper.setActive(self._imghardstar2s, not inLock)
					gohelper.setActive(self._imghardstar2u, not inLock)

					local hardEpisodeInfo = DungeonModel.instance:getEpisodeInfo(hardEpisodeConfig.id)

					if hardEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and hardOpen and passStory then
						local showHard1Star = hardEpisodeInfo.star >= DungeonEnum.StarType.Normal
						local showHard2Star = hardEpisodeInfo.star >= DungeonEnum.StarType.Advanced

						self._setStarN(self._imghardstar1s, showHard1Star, 3)
						self._setStarN(self._imghardstar1u, showHard1Star, 3)
						self._setStarN(self._imghardstar2s, showHard2Star, 3)
						self._setStarN(self._imghardstar2u, showHard2Star, 3)
					else
						self._setStarN(self._imghardstar1s, false, 3)
						self._setStarN(self._imghardstar1u, false, 3)
						self._setStarN(self._imghardstar2s, false, 3)
						self._setStarN(self._imghardstar2u, false, 3)
					end
				end
			end
		end
	end
end

function DungeonMapLevelView:_setStar(image, light, index)
	local color = "#9B9B9B"

	if light then
		color = index > 2 and "#FF4343" or "#F97142"
		image.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(image, color)
end

function DungeonMapLevelView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:refreshCostPower()
end

function DungeonMapLevelView:onUpdateParam()
	TaskDispatcher.cancelTask(self.closeThis, self)
	self:_initInfo()
	self.viewContainer:refreshHelp()
	self:showStatus()
	self:_doUpdate()
	self:checkSendGuideEvent()
end

function DungeonMapLevelView:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function DungeonMapLevelView:_setRuleDescItem(ruleCo, targetId)
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

	desc.text = string.format("<color=%s>[%s]</color>%s", tagColor[targetId], luaLang("dungeon_add_rule_target_" .. targetId), ruleCo.desc)
end

function DungeonMapLevelView:onOpen()
	self:_initInfo()
	self:showStatus()
	self:_doUpdate()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUnlockNewChapter, self._OnUnlockNewChapter, self)
	self:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, self.viewContainer.refreshHelp, self.viewContainer)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, self.showDrop, self)
	self.addEventCb(self, Activity217Controller.instance, Activity217Event.OnInfoChanged, self.showDrop, self)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, self._btncloseOnClick, self)

	local isJumpOpen = self.viewParam[viewParamIdx.isJumpOpen]

	if not isJumpOpen then
		self:checkSendGuideEvent()
	end
end

function DungeonMapLevelView:_onUpdateDungeonInfo()
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	self:showFree(chapterCo)
end

function DungeonMapLevelView:_OnUnlockNewChapter()
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function DungeonMapLevelView:_doUpdate()
	local hard = self.viewParam[5]
	local chapterType, episodeId = DungeonModel.instance:getLastSelectMode()

	if hard or chapterType == DungeonEnum.ChapterType.Hard then
		if self._episodeInfo.star == DungeonEnum.StarType.Advanced then
			self._hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)

			if self._hardEpisode then
				self._config = self._hardEpisode

				self:_showEpisodeMode(true, false)
				self._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif chapterType == DungeonEnum.ChapterType.Simple and self._simpleConfig then
		self._config = self._simpleConfig

		self:_showEpisodeMode(false, false)
		self._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if self._simpleConfig and self:checkFirstDisplay() then
		local lastPassMode = DungeonModel.instance:getLastFightEpisodePassMode(self._enterConfig)

		if lastPassMode == DungeonEnum.ChapterType.Simple then
			self._config = self._simpleConfig

			self:_showEpisodeMode(false, false)
			self._animator:Play("dungeonlevel_in_nomal", 0, 0)

			return
		end
	end

	self:onUpdate()
	self._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function DungeonMapLevelView:_initInfo()
	self._enterConfig = self.viewParam[1]
	self._enterChapterId = self._enterConfig.chapterId
	self._simpleConfig = DungeonConfig.instance:getSimpleEpisode(self._enterConfig)
	self._hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)
	self._config = self._enterConfig
	self._chapterIndex = self.viewParam[3]
	self._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(self._config.chapterId, self._config.id)

	self:_updateEpisodeInfo()

	local isJumpOpen = self.viewParam[viewParamIdx.isJumpOpen]

	if isJumpOpen then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, self._config.id)
	end

	self:refreshTitleField()
end

DungeonMapLevelView.BtnOutScreenTime = 0.3

function DungeonMapLevelView:onUpdate(hardModeArg, manually)
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)
	local chapterType = chapterCo.type
	local isHard = chapterType == DungeonEnum.ChapterType.Hard

	if self._chapterType ~= chapterType and self._animator then
		local animName = isHard and "hard" or "normal"

		self._animator:Play(animName, 0, 0)
		self._animator:Update(0)
	end

	self._chapterType = chapterType

	self._gonormal2:SetActive(false)

	if manually then
		TaskDispatcher.cancelTask(self._delayToSwitchStartBtn, self)
		TaskDispatcher.runDelay(self._delayToSwitchStartBtn, self, DungeonMapLevelView.BtnOutScreenTime)
	else
		self:_delayToSwitchStartBtn()
	end

	gohelper.setActive(self._goselectstorybg, chapterType == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(self._gounselectstorybg, chapterType ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(self._goselectnormalbgN, chapterType == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(self._gounselectnormalbgr, chapterType == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(self._gounselectnormalbgl, chapterType == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._goselecthardbgN, chapterType == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._gounselecthardbgN, chapterType ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._simagenormalbg, chapterType ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._simagehardbg, chapterType == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._gohardmodedecorate, chapterType == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._goselecthardbg, chapterType == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(self._gounselecthardbg, chapterType == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(self._goselectnormalbg, chapterType == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(self._gounselectnormalbg, chapterType == DungeonEnum.ChapterType.Hard)

	self._episodeId = self._config.id

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")

	self._simagepower2:LoadImage(powerIcon)
	self._simagepower3:LoadImage(powerIcon)
	gohelper.setActive(self._goboss, self:_isBossTypeEpisode(isHard))
	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)

	if self._config.battleId ~= 0 then
		gohelper.setActive(self._gorecommond, true)

		local isSimple = chapterType == DungeonEnum.ChapterType.Simple
		local recommendLv = DungeonHelper.getEpisodeRecommendLevel(self._episodeId, isSimple)

		if recommendLv ~= 0 then
			gohelper.setActive(self._gorecommond, true)

			self._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(recommendLv)
		else
			gohelper.setActive(self._gorecommond, false)
		end
	else
		gohelper.setActive(self._gorecommond, false)
	end

	self:setTitleDesc()
	self:showFree(chapterCo)
	self:showDrop()

	self._txttitle3.text = string.format("%02d", self._levelIndex)
	self._txtchapterindex.text = chapterCo.chapterIndex

	if manually then
		TaskDispatcher.cancelTask(self.refreshCostPower, self)
		TaskDispatcher.runDelay(self.refreshCostPower, self, DungeonMapLevelView.BtnOutScreenTime)
	else
		self:refreshCostPower()
	end

	self:refreshChallengeLimit()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.refreshChallengeLimit, self)
	self:onStoryStatus()
end

function DungeonMapLevelView:_isBossTypeEpisode(isHard)
	if isHard then
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

function DungeonMapLevelView:_delayToSwitchStartBtn()
	local isHard = self._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(self._gostartnormal, not isHard)
	gohelper.setActive(self._gostarthard, isHard)
end

function DungeonMapLevelView:showDrop()
	if not self._config then
		return
	end

	local isMultiDrop, limit, total, magnification, isDaily = Activity217Model.instance:getShowTripleByChapter(self._config.chapterId)
	local multiDropShow = isMultiDrop and limit > 0
	local episodeShow, remainTimes, dailyLimit = DoubleDropModel.instance:isShowDoubleByEpisode(self._config.id, true)
	local showDrop = episodeShow or multiDropShow

	gohelper.setActive(self._godoubletimes, showDrop)

	if showDrop then
		if multiDropShow then
			local actName = Activity217Model.instance:getActName()
			local str = isDaily and luaLang("doubleactivity_intips_daily") or luaLang("doubleactivity_intips")

			self._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(str, {
				actName,
				limit,
				total
			})
		elseif episodeShow then
			self._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), {
				remainTimes,
				dailyLimit
			})
		end

		recthelper.setAnchorY(self._gooperation.transform, -20)
		recthelper.setAnchorY(self._btnequip.transform, -410)
	else
		recthelper.setAnchorY(self._gooperation.transform, 0)
		recthelper.setAnchorY(self._btnequip.transform, -390)
	end
end

function DungeonMapLevelView:showFree(chapterCo)
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

function DungeonMapLevelView:_refreshFreeCost()
	self._txtcostcount.text = -1 * self._curSpeed
end

function DungeonMapLevelView:showViewStory()
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

function DungeonMapLevelView:refreshChallengeLimit()
	local limitType, limitCount, challengeCount = DungeonModel.instance:getEpisodeChallengeCount(self._episodeId)

	self._txtchallengecountlimit.text = limitType > 0 and limitCount > 0 and string.format("%s%s (%d/%d)", limitType == DungeonEnum.ChallengeCountLimitType.Daily and luaLang("daily") or limitType == DungeonEnum.ChallengeCountLimitType.Weekly and luaLang("weekly") or luaLang("monthly"), luaLang("times"), math.max(0, limitCount - self._episodeInfo.challengeCount), limitCount) or ""
	self._isCanChallenge, self._challengeLockCode = DungeonModel.instance:isCanChallenge(self._config)

	gohelper.setActive(self._gostart, self._isCanChallenge)
	gohelper.setActive(self._golock, not self._isCanChallenge)
end

function DungeonMapLevelView:onStoryStatus()
	local showStory = false
	local chapterCo = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	if self._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(self._config.afterStory) and self._episodeInfo.star > DungeonEnum.StarType.None then
		showStory = true
	end

	if not showStory and self._episodeInfo.star > DungeonEnum.StarType.None then
		showStory = not DungeonMapModel.instance:checkStoryElementFinished(self._config.afterStory)
	end

	if not showStory and self._config.type == DungeonEnum.EpisodeType.Story and self._episodeInfo.star > DungeonEnum.StarType.None then
		showStory = self._config.beforeStory > 0 and StoryModel.instance:isStoryFinished(self._config.beforeStory) and not DungeonMapModel.instance:checkStoryElementFinished(self._config.beforeStory)
	end

	gohelper.setActive(self._gooperation, not showStory and not self._enterAfterFreeLimit)
	gohelper.setActive(self._btnstory, showStory)

	local isHard = self._chapterType == DungeonEnum.ChapterType.Hard

	if showStory then
		self:refreshHardMode()
		self._btnhardmode.gameObject:SetActive(false)
	elseif not isHard then
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

	gohelper.setActive(self._goswitch, self._simpleConfig and isNeedShowSwitch)
	gohelper.setActive(self._gonormal, not self._simpleConfig and isNeedShowSwitch)
	gohelper.setActive(self._gohard, not self._simpleConfig and isNeedShowSwitch)
	gohelper.setActive(self._gostar, not self._simpleConfig and isNeedShowSwitch)
	recthelper.setAnchorY(self._txtdesc.transform, isNeedShowSwitch and 56.6 or 129.1)
	recthelper.setAnchorY(self._gorecommond.transform, isNeedShowSwitch and 87.3 or 168.4)
	TaskDispatcher.cancelTask(self._checkLockTime, self)
	TaskDispatcher.runRepeat(self._checkLockTime, self, 1)
end

function DungeonMapLevelView:_checkLockTime()
	local hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)
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

function DungeonMapLevelView:refreshHardMode()
	self._hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)

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

function DungeonMapLevelView:_delaySetActive()
	self._btnhardmode.gameObject:SetActive(self._btnHardModeActive)
end

function DungeonMapLevelView:refreshCostPower()
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
		local isHard = self._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#C44945")
		gohelper.setActive(self._gonormallackpower, not isHard)
		gohelper.setActive(self._gohardlackpower, isHard)
	end
end

function DungeonMapLevelView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
	AudioMgr.instance:trigger(self:getCurrentChapterListTypeAudio().onClose)

	self._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, self._episodeItemParam)

	if self._rewarditems then
		for i, v in ipairs(self._rewarditems) do
			TaskDispatcher.cancelTask(v.refreshLimitTime, v)
		end
	end

	self._chapterType = nil
end

function DungeonMapLevelView:onCloseFinish()
	return
end

function DungeonMapLevelView:clearRuleList()
	self._simageList = self:getUserDataTb_()

	for k, v in pairs(self._rulesimageList) do
		v:UnLoadImage()
	end

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()

	gohelper.destroyAllChildren(self._gorulelist)
	gohelper.destroyAllChildren(self._goruleDescList)
end

function DungeonMapLevelView:onDestroyView()
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

function DungeonMapLevelView:refreshTitleField()
	local len = GameUtil.utf8len(self._config.name)

	if len > 7 then
		if not self.titleList[2] then
			local item = self.titleList[1]

			if item == self.curTitleItem then
				return
			end

			for i, v in ipairs(self.titleList) do
				gohelper.setActive(v._go, v == item)
			end

			self.curTitleItem = item
			self._txttitle1 = item._txttitle1
			self._txttitle3 = item._txttitle3
			self._txtchapterindex = item._txtchapterindex
			self._txttitle4 = item._txttitle4
			self._gostar = item._gostar

			self:_initStar()
		end
	end
end

function DungeonMapLevelView:setTitleDesc()
	self:refreshTitleField()

	local targetConfig
	local chapterType = DungeonConfig.instance:getChapterTypeByEpisodeId(self._config.id)

	targetConfig = chapterType == DungeonEnum.ChapterType.Hard and DungeonConfig.instance:getEpisodeCO(self._config.preEpisode) or chapterType == DungeonEnum.ChapterType.Simple and DungeonConfig.instance:getEpisodeCO(self._config.normalEpisodeId) or self._config
	self._txtdesc.text = targetConfig.desc
	self._txttitle4.text = targetConfig.name_En

	local first = GameUtil.utf8sub(targetConfig.name, 1, 1)
	local sectionPosX

	self._txttitle1.text = first .. ((GameUtil.utf8len(targetConfig.name) >= 2 or nil) and string.format("<size=80>%s</size>", GameUtil.utf8sub(targetConfig.name, 2, GameUtil.utf8len(targetConfig.name) - 1)))

	ZProj.UGUIHelper.RebuildLayout(self._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(self._txttitle4.transform)
	recthelper.setAnchorX(self._txttitle3.transform, GameUtil.utf8len(self._config.name) > 2 and recthelper.getAnchorX(self._txttitle1.transform) + recthelper.getWidth(self._txttitle1.transform) or recthelper.getAnchorX(self._txttitle1.transform) + recthelper.getWidth(self._txttitle1.transform) + recthelper.getAnchorX(self._txttitle4.transform))
end

function DungeonMapLevelView:getCurrentChapterListTypeAudio()
	local isNormalType, isResourceType, isBreakType = DungeonModel.instance:getChapterListTypes()
	local audio

	return isNormalType and DungeonMapLevelView.AudioConfig[DungeonEnum.ChapterListType.Story] or isResourceType and DungeonMapLevelView.AudioConfig[DungeonEnum.ChapterListType.Resource] or isBreakType and DungeonMapLevelView.AudioConfig[DungeonEnum.ChapterListType.Insight] or DungeonMapLevelView.AudioConfig[DungeonEnum.ChapterListType.Story]
end

function DungeonMapLevelView._setStarN(image, light, index)
	local color = "#9B9B9B"

	if light then
		color = index == 1 and "#efb974" or index == 2 and "#F97142" or "#FF4343"
		image.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(image, color)
end

function DungeonMapLevelView:_btnHardOnClick()
	if self._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		self:_showHardDungeonOpenTip()

		return
	end

	local hardEpisode = DungeonConfig.instance:getHardEpisode(self._enterConfig.id)

	if hardEpisode and DungeonModel.instance:episodeIsInLockTime(hardEpisode.id) then
		GameFacade.showToastString(self._txtLockTime.text)

		return
	end

	local normalEpisodeInfo = DungeonModel.instance:getEpisodeInfo(self._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(self._enterConfig.id) or normalEpisodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	self._config = self._hardEpisode

	self:_showEpisodeMode(true, true)
end

function DungeonMapLevelView:_btnNormalOnClick()
	if self._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	self._config = self._enterConfig

	self:_showEpisodeMode(false, true)
end

function DungeonMapLevelView:_btnSimpleOnClick()
	if self._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	self._config = self._simpleConfig

	self:_showEpisodeMode(false, true)
end

function DungeonMapLevelView:checkSendGuideEvent()
	if not self._config then
		return
	end

	local pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	local battleId = DungeonConfig.instance:getEpisodeBattleId(self._config.id)
	local chapterId = self._config.chapterId
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local chapterType = chapterConfig.type

	if chapterType == DungeonEnum.ChapterType.Normal and not pass and battleId and battleId ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function DungeonMapLevelView:checkFirstDisplay()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.DungeonMapLevelFirstShow .. self._simpleConfig.id .. userId

	if PlayerPrefsHelper.getNumber(key, 0) == 0 then
		PlayerPrefsHelper.setNumber(key, 1)

		return true
	end

	return false
end

return DungeonMapLevelView
