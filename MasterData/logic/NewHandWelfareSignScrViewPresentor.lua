-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandWelfareSignScrViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewHandWelfareSignScrViewPresentor", package.seeall)

local NewHandWelfareSignScrViewPresentor = class("NewHandWelfareSignScrViewPresentor", ViewPresentor)

function NewHandWelfareSignScrViewPresentor:ctor()
	NewHandWelfareSignScrViewPresentor.super.ctor(self)
end

function NewHandWelfareSignScrViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewHandWelfareSignScrViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfaresignscrview.prefab"
	}
end

function NewHandWelfareSignScrViewPresentor:buildViews()
	return {
		NewHandWelfareSignScrView.New()
	}
end

function NewHandWelfareSignScrViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewHandWelfareSignScrViewPresentor.super.playEnterAnimation(self)
	end
end

return NewHandWelfareSignScrViewPresentor
