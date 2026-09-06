-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareonlineTabViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareonlineTabViewPresentor", package.seeall)

local NewhandwelfareonlineTabViewPresentor = class("NewhandwelfareonlineTabViewPresentor", ViewPresentor)

function NewhandwelfareonlineTabViewPresentor:ctor()
	NewhandwelfareonlineTabViewPresentor.super.ctor(self)
end

function NewhandwelfareonlineTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandwelfareonlineTabViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfareonlinetabview.prefab"
	}
end

function NewhandwelfareonlineTabViewPresentor:buildViews()
	return {
		NewhandwelfareonlineTabView.New()
	}
end

function NewhandwelfareonlineTabViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfareonlineTabViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfareonlineTabViewPresentor
