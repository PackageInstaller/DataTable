-- chunkname: @modules/logic/fight/system/flow/FightSwitchPlaneSequence.lua

module("modules.logic.fight.system.flow.FightSwitchPlaneSequence", package.seeall)

local FightSwitchPlaneSequence = class("FightSwitchPlaneSequence", FightWorkItem)

function FightSwitchPlaneSequence:onStart()
	local flow = self:com_registFlowSequence()
	local fight_param = FightModel.instance:getFightParam()

	flow:addWork(FightEndRequestWork.New())
	flow:addWork(FightWorkSwitchPlaneBefore.New(fight_param))
	flow:addWork(FightWorkEnterPlaneRequest.New(fight_param))
	self:playWorkAndDone(flow)
end

return FightSwitchPlaneSequence
