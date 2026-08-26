-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType1.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType1", package.seeall)

local FightRestartRequestType1 = class("FightRestartRequestType1", UserDataDispose)

function FightRestartRequestType1:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartRequestType1:requestFight()
	self._fight_work:onDone(true)
	DungeonFightController.instance:restartStage()
end

function FightRestartRequestType1:releaseSelf()
	self:__onDispose()
end

return FightRestartRequestType1
