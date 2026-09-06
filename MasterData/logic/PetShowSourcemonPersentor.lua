-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowSourcemonPersentor.lua

module("logic.extensions.bag.panel.stack.PetShowSourcemonPersentor", package.seeall)

local PetShowSourcemonPersentor = class("PetShowSourcemonPersentor", ViewPresentor)

function PetShowSourcemonPersentor:ctor()
	PetShowSourcemonPersentor.super.ctor(self)
end

function PetShowSourcemonPersentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetShowSourcemonPersentor:dependWhatResources()
	return {
		"ui/views/bag/petshowsourcemon.prefab"
	}
end

function PetShowSourcemonPersentor:buildViews()
	return {
		PetShowSourcemonStack.New()
	}
end

return PetShowSourcemonPersentor
