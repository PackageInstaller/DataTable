-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfaresignViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfaresignViewPresentor", package.seeall)

local NewhandwelfaresignViewPresentor = class("NewhandwelfaresignViewPresentor", ViewPresentor)

function NewhandwelfaresignViewPresentor:ctor()
	NewhandwelfaresignViewPresentor.super.ctor(self)
end

function NewhandwelfaresignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandwelfaresignViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfaresignview.prefab"
	}
end

function NewhandwelfaresignViewPresentor:buildViews()
	return {
		NewhandwelfaresignView.New()
	}
end

function NewhandwelfaresignViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandwelfaresignViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandwelfaresignViewPresentor
