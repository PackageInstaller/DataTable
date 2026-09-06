-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfarejumpViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfarejumpViewPresentor", package.seeall)

local NewhandwelfarejumpViewPresentor = class("NewhandwelfarejumpViewPresentor", ViewPresentor)

function NewhandwelfarejumpViewPresentor:ctor()
	NewhandwelfarejumpViewPresentor.super.ctor(self)
end

function NewhandwelfarejumpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandwelfarejumpViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfarejumpview.prefab"
	}
end

function NewhandwelfarejumpViewPresentor:buildViews()
	return {
		NewhandwelfarejumpView.New()
	}
end

function NewhandwelfarejumpViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfarejumpViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfarejumpViewPresentor
