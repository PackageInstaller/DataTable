-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetCommentViewPresentor.lua

module("logic.extensions.equipment.view.PetCommentViewPresentor", package.seeall)

local PetCommentViewPresentor = class("PetCommentViewPresentor", ViewWithGuidePresentor)

function PetCommentViewPresentor:ctor()
	PetCommentViewPresentor.super.ctor(self)
end

function PetCommentViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetCommentViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petcommentview.prefab"
	}
end

function PetCommentViewPresentor:buildViews()
	return {
		PetCommentView.New()
	}
end

return PetCommentViewPresentor
