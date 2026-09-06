-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranRankViewPresentor.lua

module("logic.extensions.sunranbattle.view.SunranRankViewPresentor", package.seeall)

local SunranRankViewPresentor = class("SunranRankViewPresentor", ViewWithGuidePresentor)

function SunranRankViewPresentor:ctor()
	SunranRankViewPresentor.super.ctor(self)
end

function SunranRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunranRankViewPresentor:dependWhatResources()
	return {
		"ui/views/sunranbattle/sunranrankview.prefab"
	}
end

function SunranRankViewPresentor:buildViews()
	return {
		SunranRankView.New()
	}
end

return SunranRankViewPresentor
