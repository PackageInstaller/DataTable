-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgLevelViewPresentor.lua

module("logic.extensions.originasheclg.view.OriginAsheClgLevelViewPresentor", package.seeall)

local OriginAsheClgLevelViewPresentor = class("OriginAsheClgLevelViewPresentor", ViewPresentor)

function OriginAsheClgLevelViewPresentor:ctor()
	OriginAsheClgLevelViewPresentor.super.ctor(self)
end

function OriginAsheClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAsheClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/originasheclg/originasheclglevelview.prefab"
	}
end

function OriginAsheClgLevelViewPresentor:buildViews()
	return {
		OriginAsheClgLevelView.New()
	}
end

return OriginAsheClgLevelViewPresentor
