-- chunkname: @modules/logic/fight/system/work/FightWorkFastRestartRequest.lua

module("modules.logic.fight.system.work.FightWorkFastRestartRequest", package.seeall)

local FightWorkFastRestartRequest = class("FightWorkFastRestartRequest", BaseWork)

function FightWorkFastRestartRequest:onStart()
	DungeonFightController.instance:restartStage()
	self:onDone(true)
end

return FightWorkFastRestartRequest
