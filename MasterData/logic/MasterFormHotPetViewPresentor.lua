-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormHotPetViewPresentor.lua

module("logic.extensions.masterform.view.MasterFormHotPetViewPresentor", package.seeall)

local MasterFormHotPetViewPresentor = class("MasterFormHotPetViewPresentor", ViewPresentor)

function MasterFormHotPetViewPresentor:ctor()
	MasterFormHotPetViewPresentor.super.ctor(self)
end

function MasterFormHotPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MasterFormHotPetViewPresentor:dependWhatResources()
	return {
		"ui/views/masterform/masterformhotpetview.prefab"
	}
end

function MasterFormHotPetViewPresentor:buildViews()
	return {
		MasterFormHotPetView.New()
	}
end

function MasterFormHotPetViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MasterFormHotPetViewPresentor
