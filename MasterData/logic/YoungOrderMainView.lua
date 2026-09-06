-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/youngorder/YoungOrderMainView.lua

module("logic.extensions.holydarkmm.view.youngorder.YoungOrderMainView", package.seeall)

local YoungOrderMainView = class("YoungOrderMainView", HolyDarkMMMainView)

function YoungOrderMainView:buildUI()
	YoungOrderMainView.super.buildUI(self)

	self._buffRoot = self:getGo("buffRoot")
end

function YoungOrderMainView:onEnter()
	YoungOrderMainView.super.onEnter(self)
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
end

function YoungOrderMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.YoungOrderChallengeView, self._activityId)
end

function YoungOrderMainView:_onClickTip()
	TipsFacade.instance:openRulesView("faduzhixumainview_rule")
end

return YoungOrderMainView
