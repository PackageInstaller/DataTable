-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/define/ChatRoomEnum.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.define.ChatRoomEnum", package.seeall)

local ChatRoomEnum = _M

ChatRoomEnum.NpcInfoCompPosY = 5
ChatRoomEnum.InitPos = Vector3(-25, 1.67, -17)
ChatRoomEnum.DefaultSuitConstId = 1
ChatRoomEnum.NpcRemoveTime = 0.3
ChatRoomEnum.ConstId = {
	InteractiveRange = 18,
	RoleMoveRange = 2,
	EasterEggNpcBornRate = 9,
	LuckyRainMaxCount = 3,
	LuckyRainBatchCount = 8,
	QAndANpcPos = 11,
	LuckyRainDelayTime = 4,
	FingerGuessNpcPos = 10,
	ChatRoomRoleNum = 1,
	EasterEggNpcPos = 12,
	SendEmojiCD = 14,
	ShowChatTime = 15,
	LuckyRainLastTime = 5,
	CreatePlayerRange = 17,
	LuckyRainDropTime = 6,
	LuckyRainInterverTime = 7,
	SendMoveRequestRate = 13
}
ChatRoomEnum.NpcType = {
	Player = 4,
	FingerGame = 2,
	EasterEgg = 3,
	QAndA = 1
}
ChatRoomEnum.CardType = {
	Rock = 1,
	Scissors = 2,
	Paper = 3
}
ChatRoomEnum.GameResultType = {
	Draw = 1,
	Victory = 2,
	Defeat = 0,
	None = -1
}
ChatRoomEnum.DifficultyType = {
	Normal = 2,
	Hard = 3,
	Easy = 1
}
ChatRoomEnum.CardItemState = {
	PreSelect = 2,
	Normal = 4,
	UnFlipped = 3,
	Empty = 1
}
ChatRoomEnum.NameBgType = {
	OtherPlayer = 3,
	MainPlayer = 2,
	Npc = 1
}

return ChatRoomEnum
