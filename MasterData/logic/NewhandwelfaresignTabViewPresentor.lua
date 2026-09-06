-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfaresignTabViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfaresignTabViewPresentor", package.seeall)

local NewhandwelfaresignTabViewPresentor = class("NewhandwelfaresignTabViewPresentor", ViewPresentor)

function NewhandwelfaresignTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandwelfaresignTabViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfaresigntabview.prefab"
	}
end

function NewhandwelfaresignTabViewPresentor:buildViews()
	return {
		NewhandwelfaresignTabView.New()
	}
end

function NewhandwelfaresignTabViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfaresignTabViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfaresignTabViewPresentor
