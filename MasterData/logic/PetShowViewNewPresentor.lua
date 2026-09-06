-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetShowViewNewPresentor.lua

module("logic.extensions.bag.view.PetShowViewNewPresentor", package.seeall)

local PetShowViewNewPresentor = class("PetShowViewNewPresentor", ViewWithGuidePresentor)

function PetShowViewNewPresentor:ctor()
	PetShowViewNewPresentor.super.ctor(self)
end

function PetShowViewNewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetShowViewNewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petshowview_new.prefab"
	}
end

function PetShowViewNewPresentor:buildViews()
	return {
		PetShowViewNew.New()
	}
end

return PetShowViewNewPresentor
