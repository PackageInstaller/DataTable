-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintianmanwang/view/OrigintianmanwangmainViewPresentor.lua

module("logic.extensions.origintianmanwang.view.OrigintianmanwangmainViewPresentor", package.seeall)

local OrigintianmanwangmainViewPresentor = class("OrigintianmanwangmainViewPresentor", ViewPresentor)

function OrigintianmanwangmainViewPresentor:ctor()
	OrigintianmanwangmainViewPresentor.super.ctor(self)
end

function OrigintianmanwangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigintianmanwangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/origintianmanwang/origintianmanwangmainview.prefab"
	}
end

function OrigintianmanwangmainViewPresentor:buildViews()
	return {
		OrigintianmanwangmainView.New()
	}
end

return OrigintianmanwangmainViewPresentor
