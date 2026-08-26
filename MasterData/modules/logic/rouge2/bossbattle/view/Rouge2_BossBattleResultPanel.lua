-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleResultPanel.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleResultPanel", package.seeall)

local Rouge2_BossBattleResultPanel = class("Rouge2_BossBattleResultPanel", BaseView)

function Rouge2_BossBattleResultPanel:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goscore = gohelper.findChild(self.viewGO, "#go_score")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#go_score/#simage_FullBG")
	self._simageDec = gohelper.findChildSingleImage(self.viewGO, "#go_score/#simage_Dec")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "#go_score/#go_AssessIcon")
	self._goNewRecord = gohelper.findChild(self.viewGO, "#go_score/Right/Title/go_newrecord")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_score/Right/Title/Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BossBattleResultPanel:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Rouge2_BossBattleResultPanel:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Rouge2_BossBattleResultPanel:_btncloseOnClick()
	self:_openResultView()
end

function Rouge2_BossBattleResultPanel:onClickModalMask()
	self:_openResultView()
end

function Rouge2_BossBattleResultPanel:_openResultView()
	ViewMgr.instance:openView(ViewName.Rouge2_BossBattleResultView, self.viewParam)
	self:closeThis()
end

function Rouge2_BossBattleResultPanel:_editableInitView()
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	self._gonewrecord = gohelper.findChild(self.viewGO, "#go_score/Right/Title/go_newrecord")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_score/Right/Title/txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_score/Right/Title/txt_TitleEn")
end

function Rouge2_BossBattleResultPanel:onOpen()
	self:initViewParam()
	self:setAssessIcon()
	self:checkIsNewRecord()
end

function Rouge2_BossBattleResultPanel:initViewParam()
	self._episodeId = DungeonModel.instance.curSendEpisodeId
	self._episodeCo = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._bossCo = Rouge2_BossBattleConfig.instance:getBossConfigByEpisodeId(self._episodeId)
	self._bossId = self._bossCo and self._bossCo.id
	self._fightScore = Rouge2_BossBattleController.instance:getCurBossBattleScore()
	self._txtScore.text = Rouge2_IconHelper.getScoreStr(self._fightScore)
end

function Rouge2_BossBattleResultPanel:setAssessIcon()
	if not self._assessItem then
		self:createAssessIcon()
		self._assessItem:setData(self._fightScore)
	end
end

function Rouge2_BossBattleResultPanel:createAssessIcon()
	local path = Rouge2_Enum.ResPath.BossBattleResultAssessIcon
	local childGO = self:getResInst(path, self._goAssessIcon.gameObject, "AssessIcon")

	self._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, Rouge2_BossBattleResultAssessIcon)
end

function Rouge2_BossBattleResultPanel:checkIsNewRecord()
	local isNew = Rouge2_BossBattleController.instance:checkIsNewHighestScore(self._bossId, self._fightScore)

	gohelper.setActive(self._goNewRecord, isNew)
	gohelper.setActive(self._goTitle, not isNew)
end

function Rouge2_BossBattleResultPanel:onClose()
	return
end

function Rouge2_BossBattleResultPanel:onDestroyView()
	return
end

return Rouge2_BossBattleResultPanel
