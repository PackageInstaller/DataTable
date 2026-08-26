-- chunkname: @modules/logic/fight/view/work/FightSSWLAutoSelectCardWork.lua

module("modules.logic.fight.view.work.FightSSWLAutoSelectCardWork", package.seeall)

local FightSSWLAutoSelectCardWork = class("FightSSWLAutoSelectCardWork", FightWorkItem)
local TempList = {}
local SkillItemList = {}

function FightSSWLAutoSelectCardWork:onStart()
	local buffActParam, uid = FightHelper.getSSWLSelectCardParam()

	if not buffActParam then
		return self:onDone(true)
	end

	if buffActParam[1] then
		local selected = buffActParam[1] ~= 0

		if selected then
			return self:onDone(true)
		end

		if not buffActParam[2] then
			local canSelectCount = 0

			if canSelectCount < 1 then
				return self:onDone(true)
			end

			tabletool.clear(SkillItemList)
			tabletool.clear(TempList)
			FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
			self:cancelFightWorkSafeTimer()

			for i = 3, #buffActParam do
				table.insert(SkillItemList, {
					index = i - 2,
					skillId = buffActParam[i]
				})
			end

			table.sort(SkillItemList, FightSSWLAutoSelectCardWork.sortFunc)

			for i = 1, canSelectCount do
				table.insert(TempList, SkillItemList[i].index)
			end

			local value = FightHelper.buildSSWLSelectedValue(TempList)

			FightRpc.instance:sendUseClothSkillRequest(0, uid, value, FightEnum.ClothSkillType.TwinsSelect)
			tabletool.clear(SkillItemList)
			tabletool.clear(TempList)
		end
	end
end

function FightSSWLAutoSelectCardWork:_onRespUseClothSkillFail()
	logError("双生舞苓 自动战斗 选择卡牌失败")
	self:onDone(false)
end

function FightSSWLAutoSelectCardWork.sortFunc(skillItem1, skillItem2)
	local skillId1, skillId2 = skillItem1.skillId, skillItem2.skillId
	local power1 = FightDeviceHelper.getSkillIdAddDevicePower(skillId1) or 0
	local power2 = FightDeviceHelper.getSkillIdAddDevicePower(skillId2) or 0

	if power1 ~= power2 then
		return power2 < power1
	end

	return skillItem1.index < skillItem2.index
end

function FightSSWLAutoSelectCardWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightSSWLAutoSelectCardWork
