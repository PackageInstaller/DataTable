-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareprivilegeViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareprivilegeViewPresentor", package.seeall)

local NewhandwelfareprivilegeViewPresentor = class("NewhandwelfareprivilegeViewPresentor", ViewPresentor)

function NewhandwelfareprivilegeViewPresentor:ctor()
	NewhandwelfareprivilegeViewPresentor.super.ctor(self)
end

function NewhandwelfareprivilegeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandwelfareprivilegeViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfareprivilegeview.prefab"
	}
end

function NewhandwelfareprivilegeViewPresentor:buildViews()
	return {
		NewhandwelfareprivilegeView.New()
	}
end

function NewhandwelfareprivilegeViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfareprivilegeViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfareprivilegeViewPresentor
