-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetStarViewPresentor.lua

module("logic.extensions.bag.view.stack.PetStarViewPresentor", package.seeall)

local PetStarViewPresentor = class("PetStarViewPresentor", ViewWithGuidePresentor)

function PetStarViewPresentor:ctor()
	PetStarViewPresentor.super.ctor(self)
end

function PetStarViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetStarViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petstarview.prefab"
	}
end

function PetStarViewPresentor:buildViews()
	return {
		PetStarView.New()
	}
end

return PetStarViewPresentor
