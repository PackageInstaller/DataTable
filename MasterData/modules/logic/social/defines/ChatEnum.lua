-- chunkname: @modules/logic/social/defines/ChatEnum.lua

module("modules.logic.social.defines.ChatEnum", package.seeall)

local ChatEnum = _M

ChatEnum.MsgType = {
	RoomSeekShare = 1,
	RoomShareCode = 2
}
ChatEnum.MsgTypeOPLang = {
	[ChatEnum.MsgType.RoomSeekShare] = "room_chatop_seek_share_title",
	[ChatEnum.MsgType.RoomShareCode] = "room_chatop_share_code_title"
}

return ChatEnum
