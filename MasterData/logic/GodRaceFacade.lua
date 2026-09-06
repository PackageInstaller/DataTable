-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godrace/facade/GodRaceFacade.lua

module("logic.extensions.godrace.facade.GodRaceFacade", package.seeall)

local GodRaceFacade = class("GodRaceFacade", BaseFacade)

function GodRaceFacade:loadInfo()
	GodRaceAgent.instance:sendPM_GodRaceTypeGetInfoReq()
end

GodRaceFacade.instance = GodRaceFacade.New()

return GodRaceFacade
