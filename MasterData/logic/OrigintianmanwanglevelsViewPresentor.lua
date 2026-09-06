-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintianmanwang/view/OrigintianmanwanglevelsViewPresentor.lua

module("logic.extensions.origintianmanwang.view.OrigintianmanwanglevelsViewPresentor", package.seeall)

local OrigintianmanwanglevelsViewPresentor = class("OrigintianmanwanglevelsViewPresentor", ViewPresentor)

function OrigintianmanwanglevelsViewPresentor:ctor()
	OrigintianmanwanglevelsViewPresentor.super.ctor(self)
end

function OrigintianmanwanglevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigintianmanwanglevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/origintianmanwang/origintianmanwanglevelsview.prefab"
	}
end

function OrigintianmanwanglevelsViewPresentor:buildViews()
	return {
		OrigintianmanwanglevelsView.New()
	}
end

return OrigintianmanwanglevelsViewPresentor
