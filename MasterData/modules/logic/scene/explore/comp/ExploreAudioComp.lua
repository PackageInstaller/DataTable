-- chunkname: @modules/logic/scene/explore/comp/ExploreAudioComp.lua

module("modules.logic.scene.explore.comp.ExploreAudioComp", package.seeall)

local ExploreAudioComp = class("ExploreAudioComp", BaseSceneComp)

function ExploreAudioComp:onSceneStart(sceneId, levelId)
	self.audioManagerGo = gohelper.find("AudioManager")
	self.focusGo = CameraMgr.instance:getFocusTrs().gameObject

	gohelper.enableAkListener(self.audioManagerGo, false)
	gohelper.enableAkListener(self.focusGo, true)

	self._allLoopAudioIds = {}
end

function ExploreAudioComp:onTriggerAudio(unitId, playingId)
	self._allLoopAudioIds[unitId] = self._allLoopAudioIds[unitId] or {}
	self._allLoopAudioIds[unitId][playingId] = true
end

function ExploreAudioComp:stopAudioByUnit(unitId)
	if not self._allLoopAudioIds[unitId] then
		return
	end

	for playingId in pairs(self._allLoopAudioIds[unitId]) do
		AudioMgr.instance:stopPlayingID(playingId)
	end

	self._allLoopAudioIds[unitId] = nil
end

function ExploreAudioComp:onSceneClose()
	for unitId in pairs(self._allLoopAudioIds) do
		self:stopAudioByUnit(unitId)
	end

	self._allLoopAudioIds = {}

	gohelper.enableAkListener(self.audioManagerGo, true)
	gohelper.enableAkListener(self.focusGo, false)

	self.audioManagerGo = nil
	self.focusGo = nil
end

return ExploreAudioComp
