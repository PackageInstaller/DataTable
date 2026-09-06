-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillbookViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillbookViewPresentor", package.seeall)

local ScriptkillbookViewPresentor = class("ScriptkillbookViewPresentor", ViewPresentor)

function ScriptkillbookViewPresentor:ctor()
	ScriptkillbookViewPresentor.super.ctor(self)
end

function ScriptkillbookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillbookViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillbookview.prefab"
	}
end

function ScriptkillbookViewPresentor:buildViews()
	return {
		ScriptkillbookView.New()
	}
end

return ScriptkillbookViewPresentor
