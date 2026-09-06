-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveMainViewPresentor.lua

module("logic.extensions.divineevolve.view.DivineEvolveMainViewPresentor", package.seeall)

local DivineEvolveMainViewPresentor = class("DivineEvolveMainViewPresentor", ViewPresentor)

function DivineEvolveMainViewPresentor:ctor()
	DivineEvolveMainViewPresentor.super.ctor(self)
end

function DivineEvolveMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolveMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolve/divineevolvemainview.prefab"
	}
end

function DivineEvolveMainViewPresentor:buildViews()
	return {
		DivineEvolveMainView.New()
	}
end

return DivineEvolveMainViewPresentor
