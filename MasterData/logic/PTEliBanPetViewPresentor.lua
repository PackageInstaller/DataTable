-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliBanPetViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliBanPetViewPresentor", package.seeall)

local PTEliBanPetViewPresentor = class("PTEliBanPetViewPresentor", ViewPresentor)

function PTEliBanPetViewPresentor:ctor()
	PTEliBanPetViewPresentor.super.ctor(self)
end

function PTEliBanPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTEliBanPetViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelibanpetview.prefab"
	}
end

function PTEliBanPetViewPresentor:buildViews()
	return {
		PTEliBanPetView.New()
	}
end

return PTEliBanPetViewPresentor
