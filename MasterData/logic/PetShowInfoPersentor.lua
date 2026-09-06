-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowInfoPersentor.lua

module("logic.extensions.bag.panel.stack.PetShowInfoPersentor", package.seeall)

local PetShowInfoPersentor = class("PetShowInfoPersentor", ViewPresentor)

function PetShowInfoPersentor:ctor()
	PetShowInfoPersentor.super.ctor(self)
end

function PetShowInfoPersentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetShowInfoPersentor:dependWhatResources()
	return {
		"ui/views/bag/petshowinfo.prefab"
	}
end

function PetShowInfoPersentor:buildViews()
	return {
		PetShowInfoStack.New()
	}
end

return PetShowInfoPersentor
