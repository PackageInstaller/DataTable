-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventDanceLion.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventDanceLion", package.seeall)

local SeasonSceneEventDanceLion = class("SeasonSceneEventDanceLion", SeasonSceneEventImplBase)

function SeasonSceneEventDanceLion:_getCurStatus()
	local mapMo = SeasonModel.instance:getMapInfoById(self.evtData.id)

	return (mapMo or nil) and mapMo:getRotateDir()
end

return SeasonSceneEventDanceLion
