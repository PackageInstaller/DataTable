-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillprizeViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillprizeViewPresentor", package.seeall)

local ScriptkillprizeViewPresentor = class("ScriptkillprizeViewPresentor", ViewPresentor)

function ScriptkillprizeViewPresentor:ctor()
	ScriptkillprizeViewPresentor.super.ctor(self)
end

function ScriptkillprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillprizeview.prefab"
	}
end

function ScriptkillprizeViewPresentor:buildViews()
	return {
		ScriptkillprizeView.New()
	}
end

return ScriptkillprizeViewPresentor
