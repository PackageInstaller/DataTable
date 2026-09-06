-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfarejumpTabViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfarejumpTabViewPresentor", package.seeall)

local NewhandwelfarejumpTabViewPresentor = class("NewhandwelfarejumpTabViewPresentor", ViewPresentor)

function NewhandwelfarejumpTabViewPresentor:ctor()
	NewhandwelfarejumpTabViewPresentor.super.ctor(self)
end

function NewhandwelfarejumpTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandwelfarejumpTabViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfarejumptabview.prefab"
	}
end

function NewhandwelfarejumpTabViewPresentor:buildViews()
	return {
		NewhandwelfarejumpTabView.New()
	}
end

function NewhandwelfarejumpTabViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfarejumpTabViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfarejumpTabViewPresentor
