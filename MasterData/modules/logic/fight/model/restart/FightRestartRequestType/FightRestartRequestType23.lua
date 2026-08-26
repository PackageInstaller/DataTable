-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType23.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType23", package.seeall)

local FightRestartRequestType23 = class("FightRestartRequestType23", FightRestartRequestType1)

function FightRestartRequestType23:requestFight()
	self._fight_work:onDone(true)

	local result = FightController.instance:setFightHeroGroup()

	if result then
		local fightParam = self._fightParam
		local battleContext = Season123Model.instance:getBattleContext()

		if not battleContext then
			FightGameMgr.restartMgr:restartFightFail()

			return
		end

		if not battleContext.layer then
			local layer = -1

			Activity123Rpc.instance:sendStartAct123BattleRequest(battleContext.actId, layer, fightParam.chapterId, fightParam.episodeId, fightParam, fightParam.multiplication, nil, fightParam.isReplay, true, self.onReceiveStartBattle, self)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	end
end

function FightRestartRequestType23:onReceiveStartBattle(cmd, resultCode, msg)
	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end
end

return FightRestartRequestType23
