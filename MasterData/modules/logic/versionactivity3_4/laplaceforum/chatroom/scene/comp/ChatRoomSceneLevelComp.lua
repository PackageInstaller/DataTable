-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/scene/comp/ChatRoomSceneLevelComp.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.scene.comp.ChatRoomSceneLevelComp", package.seeall)

local ChatRoomSceneLevelComp = class("ChatRoomSceneLevelComp", PartyGameLobbySceneLevelComp)

function ChatRoomSceneLevelComp:loadLevel(levelId)
	self._levelId = levelId

	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = "modules/party_game/scene/game_home/prefabs/party_game_home_p.prefab"

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

return ChatRoomSceneLevelComp
