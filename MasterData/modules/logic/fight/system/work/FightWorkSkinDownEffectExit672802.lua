-- chunkname: @modules/logic/fight/system/work/FightWorkSkinDownEffectExit672802.lua

module("modules.logic.fight.system.work.FightWorkSkinDownEffectExit672802", package.seeall)

local FightWorkSkinDownEffectExit672802 = class("FightWorkSkinDownEffectExit672802", FightWorkItem)

function FightWorkSkinDownEffectExit672802:onConstructor()
	return
end

function FightWorkSkinDownEffectExit672802:onStart()
	local flow = self:com_registFlowSequence()
	local floorEffect = FightMsgMgr.sendMsg(FightMsgId.GetCardSkin672802FloorEffect)

	if floorEffect then
		local animator = gohelper.onceAddComponent(floorEffect, gohelper.Type_Animator)
		local speed = FightModel.instance:getUISpeed()

		animator.speed = speed

		animator:Play("fightskin_02_out", 0, 0)
		flow:registWork(FightWorkDelayTimer, 0.5 / speed)
		flow:registWork(FightWorkFunction, gohelper.setActive, floorEffect, false)
	end

	self:playWorkAndDone(flow)
end

return FightWorkSkinDownEffectExit672802
