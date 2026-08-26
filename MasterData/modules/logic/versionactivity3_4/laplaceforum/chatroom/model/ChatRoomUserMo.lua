-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/model/ChatRoomUserMo.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.model.ChatRoomUserMo", package.seeall)

local ChatRoomUserMo = class("ChatRoomUserMo", ChatRoomUserMo)

function ChatRoomUserMo:ctor(params)
	self.wearClothIdMap = {}
end

function ChatRoomUserMo:updateUserInfo(info)
	self.userId = info.userId
	self.name = info.name
	self.titleId = info.title
	self.posX = info.x / 1000
	self.posY = info.y / 1000

	self:updateWearClothIds(info.wearClothIds)
end

function ChatRoomUserMo:updateWearClothIds(wearClothIds)
	for _, clothId in ipairs(wearClothIds) do
		local config = PartyClothConfig.instance:getClothConfig(clothId)

		if config then
			self.wearClothIdMap[config.partId] = clothId
		end
	end

	if next(self.wearClothIdMap) == nil then
		self.wearClothIdMap = PartyClothConfig.instance:getInitClothIdMap()
	end
end

function ChatRoomUserMo:getWearClothIdMap()
	return self.wearClothIdMap
end

function ChatRoomUserMo:getTitleName()
	local titleCo = TitleAppointmentConfig.instance:getTitleCo(self.titleId)

	return (titleCo or nil) and (titleCo.titleName or "")
end

return ChatRoomUserMo
