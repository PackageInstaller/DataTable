-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_ResultView.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultView", package.seeall)

local V1a6_BossRush_ResultView = class("V1a6_BossRush_ResultView", BaseView)

function V1a6_BossRush_ResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFullBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1")
	self._simageFullBGLayer4 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1Layer4")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Title/#simage_Title")
	self._btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Rank")
	self._simagePlayerHead = gohelper.findChildSingleImage(self.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "Player/#txt_PlayerName")
	self._txtTime = gohelper.findChildText(self.viewGO, "Player/#txt_Time")
	self._imgScoreBg = gohelper.findChildImage(self.viewGO, "Right/image_ScoreBG")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/image_ScoreBG/#txt_Score")
	self._goGroup = gohelper.findChild(self.viewGO, "Right/#go_Group")
	self._goNotEmpty = gohelper.findChild(self.viewGO, "Right/#go_NotEmpty")
	self._imgAssessBG = gohelper.findChildImage(self.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	self._simgAssessBG = gohelper.findChildSingleImage(self.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Right/#go_AssessIcon")
	self._goEvaluate = gohelper.findChild(self.viewGO, "Right/#go_Evaluate")
	self._scrollaffix = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Evaluate/#scroll_affix")
	self._goAffixItem = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/Tips")
	self._scrollTips = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips")
	self._goInfoAffixItem = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	self._txtAffixDescr = gohelper.findChildText(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	self._goAffixTitle = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr/#go_AffixTitle")
	self._btnaffix = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Evaluate/#scroll_affix/#btn_affix")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
	self._btnaffix:AddClickListener(self._btnaffixOnClick, self)
	self._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.EvaluateItemAnim, self._evaluateItemAnimCallback, self)
end

function V1a6_BossRush_ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnaffix:RemoveClickListener()
	self._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.EvaluateItemAnim)
end

function V1a6_BossRush_ResultView:_btnaffixOnClick()
	if not self._tipActive then
		self:activeEvaluateTip(not self._tipActive)
	end
end

function V1a6_BossRush_ResultView:_btncloseOnClick()
	if self._tipActive then
		self:activeEvaluateTip(false)
	else
		self:closeThis()
	end
end

function V1a6_BossRush_ResultView:_btnRankOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function V1a6_BossRush_ResultView:_editableInitView()
	self:_initHeroGroup()
end

function V1a6_BossRush_ResultView:onUpdateParam()
	return
end

function V1a6_BossRush_ResultView:onOpen()
	self._curStage, self._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	self.fightScore = BossRushModel.instance:getFightScore() or 0
	self._txtScore.text = self.fightScore
	self._isSpecialLayer = BossRushModel.instance:isSpecialLayer(self._curLayer)

	self:setAssessIcon()
	self:_initPlayerInfo()
	self:_initBoss()
	self:initEvaluate()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_appraise)
	gohelper.setActive(self._simageFullBG1.gameObject, not self._isSpecialLayer)
	gohelper.setActive(self._simageFullBGLayer4.gameObject, self._isSpecialLayer)
end

function V1a6_BossRush_ResultView:onClose()
	FightController.onResultViewClose()
end

function V1a6_BossRush_ResultView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageTitle:UnLoadImage()
	self._simagePlayerHead:UnLoadImage()
	self._simgAssessBG:UnLoadImage()
	GameUtil.onDestroyViewMember(self, "_heroGroup")
end

function V1a6_BossRush_ResultView:_initHeroGroup()
	local itemClass = V1a4_BossRush_HeroGroup
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_herogroup, self._goGroup, itemClass.__cname)

	self._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, self.viewContainer)

	self._heroGroup:setDataByCurFightParam()
end

function V1a6_BossRush_ResultView:_initPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simagePlayerHead)

	self._liveHeadIcon:setLiveHead(playerInfo.portrait)

	self._txtTime.text = TimeUtil.getServerDateToString()
	self._txtPlayerName.text = playerInfo.name
end

function V1a6_BossRush_ResultView:_initBoss()
	if self._curStage then
		self._simageFullBG:LoadImage(BossRushConfig.instance:getResultViewFullBgSImage(self._curStage))
		self._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(self._curStage))

		for i = 1, 3 do
			local bgGo = gohelper.findChild(self.viewGO, "boss_topbg" .. i)

			gohelper.setActive(bgGo, i == self._curStage)
		end
	end
end

