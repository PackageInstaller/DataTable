-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaSelectView.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaSelectView", package.seeall)

local DivineLouNaSelectView = class("DivineLouNaSelectView", ShenJiSelectView)

function DivineLouNaSelectView:_onClickSlider()
	UIStateManager.instance:push(ViewName.DivineLouNaBuffView, self._activityId)
end

function DivineLouNaSelectView:_onClickTip()
	local ruleCfg = ShenJiChallengeConfig.instance:getRuleCfgs(self._activityId, 1)

	if ruleCfg and ruleCfg[1] then
		local cfg = ruleCfg[1]
		local key = cfg.ruleKey

		TipsFacade.instance:openRulesView(key)
	end
end

function DivineLouNaSelectView:_popupTipViewFirst()
	local key = ViewName.ShenJiSelectView .. self._activityId
	local isMarkedFirst = GameUtil.getUserData(key)

	if not isMarkedFirst then
		GameUtil.saveUserData(key, true)
		self:_onClickTip()
	end
end

return DivineLouNaSelectView
