-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaTipViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaTipViewPresentor", package.seeall)

local DivineNuoYaTipViewPresentor = class("DivineNuoYaTipViewPresentor", ViewPresentor)

function DivineNuoYaTipViewPresentor:ctor()
	DivineNuoYaTipViewPresentor.super.ctor(self)
end

function DivineNuoYaTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaTipViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyatipview.prefab"
	}
end

function DivineNuoYaTipViewPresentor:buildViews()
	return {
		DivineNuoYaTipView.New()
	}
end

return DivineNuoYaTipViewPresentor
