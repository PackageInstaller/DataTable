-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcv/view/PetcvPresentor.lua

module("logic.extensions.petcv.view.PetcvPresentor", package.seeall)

local PetcvPresentor = class("PetcvPresentor", ViewPresentor)

function PetcvPresentor:ctor()
	PetcvPresentor.super.ctor(self)
end

function PetcvPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetcvPresentor:dependWhatResources()
	return {
		"ui/views/petcv/petcvview.prefab"
	}
end

function PetcvPresentor:buildViews()
	return {
		PetcvView.New()
	}
end

return PetcvPresentor
