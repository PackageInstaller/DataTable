-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/facade/WeekRewardFacade.lua

module("logic.extensions.weekreward.facade.WeekRewardFacade", package.seeall)

local WeekRewardFacade = class("WeekRewardFacade")

function WeekRewardFacade:enterSignIn()
	WeekRewardAgent.instance:sendSignInInfoReq()
end

WeekRewardFacade.instance = WeekRewardFacade.New()

return WeekRewardFacade
