-- chunkname: @modules/logic/fight/system/work/FightWorkBLESelectCrystal.lua

module("modules.logic.fight.system.work.FightWorkBLESelectCrystal", package.seeall)

local FightWorkBLESelectCrystal = class("FightWorkBLESelectCrystal", FightWorkItem)

function FightWorkBLESelectCrystal:onStart()
	local heatScale = FightDataHelper.getHeatScale(FightEnum.TeamType.MySide)

	if not heatScale then
		return self:onDone(true)
	end

	local totalSelect, perSelect, selected, uid = FightHelper.getBLECrystalParam()

	if not totalSelect then
		return self:onDone(true)
	end

	if not selected then
		self:cancelFightWorkSafeTimer()
		ViewMgr.instance:openView(ViewName.FightBLESelectCrystalView, {
			totalSelectCount = totalSelect,
			oneSelectCount = perSelect,
			BLEUid = uid
		})

		return
	end

	return self:onDone(true)
end

return FightWorkBLESelectCrystal
