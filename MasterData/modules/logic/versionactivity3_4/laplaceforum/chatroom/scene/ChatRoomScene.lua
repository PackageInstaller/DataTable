-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/scene/ChatRoomScene.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.scene.ChatRoomScene", package.seeall)

local ChatRoomScene = class("ChatRoomScene", BaseScene)

function ChatRoomScene:_createAllComps()
	self:_addComp("director", ChatRoomSceneDirector)
	self:_addComp("level", ChatRoomSceneLevelComp)
	self:_addComp("view", ChatRoomSceneViewComp)
	self:_addComp("camera", ChatRoomSceneCameraComp)
	self:_addComp("graphics", PartyGameLobbySceneGraphicsComp)
end

return ChatRoomScene
