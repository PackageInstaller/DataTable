-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType46.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType46", package.seeall)

local FightRestartRequestType46 = class("FightRestartRequestType46", UserDataDispose)

function FightRestartRequestType46:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartRequestType46:requestFight()
	self._fight_work:onDone(true)
	TowerComposeController.instance:startDungeonRequest()
end

function FightRestartRequestType46:releaseSelf()
	self:__onDispose()
end

return FightRestartRequestType46
