-- chunkname: @modules/logic/partygamelobby/define/PartyGameLobbyEnum.lua

module("modules.logic.partygamelobby.define.PartyGameLobbyEnum", package.seeall)

local PartyGameLobbyEnum = _M

PartyGameLobbyEnum.PlayerMoveSpeed = 7.5
PartyGameLobbyEnum.JoystickPerRadians = math.rad(45)
PartyGameLobbyEnum.MaxPlayerCount = 8
PartyGameLobbyEnum.InitPos = Vector3(-30.92, 1.67, 6.73)
PartyGameLobbyEnum.MovePosScale = 100
PartyGameLobbyEnum.DailyOpenId = 340002
PartyGameLobbyEnum.RoomOpenId = 340003
PartyGameLobbyEnum.GuideParam = {
	CardDropGame = 100,
	Result2SelectCard = 22,
	Result1SelectCard = 21,
	Game2 = 11,
	Game1 = 8
}
PartyGameLobbyEnum.GuideIds = {
	GuideId2 = 34013,
	GuideId5 = 34016,
	GuideId3 = 34014,
	LastGuideId = 34018,
	GuideId4 = 34015,
	FirstGuideId = 34011,
	GuideId1 = 34012,
	GuideId6 = 34017
}
PartyGameLobbyEnum.RefuseType = {
	Passive = 1,
	Active = 2
}
PartyGameLobbyEnum.SkipGame = {
	Playing = 2,
	Verison = 1
}
PartyGameLobbyEnum.MatchStatus = {
	NoMatch = 0,
	StartMatch = 1,
	MatchSuccess = 3,
	Matching = 2
}
PartyGameLobbyEnum.BuildingType = {
	Lottery = 3,
	Shop = 1,
	DressUp = 2
}
PartyGameLobbyEnum.RoomState = {
	InRoom = 3,
	Create = 2,
	InMatch = 4,
	None = 1
}
PartyGameLobbyEnum.RoomOperateState = {
	NotReady = 0,
	Ready = 1
}
PartyGameLobbyEnum.FriendState = {
	InGame = 4,
	Matching = 3,
	Normal = 0
}
PartyGameLobbyEnum.TipsRes = {
	Invite = "modules/party_game/ui/viewres/main/partygame_invitetipsitem.prefab",
	Join = "modules/party_game/ui/viewres/main/partygame_roomtipsitem.prefab"
}
PartyGameLobbyEnum.SceneLevelId = {
	Lottery = 3,
	Lobby = 1,
	Dress = 2
}
PartyGameLobbyEnum.SceneUrl = {
	[PartyGameLobbyEnum.SceneLevelId.Lobby] = "modules/party_game/scene/game_home/prefabs/party_game_home_p.prefab",
	[PartyGameLobbyEnum.SceneLevelId.Dress] = "modules/party_game/scene/game_home/prefabs/party_game_home_huanzhuang_p.prefab",
	[PartyGameLobbyEnum.SceneLevelId.Lottery] = "modules/party_game/scene/game_home/prefabs/party_game_home_choujiang_p.prefab"
}
PartyGameLobbyEnum.CameraId = {
	[PartyGameLobbyEnum.SceneLevelId.Lobby] = 24,
	[PartyGameLobbyEnum.SceneLevelId.Dress] = 25,
	[PartyGameLobbyEnum.SceneLevelId.Lottery] = 26
}

return PartyGameLobbyEnum
