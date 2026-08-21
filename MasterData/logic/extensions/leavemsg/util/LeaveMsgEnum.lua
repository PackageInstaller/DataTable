-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/util/LeaveMsgEnum.lua

module("logic.extensions.leavemsg.util.LeaveMsgEnum", package.seeall)

local LeaveMsgEnum = {}

LeaveMsgEnum.EmptyMarkEdit = "<sprite name=\"fhdt01\"><sprite name=\"fhdt02\">"
LeaveMsgEnum.EmptyMarkEditColor = "<sprite name=\"fhdt01\" color=%s><sprite name=\"fhdt02\" color=%s>"
LeaveMsgEnum.MsgType = {
	Voice = 2,
	Word = 1
}
LeaveMsgEnum.MsgPartType = {
	Word = 3,
	VoiceHero = 100,
	VoiceHeroRes = 101,
	Joiner = 2,
	Emoji = 4,
	Subject = 1
}
LeaveMsgEnum.MsgPart2AirMsgEnum = {
	[LeaveMsgEnum.MsgPartType.Subject] = GameEnum.AirMsgTextEnum.Phrase,
	[LeaveMsgEnum.MsgPartType.Word] = GameEnum.AirMsgTextEnum.Word,
	[LeaveMsgEnum.MsgPartType.Joiner] = GameEnum.AirMsgTextEnum.Joiner
}

return LeaveMsgEnum
