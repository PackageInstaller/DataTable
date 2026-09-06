-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillseachViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillseachViewPresentor", package.seeall)

local ScriptkillseachViewPresentor = class("ScriptkillseachViewPresentor", ViewPresentor)

function ScriptkillseachViewPresentor:ctor()
	ScriptkillseachViewPresentor.super.ctor(self)
end

function ScriptkillseachViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillseachViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillseachview.prefab"
	}
end

function ScriptkillseachViewPresentor:buildViews()
	return {
		ScriptkillseachView.New()
	}
end

return ScriptkillseachViewPresentor
