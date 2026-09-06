-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegeTabViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegeTabViewPresentor", package.seeall)

local NewhandprivilegeTabViewPresentor = class("NewhandprivilegeTabViewPresentor", ViewPresentor)

function NewhandprivilegeTabViewPresentor:ctor()
	NewhandprivilegeTabViewPresentor.super.ctor(self)
end

function NewhandprivilegeTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandprivilegeTabViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandprivilegetabview.prefab"
	}
end

function NewhandprivilegeTabViewPresentor:buildViews()
	return {
		NewhandprivilegeTabView.New()
	}
end

function NewhandprivilegeTabViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandprivilegeTabViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandprivilegeTabViewPresentor
