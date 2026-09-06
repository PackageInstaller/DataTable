-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetStarViewNewPresentor.lua

module("logic.extensions.bag.view.stack.PetStarViewNewPresentor", package.seeall)

local PetStarViewNewPresentor = class("PetStarViewNewPresentor", ViewPresentor)

function PetStarViewNewPresentor:ctor()
	PetStarViewNewPresentor.super.ctor(self)
end

function PetStarViewNewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetStarViewNewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petstarview_new.prefab"
	}
end

function PetStarViewNewPresentor:buildViews()
	return {
		PetStarViewNew.New()
	}
end

return PetStarViewNewPresentor
