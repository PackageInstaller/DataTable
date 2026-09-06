-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkilllistViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkilllistViewPresentor", package.seeall)

local ScriptkilllistViewPresentor = class("ScriptkilllistViewPresentor", ViewPresentor)

function ScriptkilllistViewPresentor:ctor()
	ScriptkilllistViewPresentor.super.ctor(self)
end

function ScriptkilllistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkilllistViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkilllistview.prefab"
	}
end

function ScriptkilllistViewPresentor:buildViews()
	return {
		ScriptkilllistView.New()
	}
end

return ScriptkilllistViewPresentor
