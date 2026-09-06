-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnMainViewPresentor.lua

module("logic.extensions.divinean.view.DivineAnMainViewPresentor", package.seeall)

local DivineAnMainViewPresentor = class("DivineAnMainViewPresentor", ViewPresentor)

function DivineAnMainViewPresentor:ctor()
	DivineAnMainViewPresentor.super.ctor(self)
end

function DivineAnMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAnMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinean/divineanmainview.prefab"
	}
end

function DivineAnMainViewPresentor:buildViews()
	return {
		DivineAnMainView.New()
	}
end

return DivineAnMainViewPresentor
