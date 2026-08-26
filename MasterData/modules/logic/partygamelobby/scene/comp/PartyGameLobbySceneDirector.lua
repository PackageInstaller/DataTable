-- chunkname: @modules/logic/partygamelobby/scene/comp/PartyGameLobbySceneDirector.lua

module("modules.logic.partygamelobby.scene.comp.PartyGameLobbySceneDirector", package.seeall)

local PartyGameLobbySceneDirector = class("PartyGameLobbySceneDirector", BaseSceneComp)

function PartyGameLobbySceneDirector:onInit()
	self._scene = self:getCurScene()
	self.animSuccess = false
	self.switchSuccess = false
end

function PartyGameLobbySceneDirector:_onLevelLoaded()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	self._scene:onPrepared()
end

function PartyGameLobbySceneDirector:onSceneStart(sceneId, levelId)
	self._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function PartyGameLobbySceneDirector:onScenePrepared(sceneId, levelId)
	return
end

function PartyGameLobbySceneDirector:onSceneClose()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

return PartyGameLobbySceneDirector
