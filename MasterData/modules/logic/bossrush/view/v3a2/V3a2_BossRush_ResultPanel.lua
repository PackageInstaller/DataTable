-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_ResultPanel.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_ResultPanel", package.seeall)

local V3a2_BossRush_ResultPanel = class("V3a2_BossRush_ResultPanel", BaseView)

function V3a2_BossRush_ResultPanel:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goscore = gohelper.findChild(self.viewGO, "#go_score")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#go_score/#simage_FullBG")
	self._simageDec = gohelper.findChildSingleImage(self.viewGO, "#go_score/#simage_Dec")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	self._goAffixItem = gohelper.findChild(self.viewGO, "#go_score/Right/Affix/#go_AffixItem")
	self._txtAffix = gohelper.findChildText(self.viewGO, "#go_score/Right/Affix/#go_AffixItem/#txt_Affix")
	self._goAssessNotEmpty = gohelper.findChild(self.viewGO, "#go_score/#go_AssessNotEmpty")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "#go_score/#go_AssessIcon")
	self._goassess = gohelper.findChild(self.viewGO, "#go_assess")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_ResultPanel:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveGet128EvaluateReply, self.refreshEvaluate, self)
	BossRushController.instance:registerCallback(BossRushEvent.V3a2_BossRush_ResultAssess_AnimFinish, self._animFinishCallback, self)
end

function V3a2_BossRush_ResultPanel:removeEvents()
	self._btnclose:RemoveClickListener()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveGet128EvaluateReply, self.refreshEvaluate, self)
	BossRushController.instance:unregisterCallback(BossRushEvent.V3a2_BossRush_ResultAssess_AnimFinish, self._animFinishCallback, self)
end

function V3a2_BossRush_ResultPanel:_btncloseOnClick()
	if self._clickCount < 60 and not self._isCanSkip then
		self._clickCount = self._clickCount + 1

		return
	end

	self:_openResultView()
end

function V3a2_BossRush_ResultPanel:onClickModalMask()
	self._isCanSkip = true

	self:_openResultView()
end

function V3a2_BossRush_ResultPanel:_editableInitView()
	self._imgScorebg = gohelper.findChildImage(self.viewGO, "#go_score/Right/Score/image_ScoreBG")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	self._gonewrecord = gohelper.findChild(self.viewGO, "#go_score/Right/Title/go_newrecord")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_score/Right/Title/txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_score/Right/Title/txt_TitleEn")

	gohelper.setActive(self._goscore, false)

	self._curStage, self._curLayer, self._actId = BossRushModel.instance:getBattleStageAndLayer()
	self.fightScore = BossRushModel.instance:getFightScore() or 0
	self._txtScore.text = BossRushConfig.instance:getScoreStr(self.fightScore)
	self._isSpecialLayer = BossRushModel.instance:isSpecialLayer(self._curLayer)

	self:createResultAssess()

	local go3s = gohelper.findChild(self.viewGO, "3s")
	local go4s = gohelper.findChild(self.viewGO, "4s")
	local go5s = gohelper.findChild(self.viewGO, "5s")

	self._govx = self:getUserDataTb_()
	self._govx[BossRushEnum.ScoreLevelStr.SSS] = go3s
	self._govx[BossRushEnum.ScoreLevelStr.SSSS] = go4s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSS] = go5s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSSS] = go5s

	self:initEvaluate()
end

function V3a2_BossRush_ResultPanel:onOpen()
	self._isCanSkip = false
	self._clickCount = 0

	self:setAssessIcon()
	self:checkIsNewRecord()
end

function V3a2_BossRush_ResultPanel:_openResultView()
	if self._actId == V3a9_BossRushModel.instance:getActModeActId() then
		ViewMgr.instance:openView(ViewName.V3a9_BossRush_ResultView, self.viewParam)
	else
		ViewMgr.instance:openView(ViewName.V3a2_BossRush_ResultView, self.viewParam)
	end

	self:closeThis()
end

function V3a2_BossRush_ResultPanel:createResultAssess()
	local path = BossRushEnum.ResPath.v3a2_bossrush_resultassess
	local childGO = self:getResInst(path, self._goassess, "ResultAssess")

	self._resultAssessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V3a2_BossRush_ResultAssess)
end

function V3a2_BossRush_ResultPanel:createAssessIcon()
	local path = BossRushEnum.ResPath.v1a4_bossrush_result_assess
	local childGO = self:getResInst(path, self._goAssessIcon.gameObject, "AssessIcon")

	self._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_BossRush_AssessIcon)
end

function V3a2_BossRush_ResultPanel:setAssessIcon()
	local type = BossRushEnum.AssessType.V3a2
	local res, level, strLevel = BossRushConfig.instance:getAssessSpriteName(self._curStage, self.fightScore, type)
	local scoreVX = self._govx[strLevel]

	for lv, go in pairs(self._govx) do
		local isShow = scoreVX == go

		gohelper.setActive(go, isShow)
	end

	local _isEmpty = string.nilorempty(res)

	gohelper.setActive(self._goAssessNotEmpty, not _isEmpty)

	if self._resultAssessItem then
		if not self._assessItem then
			self:createAssessIcon()
			self._assessItem:setData(self._curStage, self.fightScore, self._isSpecialLayer)
		end

		self._resultAssessItem:playAnim(self.fightScore)
	end
end

function V3a2_BossRush_ResultPanel:_animFinishCallback()
	gohelper.setActive(self._goscore, true)
	gohelper.setActive(self._goassess, false)
	self:_openAnimCallback()

	self._isCanSkip = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_level)
end

function V3a2_BossRush_ResultPanel:initEvaluate()
	gohelper.setActive(self._goAffixItem, false)

	local image = gohelper.findChildImage(self._goAffixItem, "image_AffixBG")
	local icon = self._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg"

	UISpriteSetMgr.instance:setV1a4BossRushSprite(image, icon)

	self._evaluateList = self:getUserDataTb_()

	self:refreshEvaluate()
end

function V3a2_BossRush_ResultPanel:refreshEvaluate()
	local ids = BossRushModel.instance:getEvaluateList()
	local isHasEvaluate = ids and #ids > 0

	if isHasEvaluate then
		for i, id in pairs(ids) do
			local item = self:getEvaluateItem(i)
			local name, desc = BossRushConfig.instance:getEvaluateInfo(id)

			item.txt.text = name

			gohelper.setActive(item.go, true)
		end

		if #self._evaluateList > #ids then
			for i = #ids + 1, #self._evaluateList do
				gohelper.setActive(self._evaluateList[i].go, false)
			end
		end
	end
end

function V3a2_BossRush_ResultPanel:getEvaluateItem(index)
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

function V3a2_BossRush_ResultPanel:_openAnimCallback()
	if self._evaluateList then
		for _, v in pairs(self._evaluateList) do
			v.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function V3a2_BossRush_ResultPanel:checkIsNewRecord()
	if self._curStage then
		local isNew = BossRushModel.instance:checkIsNewHighestPointRecord(self._curStage)

		if isNew then
			if not V3a2BossRushEnum.ResultRecord.New then
				local str = V3a2BossRushEnum.ResultRecord.Normal

				self._txtTitle.text = luaLang(str)
				self._txtTitleEn.text = luaLang(str .. "_en")

				gohelper.setActive(self._gonewrecord, isNew)

				if self._resultAssessItem then
					self._resultAssessItem:showNewRecord(isNew)
				end
			end
		end
	end
end

function V3a2_BossRush_ResultPanel:onClose()
	return
end

function V3a2_BossRush_ResultPanel:onDestroyView()
	return
end

return V3a2_BossRush_ResultPanel
