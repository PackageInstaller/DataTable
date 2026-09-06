-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranBuffViewPresentor.lua

module("logic.extensions.sunranbattle.view.SunranBuffViewPresentor", package.seeall)

local SunranBuffViewPresentor = class("SunranBuffViewPresentor", ViewWithGuidePresentor)

function SunranBuffViewPresentor:ctor()
	SunranBuffViewPresentor.super.ctor(self)
end

function SunranBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunranBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/sunranbattle/sunranbuffview.prefab"
	}
end

function SunranBuffViewPresentor:buildViews()
	return {
		SunranBuffView.New()
	}
end

return SunranBuffViewPresentor
