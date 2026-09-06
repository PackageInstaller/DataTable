-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spriteladder/facade/SpriteLadderFacade.lua

module("logic.extensions.spriteladder.facade.SpriteLadderFacade", package.seeall)

local SpriteLadderFacade = class("SpriteLadderFacade")

function SpriteLadderFacade:ctor()
	return
end

function SpriteLadderFacade:loadPetStairInfo()
	SpriteLadderAgent.instance:sendPM_PetStairGetInfoReq()
end

SpriteLadderFacade.instance = SpriteLadderFacade.New()

return SpriteLadderFacade
