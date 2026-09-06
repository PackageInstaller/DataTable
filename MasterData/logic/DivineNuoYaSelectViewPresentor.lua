-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaSelectViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaSelectViewPresentor", package.seeall)

local DivineNuoYaSelectViewPresentor = class("DivineNuoYaSelectViewPresentor", ViewPresentor)

function DivineNuoYaSelectViewPresentor:ctor()
	DivineNuoYaSelectViewPresentor.super.ctor(self)
end

function DivineNuoYaSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyaselectview.prefab"
	}
end

function DivineNuoYaSelectViewPresentor:buildViews()
	return {
		DivineNuoYaSelectView.New()
	}
end

return DivineNuoYaSelectViewPresentor
