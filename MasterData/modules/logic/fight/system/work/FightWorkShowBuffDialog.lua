-- chunkname: @modules/logic/fight/system/work/FightWorkShowBuffDialog.lua

module("modules.logic.fight.system.work.FightWorkShowBuffDialog", package.seeall)

local FightWorkShowBuffDialog = class("FightWorkShowBuffDialog", BaseWork)

FightWorkShowBuffDialog.needStopWork = nil
FightWorkShowBuffDialog.addBuffRoundId = nil
FightWorkShowBuffDialog.delBuffRoundId = nil

function FightWorkShowBuffDialog:onStart()
	local roundId = FightModel.instance:getCurRoundId()

	if roundId == 1 then
		FightWorkShowBuffDialog.addBuffRoundId = nil
		FightWorkShowBuffDialog.delBuffRoundId = nil
	end

	FightWorkShowBuffDialog.needStopWork = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.BuffRoundBefore)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.BuffRoundAfter)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.RoundEndAndCheckBuff)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.checkHaveMagicCircle)

	if FightWorkShowBuffDialog.needStopWork then
		self._flow = FlowSequence.New()

		self._flow:addWork(FunctionWork.New(self._detectPlayTimeline, self))
		self._flow:addWork(FightWorkWaitDialog.New())
		self._flow:registerDoneListener(self._onFightDialogEnd, self)
		self._flow:start()
	else
		self:onDone(true)
	end
end

local _id2Timeline = {
	[13304021] = "630404_innate1",
	[13304022] = "630404_innate1",
	[13304020] = "630404_innate1",
	[13304024] = "630404_innate1",
	[13304011] = "630404_innate1",
	[13304019] = "630404_innate1",
	[13304013] = "630404_innate1",
	[13304023] = "630404_innate1",
	[13304012] = "630404_innate1",
	[13304025] = "630404_innate1",
	[13304026] = "630404_innate1",
	[13304027] = "630404_innate1",
	[13304010] = "630404_innate1"
}

function FightWorkShowBuffDialog:_detectPlayTimeline()
	local config = FightWorkShowBuffDialog.needStopWork

	if config and _id2Timeline[config.id] then
		local entityId = "-1"
		local entity = FightHelper.getEntity(entityId)

		if entity and entity.skill then
			local temp_data = {
				actId = 0,
				stepUid = 0,
				actEffect = {
					{
						targetId = entityId
					}
				},
				fromId = entityId,
				toId = entityId,
				actType = FightEnum.ActType.SKILL
			}

			entity.skill:playTimeline(_id2Timeline[FightWorkShowBuffDialog.needStopWork.id], temp_data)
		end
	end
end

function FightWorkShowBuffDialog:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkShowBuffDialog:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onFightDialogEnd, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkShowBuffDialog
