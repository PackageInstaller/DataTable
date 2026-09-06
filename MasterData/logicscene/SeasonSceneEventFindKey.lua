-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventFindKey.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventFindKey", package.seeall)

local SeasonSceneEventFindKey = class("SeasonSceneEventFindKey", SeasonSceneEventImplBase)

function SeasonSceneEventFindKey:_getCurStatus()
	local seasonId = SeasonModel.instance:getSeasonId()
	local keyCfg = SeasonConfig.instance:getMapEvtDetail(seasonId, self.evtData.eventType, self.evtData.eventId)

	return (SeasonModel.instance:isOccupied(self.evtData.id) or nil) and (keyCfg.isKey == true and 4 or 2)
end

return SeasonSceneEventFindKey
