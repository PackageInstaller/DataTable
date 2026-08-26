-- chunkname: @modules/logic/partygamelobby/scene/comp/PartyGameLobbySceneLevelComp.lua

module("modules.logic.partygamelobby.scene.comp.PartyGameLobbySceneLevelComp", package.seeall)

local PartyGameLobbySceneLevelComp = class("PartyGameLobbySceneLevelComp", CommonSceneLevelComp)

function PartyGameLobbySceneLevelComp:getSceneLevelUrl()
	return PartyGameLobbyEnum.SceneUrl[self._levelId]
end

function PartyGameLobbySceneLevelComp:_onLoadCallback(assetItem)
	PartyGameLobbySceneLevelComp.super._onLoadCallback(self, assetItem)
end

return PartyGameLobbySceneLevelComp
