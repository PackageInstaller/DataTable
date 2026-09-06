-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegeViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegeViewPresentor", package.seeall)

local NewhandprivilegeViewPresentor = class("NewhandprivilegeViewPresentor", ViewPresentor)

function NewhandprivilegeViewPresentor:ctor()
	NewhandprivilegeViewPresentor.super.ctor(self)
end

function NewhandprivilegeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandprivilegeViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandprivilegeview.prefab"
	}
end

function NewhandprivilegeViewPresentor:buildViews()
	return {
		NewhandprivilegeView.New()
	}
end

function NewhandprivilegeViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandprivilegeViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandprivilegeViewPresentor
