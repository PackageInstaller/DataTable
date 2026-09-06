-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaResultViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaResultViewPresentor", package.seeall)

local DivineNuoYaResultViewPresentor = class("DivineNuoYaResultViewPresentor", ViewPresentor)

function DivineNuoYaResultViewPresentor:ctor()
	DivineNuoYaResultViewPresentor.super.ctor(self)
end

function DivineNuoYaResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyaresultview.prefab"
	}
end

function DivineNuoYaResultViewPresentor:buildViews()
	return {
		DivineNuoYaResultView.New()
	}
end

return DivineNuoYaResultViewPresentor
