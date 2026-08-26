-- chunkname: @modules/logic/partygame/controller/PartyGameStatHelper.lua

module("modules.logic.partygame.controller.PartyGameStatHelper", package.seeall)

local PartyGameStatHelper = class("PartyGameStatHelper")

function PartyGameStatHelper:ctor()
	return
end

function PartyGameStatHelper:partyGameMeme(id)
	StatController.instance:track(StatEnum.EventName.PartyGameMeme, {
		[StatEnum.EventProperties.PartyRoomId] = tostring(PartyGameRoomModel.instance:getRoomId()),
		[StatEnum.EventProperties.Members] = PartyGameRoomModel.instance:getPlayerNum(),
		[StatEnum.EventProperties.isOwner] = PartyGameRoomModel.instance:isRoomOwner(),
		[StatEnum.EventProperties.Meme] = id
	})
end

function PartyGameStatHelper:partyMatch(operation)
	StatController.instance:track(StatEnum.EventName.PartyMatch, {
		[StatEnum.EventProperties.OperationType] = operation,
		[StatEnum.EventProperties.PartyRoomId] = tostring(PartyGameRoomModel.instance:getRoomId()),
		[StatEnum.EventProperties.Members] = PartyGameRoomModel.instance:getPlayerNum(),
		[StatEnum.EventProperties.isOwner] = PartyGameRoomModel.instance:isRoomOwner(),
		[StatEnum.EventProperties.UseTime] = (operation ~= StatEnum.PartyGameEnum.StartMatch and PartyGameRoomModel.instance:getMatchTime() or nil) and ServerTime.now() - PartyGameRoomModel.instance:getMatchTime()
	})
end

function PartyGameStatHelper:partyGameStart()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	StatController.instance:track(StatEnum.EventName.PartyGameStart, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount()
	})
end

function PartyGameStatHelper:partyGameExit()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	StatController.instance:track(StatEnum.EventName.PartyGameExit, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount()
	})
end

function PartyGameStatHelper:partyGameEnd()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	local myUid = curGame:getMainPlayerUid()
	local mo = PartyGameModel.instance:getPlayerMoByUid(myUid)

	if not mo then
		return
	end

	local winTeam = curGame:getWinTeam()
	local myTeam = mo.tempType
	local isTeamType = curGame:isTeamType()
	local rank = curGame:getRank(myUid)
	local isWin = false

	isWin = isTeamType and winTeam == myTeam or rank == 1

	StatController.instance:track(StatEnum.EventName.PartyGameEnd, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount(),
		[StatEnum.EventProperties.IsWin] = isWin,
		[StatEnum.EventProperties.IsTeamType] = isTeamType,
		[StatEnum.EventProperties.Result] = tostring(curGame:getPlayerScore(myUid)),
		[StatEnum.EventProperties.Rank] = rank,
		[StatEnum.EventProperties.PartySkinList] = tabletool.copy(mo.skinIds),
		[StatEnum.EventProperties.PartyHp] = mo.hp,
		[StatEnum.EventProperties.PartyCardList] = tabletool.copy(mo.cardIds)
	})
end

function PartyGameStatHelper:partySettle(isWin, rank, partyId)
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame then
		return
	end

	local myUid = curGame:getMainPlayerUid()
	local mo = PartyGameModel.instance:getPlayerMoByUid(myUid)

	if not mo then
		return
	end

	StatController.instance:track(StatEnum.EventName.PartySettle, {
		[StatEnum.EventProperties.PartyGameId] = curGame:getGameId(),
		[StatEnum.EventProperties.Members] = PartyGameModel.instance:getPlayerCount(),
		[StatEnum.EventProperties.PartyGameRobots] = PartyGameModel.instance:getRobotCount(),
		[StatEnum.EventProperties.IsWin] = isWin,
		[StatEnum.EventProperties.Rank] = rank,
		[StatEnum.EventProperties.PartyId] = partyId,
		[StatEnum.EventProperties.PartySkinList] = tabletool.copy(mo.skinIds),
		[StatEnum.EventProperties.PartyHp] = mo.hp,
		[StatEnum.EventProperties.PartyCardList] = tabletool.copy(mo.cardIds)
	})
end

function PartyGameStatHelper:logPartyFriendsInfo(map)
	if not map then
		return
	end

	local stateList = {}

	for i, v in pairs(map) do
		table.insert(stateList, v.state)
	end

	StatController.instance:track(StatEnum.EventName.PartyFriendsInfo, {
		[StatEnum.EventProperties.PartyFriendStateList] = stateList
	})
end

function PartyGameStatHelper:partyGameInvite(operation, targetRoleId, roomId)
	StatController.instance:track(StatEnum.EventName.PartyGameInvite, {
		[StatEnum.EventProperties.OperationType] = operation,
		[StatEnum.EventProperties.TargetRoleId] = tostring(targetRoleId),
		[StatEnum.EventProperties.PartyRoomId] = tostring(roomId)
	})
end

function PartyGameStatHelper:partyGameReconnect()
	local curGame = PartyGameController.instance:getCurPartyGame()
	local var_10_0 = StatEnum.EventName.PartyGameReconnect
	local var_10_1 = {}

	var_10_1[StatEnum.EventProperties.PartyGameId] = curGame and curGame:getGameId() or 0

	StatController.instance:track(var_10_0, var_10_1)
end

PartyGameStatHelper.instance = PartyGameStatHelper.New()

return PartyGameStatHelper
