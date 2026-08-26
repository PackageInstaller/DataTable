-- chunkname: @modules/logic/fight/system/work/FightWorkSkinDownEffectExit672803.lua

module("modules.logic.fight.system.work.FightWorkSkinDownEffectExit672803", package.seeall)

local FightWorkSkinDownEffectExit672803 = class("FightWorkSkinDownEffectExit672803", FightWorkItem)

function FightWorkSkinDownEffectExit672803:onConstructor()
	return
end

function FightWorkSkinDownEffectExit672803:onStart()
	local flow = self:com_registFlowSequence()
	local floorEffect = FightMsgMgr.sendMsg(FightMsgId.GetCardSkin672803FloorEffect)

	if floorEffect then
		local speed = FightModel.instance:getUISpeed()

		flow:registWork(FightWorkDelayTimer, 0.5 / speed)
		flow:registWork(FightWorkFunction, gohelper.setActive, floorEffect, false)
	end

	self:playWorkAndDone(flow)
end

return FightWorkSkinDownEffectExit672803
