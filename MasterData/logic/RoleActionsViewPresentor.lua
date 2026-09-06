-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleactions/view/RoleActionsViewPresentor.lua

module("logic.extensions.recommendfmt.view.RoleActionsViewPresentor", package.seeall)

local RoleActionsViewPresentor = class("RoleActionsViewPresentor", ViewPresentor)

function RoleActionsViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function RoleActionsViewPresentor:dependWhatResources()
	return {
		CommonResPath.RoleActions
	}
end

function RoleActionsViewPresentor:buildViews()
	return {
		RoleActionsView.New()
	}
end

function RoleActionsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RoleActionsViewPresentor
