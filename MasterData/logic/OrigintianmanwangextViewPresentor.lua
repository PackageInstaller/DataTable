-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintianmanwang/view/OrigintianmanwangextViewPresentor.lua

module("logic.extensions.origintianmanwang.view.OrigintianmanwangextViewPresentor", package.seeall)

local OrigintianmanwangextViewPresentor = class("OrigintianmanwangextViewPresentor", ViewPresentor)

function OrigintianmanwangextViewPresentor:ctor()
	OrigintianmanwangextViewPresentor.super.ctor(self)
end

function OrigintianmanwangextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigintianmanwangextViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/origintianmanwang/origintianmanwangextview.prefab"
	}
end

function OrigintianmanwangextViewPresentor:buildViews()
	return {
		OrigintianmanwangextView.New()
	}
end

return OrigintianmanwangextViewPresentor
