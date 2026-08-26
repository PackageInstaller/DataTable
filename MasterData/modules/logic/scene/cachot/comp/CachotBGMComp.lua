-- chunkname: @modules/logic/scene/cachot/comp/CachotBGMComp.lua

module("modules.logic.scene.cachot.comp.CachotBGMComp", package.seeall)

local CachotBGMComp = class("CachotBGMComp", BaseSceneComp)

function CachotBGMComp:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._levelComp = self._scene.level

	self._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self.onLevelLoaded, self)
end

function CachotBGMComp:onLevelLoaded()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local bgmId = V1a6_CachotEventConfig.instance:getBgmIdByLayer((rogueInfo or nil) and rogueInfo.layer)

	if bgmId then
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, bgmId)
	end
end

function CachotBGMComp:onSceneClose()
	self._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self.onLevelLoaded, self)
end

return CachotBGMComp
