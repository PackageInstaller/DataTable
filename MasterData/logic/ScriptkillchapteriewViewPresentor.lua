-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillchapteriewViewPresentor.lua

module("logic.extensions.scriptkill.view.ScriptkillchapteriewViewPresentor", package.seeall)

local ScriptkillchapteriewViewPresentor = class("ScriptkillchapteriewViewPresentor", ViewPresentor)

function ScriptkillchapteriewViewPresentor:ctor()
	ScriptkillchapteriewViewPresentor.super.ctor(self)
end

function ScriptkillchapteriewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScriptkillchapteriewViewPresentor:dependWhatResources()
	return {
		"ui/views/scriptkill/scriptkillchapteriew.prefab"
	}
end

function ScriptkillchapteriewViewPresentor:buildViews()
	return {
		ScriptkillchapteriewView.New()
	}
end

return ScriptkillchapteriewViewPresentor
