-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveEnterViewPresentor.lua

module("logic.extensions.divineevolve.view.DivineEvolveEnterViewPresentor", package.seeall)

local DivineEvolveEnterViewPresentor = class("DivineEvolveEnterViewPresentor", ViewPresentor)

function DivineEvolveEnterViewPresentor:ctor()
	DivineEvolveEnterViewPresentor.super.ctor(self)
end

function DivineEvolveEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolveEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolve/divineevolveenterview.prefab"
	}
end

function DivineEvolveEnterViewPresentor:buildViews()
	return {
		DivineEvolveEnterView.New()
	}
end

return DivineEvolveEnterViewPresentor
