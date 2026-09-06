-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangmainView.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangmainView", package.seeall)

local SyguangmingwangmainView = class("SyguangmingwangmainView", LianjinMainView)

function SyguangmingwangmainView:_getChallengeId()
	return AthenaModel.CHALLENGEID_SYGMY
end

function SyguangmingwangmainView:_onClickWit()
	UIStateManager.instance:push(ViewName.SyguangmingwangwitView, self._challengeId)
end

function SyguangmingwangmainView:_onClickForce()
	UIStateManager.instance:push(ViewName.SyguangmingwangforceView, self._challengeId)
end

function SyguangmingwangmainView:_onClickRank()
	GotoMgr.gotoByString(self._cfg and self._cfg.jumpRank)
end

function SyguangmingwangmainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "syguangmingwangmainview_rule")
end

function SyguangmingwangmainView:_clickBtn()
	if AthenaModel.instance:getBattleType(self._challengeId) == 2 then
		self:_onClickForce()
	elseif AthenaModel.instance:getBattleType(self._challengeId) == 1 then
		self:_onClickWit()
	end
end

function SyguangmingwangmainView:onEnter()
	SyguangmingwangmainView.super.onEnter(self)
end

return SyguangmingwangmainView
