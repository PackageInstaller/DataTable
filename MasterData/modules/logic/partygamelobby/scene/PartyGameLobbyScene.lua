-- chunkname: @modules/logic/partygamelobby/scene/PartyGameLobbyScene.lua

module("modules.logic.partygamelobby.scene.PartyGameLobbyScene", package.seeall)

local PartyGameLobbyScene = class("PartyGameLobbyScene", BaseScene)

function PartyGameLobbyScene:_createAllComps()
	self:_addComp("director", PartyGameLobbySceneDirector)
	self:_addComp("level", PartyGameLobbySceneLevelComp)
	self:_addComp("view", PartyGameLobbySceneViewComp)
	self:_addComp("camera", PartyGameLobbySceneCameraComp)
	self:_addComp("graphics", PartyGameLobbySceneGraphicsComp)
end

return PartyGameLobbyScene
