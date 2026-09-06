-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillresultViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillresultViewPresentor", package.seeall)

local ScriptkillresultViewPresentor = class("ScriptkillresultViewPresentor", ViewPresentor)

function ScriptkillresultViewPresentor:ctor()
	ScriptkillresultViewPresentor.super.ctor(self)
end

function ScriptkillresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillresultViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillresultview.prefab"
	}
end

function ScriptkillresultViewPresentor:buildViews()
	return {
		ScriptkillresultView.New()
	}
end

return ScriptkillresultViewPresentor
