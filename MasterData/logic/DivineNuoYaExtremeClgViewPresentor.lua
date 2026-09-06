-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaExtremeClgViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaExtremeClgViewPresentor", package.seeall)

local DivineNuoYaExtremeClgViewPresentor = class("DivineNuoYaExtremeClgViewPresentor", ViewPresentor)

function DivineNuoYaExtremeClgViewPresentor:ctor()
	DivineNuoYaExtremeClgViewPresentor.super.ctor(self)
end

function DivineNuoYaExtremeClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaExtremeClgViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyaextremeclgview.prefab"
	}
end

function DivineNuoYaExtremeClgViewPresentor:buildViews()
	return {
		DivineNuoYaExtremeClgView.New()
	}
end

return DivineNuoYaExtremeClgViewPresentor
