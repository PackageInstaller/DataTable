-- chunkname: @modules/logic/versionactivity3_9/dungeon/view/maplevel/VersionActivity3_9DungeonMapLevelView.lua

module("modules.logic.versionactivity3_9.dungeon.view.maplevel.VersionActivity3_9DungeonMapLevelView", package.seeall)

local VersionActivity3_9DungeonMapLevelView = class("VersionActivity3_9DungeonMapLevelView", VersionActivityFixedDungeonMapLevelView1)

function VersionActivity3_9DungeonMapLevelView:onInitView()
	self.goVersionActivity = gohelper.findChild(self.viewGO, "anim/versionactivity")
	self.animator = self.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.goVersionActivity)
	self.animationEventWrap = self.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._simageactivitynormalbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	self._simageactivityhardbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	self._txtmapName = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	self._txtmapNameEn = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	self._txtmapNum = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	self._txtmapChapterIndex = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	self._gonormaleye = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	self._gohardeye = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	self._imagestar1 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	self._imagestar2 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	self._goswitch = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch")
	self._gotype1 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	self._gotype2 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	self._gotype3 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	self._gotype4 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	self._gotype0 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	self._gorecommend = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_recommend")
	self._txtrecommendlv = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/bg/mask/#txt_activitydesc")
	self._gorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_rewards")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	self._btnactivityreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	self._gonorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_norewards")

	local goStartBtnRoot = gohelper.findChild(self.viewGO, "anim/versionactivity/right/startBtn")

	self.startBtnAnimator = goStartBtnRoot:GetComponent(typeof(UnityEngine.Animator))
	self._btnnormalStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	self._txtusepowernormal = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	self._txtnorstarttext = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	self._txtnorstarttexten = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	self._btnhardStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	self._txtusepowerhard = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	self._btnlockStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	self._simagepower = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	self._btnreplayStory = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "anim/#go_lefttop")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/bg/mask/#txt_activitydesc")
	self._goMask = gohelper.findChild(self.viewGO, "anim/versionactivity/right/bg/mask")
	self._verticalLayoutGroup = self._goMask:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self._goTitle = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title")
	self._txtTime = gohelper.findChildText(self.viewGO, "anim/versionactivity/#go_tips/#txt_time")
	self._txtPlace = gohelper.findChildText(self.viewGO, "anim/versionactivity/#go_tips/#txt_place")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/#btn_right")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self.storyPosX = 0
	self.fightPosX = 121

	if self._editableInitView then
		self:_editableInitView()
	end
end

return VersionActivity3_9DungeonMapLevelView
