-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetshowrunePresentor.lua

module("logic.extensions.bag.view.stack.PetshowrunePresentor", package.seeall)

local PetshowrunePresentor = class("PetshowrunePresentor", ViewPresentor)

function PetshowrunePresentor:ctor()
	PetshowrunePresentor.super.ctor(self)
end

function PetshowrunePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetshowrunePresentor:dependWhatResources()
	return {
		"ui/views/bag/petshowrune.prefab"
	}
end

function PetshowrunePresentor:buildViews()
	return {
		PetshowruneView.New()
	}
end

return PetshowrunePresentor
