-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_ResultPanel.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultPanel", package.seeall)

local V1a6_BossRush_ResultPanel = class("V1a6_BossRush_ResultPanel", BaseView)

function V1a6_BossRush_ResultPanel:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goscore = gohelper.findChild(self.viewGO, "#go_score")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#go_score/#simage_FullBG")
	self._imgScorebg = gohelper.findChildImage(self.viewGO, "#go_score/Right/Score/image_ScoreBG")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	self._gonewrecord = gohelper.findChild(self.viewGO, "#go_score/Right/Title/go_newrecord")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_score/Right/Title/txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_score/Right/Title/txt_TitleEn")
	self._goAffixItem = gohelper.findChild(self.viewGO, "#go_score/Right/Affix/#go_AffixItem")
	self._txtAffix = gohelper.findChildText(self.viewGO, "#go_score/Right/Affix/#go_AffixItem/#txt_Affix")
	self._goAssessNotEmpty = gohelper.findChild(self.viewGO, "#go_score/#go_AssessNotEmpty")
	self._imgAssessbg = gohelper.findChildImage(self.viewGO, "#go_score/#go_AssessNotEmpty/image_AssessLight")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "#go_score/#go_AssessIcon")
	self._goassess = gohelper.findChild(self.viewGO, "#go_assess")
	self._goRigth = gohelper.findChild(self.viewGO, "#go_score/Right")
	self._go3s = gohelper.findChild(self.viewGO, "#go_score/3s")
	self._go4s = gohelper.findChild(self.viewGO, "#go_score/4s")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_ResultPanel:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveGet128EvaluateReply, self.refreshEvaluate, self)
	self._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.ScoreTween, self._scoreTweenCallback, self)
end

function V1a6_BossRush_ResultPanel:removeEvents()
	self._btnclose:RemoveClickListener()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveGet128EvaluateReply, self.refreshEvaluate, self)
	self._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.ScoreTween)
end

function V1a6_BossRush_ResultPanel:_btncloseOnClick()
	if self._clickCount < 60 and not self._isCanSkip then
		self._clickCount = self._clickCount + 1

		return
	end

	self:_openResultView()
end

function V1a6_BossRush_ResultPanel:_editableInitView()
	self._curStage, self._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	self.fightScore = BossRushModel.instance:getFightScore() or 0
	self._txtScore.text = 0
	self._isSpecialLayer = BossRushModel.instance:isSpecialLayer(self._curLayer)

	self:createResultAssess()
	self:setAssessIcon()
	self:initEvaluate()
	self:checkIsNewRecord()
end

function V1a6_BossRush_ResultPanel:_openResultView()
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_ResultView, self.viewParam)
	self:closeThis()
end

function V1a6_BossRush_ResultPanel:onUpdateParam()
	return
end

function V1a6_BossRush_ResultPanel:onOpen()
	self._isCanSkip = false
	self._clickCount = 0
end

function V1a6_BossRush_ResultPanel:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:_onTweenFinish()
end

function V1a6_BossRush_ResultPanel:onDestroyView()
	return
end

function V1a6_BossRush_ResultPanel:onClickModalMask()
	self:_btncloseOnClick()
end

function V1a6_BossRush_ResultPanel:setAssessIcon()
	if self._isSpecialLayer then
		if not BossRushEnum.AssessType.Layer4 then
			local type = BossRushEnum.AssessType.Normal
			local res, level, strLevel = BossRushConfig.instance:getAssessSpriteName(self._curStage, self.fightScore, type)
			local _isEmpty = string.nilorempty(res)

			gohelper.setActive(self._goAssessNotEmpty, not _isEmpty)

			if self._resultAssessItem then
				self._resultAssessItem:setData(self._curStage, self.fightScore, level, self, type)
			else
				if not self._assessItem then
					self:createAssessIcon()
					self._assessItem:setData(self._curStage, self.fightScore, type)
				end

				self._resultAssessItem:playAnim(_isEmpty, self._animFinishCallback, self)
				self._resultAssessItem:refreshLayerGo(self._isSpecialLayer)
			end

			if _isEmpty then
				if not BossRushEnum.V1a6_ResultAnimName.OpenEmpty then
					local anim = BossRushEnum.V1a6_ResultAnimName.Open

					self._animatorPlayer:Play(anim, self._openAnimCallback, self)

					level = level or -1

					local is4S = level > BossRushEnum.ScoreLevel.S_AA

					self._imgScorebg.color = is4S and SLFramework.UGUI.GuiHelper.ParseColor("#D6816C") or Color.white
					self._imgAssessbg.color = is4S and SLFramework.UGUI.GuiHelper.ParseColor("#E78263") or Color.white

					gohelper.setActive(self._go3s, not self._isSpecialLayer and not is4S)
					gohelper.setActive(self._go4s, not self._isSpecialLayer and is4S)

					local layer4_1 = gohelper.findChild(self.viewGO, "#go_score/Layer4")

					gohelper.setActive(layer4_1, self._isSpecialLayer)
				end
			end
		end
	end
end

function V1a6_BossRush_ResultPanel:createResultAssess()
	local path = BossRushEnum.ResPath.v1a6_bossrush_result_assess
	local childGO = self:getResInst(path, self._goassess, "ResultAssess")

	self._resultAssessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_BossRush_ResultAssess)
end

function V1a6_BossRush_ResultPanel:createAssessIcon()
	local path = BossRushEnum.ResPath.v1a4_bossrush_result_assess
	local childGO = self:getResInst(path, self._goAssessIcon.gameObject, "AssessIcon")

	self._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_BossRush_AssessIcon)
end

function V1a6_BossRush_ResultPanel:_animFinishCallback()
	return
end

function V1a6_BossRush_ResultPanel:_openAnimCallback()
	if self._evaluateList then
		for _, v in pairs(self._evaluateList) do
			v.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function V1a6_BossRush_ResultPanel:_scoreTweenCallback()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, self.fightScore, 0.5, self._onTweenUpdate, self._onTweenFinish, self)
end

function V1a6_BossRush_ResultPanel:_onTweenUpdate(value)
	if self._txtScore then
		self._txtScore.text = Mathf.Ceil(value)
	end
end

function V1a6_BossRush_ResultPanel:_onTweenFinish()
	self._isCanSkip = true
	self._txtScore.text = self.fightScore
end

function V1a6_BossRush_ResultPanel:initEvaluate()
	gohelper.setActive(self._goAffixItem, false)

	local image = gohelper.findChildImage(self._goAffixItem, "image_AffixBG")
	local icon = self._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg"

	UISpriteSetMgr.instance:setV1a4BossRushSprite(image, icon)

	self._evaluateList = self:getUserDataTb_()

	self:refreshEvaluate()
end

function V1a6_BossRush_ResultPanel:refreshEvaluate()
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

function V1a6_BossRush_ResultPanel:getEvaluateItem(index)
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

function V1a6_BossRush_ResultPanel:checkIsNewRecord()
	if self._curStage then
		local isNew = BossRushModel.instance:checkIsNewHighestPointRecord(self._curStage)
		local str = isNew and "v1a4_bossrush_resultview_txt_newrecord" or "v1a4_bossrush_resultview_txt_score"

		self._txtTitle.text = luaLang(str)
		self._txtTitleEn.text = luaLang(str .. "_en")

		gohelper.setActive(self._gonewrecord, isNew)
	end
end

return V1a6_BossRush_ResultPanel
