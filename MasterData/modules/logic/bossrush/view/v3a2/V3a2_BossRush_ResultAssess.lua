-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_ResultAssess.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_ResultAssess", package.seeall)

local V3a2_BossRush_ResultAssess = class("V3a2_BossRush_ResultAssess", ListScrollCellExtend)

function V3a2_BossRush_ResultAssess:onInitView()
	self._simageDec1 = gohelper.findChildSingleImage(self.viewGO, "Dec/#simage_Dec1")
	self._simageDec2 = gohelper.findChildSingleImage(self.viewGO, "Dec/#simage_Dec2")
	self._gocomplete = gohelper.findChild(self.viewGO, "#go_complete")
	self._goScore = gohelper.findChild(self.viewGO, "#go_Score")
	self._txtScore1 = gohelper.findChildText(self.viewGO, "#go_Score/Score1/#txt_Score")
	self._txtScore2 = gohelper.findChildText(self.viewGO, "#go_Score/Score2/#txt_Score")
	self._goRecord = gohelper.findChild(self.viewGO, "#go_Record")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_Record/#txt_Score")
	self._goNewRecord = gohelper.findChild(self.viewGO, "#go_Record/#go_NewRecord")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_ResultAssess:addEvents()
	return
end

function V3a2_BossRush_ResultAssess:removeEvents()
	return
end

function V3a2_BossRush_ResultAssess:_editableInitView()
	self._goScore1 = gohelper.findChild(self.viewGO, "#go_Score/Score1")
	self._goScore2 = gohelper.findChild(self.viewGO, "#go_Score/Score2")
	self._txtRecord = gohelper.findChildText(self.viewGO, "#go_Record/#txt_record")
	self._recordAnimEvent = self._goRecord:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._recordAnimEvent:AddEventListener(V3a2BossRushEnum.AnimEventName.RecordScore, self._playAnim4, self)

	self._scoreAnimEvent = self._goScore:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._scoreAnimEvent:AddEventListener(V3a2BossRushEnum.AnimEventName.PlayAudio_Appraise, self._playAudio_Appraise, self)
end

function V3a2_BossRush_ResultAssess:_editableAddEvents()
	return
end

function V3a2_BossRush_ResultAssess:_editableRemoveEvents()
	return
end

function V3a2_BossRush_ResultAssess:onUpdateMO(mo)
	return
end

function V3a2_BossRush_ResultAssess:onSelect(isSelect)
	return
end

function V3a2_BossRush_ResultAssess:onDestroyView()
	self:destroyFlow()
	self._recordAnimEvent:RemoveEventListener(V3a2BossRushEnum.AnimEventName.RecordScore)
	self._scoreAnimEvent:RemoveEventListener(V3a2BossRushEnum.AnimEventName.PlayAudio_Appraise)
end

function V3a2_BossRush_ResultAssess:showNewRecord(isNew)
	gohelper.setActive(self._goNewRecord, isNew)

	if isNew then
		if not V3a2BossRushEnum.ResultRecord.New then
			local str = V3a2BossRushEnum.ResultRecord.Normal

			self._txtRecord.text = luaLang(str)
		end
	end
end

function V3a2_BossRush_ResultAssess:isHasZeroScore()
	local score = V3a2_BossRushModel.instance:getScore()

	return score.baseScore == 0 or score.ruleScore == 0
end

function V3a2_BossRush_ResultAssess:playAnim(fightScore)
	self._fightScore = fightScore
	self._txtScore.text = 0

	local score = V3a2_BossRushModel.instance:getScore()

	self._txtScore1.text = BossRushConfig.instance:getScoreStr(score.baseScore or 0)
	self._txtScore2.text = BossRushConfig.instance:getScoreStr(score.ruleScore or 0)

	self:destroyFlow()

	self.workFlow = FlowSequence.New()

	self.workFlow:addWork(DelayFuncWork.New(self._playAnim0, self, 1))
	self.workFlow:start()
end

function V3a2_BossRush_ResultAssess:_playAnim0()
	gohelper.setActive(self._goScore, false)
	gohelper.setActive(self._goRecord, false)
	gohelper.setActive(self._gocomplete, true)
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
	self.workFlow:addWork(DelayFuncWork.New(self._playAnim1, self, 2))
end

function V3a2_BossRush_ResultAssess:destroyFlow()
	if self.workFlow then
		self.workFlow:destroy()

		self.workFlow = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function V3a2_BossRush_ResultAssess:_playAnim1()
	gohelper.setActive(self._gocomplete, false)

	if self:isHasZeroScore() then
		self:_playAnim3()
	else
		self:_playAnim2()
	end
end

function V3a2_BossRush_ResultAssess:_playAnim2()
	gohelper.setActive(self._goScore, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_survey)
	self.workFlow:addWork(DelayFuncWork.New(self._playAnim3, self, 1.5))
end

function V3a2_BossRush_ResultAssess:_playAudio_Appraise()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_appraise)
end

function V3a2_BossRush_ResultAssess:_playAnim3()
	gohelper.setActive(self._goRecord, true)
	gohelper.setActive(self._goScore, false)
	self.workFlow:addWork(DelayFuncWork.New(self._playAnim5, self, 1.5))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
end

function V3a2_BossRush_ResultAssess:_playAnim4()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, self._fightScore, 0.5, self._onTweenUpdate, self._onTweenFinish, self)
end

function V3a2_BossRush_ResultAssess:_playAnim5()
	gohelper.setActive(self._goRecord, false)
	self:_onFinishAnim()
end

function V3a2_BossRush_ResultAssess:_onTweenUpdate(value)
	if self._txtScore then
		self._txtScore.text = BossRushConfig.instance:getScoreStr(Mathf.Ceil(value))
	end
end

function V3a2_BossRush_ResultAssess:_onTweenFinish()
	self:_onTweenUpdate(self._fightScore)
end

function V3a2_BossRush_ResultAssess:_onFinishAnim()
	BossRushController.instance:dispatchEvent(BossRushEvent.V3a2_BossRush_ResultAssess_AnimFinish)
end

return V3a2_BossRush_ResultAssess
