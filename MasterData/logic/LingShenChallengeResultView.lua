-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/view/LingShenChallengeResultView.lua

module("logic.extensions.lingshenchallenge.view.LingShenChallengeResultView", package.seeall)

local LingShenChallengeResultView = class("LingShenChallengeResultView", BattleSettlementSuccessView)

function LingShenChallengeResultView:customSettlementInfo()
	self:_onEnumTypeIsLingShen()
end

function LingShenChallengeResultView:_onEnumTypeIsLingShen()
	local params = BattleSettlementModel.instance:getParams()

	self:dequeueQueue()
	self:enqueueQueue(self._settlementProgress, {
		params.curTotalDamage,
		params.maxBossHp,
		params.conditionStr
	})
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

return LingShenChallengeResultView
