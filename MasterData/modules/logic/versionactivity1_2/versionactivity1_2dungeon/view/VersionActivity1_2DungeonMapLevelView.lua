-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonMapLevelView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapLevelView", package.seeall)

local VersionActivity1_2DungeonMapLevelView = class("VersionActivity1_2DungeonMapLevelView", VersionActivity1_2DungeonMapLevelBaseView)

function VersionActivity1_2DungeonMapLevelView:onInitView()
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._simageactivitynormalbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	self._simageactivityhardbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	self._txtmapName = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	self._txtmapNameEn = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	self._txtmapNum = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	self._imagestar1 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/#image_star1")
	self._imagestar2 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/#image_star2")
	self._goswitch = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch")
	self._gotype1 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	self._gotype2 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	self._gotype3 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	self._gotype4 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	self._golock = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_lock")
	self._lockAni = gohelper.onceAddComponent(self._golock, typeof(UnityEngine.Animator))
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	self._gorecommond = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/recommend")
	self._txtrecommondlv = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/recommend/#txt_recommendlv")
	self._gorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/rewards")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "anim/versionactivity/right/rewards/rewardList/#go_activityrewarditem")
	self._btnactivityreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/rewards/#btn_activityreward")
	self._gonorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_norewards")
	self._gonormalStartnode = gohelper.findChild(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node")
	self._btnnormalStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	self._txtusepowernormal = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node/#txt_usepowernormal")
	self._txtnorstarttext = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	self._simagepower = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node/#simage_power")
	self._btnnormalStart2 = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2")
	self._txtusepowernormal2 = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#txt_usepowernormal2")
	self._txtnorstarttext2 = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#txt_norstarttext2")
	self._simagepower2 = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#simage_power2")
	self._btnhardStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	self._btnreplayStory = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_reviewcg")
	self._txtusepowerhard = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "anim/#go_lefttop")
	self._goruledesc = gohelper.findChild(self.viewGO, "anim/#go_ruledesc")
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#go_ruledesc/#btn_closerule")
	self._goruleitem = gohelper.findChild(self.viewGO, "anim/#go_ruledesc/bg/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "anim/#go_ruledesc/bg/#go_ruleDescList")
	self._gotraptip = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_tip/#go_traptip")
	self._txtchapterindex = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_chapterindex")
	self._simagepowerhard = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#image_powerhard")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2DungeonMapLevelView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
	self._btnactivityreward:AddClickListener(self._btnactivityrewardOnClick, self)
	self._btnnormalStart:AddClickListener(self._btnnormalStartOnClick, self)
	self._btnnormalStart2:AddClickListener(self._btnnormalStartOnClick, self)
	self._btnhardStart:AddClickListener(self._btnhardStartOnClick, self)
	self._btnreplayStory:AddClickListener(self._btnreplayStoryOnClick, self)
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function VersionActivity1_2DungeonMapLevelView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
	self._btnactivityreward:RemoveClickListener()
	self._btnnormalStart:RemoveClickListener()
	self._btnnormalStart2:RemoveClickListener()
	self._btnhardStart:RemoveClickListener()
	self._btnreplayStory:RemoveClickListener()
	self._btncloserule:RemoveClickListener()
end

function VersionActivity1_2DungeonMapLevelView:onOpen()
	self._simagepowerhard:LoadImage(ResUrl.getCurrencyItemIcon("204"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	VersionActivity1_2DungeonMapLevelView.super.onOpen(self)
	gohelper.setActive(self._gotraptip, VersionActivity1_2DungeonModel.instance:getTrapPutting())

	self._txtchapterindex.text = self._chapterConfig.chapterIndex .. "."
end

function VersionActivity1_2DungeonMapLevelView:_btnreplayStoryOnClick()
	if not self.storyIdList or #self.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(self.storyIdList)
end

function VersionActivity1_2DungeonMapLevelView:refreshStar()
	if not self.showEpisodeMo then
		return
	end

	local episodeId = self.showEpisodeCo.id
	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)
	local image_star1 = self._imagestar1
	local image_star2 = self._imagestar2
	local is_hard = self:isDungeonHardModel()
	local _color

	if is_hard then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star1, "juqing_xing1_kn")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star2, "juqing_xing2_kn")

		_color = "#e43938"
	else
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star1, "juqing_xing1")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(image_star2, "juqing_xing2")

		if self._cur_select_index == 1 then
			_color = "#e4b472"
		elseif self._cur_select_index == 2 then
			_color = "#e7853d"
		elseif self._cur_select_index == 3 then
			_color = "#ef3939"
		end
	end

	local _gray = "#949494"
	local pass = DungeonModel.instance:hasPassLevelAndStory(episodeId)

	SLFramework.UGUI.GuiHelper.SetColor(image_star1, pass and _color or _gray)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(image_star2.gameObject, false)
	else
		gohelper.setActive(image_star2.gameObject, true)
		SLFramework.UGUI.GuiHelper.SetColor(image_star2, pass and episodeMo and episodeMo.star >= DungeonEnum.StarType.Advanced and _color or _gray)
	end
end

function VersionActivity1_2DungeonMapLevelView:isDungeonHardModel()
	return VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[self.showEpisodeCo.chapterId] == VersionActivity1_2DungeonEnum.DungeonMode.Hard
end

function VersionActivity1_2DungeonMapLevelView:_onCurrencyChange()
	self:refreshStartBtn()
end

return VersionActivity1_2DungeonMapLevelView
