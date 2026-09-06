-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minghuangchallenge/view/MinghuangdetailView.lua

module("logic.extensions.minghuangchallenge.view.MinghuangdetailView", package.seeall)

local MinghuangdetailView = class("MinghuangdetailView", TimeLimitedDetailView)

function MinghuangdetailView:buildUI()
	MinghuangdetailView.super.buildUI(self)

	self._challengeId = 147
end

function MinghuangdetailView:_onClickFinish()
	local text = string.format("你确定要结束当次挑战吗？\n还剩下%s次战斗轮数，\n一旦确定结束则根据当前累积总伤害结算奖励。", 5 - self._info.curRound)

	local function okHandler()
		TLChallengeController.instance:reqResetChallenge(self._challengeId, self._onResetChallengeRes, self)
	end

	TLChallengeController.instance:openTLCTip("结束挑战", text, "结束挑战", okHandler, nil, self._challengeId, true, "board_tzfbb_01")
end

return MinghuangdetailView
