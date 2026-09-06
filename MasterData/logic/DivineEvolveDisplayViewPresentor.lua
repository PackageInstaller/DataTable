-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveDisplayViewPresentor.lua

module("logic.extensions.divineevolve.view.DivineEvolveDisplayViewPresentor", package.seeall)

local DivineEvolveDisplayViewPresentor = class("DivineEvolveDisplayViewPresentor", ViewPresentor)

function DivineEvolveDisplayViewPresentor:ctor()
	DivineEvolveDisplayViewPresentor.super.ctor(self)
end

function DivineEvolveDisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolveDisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolve/divineevolvedisplayview.prefab"
	}
end

function DivineEvolveDisplayViewPresentor:buildViews()
	return {
		DivineEvolveDisplayView.New()
	}
end

return DivineEvolveDisplayViewPresentor
