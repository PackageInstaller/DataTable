-- chunkname: @modules/logic/fight/system/work/FightWorkEnterPlaneRequest.lua

module("modules.logic.fight.system.work.FightWorkEnterPlaneRequest", package.seeall)

local FightWorkEnterPlaneRequest = class("FightWorkEnterPlaneRequest", BaseWork)

function FightWorkEnterPlaneRequest:ctor(fightParam)
	self._fightParam = fightParam
end

function FightWorkEnterPlaneRequest:onStart()
	local entityMO = FightDataHelper.entityMgr:getAllEntityMO()

	TowerComposeModel.instance:setLastEntityMO(entityMO)
	TowerComposeController.instance:startDungeonRequest()
end

function FightWorkEnterPlaneRequest:clearWork()
	return
end

return FightWorkEnterPlaneRequest
