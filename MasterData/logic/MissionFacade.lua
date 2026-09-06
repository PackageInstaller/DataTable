-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/facade/MissionFacade.lua

module("logic.extensions.mission.facade.MissionFacade", package.seeall)

local MissionFacade = class("MissionFacade", BaseFacade)

function MissionFacade:showMissionView()
	return
end

function MissionFacade:notEnoughPower(mul)
	return MissionModel.instance:notEnoughPower(mul)
end

function MissionFacade:setBattleConditionId(id)
	MissionModel.instance:setBattleConditionId(id)
end

function MissionFacade:getBattleConditionId()
	return MissionModel.instance:getBattleConditionId()
end

MissionFacade.instance = MissionFacade.New()

return MissionFacade
