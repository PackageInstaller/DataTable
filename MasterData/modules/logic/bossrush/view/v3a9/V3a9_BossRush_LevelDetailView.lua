-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_LevelDetailView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_LevelDetailView", package.seeall)

local V3a9_BossRush_LevelDetailView = class("V3a9_BossRush_LevelDetailView", V3a2_BossRush_LevelDetailView)

function V3a9_BossRush_LevelDetailView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._gospines = gohelper.findChild(self.viewGO, "#go_spines")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simageFrame = gohelper.findChildSingleImage(self.viewGO, "#simage_Frame")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Left/score/Image_ScoreBG/#txt_ScoreNum")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/score/Image_ScoreBG/#go_AssessIcon")
	self._btnbonus = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_bonus")
	self._goRedPoint1 = gohelper.findChild(self.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "DetailPanel/Title/title/#simage_Title")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "DetailPanel/Title/title/#simage_Title/#image_IssxIcon")
	self._txtEn = gohelper.findChildText(self.viewGO, "DetailPanel/Title/title/#simage_Title/#txt_Name/#txt_En")
	self._txtName = gohelper.findChildText(self.viewGO, "DetailPanel/Title/title/#simage_Title/#txt_Name")
	self._btnSearchIcon = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Title/title/#btn_SearchIcon")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#scroll_desc")
	self._txtDescr = gohelper.findChildText(self.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	self._gostrategy = gohelper.findChild(self.viewGO, "DetailPanel/#go_strategy")
	self._scrollstrategy = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#go_strategy/type/#scroll_strategy")
	self._scrollConditionIcons = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons/#btn_additionRuleclick")
	self._goruletemp = gohelper.findChild(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons/#go_ruletemp/#image_tagicon")
	self._goresilience = gohelper.findChild(self.viewGO, "DetailPanel/#go_resilience")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#go_resilience/Info/#btn_Info")
	self._txtresilienceValue = gohelper.findChildText(self.viewGO, "DetailPanel/#go_resilience/#txt_resilienceValue")
	self._gotips = gohelper.findChild(self.viewGO, "DetailPanel/#go_tips")
	self._txtdesc = gohelper.findChildText(self.viewGO, "DetailPanel/#go_tips/tipsbg/#txt_desc")
	self._btntipClose = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#go_tips/#btn_tipClose")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#btn_Go")
	self._txtGo = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_Go")
	self._txtDoubleTimes = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	self._gorank = gohelper.findChild(self.viewGO, "DetailPanel/#go_rank")
	self._goweak = gohelper.findChild(self.viewGO, "DetailPanel/#go_weak")
	self._goweakicon = gohelper.findChild(self.viewGO, "DetailPanel/#go_weak/tipsbg/icon")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_LevelDetailView:addEvents()
	V3a9_BossRush_LevelDetailView.super.addEvents(self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnResetStage, self._onResetStage, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function V3a9_BossRush_LevelDetailView:removeEvents()
	V3a9_BossRush_LevelDetailView.super.removeEvents(self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnResetStage, self._onResetStage, self)
	self._btnreset:RemoveClickListener()
end

function V3a9_BossRush_LevelDetailView:_btnresetOnClick()
	V3a9_BossRushController.instance:onResetTeam(self._activityId, self._stage, self._resetTeamCallback, self)
end

function V3a9_BossRush_LevelDetailView:_resetTeamCallback()
	self._animScore:Play("switch", 0, 0)
	AudioMgr.instance:trigger(BossRushAudioEnum.Audio.play_ui_shuori_qiyuan_reset)
end

function V3a9_BossRush_LevelDetailView:_btnSearchIconOnClick()
	EnemyInfoController.instance:openBossRushEnemyInfoView(self._activityId, self._stage, self._layer)
end

function V3a9_BossRush_LevelDetailView:_editableInitView()
	V3a9_BossRush_LevelDetailView.super._editableInitView(self)

	self._animScore = gohelper.findChildComponent(self.viewGO, "Left/score", typeof(UnityEngine.Animator))
end

function V3a9_BossRush_LevelDetailView:_btnGoOnClick()
	V3a9_BossRushModel.instance:refreshShowHeroEquips(self._stage)
	BossRushController.instance:enterFightScene(self._stage, self._layer, self._activityId)
end

function V3a9_BossRush_LevelDetailView:onOpen()
	V3a9_BossRush_LevelDetailView.super.onOpen(self)
	self:_refresh()
end

function V3a9_BossRush_LevelDetailView:_refreshHeros()
	if not self._heroTeam then
		local goTeam = gohelper.findChild(self.viewGO, "Left/Role/Role")

		self._heroTeam = MonoHelper.addNoUpdateLuaComOnceToGo(goTeam, V3a9_BossRush_MainActHeroTeam)
	end

	self._heroTeam:onUpdateMO(self.viewParam.actModeTeam)
end

function V3a9_BossRush_LevelDetailView:_refresh()
	self:_refreshHeros()
	self:refreshScore()
	self:_refreshResetState()
end

function V3a9_BossRush_LevelDetailView:_onResetStage()
	self:_refresh()
end

function V3a9_BossRush_LevelDetailView:_refreshResetState()
	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._activityId, self._stage)
	local isChallenge = stageMo and stageMo:isChallenge()

	gohelper.setActive(self._btnreset.gameObject, isChallenge)

	local txt = isChallenge and "p_v3a9_bossrushleveldetail_txt_Go_2" or "p_v3a9_bossrushleveldetail_txt_Go_1"

	self._txtGo.text = luaLang(txt)
end

function V3a9_BossRush_LevelDetailView:refreshScore()
	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._activityId, self._stage)

	if stageMo then
		if not stageMo.latestPoint then
			local highestPoint = 0

			self._assessIcon:setData(self._stage, highestPoint, false)

			self._txtScoreNum.text = BossRushConfig.instance:getScoreStr(highestPoint)
		end
	end
end

function V3a9_BossRush_LevelDetailView:onClose()
	V3a9_BossRush_LevelDetailView.super.onClose(self)
end

function V3a9_BossRush_LevelDetailView:onDestroyView()
	V3a9_BossRush_LevelDetailView.super.onClose(self)
end

return V3a9_BossRush_LevelDetailView
