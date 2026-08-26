-- chunkname: @modules/logic/fight/system/work/FightWorkClientEffect339.lua

module("modules.logic.fight.system.work.FightWorkClientEffect339", package.seeall)

local FightWorkClientEffect339 = class("FightWorkClientEffect339", FightEffectBase)

function FightWorkClientEffect339:onConstructor()
	self.SAFETIME = 3
end

function FightWorkClientEffect339:onStart()
	local clientEffect = self.actEffectData.effectNum
	local func = self["clientEffect" .. clientEffect]

	if not func then
		if isDebugBuild then
			logError("客户端未处理表现 ： " .. tostring(clientEffect))
		end

		return self:onDone(true)
	end

	local checkFunc = self["clientEffectCheckFunc" .. clientEffect]

	if checkFunc and not checkFunc(self) then
		return self:onDone(true)
	end

	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(Work2FightWork, FunctionWork, func, self)

	local waitTime = FightWorkClientEffect339.ClientEffectWaitTime[clientEffect]

	if waitTime and waitTime > 0 then
		flow:registWork(Work2FightWork, TimerWork, waitTime)
	end

	local doneFunc = self["clientEffectDone" .. clientEffect]

	if doneFunc then
		flow:registWork(Work2FightWork, FunctionWork, doneFunc, self)
	end

	flow:start()
end

function FightWorkClientEffect339:clientEffect1()
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnBroken)
end

function FightWorkClientEffect339:clientEffect2()
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnClear)
end

function FightWorkClientEffect339:clientEffect3()
	FightController.instance:dispatchEvent(FightEvent.TriggerVorpalithSkill)
end

function FightWorkClientEffect339:clientEffect4()
	FightController.instance:dispatchEvent(FightEvent.Rouge2_ScanMusic)
end

function FightWorkClientEffect339:clientEffectCheckFunc5()
	local entityId = self.actEffectData.targetId
	local skillId = FightHelper.getEntityRecordSkillIdAndCount(entityId)

	skillId = tonumber(skillId)

	return skillId and skillId > 0
end

function FightWorkClientEffect339:clientEffect5()
	local entityId = self.actEffectData.targetId

	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	ViewMgr.instance:openView(ViewName.FightLorentzCardCopyView, {
		entityId = entityId
	})
end

function FightWorkClientEffect339:clientEffectDone5()
	ViewMgr.instance:closeView(ViewName.FightLorentzCardCopyView)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
end

FightWorkClientEffect339.ClientEffectEnum = {
	TriggerVorpalithSkill = 3,
	LorentzCopyCard = 5,
	TriggerRouge2ScanMusic = 4,
	DoomsdayClock = 1,
	DoomsdayClockClear = 2
}
FightWorkClientEffect339.ClientEffectWaitTime = {
	[FightWorkClientEffect339.ClientEffectEnum.DoomsdayClock] = 0.5,
	[FightWorkClientEffect339.ClientEffectEnum.DoomsdayClockClear] = 0.2,
	[FightWorkClientEffect339.ClientEffectEnum.TriggerRouge2ScanMusic] = 0.5,
	[FightWorkClientEffect339.ClientEffectEnum.LorentzCopyCard] = 2.5
}

return FightWorkClientEffect339
