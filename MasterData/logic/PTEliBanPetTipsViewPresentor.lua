-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliBanPetTipsViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliBanPetTipsViewPresentor", package.seeall)

local PTEliBanPetTipsViewPresentor = class("PTEliBanPetTipsViewPresentor", ViewPresentor)

function PTEliBanPetTipsViewPresentor:ctor()
	PTEliBanPetTipsViewPresentor.super.ctor(self)
end

function PTEliBanPetTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTEliBanPetTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelibanpettipsview.prefab"
	}
end

function PTEliBanPetTipsViewPresentor:buildViews()
	return {
		PTEliBanPetTipsView.New()
	}
end

return PTEliBanPetTipsViewPresentor
