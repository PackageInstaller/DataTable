-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonEvents.lua

module("logicscene.scene.component.season.SceneCompSeasonGridsInfo", package.seeall)

local SceneCompSeasonEvents = class("SceneCompSeasonEvents", SceneComponentBase)
local json = require("cjson")

function SceneCompSeasonEvents:onEnterSceneFinished(sceneId, bornX, bornZ)
	SceneCompSeasonEvents.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function SceneCompSeasonEvents:addEventUnit(evtUnit)
	self._evtUnits = self._evtUnits or {}
	self._evtUnits[evtUnit.row] = self._evtUnits[evtUnit.row] or {}
	self._evtUnits[evtUnit.row][evtUnit.col] = evtUnit
end

function SceneCompSeasonEvents:getEventUnit(row, col)
	if not self._evtUnits or not self._evtUnits[row] then
		return
	end

	return self._evtUnits[row][col]
end

function SceneCompSeasonEvents:getAllEventUnits()
	return self._evtUnits
end

function SceneCompSeasonEvents:onExitScene()
	self._evtUnits = nil
end

return SceneCompSeasonEvents
