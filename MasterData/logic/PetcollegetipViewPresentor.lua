-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegetipViewPresentor.lua

module("logic.extensions.petcollege.view.PetcollegetipViewPresentor", package.seeall)

local PetcollegetipViewPresentor = class("PetcollegetipViewPresentor", ViewWithGuidePresentor)

function PetcollegetipViewPresentor:ctor()
	PetcollegetipViewPresentor.super.ctor(self)
end

function PetcollegetipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetcollegetipViewPresentor:dependWhatResources()
	return {
		"ui/views/petcollege/petcollegetip.prefab"
	}
end

function PetcollegetipViewPresentor:buildViews()
	return {
		PetcollegetipView.New()
	}
end

return PetcollegetipViewPresentor
