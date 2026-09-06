-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillreplayViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillreplayViewPresentor", package.seeall)

local ScriptkillreplayViewPresentor = class("ScriptkillreplayViewPresentor", ViewPresentor)

function ScriptkillreplayViewPresentor:ctor()
	ScriptkillreplayViewPresentor.super.ctor(self)
end

function ScriptkillreplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillreplayViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillreplayview.prefab"
	}
end

function ScriptkillreplayViewPresentor:buildViews()
	return {
		ScriptkillreplayView.New()
	}
end

return ScriptkillreplayViewPresentor
