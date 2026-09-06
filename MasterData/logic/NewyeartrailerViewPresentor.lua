-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/NewyeartrailerViewPresentor.lua

module("logic.extensions.bonus.view.christmasandnewyear.NewyeartrailerViewPresentor", package.seeall)

local NewyeartrailerViewPresentor = class("NewyeartrailerViewPresentor", ViewPresentor)

function NewyeartrailerViewPresentor:ctor()
	NewyeartrailerViewPresentor.super.ctor(self)
end

function NewyeartrailerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewyeartrailerViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/christmasandnewyear/newyeartrailerview.prefab"
	}
end

function NewyeartrailerViewPresentor:buildViews()
	return {
		NewyeartrailerView.New()
	}
end

return NewyeartrailerViewPresentor
