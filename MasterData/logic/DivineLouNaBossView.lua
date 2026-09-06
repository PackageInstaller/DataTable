-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaBossView.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaBossView", package.seeall)

local DivineLouNaBossView = class("DivineLouNaBossView", ShenJiBossView)

function DivineLouNaBossView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineLouNaBuffView, self._activityId)
end

function DivineLouNaBossView:_onClickTip()
	local ruleCfg = ShenJiChallengeConfig.instance:getRuleCfgs(self._activityId, 2)

	if ruleCfg and ruleCfg[1] then
		local cfg = ruleCfg[1]
		local key = cfg.ruleKey

		TipsFacade.instance:openRulesView(key)
	end
end

function DivineLouNaBossView:_popupTipViewFirst()
	local key = ViewName.ShenJiBossView .. self._activityId
	local isMarkedFirst = GameUtil.getUserData(key)

	if not isMarkedFirst then
		GameUtil.saveUserData(key, true)
		self:_onClickTip()
	end
end

function DivineLouNaBossView:_onClickChallenge()
	if ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId) then
		FloatWordMgr.instance:show("您已挑战完成，无需再战")

		return
	end

	if ShenJiChallengeModel.instance:getTodayPassBoss() then
		FloatWordMgr.instance:show("今日Boss已挑战成功")

		return
	end

	local maxNum = self._fightBossTimes
	local curNum = ShenJiChallengeModel.instance:getBossChallengeTimes()
	local leftNum = Mathf.Max(maxNum - curNum, 0)

	if leftNum <= 0 then
		local text = string.format("本轮挑战失败，请重置挑战\n<color=#%s>提示：适合的阵型和化器buff能提高破阵概率</color>", ColorConst.Green)

		TipsFacade.instance:openTipWindowNoX(lang("tip"), text, nil, nil, UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local isEmulate = false

	ShenJiChallengeController.instance:openBossMissionView(self._activityId, self._bossId, isEmulate)
end

return DivineLouNaBossView
