-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranResultViewPresentor.lua

module("logic.extensions.sunranbattle.view.SunranResultViewPresentor", package.seeall)

local SunranResultViewPresentor = class("SunranResultViewPresentor", ViewWithGuidePresentor)

function SunranResultViewPresentor:ctor()
	SunranResultViewPresentor.super.ctor(self)
end

function SunranResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunranResultViewPresentor:dependWhatResources()
	return {
		"ui/views/sunranbattle/sunranresultview.prefab"
	}
end

function SunranResultViewPresentor:buildViews()
	return {
		SunranResultView.New()
	}
end

return SunranResultViewPresentor
