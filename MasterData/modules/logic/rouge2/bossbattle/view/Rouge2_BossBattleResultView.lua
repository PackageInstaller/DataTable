-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleResultView.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleResultView", package.seeall)

local Rouge2_BossBattleResultView = class("Rouge2_BossBattleResultView", BaseView)

function Rouge2_BossBattleResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageBossIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_BossIcon")
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
	self._goGroup = gohelper.findChild(self.viewGO, "Right/#go_Group")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Right/#go_AssessIcon")
	self._txtMaxDamage = gohelper.findChildText(self.viewGO, "Right/MaxDamage/#txt_MaxDamage")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BossBattleResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
end

function Rouge2_BossBattleResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function Rouge2_BossBattleResultView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_BossBattleResultView:_btnRankOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Rouge2_BossBattleResultView:_editableInitView()
	self._imgScoreBg = gohelper.findChildImage(self.viewGO, "Right/Score/image_ScoreBG")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	self:_initHeroGroup()
end

function Rouge2_BossBattleResultView:_initHeroGroup()
	local itemClass = Rouge2_BossBattleHeroGroup
	local go = self.viewContainer:getResInst(Rouge2_Enum.ResPath.BossBattleHeroGroup, self._goGroup, itemClass.__cname)

	self._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, self.viewContainer)

	self._heroGroup:setDataByCurFightParam()
end

function Rouge2_BossBattleResultView:onOpen()
	self:initViewParam()
	self:initScoreInfo()
	self:setAssessIcon()
	self:initPlayerInfo()
	self:initBossInfo()
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
end

function Rouge2_BossBattleResultView:initViewParam()
	self._episodeId = DungeonModel.instance.curSendEpisodeId
	self._episodeCo = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._bossCo = Rouge2_BossBattleConfig.instance:getBossConfigByEpisodeId(self._episodeId)
	self._bossId = self._bossCo and self._bossCo.id
	self._fightScore = Rouge2_BossBattleController.instance:getCurBossBattleScore()
	self._assessCo = Rouge2_BossBattleConfig.instance:getAssessConfigByScore(self._fightScore)
	self._hasAssess = self._assessCo ~= nil
end

function Rouge2_BossBattleResultView:initScoreInfo()
	self._txtMaxDamage.text = Rouge2_BossBattleController.instance:getRoundMaxDamage()
	self._txtScore.text = Rouge2_IconHelper.getScoreStr(self._fightScore)

	local isNew = Rouge2_BossBattleController.instance:checkIsNewHighestScore(self._bossId, self._fightScore)

	gohelper.setActive(self._goNewRecord, isNew)
end

function Rouge2_BossBattleResultView:setAssessIcon()
	if not self._assessItem then
		self:createAssessIcon()
	end

	self._assessItem:setData(self._fightScore)

	if self._hasAssess then
		local isHard = self._assessCo.isHard ~= 0
		local scoreColor = Color.white
		local assessColor = Color.white

		if isHard then
			scoreColor = SLFramework.UGUI.GuiHelper.ParseColor("#D6816C")
			assessColor = SLFramework.UGUI.GuiHelper.ParseColor("#BC361D")
		end

		self._imgScoreBg.color = scoreColor
	end
end

function Rouge2_BossBattleResultView:createAssessIcon()
	local path = Rouge2_Enum.ResPath.BossBattleResultAssessIcon
	local childGO = self:getResInst(path, self._goAssessIcon, "AssessIcon")

	self._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, Rouge2_BossBattleResultAssessIcon)
end

function Rouge2_BossBattleResultView:initBossInfo()
	self._simageBossIcon:LoadImage(ResUrl.getRouge2Icon("bossbattle/" .. self._bossCo.resultBossIcon))
	self._simageTitle:LoadImage(ResUrl.getBossRushDetailPath(self._bossCo.resultTitleIcon))

	self._txtName.text = self._episodeCo and self._episodeCo.name
	self._txtEn.text = self._episodeCo and self._episodeCo.name_En
end

function Rouge2_BossBattleResultView:initPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simagePlayerHead)

	self._liveHeadIcon:setLiveHead(playerInfo.portrait)

	self._txtTime.text = TimeUtil.getServerDateToString()
	self._txtPlayerName.text = playerInfo.name
end

function Rouge2_BossBattleResultView:onClose()
	FightController.onResultViewClose()
end

function Rouge2_BossBattleResultView:onDestroyView()
	self._simageBossIcon:UnLoadImage()
	self._simageTitle:UnLoadImage()
end

return Rouge2_BossBattleResultView
