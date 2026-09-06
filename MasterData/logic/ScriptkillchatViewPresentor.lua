-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillchatViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillchatViewPresentor", package.seeall)

local ScriptkillchatViewPresentor = class("ScriptkillchatViewPresentor", ViewPresentor)

function ScriptkillchatViewPresentor:ctor()
	ScriptkillchatViewPresentor.super.ctor(self)
end

function ScriptkillchatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillchatViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillchatview.prefab"
	}
end

function ScriptkillchatViewPresentor:buildViews()
	return {
		ScriptkillchatView.New()
	}
end

return ScriptkillchatViewPresentor
