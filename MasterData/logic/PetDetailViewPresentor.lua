-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/PetDetailViewPresentor.lua

module("logic.extensions.share.view.PetDetailViewPresentor", package.seeall)

local PetDetailViewPresentor = class("PetDetailViewPresentor", ViewPresentor)

function PetDetailViewPresentor:ctor()
	PetDetailViewPresentor.super.ctor(self)
end

function PetDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/share/petdetailview.prefab",
		PetCell.ResPath,
		ItemAttr.ResPath
	}
end

function PetDetailViewPresentor:buildViews()
	return {
		PetDetailView.New()
	}
end

return PetDetailViewPresentor
