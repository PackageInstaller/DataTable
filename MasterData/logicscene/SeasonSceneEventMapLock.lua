-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventMapLock.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventMapLock", package.seeall)

local SeasonSceneEventMapLock = class("SeasonSceneEventMapLock", SeasonSceneEventImplBase)

function SeasonSceneEventMapLock:_getCurStatus()
	local isOccupied = SeasonModel.instance:isOccupied(self.evtData.id)

	return (not isOccupied or nil) and 1
end

return SeasonSceneEventMapLock
