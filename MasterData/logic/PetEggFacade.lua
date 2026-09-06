-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petegg/facade/PetEggFacade.lua

module("logic.extensions.petegg.facade.PetEggFacade", package.seeall)

local PetEggFacade = class("PetEggFacade", BaseFacade)

function PetEggFacade:enterPetEgg()
	if not PetEggModel.instance:isDataInited() then
		PetEggAgent.instance:sendGetUserHatchInfosReq()
	end
end

PetEggFacade.instance = PetEggFacade.New()

return PetEggFacade
