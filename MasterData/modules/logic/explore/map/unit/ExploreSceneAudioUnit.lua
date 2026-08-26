-- chunkname: @modules/logic/explore/map/unit/ExploreSceneAudioUnit.lua

module("modules.logic.explore.map.unit.ExploreSceneAudioUnit", package.seeall)

local ExploreSceneAudioUnit = class("ExploreSceneAudioUnit", ExploreBaseDisplayUnit)

function ExploreSceneAudioUnit:onInit()
	ExploreSceneAudioUnit.super.onInit(self)
	gohelper.addAkGameObject(self.go)
end

function ExploreSceneAudioUnit:onHeroInitDone()
	ExploreSceneAudioUnit.super.onHeroInitDone(self)

	local audioId = tonumber(self.mo.specialDatas[1])

	ExploreHelper.triggerAudio(audioId, true, self.go, self.id)
end

function ExploreSceneAudioUnit:setInFOV()
	return
end

function ExploreSceneAudioUnit:isInFOV()
	return true
end

function ExploreSceneAudioUnit:onDestroy()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	scene.audio:stopAudioByUnit(self.id)
end

return ExploreSceneAudioUnit
