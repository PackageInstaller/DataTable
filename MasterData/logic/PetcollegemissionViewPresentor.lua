-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegemissionViewPresentor.lua

module("logic.extensions.petcollege.view.PetcollegemissionViewPresentor", package.seeall)

local PetcollegemissionViewPresentor = class("PetcollegemissionViewPresentor", MissionViewPresentor)

function PetcollegemissionViewPresentor:ctor()
	PetcollegemissionViewPresentor.super.ctor(self)
end

function PetcollegemissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetcollegemissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/petcollege/petcollegetechbtn.prefab",
		self:_addCommonRes()
	}
end

function PetcollegemissionViewPresentor:buildViews()
	return {
		PetcollegemissionView.New(),
		PetCollegeFmtRightView.New(),
		PetCollegeFmtLeftView.New(),
		PetCollegeMissionFmtView.New()
	}
end

return PetcollegemissionViewPresentor
