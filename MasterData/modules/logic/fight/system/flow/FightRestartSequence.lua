-- chunkname: @modules/logic/fight/system/flow/FightRestartSequence.lua

module("modules.logic.fight.system.flow.FightRestartSequence", package.seeall)

local FightRestartSequence = class("FightRestartSequence", FightWorkItem)

FightRestartSequence.RestartType2Type = {
	[38] = 34,
	[121] = 1,
	[42] = 1,
	[46] = 1,
	[122] = 1,
	[191] = 1,
	[201] = 1,
	[202] = 1,
	[24] = 23,
	[143] = 1,
	[31] = 166,
	[34] = 34,
	[161] = 1,
	[21] = 1,
	[32] = 166,
	[183] = 1,
	[36] = 34,
	[181] = 1,
	[99] = 1,
	[123] = 1,
	[19] = 1,
	[124] = 1,
	[151] = 1,
	[35] = 34,
	[14] = 1,
	[135] = 131,
	[134] = 131,
	[133] = 131,
	[132] = 131
}

function FightRestartSequence:onStart()
	local flow = self:com_registFlowSequence()
	local fight_param = FightModel.instance:getFightParam()

	flow:addWork(FightWorkRestartAbandon.New(fight_param))
	flow:addWork(FunctionWork.New(self.startRestartGame, self))
	flow:addWork(FightWorkRestartBefore.New(fight_param))
	flow:addWork(FightWorkRestartRequest.New(fight_param))
	self:playWorkAndDone(flow)
end

function FightRestartSequence:startRestartGame()
	FightMsgMgr.sendMsg(FightMsgId.RestartGame)
end

return FightRestartSequence
