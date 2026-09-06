-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetGetPetViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetGetPetViewPresentor", package.seeall)

local CutePetGetPetViewPresentor = class("CutePetGetPetViewPresentor", ViewWithGuidePresentor)

function CutePetGetPetViewPresentor:ctor()
	CutePetGetPetViewPresentor.super.ctor(self)
end

function CutePetGetPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetGetPetViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetgetpetview.prefab"
	}
end

function CutePetGetPetViewPresentor:buildViews()
	return {
		CutePetGetPetView.New()
	}
end

function CutePetGetPetViewPresentor:onClickOutside()
	self:close()
end

return CutePetGetPetViewPresentor
