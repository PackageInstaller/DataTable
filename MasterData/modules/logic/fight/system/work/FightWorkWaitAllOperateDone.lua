-- chunkname: @modules/logic/fight/system/work/FightWorkWaitAllOperateDone.lua

module("modules.logic.fight.system.work.FightWorkWaitAllOperateDone", package.seeall)

local FightWorkWaitAllOperateDone = class("FightWorkWaitAllOperateDone", FightWorkItem)

function FightWorkWaitAllOperateDone:onStart()
	local operateWorkComp = FightGameMgr.operateMgr.workComp
	local flow = self:com_registWork(FightWorkFlowSequence)

	for i, work in ipairs(operateWorkComp.workList) do
		if work.class.__cname ~= "FightWorkRequestAutoFight" then
			flow:registWork(FightWorkListen2WorkDone, work)
		end
	end

	self:playWorkAndDone(flow)
end

function FightWorkWaitAllOperateDone:onDestructor()
	return
end

return FightWorkWaitAllOperateDone
