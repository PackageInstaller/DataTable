-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpAllPetViewPresentor.lua

module("logic.extensions.expedition.view.ExpAllPetViewPresentor", package.seeall)

local ExpAllPetViewPresentor = class("ExpAllPetViewPresentor", ViewPresentor)

function ExpAllPetViewPresentor:ctor()
	ExpAllPetViewPresentor.super.ctor(self)
end

function ExpAllPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpAllPetViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/allpetview.prefab"
	}
end

function ExpAllPetViewPresentor:buildViews()
	return {
		ExpAllPetView.New()
	}
end

return ExpAllPetViewPresentor
