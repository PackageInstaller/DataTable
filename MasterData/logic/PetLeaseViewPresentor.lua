-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petlease/view/PetLeaseViewPresentor.lua

module("logic.extensions.petlease.view.PetLeaseViewPresentor", package.seeall)

local PetLeaseViewPresentor = class("PetLeaseViewPresentor", ViewPresentor)

function PetLeaseViewPresentor:ctor()
	PetLeaseViewPresentor.super.ctor(self)
end

function PetLeaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetLeaseViewPresentor:dependWhatResources()
	return {
		"ui/views/petlease/petleaseview.prefab"
	}
end

function PetLeaseViewPresentor:buildViews()
	return {
		PetLeaseView.New()
	}
end

return PetLeaseViewPresentor
