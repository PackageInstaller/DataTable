-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_Assess_Score.lua

module("modules.logic.bossrush.view.V1a4_BossRush_Assess_Score", package.seeall)

local V1a4_BossRush_Assess_Score = class("V1a4_BossRush_Assess_Score", V1a4_BossRush_AssessIcon)

function V1a4_BossRush_Assess_Score:init(go)
	V1a4_BossRush_AssessIcon.init(self, go)

	self._txtScoreNum = gohelper.findChildText(go, "Score/#txt_ScoreNum")
	self._txtScoreTran = gohelper.findChild(go, "Score/#txt_Score").transform
	self._newRecordTran = gohelper.findChild(go, "Score/#txt_ScoreNum/NewRecord").transform
	self.vxassess = {
		[BossRushEnum.ScoreLevel.S] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_s"),
		[BossRushEnum.ScoreLevel.S_A] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_ss"),
		[BossRushEnum.ScoreLevel.S_AA] = gohelper.findChild(self._imageAssessIcon.gameObject, "vx_sss")
	}

	self:setActiveNewRecord(false)
	self:showVX(false)

	self._txtScoreNum.text = ""
end

function V1a4_BossRush_Assess_Score:setActiveDesc(isActive)
	GameUtil.setActive01(self._txtScoreTran, isActive)
end

function V1a4_BossRush_Assess_Score:setActiveNewRecord(isActive)
	GameUtil.setActive01(self._newRecordTran, isActive)
end

function V1a4_BossRush_Assess_Score:setData(stage, score, type)
	V1a4_BossRush_AssessIcon.setData(self, stage, score, type)

	local _, level = BossRushConfig.instance:getAssessSpriteName(stage, score, type)

	self._txtScoreNum.text = BossRushConfig.instance:getScoreStr(score)

	self:showVX(level)

	if level > 0 then
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
	end
end

function V1a4_BossRush_Assess_Score:setData_ResultView(stage, score, type)
	self:setData(stage, score, type)

	local _, level = BossRushConfig.instance:getAssessSpriteName(stage, score, type)

	if level > 0 then
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources)
	end
end

function V1a4_BossRush_Assess_Score:onDestroyView()
	return
end

function V1a4_BossRush_Assess_Score:showVX(level)
	for i, v in pairs(self.vxassess) do
		gohelper.setActive(v, level == i)
	end
end

return V1a4_BossRush_Assess_Score
