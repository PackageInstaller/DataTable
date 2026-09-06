-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetFilesViewPresentor.lua

module("logic.extensions.handbook.view.PetFilesViewPresentor", package.seeall)

local PetFilesViewPresentor = class("PetFilesViewPresentor", ViewPresentor)

function PetFilesViewPresentor:ctor()
	PetFilesViewPresentor.super.ctor(self)
end

function PetFilesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetFilesViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petfilesview.prefab"
	}
end

function PetFilesViewPresentor:buildViews()
	return {
		PetFilesView.New()
	}
end

return PetFilesViewPresentor
