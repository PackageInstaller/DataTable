-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillrankViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillrankViewPresentor", package.seeall)

local ScriptkillrankViewPresentor = class("ScriptkillrankViewPresentor", ViewPresentor)

function ScriptkillrankViewPresentor:ctor()
	ScriptkillrankViewPresentor.super.ctor(self)
end

function ScriptkillrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillrankViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillrankview.prefab"
	}
end

function ScriptkillrankViewPresentor:buildViews()
	return {
		ScriptkillrankView.New()
	}
end

return ScriptkillrankViewPresentor
