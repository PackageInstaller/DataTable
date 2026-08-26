-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_ResultView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_ResultView", package.seeall)

local V3a2_BossRush_ResultView = class("V3a2_BossRush_ResultView", V1a6_BossRush_ResultView)

function V3a2_BossRush_ResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFullBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1")
	self._simageDec = gohelper.findChildSingleImage(self.viewGO, "#simage_Dec")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Title/title/#simage_Title")
	self._txtEn = gohelper.findChildText(self.viewGO, "Title/title/#txt_En")
	self._txtName = gohelper.findChildText(self.viewGO, "Title/title/#txt_Name")
	self._btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "Title/title/#btn_Rank")
	self._simagePlayerHead = gohelper.findChildSingleImage(self.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "Player/#txt_PlayerName")
	self._txtTime = gohelper.findChildText(self.viewGO, "Player/#txt_Time")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#btn_Info")
	self._goNewRecord = gohelper.findChild(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_NewRecord")
	self._gotips = gohelper.findChild(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips")
	self._gotipsbg = gohelper.findChild(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips/#go_tipsbg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips/#go_tipsbg/#txt_desc")
	self._btntipclose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips/#btn_tipclose")
	self._goGroup = gohelper.findChild(self.viewGO, "Right/#go_Group")
	self._goNotEmpty = gohelper.findChild(self.viewGO, "Right/#go_NotEmpty")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Right/#go_AssessIcon")
	self._goEvaluate = gohelper.findChild(self.viewGO, "Right/#go_Evaluate")
	self._scrollaffix = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Evaluate/#scroll_affix")
	self._goAffixItem = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem")
	self._txtAffix = gohelper.findChildText(self.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem/#txt_Affix")
	self._btnaffix = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Evaluate/#scroll_affix/#btn_affix")
	self._scrollTips = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips")
	self._txtAffixDescr = gohelper.findChildText(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	self._goAffixTitle = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr/#go_AffixTitle")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "Right/rank/#image_SliderFG")
	self._txtrank = gohelper.findChildText(self.viewGO, "Right/rank/#txt_rank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btntipclose:AddClickListener(self._btntipcloseOnClick, self)
	self._btnaffix:AddClickListener(self._btnaffixOnClick, self)
end

function V3a2_BossRush_ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btntipclose:RemoveClickListener()
	self._btnaffix:RemoveClickListener()
end

function V3a2_BossRush_ResultView:_btnInfoOnClick()
	self:_showScoreTip(true)
end

function V3a2_BossRush_ResultView:_btntipcloseOnClick()
	self:_showScoreTip(false)
end

function V3a2_BossRush_ResultView:_editableInitView()
	self._imagerankIcon = gohelper.findChildImage(self.viewGO, "Right/rank")
	self._simgAssessBG = gohelper.findChildSingleImage(self.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	self._imgAssessBG = gohelper.findChildImage(self.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	self._imgScoreBg = gohelper.findChildImage(self.viewGO, "Right/Score/image_ScoreBG")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/Tips")
	self._goInfoAffixItem = self._txtAffixDescr.gameObject
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	V3a2_BossRush_ResultView.super._editableInitView(self)
end

function V3a2_BossRush_ResultView:onOpen()
	self._curStage, self._curLayer, self._actId = BossRushModel.instance:getBattleStageAndLayer()
	self.fightScore = BossRushModel.instance:getFightScore() or 0
	self._txtScore.text = BossRushConfig.instance:getScoreStr(self.fightScore)
	self._isSpecialLayer = BossRushModel.instance:isSpecialLayer(self._curLayer)

	self:setAssessIcon()
	self:_initPlayerInfo()
	self:_initBoss()
	self:initEvaluate()
	gohelper.setActive(self._simageFullBG1.gameObject, not self._isSpecialLayer)

	local isNew = BossRushModel.instance:checkIsNewHighestPointRecord(self._curStage)

	gohelper.setActive(self._goNewRecord, isNew)
	self:refreshRankUI()
	self:_showScoreTip(false)
	self:_refreshScore()
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
end

function V3a2_BossRush_ResultView:_showScoreTip(show)
	gohelper.setActive(self._gotipsbg, show)
	gohelper.setActive(self._btntipclose, show)
end

function V3a2_BossRush_ResultView:_refreshScore()
	local score = V3a2_BossRushModel.instance:getScore()

	gohelper.setActive(self._txtdesc.gameObject, false)

	self._scoreItems = self:getUserDataTb_()

	for i = 1, 3 do
		local item = self._scoreItems[i]

		if not item then
			item = self:getUserDataTb_()

			local go = gohelper.cloneInPlace(self._txtdesc.gameObject)

			item.go = go
			item.txt = go:GetComponent(gohelper.Type_TextMesh)
			self._scoreItems[i] = item
		end

		local lang, scoreTxt

		if i == 1 then
			lang = "v3a2BossRush_Result_BaseScore"
			scoreTxt = score and score.baseScore or 0
		elseif i == 2 then
			lang = "v3a2BossRush_Result_RuleScore"
			scoreTxt = score and score.ruleScore or 0
		else
			lang = "v3a2BossRush_Result_TotalScore"
			scoreTxt = self.fightScore
		end

		item.txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(lang), scoreTxt or 0)

		gohelper.setActive(item.go, true)
	end
end

function V3a2_BossRush_ResultView:_initBoss()
	if self._curStage then
		self._simageFullBG:LoadImage(BossRushConfig.instance:getBossDetailFullPath(self._curStage, self._actId))
		self._simageTitle:LoadImage(BossRushConfig.instance:getBossDetailTitlePath(self._curStage, self._actId))

		for i = 1, 3 do
			local bgGo = gohelper.findChild(self.viewGO, "boss_topbg" .. i)

			gohelper.setActive(bgGo, i == self._curStage)
		end

		local stageCO = BossRushConfig.instance:getStageCO(self._curStage, self._actId)

		self._txtName.text = stageCO.name
		self._txtEn.text = stageCO.name_en
	end
end

function V3a2_BossRush_ResultView:setAssessIcon()
	if not self._assessItem then
		self:createAssessIcon()
	end

	local res, level = self._assessItem:setData(self._curStage, self.fightScore, false)
	local _isEmpty = string.nilorempty(res)

	gohelper.setActive(self._goNotEmpty, not _isEmpty)

	level = level or -1

	local scoreColor = Color.white
	local assessColor = Color.white
	local is4S = level > BossRushEnum.ScoreLevel.S_AA

	if is4S then
		scoreColor = SLFramework.UGUI.GuiHelper.ParseColor("#D6816C")
		assessColor = SLFramework.UGUI.GuiHelper.ParseColor("#BC361D")
	end

	self._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v1a6_bossrush_assessbg2"))

	self._imgScoreBg.color = scoreColor
	self._imgAssessBG.color = assessColor
end

function V3a2_BossRush_ResultView:refreshRankUI()
	local rank = V3a2_BossRushModel.instance:getRank()

	self._txtrank.text = rank

	UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imagerankIcon, V3a2_BossRushModel.instance:getRankLevelBg(rank))

	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress()

	self._imageSliderFG.fillAmount = Mathf.Clamp01(exp / needExp)
end

return V3a2_BossRush_ResultView
