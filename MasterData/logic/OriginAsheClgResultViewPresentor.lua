-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgResultViewPresentor.lua

module("logic.extensions.originasheclg.view.OriginAsheClgResultViewPresentor", package.seeall)

local OriginAsheClgResultViewPresentor = class("OriginAsheClgResultViewPresentor", ViewPresentor)

function OriginAsheClgResultViewPresentor:ctor()
	OriginAsheClgResultViewPresentor.super.ctor(self)
end

function OriginAsheClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAsheClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originasheclg/originasheclgresultview.prefab"
	}
end

function OriginAsheClgResultViewPresentor:buildViews()
	return {
		OriginAsheClgResultView.New()
	}
end

return OriginAsheClgResultViewPresentor
