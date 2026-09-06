-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaExtremeViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaExtremeViewPresentor", package.seeall)

local DivineNuoYaExtremeViewPresentor = class("DivineNuoYaExtremeViewPresentor", ViewPresentor)

function DivineNuoYaExtremeViewPresentor:ctor()
	DivineNuoYaExtremeViewPresentor.super.ctor(self)
end

function DivineNuoYaExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyaextremeview.prefab"
	}
end

function DivineNuoYaExtremeViewPresentor:buildViews()
	return {
		DivineNuoYaExtremeView.New()
	}
end

return DivineNuoYaExtremeViewPresentor
