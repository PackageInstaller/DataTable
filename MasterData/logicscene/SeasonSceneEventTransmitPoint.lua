-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventTransmitPoint.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventTransmitPoint", package.seeall)

local SeasonSceneEventTransmitPoint = class("SeasonSceneEventTransmitPoint", SeasonSceneEventImplBase)

function SeasonSceneEventTransmitPoint:_getCurStatus()
	local curStatus = 2

	if self._prepareTranspointAnim then
		curStatus = -1
	else
		local mapData = SeasonModel.instance:getMapInfoById(self.evtData.id)

		if not mapData or not mapData:isInitServerData() or mapData:isLock() then
			curStatus = 1
		end
	end

	return curStatus
end

function SeasonSceneEventTransmitPoint:setPrepareTranspointAnim(prepared)
	self._prepareTranspointAnim = prepared

	self:updateEvtStatus()
end

return SeasonSceneEventTransmitPoint
