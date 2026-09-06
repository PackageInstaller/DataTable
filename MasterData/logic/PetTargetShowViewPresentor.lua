-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PetTargetShowViewPresentor.lua

module("logic.extensions.powerland.view.PetTargetShowViewPresentor", package.seeall)

local PetTargetShowViewPresentor = class("PetTargetShowViewPresentor", ViewPresentor)

function PetTargetShowViewPresentor:ctor()
	PetTargetShowViewPresentor.super.ctor(self)
end

function PetTargetShowViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetTargetShowViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/pettargetshowview.prefab"
	}
end

function PetTargetShowViewPresentor:buildViews()
	return {
		PetTargetShowView.New()
	}
end

return PetTargetShowViewPresentor
