-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintianmanwang/view/OrigintianmanwangpopViewPresentor.lua

module("logic.extensions.origintianmanwang.view.OrigintianmanwangpopViewPresentor", package.seeall)

local OrigintianmanwangpopViewPresentor = class("OrigintianmanwangpopViewPresentor", ViewPresentor)

function OrigintianmanwangpopViewPresentor:ctor()
	OrigintianmanwangpopViewPresentor.super.ctor(self)
end

function OrigintianmanwangpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigintianmanwangpopViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/origintianmanwang/origintianmanwangpopview.prefab"
	}
end

function OrigintianmanwangpopViewPresentor:buildViews()
	return {
		OrigintianmanwangpopView.New()
	}
end

return OrigintianmanwangpopViewPresentor
