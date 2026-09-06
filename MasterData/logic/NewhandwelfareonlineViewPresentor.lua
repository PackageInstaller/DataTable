-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareonlineViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareonlineViewPresentor", package.seeall)

local NewhandwelfareonlineViewPresentor = class("NewhandwelfareonlineViewPresentor", ViewPresentor)

function NewhandwelfareonlineViewPresentor:ctor()
	NewhandwelfareonlineViewPresentor.super.ctor(self)
end

function NewhandwelfareonlineViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandwelfareonlineViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfareonlineview.prefab"
	}
end

function NewhandwelfareonlineViewPresentor:buildViews()
	return {
		NewhandwelfareonlineView.New()
	}
end

function NewhandwelfareonlineViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfareonlineViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfareonlineViewPresentor
