-- chunkname: @modules/logic/fight/system/work/FightWorkCheckNaNaBindContract.lua

module("modules.logic.fight.system.work.FightWorkCheckNaNaBindContract", package.seeall)

local FightWorkCheckNaNaBindContract = class("FightWorkCheckNaNaBindContract", FightWorkItem)

function FightWorkCheckNaNaBindContract:onStart()
	local notifyEntityId = FightModel.instance.notifyEntityId

	if string.nilorempty(notifyEntityId) then
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity(notifyEntityId)

	if not entity then
		self:onDone(true)

		return
	end

	local canContractList = FightModel.instance.canContractList

	if not canContractList or #canContractList < 1 then
		self:onDone(true)

		return
	end

	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.BindContract)
	ViewMgr.instance:openView(ViewName.FightNaNaTargetView)
	self:cancelFightWorkSafeTimer()
end

return FightWorkCheckNaNaBindContract
