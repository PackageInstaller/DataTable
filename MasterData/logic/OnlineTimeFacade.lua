-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/facade/OnlineTimeFacade.lua

module("logic.extensions.onlinetime.facade.OnlineTimeFacade", package.seeall)

local OnlineTimeFacade = class("OnlineTimeFacade", BaseFacade)

function OnlineTimeFacade:initHud(go)
	OnlineTimeController.instance:initHud(go)
end

function OnlineTimeFacade:sendGetInfo()
	OnlineTimeController.instance:sendGetInfo()
end

OnlineTimeFacade.instance = OnlineTimeFacade.New()

return OnlineTimeFacade
