-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillpopupViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillpopupViewPresentor", package.seeall)

local ScriptkillpopupViewPresentor = class("ScriptkillpopupViewPresentor", ViewPresentor)

function ScriptkillpopupViewPresentor:ctor()
	ScriptkillpopupViewPresentor.super.ctor(self)
end

function ScriptkillpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillpopupview.prefab"
	}
end

function ScriptkillpopupViewPresentor:buildViews()
	return {
		ScriptkillpopupView.New()
	}
end

return ScriptkillpopupViewPresentor
