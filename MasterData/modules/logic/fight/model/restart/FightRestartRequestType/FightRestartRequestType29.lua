-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType29.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType29", package.seeall)

local FightRestartRequestType29 = class("FightRestartRequestType29", UserDataDispose)

function FightRestartRequestType29:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
end

function FightRestartRequestType29:requestFight()
	DungeonFightController.instance:restartStage()
	self._fight_work:onDone(true)
end

function FightRestartRequestType29:releaseSelf()
	self:__onDispose()
end

return FightRestartRequestType29
