-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillguessViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillguessViewPresentor", package.seeall)

local ScriptkillguessViewPresentor = class("ScriptkillguessViewPresentor", ViewPresentor)

function ScriptkillguessViewPresentor:ctor()
	ScriptkillguessViewPresentor.super.ctor(self)
end

function ScriptkillguessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillguessViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillguessview.prefab"
	}
end

function ScriptkillguessViewPresentor:buildViews()
	return {
		ScriptkillguessView.New()
	}
end

return ScriptkillguessViewPresentor
