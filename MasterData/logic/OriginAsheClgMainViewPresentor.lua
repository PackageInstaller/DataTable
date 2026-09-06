-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgMainViewPresentor.lua

module("logic.extensions.originasheclg.view.OriginAsheClgMainViewPresentor", package.seeall)

local OriginAsheClgMainViewPresentor = class("OriginAsheClgMainViewPresentor", ViewPresentor)

function OriginAsheClgMainViewPresentor:ctor()
	OriginAsheClgMainViewPresentor.super.ctor(self)
end

function OriginAsheClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAsheClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originasheclg/originasheclgmainview.prefab"
	}
end

function OriginAsheClgMainViewPresentor:buildViews()
	return {
		OriginAsheClgMainView.New()
	}
end

return OriginAsheClgMainViewPresentor
