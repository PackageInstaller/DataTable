-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petdisplay/facade/PetDisplayFacade.lua

module("logic.extensions.petdisplay.facade.PetDisplayFacade", package.seeall)

local PetDisplayFacade = class("PetDisplayFacade", BaseFacade)

PetDisplayFacade.instance = PetDisplayFacade.New()

return PetDisplayFacade
