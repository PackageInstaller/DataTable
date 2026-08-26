-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/scene/comp/ChatRoomSceneViewComp.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.scene.comp.ChatRoomSceneViewComp", package.seeall)

local ChatRoomSceneViewComp = class("ChatRoomSceneViewComp", PartyGameLobbySceneViewComp)

function ChatRoomSceneViewComp:onScenePrepared(sceneId, levelId)
	ViewMgr.instance:openView(ViewName.ChatRoomMainView)
end

function ChatRoomSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.ChatRoomMainView)
end

return ChatRoomSceneViewComp