function V1a6_BossRush_ResultView:setAssessIcon()
	if not self._assessItem then
		self:createAssessIcon()
	end

	local special = BossRushModel.instance:isSpecialLayer(self._curLayer)

	if special then
		if not BossRushEnum.AssessType.Layer4 then
			local type = BossRushEnum.AssessType.Normal
			local res, level = self._assessItem:setData(self._curStage, self.fightScore, type)
			local _isEmpty = string.nilorempty(res)

			gohelper.setActive(self._goNotEmpty, not _isEmpty)

			level = level or -1

			local scoreColor = Color.white
			local assessColor = Color.white

			if special then
				self._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v2a1_bossrush_assessbg2"))
			else
				local is4S = level > BossRushEnum.ScoreLevel.S_AA

				if is4S then
					scoreColor = SLFramework.UGUI.GuiHelper.ParseColor("#D6816C")
					assessColor = SLFramework.UGUI.GuiHelper.ParseColor("#BC361D")
				end

				self._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v1a6_bossrush_assessbg2"))

				self._imgScoreBg.color = scoreColor
				self._imgAssessBG.color = assessColor
			end
		end
	end
end

function V1a6_BossRush_ResultView:createAssessIcon()
	local path = BossRushEnum.ResPath.v1a4_bossrush_result_assess
	local childGO = self:getResInst(path, self._goAssessIcon, "AssessIcon")

	self._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_BossRush_AssessIcon)
end

function V1a6_BossRush_ResultView:initEvaluate()
	self:activeEvaluateTip(false)
	gohelper.setActive(self._goAffixItem, false)
	gohelper.setActive(self._goInfoAffixItem, false)

	local image = gohelper.findChildImage(self._goAffixItem, "image_AffixBG")
	local image1 = gohelper.findChildImage(self._goInfoAffixItem, "#go_AffixTitle/image_AffixBG")
	local icon = self._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg"

	UISpriteSetMgr.instance:setV1a4BossRushSprite(image, icon)
	UISpriteSetMgr.instance:setV1a4BossRushSprite(image1, icon)

	self._evaluateList = self:getUserDataTb_()
	self._evaluateInfoList = self:getUserDataTb_()

	self:refreshEvaluate()
end

function V1a6_BossRush_ResultView:refreshEvaluate()
	local ids = BossRushModel.instance:getEvaluateList()

	if ids then
		for i, id in pairs(ids) do
			local item = self:getEvaluateItem(i)
			local name, desc = BossRushConfig.instance:getEvaluateInfo(id)

			item.txt.text = name

			gohelper.setActive(item.go, true)

			local infoitem = self:getEvaluateInfoItem(i)

			infoitem.titleTxt.text = name
			infoitem.titledesc.text = desc

			gohelper.setActive(infoitem.go, true)
		end

		if #self._evaluateList > #ids then
			for i = #ids + 1, #self._evaluateList do
				gohelper.setActive(self._evaluateList[i].go, false)
			end
		end

		if #self._evaluateInfoList > #ids then
			for i = #ids + 1, #self._evaluateInfoList do
				gohelper.setActive(self._evaluateInfoList[i].go, false)
			end
		end
	end

	local hasEvaluate = ids and #ids > 0

	gohelper.setActive(self._goEvaluate, hasEvaluate)

	if hasEvaluate then
		if not BossRushEnum.V1a6_ResultAnimName.HasEvaluate then
			local anim = BossRushEnum.V1a6_ResultAnimName.NoEvaluate

			self._animatorPlayer:Play(anim, self._animCallback, self)
		end
	end
end

function V1a6_BossRush_ResultView:getEvaluateItem(index)
	local item = self._evaluateList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goAffixItem, "evaluate_" .. index)

		item = {
			go = go,
			txt = gohelper.findChildText(go, "#txt_Affix"),
			anim = go:GetComponent(typeof(UnityEngine.Animator))
		}
		self._evaluateList[index] = item
	end

	return item
end

function V1a6_BossRush_ResultView:getEvaluateInfoItem(index)
	local item = self._evaluateInfoList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goInfoAffixItem, "evaluateInfo_" .. index)

		item = {
			go = go,
			titleTxt = gohelper.findChildText(go, "#go_AffixTitle/#txt_Affix"),
			titledesc = go:GetComponent(gohelper.Type_TextMesh)
		}
		self._evaluateInfoList[index] = item
	end

	return item
end

function V1a6_BossRush_ResultView:activeEvaluateTip(active)
	gohelper.setActive(self._goTips, active)

	self._tipActive = active
end

function V1a6_BossRush_ResultView:_evaluateItemAnimCallback()
	if self._evaluateList then
		for _, v in pairs(self._evaluateList) do
			v.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function V1a6_BossRush_ResultView:_animCallback()
	return
end

return V1a6_BossRush_ResultView
