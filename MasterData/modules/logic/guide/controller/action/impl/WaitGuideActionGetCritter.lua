-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionGetCritter.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionGetCritter", package.seeall)

local WaitGuideActionGetCritter = class("WaitGuideActionGetCritter", BaseGuideAction)

function WaitGuideActionGetCritter:onStart(context)
	WaitGuideActionGetCritter.super.onStart(self, context)
	CritterController.instance:registerCallback(CritterEvent.CritterGuideReply, self._onCritterGuideReply, self)
	CritterRpc.instance:sendGainGuideCritterRequest(self.guideId, self.stepId)

	self.noOpenView = tonumber(self.actionParam) == 1
end

function WaitGuideActionGetCritter:_check()
	self:onDone(true)
end

function WaitGuideActionGetCritter:_onCritterGuideReply(msg)
	if not self.noOpenView then
		local uids = msg.uids

		for i = 1, #uids do
			local critterMo = CritterModel.instance:getCritterMOByUid(uids[i])

			if critterMo then
				local param = {
					mode = RoomSummonEnum.SummonType.Summon,
					critterMo = critterMo
				}

				ViewMgr.instance:openView(ViewName.RoomGetCritterView, param)

				break
			end
		end
	end

	self:_check()
end

function WaitGuideActionGetCritter:clearWork()
	CritterController.instance:unregisterCallback(CritterEvent.CritterGuideReply, self._onCritterGuideReply, self)
end

return WaitGuideActionGetCritter
