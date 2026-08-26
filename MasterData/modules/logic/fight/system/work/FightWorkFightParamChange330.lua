-- chunkname: @modules/logic/fight/system/work/FightWorkFightParamChange330.lua

module("modules.logic.fight.system.work.FightWorkFightParamChange330", package.seeall)

local FightWorkFightParamChange330 = class("FightWorkFightParamChange330", FightEffectBase)

FightWorkFightParamChange330.tempWorkKeyDict = {}

function FightWorkFightParamChange330:onStart()
	self.sequenceFlow = self:com_registWorkDoneFlowSequence()
	self.param = FightDataHelper.fieldMgr.param

	local arr = GameUtil.splitString2(self.actEffectData.reserveStr, true)
	local existWorkKeyDict = FightWorkFightParamChange330.tempWorkKeyDict

	tabletool.clear(existWorkKeyDict)

	for i, v in ipairs(arr) do
		local id = v[1]
		local offset = v[2]
		local currentValue = self.param[id]
		local oldValue = currentValue - offset
		local workKey = FightWorkFightParamChange330.Param2WorkKey[id]
		local existWork = workKey and existWorkKeyDict[workKey]

		if not existWork then
			if workKey then
				existWorkKeyDict[workKey] = true
			end

			local work = FightWorkFightParamChange330.Key2Work[id]

			if work then
				self.sequenceFlow:registWork(work, id, oldValue, currentValue, offset)
			else
				self.sequenceFlow:registWork(FightWorkSendEvent, FightEvent.UpdateFightParam, id, oldValue, currentValue, offset, self.actEffectData)
			end
		end
	end

	self.sequenceFlow:start()
end

FightWorkFightParamChange330.Key2Work = {
	[FightParamData.ParamKey.DoomsdayClock_Value] = FightParamChangeWork3,
	[FightParamData.ParamKey.DoomsdayClock_Range1] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range2] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range3] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range4] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Offset] = FightParamChangeWork4,
	[FightParamData.ParamKey.ACT191_MIN_HP_RATE] = FightParamChangeWork9,
	[FightParamData.ParamKey.DOUQUQU_DICE] = FightParamChangeWork20
}

local KeyIndex = 0

local function GetKey()
	KeyIndex = KeyIndex + 1

	return KeyIndex
end

FightWorkFightParamChange330.WorkKey = {
	DoomsDayClockAreaChangeKey = GetKey()
}
FightWorkFightParamChange330.Param2WorkKey = {
	[FightParamData.ParamKey.DoomsdayClock_Range1] = FightWorkFightParamChange330.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range2] = FightWorkFightParamChange330.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range3] = FightWorkFightParamChange330.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range4] = FightWorkFightParamChange330.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Offset] = FightWorkFightParamChange330.WorkKey.DoomsDayClockAreaChangeKey
}

return FightWorkFightParamChange330
