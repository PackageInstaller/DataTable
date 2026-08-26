-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoStoryEventWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoStoryEventWork", package.seeall)

local TravelGoStoryEventWork = class("TravelGoStoryEventWork", BaseWork)

function TravelGoStoryEventWork:onStart()
	TravelGoController.instance:registerCallback(TravelGoEvent.OnStoryEventSelect, self.onStoryEventSelect, self)

	self.mo = TravelGoModel.instance.travelGoEventMO
	self.flow = FlowSequence.New()

	local npcId = self.mo.cfg.npc

	self.haveNpc = npcId and npcId ~= 0

	if self.haveNpc then
		self.flow:addWork(FunctionWork.New(self.createNpc, self))
		self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnPlayerMoveToEventPos, {
			isBattle = false
		}))
		self.flow:addWork(TimerWork.New(TravelGoController.instance.PlayerMoveToTime))
	end

	self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnStartStoryEvent))
	self.flow:start()
end

function TravelGoStoryEventWork:createNpc()
	self.npc = TravelGoController.instance.travelGoEntityMgr:createNpcEntity(self.mo.cfg.npc)
	self.npcUid = self.npc.uid
end

function TravelGoStoryEventWork:onStoryEventSelect(choiceIndex)
	TravelGoModel.instance.travelGoEventMO:setStoryChoice(choiceIndex)

	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO

	if self.haveNpc then
		if choiceIndex == 1 then
			if not self.npc.cfg.chooseAnimator1 then
				do
					local animName = self.npc.cfg.chooseAnimator2

					TravelGoController.instance:dispatchEvent(TravelGoEvent.OnPlaySpineAnim, self.npcUid, animName, false, true)
				end

				if self.descFlow then
					self.descFlow:destroy()

					goto label_3_0
				end
			end
		end
	end

	self.descFlow = FlowSequence.New()

	::label_3_0::

	local descList = travelGoEventMO:getStorySelectDescList(choiceIndex)

	if descList then
		local actId = TravelGoModel.instance.activityId
		local waitTime = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.StorySelectWaitTime, true) or 0

		self.descFlow:addWork(TimerWork.New(waitTime))

		local descIntervalTime = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.DescIntervalTime, true) or 0

		for i, desc in ipairs(descList) do
			local param = {
				desc = desc
			}

			self.descFlow:addWork(FunctionWork.New(TravelGoController.instance.addDescItem, TravelGoController.instance, param))

			if i ~= #descList then
				self.descFlow:addWork(TimerWork.New(descIntervalTime))
			end
		end
	end

	self.descFlow:registerDoneListener(self.onDescOk, self)
	self.descFlow:start()
end

function TravelGoStoryEventWork:onDescOk()
	self:onDone(true)
end

function TravelGoStoryEventWork:clearWork()
	TravelGoController.instance:unregisterCallback(TravelGoEvent.OnStoryEventSelect, self.onStoryEventSelect, self)

	if self.haveNpc then
		TravelGoController.instance.travelGoEntityMgr:removeNpc(self.npcUid)
		TravelGoController.instance:dispatchEvent(TravelGoEvent.OnPlayerStartMove)
	end

	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end

	if self.descFlow then
		self.descFlow:destroy()

		self.descFlow = nil
	end
end

return TravelGoStoryEventWork
