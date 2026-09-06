-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveHandbookViewPresentor.lua

module("logic.extensions.divineevolve.view.DivineEvolveHandbookViewPresentor", package.seeall)

local DivineEvolveHandbookViewPresentor = class("DivineEvolveHandbookViewPresentor", ViewPresentor)

function DivineEvolveHandbookViewPresentor:ctor()
	DivineEvolveHandbookViewPresentor.super.ctor(self)
end

function DivineEvolveHandbookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolveHandbookViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolve/divineevolvehandbookview.prefab"
	}
end

function DivineEvolveHandbookViewPresentor:buildViews()
	return {
		DivineEvolveHandbookView.New()
	}
end

return DivineEvolveHandbookViewPresentor
