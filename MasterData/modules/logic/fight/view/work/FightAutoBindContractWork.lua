-- chunkname: @modules/logic/fight/view/work/FightAutoBindContractWork.lua

module("modules.logic.fight.view.work.FightAutoBindContractWork", package.seeall)

local FightAutoBindContractWork = class("FightAutoBindContractWork", FightWorkItem)

function FightAutoBindContractWork:onConstructor()
	self.SAFETIME = 10
end

function FightAutoBindContractWork:onStart()
	local notifyEntityId = FightModel.instance.notifyEntityId

	if string.nilorempty(notifyEntityId) then
		return self:onDone(true)
	end

	local entity = FightHelper.getEntity(notifyEntityId)

	if not entity then
		return self:onDone(true)
	end

	local canContractList = FightModel.instance.canContractList

	if not canContractList or #canContractList < 1 then
		return self:onDone(true)
	end

	return self:autoContract(canContractList, notifyEntityId)
end

function FightAutoBindContractWork:autoContract(entityIdList, curEntityUid)
	local targetUid
	local targetAtk = 0

	for _, entityId in ipairs(entityIdList) do
		if entityId ~= curEntityUid then
			local entityMo = FightDataHelper.entityMgr:getById(entityId)
			local attrMo = entityMo and entityMo.attrMO
			local atk = attrMo and attrMo.attack

			if atk and targetAtk < atk then
				targetUid = entityId
				targetAtk = atk
			end
		end
	end

	if not targetUid then
		return self:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
	FightRpc.instance:sendUseClothSkillRequest(0, curEntityUid, targetUid, FightEnum.ClothSkillType.Contract)
	self:cancelFightWorkSafeTimer()
end

function FightAutoBindContractWork:_onRespUseClothSkillFail()
	self:onDone(false)
end

function FightAutoBindContractWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightAutoBindContractWork
