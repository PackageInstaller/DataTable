-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SmallLuyngardeMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SmallLuyngardeMainViewPresentor", package.seeall)

local SmallLuyngardeMainViewPresentor = class("SmallLuyngardeMainViewPresentor", ViewPresentor)

function SmallLuyngardeMainViewPresentor:ctor()
	SmallLuyngardeMainViewPresentor.super.ctor(self)
end

function SmallLuyngardeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SmallLuyngardeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/smallluyngardemainview.prefab"
	}
end

function SmallLuyngardeMainViewPresentor:buildViews()
	return {
		SmallLuyngardeMainView.New()
	}
end

return SmallLuyngardeMainViewPresentor
