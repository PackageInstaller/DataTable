-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillmainViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillmainViewPresentor", package.seeall)

local ScriptkillmainViewPresentor = class("ScriptkillmainViewPresentor", ViewPresentor)

function ScriptkillmainViewPresentor:ctor()
	ScriptkillmainViewPresentor.super.ctor(self)
end

function ScriptkillmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillmainViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillmainview.prefab"
	}
end

function ScriptkillmainViewPresentor:buildViews()
	return {
		ScriptkillmainView.New()
	}
end

return ScriptkillmainViewPresentor
