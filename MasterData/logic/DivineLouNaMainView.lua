-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaMainView.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaMainView", package.seeall)

local DivineLouNaMainView = class("DivineLouNaMainView", ShenJiChallengeMainView)

function DivineLouNaMainView:_getActivityId()
	return checknumber(self:getFirstParam())
end

function DivineLouNaMainView:_onClickChallenge1()
	UIStateManager.instance:push(ViewName.DivineLouNaSelectView, self._activityId)
end

function DivineLouNaMainView:_onClickChallenge2()
	UIStateManager.instance:push(ViewName.DivineLouNaBossView, self._activityId)
end

return DivineLouNaMainView
