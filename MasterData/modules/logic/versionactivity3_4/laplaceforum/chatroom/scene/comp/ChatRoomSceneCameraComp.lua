-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/scene/comp/ChatRoomSceneCameraComp.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.scene.comp.ChatRoomSceneCameraComp", package.seeall)

local ChatRoomSceneCameraComp = class("ChatRoomSceneCameraComp", PartyGameLobbySceneCameraComp)

function ChatRoomSceneCameraComp:getCameraFocus()
	local intPos = ChatRoomEnum.InitPos

	return intPos.x or 0, intPos.y or 0, intPos.z or 0
end

function ChatRoomSceneCameraComp:_initCurSceneCameraTrace()
	self._cameraConfigId = 24
	self._cameraCO = lua_camera.configDict[self._cameraConfigId]

	self:resetParam()
	self:setFocus(self:getCameraFocus())
	self:applyDirectly()
end

return ChatRoomSceneCameraComp
