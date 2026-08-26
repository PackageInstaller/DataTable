-- chunkname: @modules/logic/fight/system/flow/FightFastRestartSequence.lua

module("modules.logic.fight.system.flow.FightFastRestartSequence", package.seeall)

local FightFastRestartSequence = class("FightFastRestartSequence", FightWorkItem)

function FightFastRestartSequence:onStart()
	local flow = self:com_registFlowSequence()
	local fight_param = FightModel.instance:getFightParam()

	flow:addWork(FightWorkRestartBefore.New(fight_param))
	flow:addWork(FightWorkFastRestartRequest.New(fight_param))
	self:playWorkAndDone(flow)
end

return FightFastRestartSequence
