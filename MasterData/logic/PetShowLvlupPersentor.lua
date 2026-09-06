-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowLvlupPersentor.lua

module("logic.extensions.bag.panel.stack.PetShowLvlupPersentor", package.seeall)

local PetShowLvlupPersentor = class("PetShowLvlupPersentor", ViewPresentor)

function PetShowLvlupPersentor:ctor()
	PetShowLvlupPersentor.super.ctor(self)
end

function PetShowLvlupPersentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetShowLvlupPersentor:dependWhatResources()
	return {
		"ui/views/bag/petshowlvlup.prefab"
	}
end

function PetShowLvlupPersentor:buildViews()
	return {
		PetShowLvlupStack.New()
	}
end

return PetShowLvlupPersentor
