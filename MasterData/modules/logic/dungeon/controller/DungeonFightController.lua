-- chunkname: @modules/logic/dungeon/controller/DungeonFightController.lua

module("modules.logic.dungeon.controller.DungeonFightController", package.seeall)

local DungeonFightController = class("DungeonFightController", BaseController)

function DungeonFightController:onInit()
	self._battleEpisodeType = nil
	self._otherBattleReqAction = nil
	self._otherBattleObj = nil
end

function DungeonFightController:onInitFinish()
	return
end

function DungeonFightController:addConstEvents()
	return
end

function DungeonFightController:reInit()
	self._battleEpisodeType = nil
	self._otherBattleReqAction = nil
	self._otherBattleObj = nil
end

function DungeonFightController:enterNewbieFight(chapterId, episodeId)
	local fightParam = FightController.instance:setNewBieFightParamByEpisodeId(episodeId)

	self:sendStartDungeonRequest(chapterId, episodeId, fightParam)
end

function DungeonFightController:enterFightByBattleId(chapterId, episodeId, battleId)
	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeAndBattle(episodeId, battleId)

	fightParam:setDungeon(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function DungeonFightController:enterWeekwalkFight(chapterId, episodeId, battleId)
	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeAndBattle(episodeId, battleId)

	fightParam:setDungeon(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function DungeonFightController:enterMeilanniFight(chapterId, episodeId, battleId)
	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeAndBattle(episodeId, battleId)

	fightParam:setDungeon(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function DungeonFightController:enterSeasonFight(chapterId, episodeId)
	FightModel.instance:clear()
	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeId(episodeId)

	fightParam:setDungeon(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function DungeonFightController:enterFight(chapterId, episodeId, multiplication, adventure)
	FightModel.instance:clear()
	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeId(episodeId)

	fightParam:setDungeon(chapterId, episodeId, multiplication)
	fightParam:setPreload()
	fightParam:setAdventure(adventure)
	FightController.instance:enterFightScene()
end

function DungeonFightController:sendStartDungeonRequest(chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord)
	if self._otherBattleReqAction then
		self._otherBattleReqAction(self._otherBattleObj)
		self:setBattleRequestAction(nil, nil)
	else
		DungeonRpc.instance:sendStartDungeonRequest(chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord)
	end
end

function DungeonFightController:onReceiveStartDungeonReply(resultCode, msg)
	FightRpc.instance:onReceiveTestFightReply(resultCode, msg)
end

function DungeonFightController:sendEndFightRequest(isAbort, endType)
	DungeonRpc.instance:sendEndDungeonRequest(isAbort, endType)
end

function DungeonFightController:onReceiveEndDungeonReply(resultCode, msg)
	FightRpc.instance:onReceiveEndFightReply(resultCode, msg)
end

function DungeonFightController.restartStage()
	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	fightParam.chapterId = episode_config.chapterId

	DungeonRpc.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, fightParam.multiplication, nil, nil, true)
end

function DungeonFightController.restartSpStage()
	local cur_scene = GameSceneMgr.instance:getCurScene()

	cur_scene.director:registRespBeginFight()
	FightGameMgr.bgmMgr:resumeBgm()

	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	fightParam.chapterId = episode_config.chapterId

	DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, fightParam.multiplication)
end

function DungeonFightController:setBattleRequestAction(action, obj)
	self._otherBattleReqAction = action
	self._otherBattleObj = obj
end

DungeonFightController.instance = DungeonFightController.New()

return DungeonFightController
