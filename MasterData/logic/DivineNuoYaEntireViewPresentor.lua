-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaEntireViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaEntireViewPresentor", package.seeall)

local DivineNuoYaEntireViewPresentor = class("DivineNuoYaEntireViewPresentor", ViewPresentor)

function DivineNuoYaEntireViewPresentor:ctor()
	DivineNuoYaEntireViewPresentor.super.ctor(self)
end

function DivineNuoYaEntireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaEntireViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyaentireview.prefab"
	}
end

function DivineNuoYaEntireViewPresentor:buildViews()
	return {
		DivineNuoYaEntireView.New()
	}
end

return DivineNuoYaEntireViewPresentor
