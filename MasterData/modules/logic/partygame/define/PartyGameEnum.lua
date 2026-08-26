-- chunkname: @modules/logic/partygame/define/PartyGameEnum.lua

module("modules.logic.partygame.define.PartyGameEnum", package.seeall)

local PartyGameEnum = _M

PartyGameEnum.PartyGameUISpineRes = "roles_special/role_partygame/v3a4_566101_dlr/566101_dlr_ui.prefab"
PartyGameEnum.PartyGameSceneSpineRes = "roles_special/role_partygame/v3a4_566101_dlr/566101_dlr_partygame.prefab"
PartyGameEnum.GameState = {
	GameStart = 2,
	Running = 4,
	InitFinish = 1,
	Paused = 3,
	Initializing = 0,
	GameOver = 6,
	Terminated = 7,
	TraceState = 5
}
PartyGameEnum.GamePlayerTeamType = {
	Blue = 2,
	Red = 1,
	None = 0
}
PartyGameEnum.resultViewShowTime = 2
PartyGameEnum.resultCountDownTime = 5
PartyGameEnum.GameId = {
	CollatingSort = 12,
	WayFinding = 2,
	PedalingPlaid = 9,
	CardDrop = 100,
	WhichMore = 15,
	PacMan = 10,
	SnatchPlaid = 6,
	Security = 5,
	FindDoor = 13,
	SnatchTerritory = 8,
	DodgeBullets = 3,
	Decision = 7,
	Puzzle = 18,
	CoinGrabbing = 1,
	Jenga = 11,
	SplicingRoad = 19,
	WoodenMan = 4,
	SnatchArea = 16,
	FindLove = 14,
	GuessWho = 17
}
PartyGameEnum.GameIdToName = {}

for k, v in pairs(PartyGameEnum.GameId) do
	PartyGameEnum.GameIdToName[v] = k
end

PartyGameEnum.DefaultRoleLightFactor = 1
PartyGameEnum.RoleLightFactor = {}
PartyGameEnum.LobbyRoleLightFactor = PartyGameEnum.DefaultRoleLightFactor
PartyGameEnum.PartyGameConfigData = PartyGame.Runtime.GameLogic.PartyGameConfigData
PartyGameEnum.VirtualButtonId = PartyGame.Runtime.GameLogic.Component.VirtualButtonId
PartyGameEnum.CommandUtil = PartyGame.Runtime.Utils.CommandUtil
PartyGameEnum.AllResultVsViewWaitDuration = 5
PartyGameEnum.PromotionViewWaitDuration = 5
PartyGameEnum.SelectCardRewardWaitTime = 10
PartyGameEnum.SelectCardRewardWaitTime2 = 2
PartyGameEnum.PopStopKey = "PartyGameEnum_PartyGameResultViewKey"
PartyGameEnum.LoadingTime = 1

return PartyGameEnum
