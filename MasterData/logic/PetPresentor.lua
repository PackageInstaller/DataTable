-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetPresentor.lua

module("logic.extensions.bag.panel.PetPresentor", package.seeall)

local PetPresentor = class("PetPresentor", ViewWithGuidePresentor)

function PetPresentor:ctor()
	PetPresentor.super.ctor(self)
end

function PetPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetPresentor:dependWhatResources()
	return {
		"ui/views/bag/petview.prefab"
	}
end

function PetPresentor:buildViews()
	return {
		PetView.New()
	}
end

return PetPresentor
