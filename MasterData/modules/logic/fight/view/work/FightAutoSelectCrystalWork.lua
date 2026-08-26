-- chunkname: @modules/logic/fight/view/work/FightAutoSelectCrystalWork.lua

module("modules.logic.fight.view.work.FightAutoSelectCrystalWork", package.seeall)

local FightAutoSelectCrystalWork = class("FightAutoSelectCrystalWork", FightWorkItem)

function FightAutoSelectCrystalWork:onStart()
	local heatScale = FightDataHelper.getHeatScale(FightEnum.TeamType.MySide)

	if not heatScale then
		return self:onDone(true)
	end

	local totalSelect, perSelect, selected, uid = FightHelper.getBLECrystalParam()

	if not totalSelect then
		return self:onDone(true)
	end

	if selected then
		return self:onDone(true)
	end

	if FightDataHelper.tempMgr:isAutoSelectedCrystal() then
		return self:onDone(true)
	end

	FightDataHelper.tempMgr:setAutoSelectedCrystal(true)
	self:cancelFightWorkSafeTimer()
	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)

	local enumId = PlayerEnum.SimpleProperty.BLELastSelectedCrystal
	local crystal = PlayerModel.instance:getSimpleProperty(enumId)

	if string.nilorempty(crystal) then
		ViewMgr.instance:openView(ViewName.FightBLESelectCrystalView, {
			totalSelectCount = totalSelect,
			oneSelectCount = perSelect,
			BLEUid = uid
		})

		return
	end

	local b, p, g = FightHelper.getCrystalNum(crystal)
	local curTotal = b + p + g

	if curTotal ~= totalSelect then
		ViewMgr.instance:openView(ViewName.FightBLESelectCrystalView, {
			totalSelectCount = totalSelect,
			oneSelectCount = perSelect,
			BLEUid = uid
		})

		return
	end

	if perSelect < b or perSelect < p or perSelect < g then
		ViewMgr.instance:openView(ViewName.FightBLESelectCrystalView, {
			totalSelectCount = totalSelect,
			oneSelectCount = perSelect,
			BLEUid = uid
		})

		return
	end

	FightRpc.instance:sendUseClothSkillRequest(0, uid, tonumber(crystal), FightEnum.ClothSkillType.SelectCrystal)
end

function FightAutoSelectCrystalWork:_onRespUseClothSkillFail()
	logError("select crystal fail")
	self:onDone(false)
end

function FightAutoSelectCrystalWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightAutoSelectCrystalWork
