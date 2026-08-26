-- chunkname: @modules/logic/guide/rpc/GuideRpc.lua

module("modules.logic.guide.rpc.GuideRpc", package.seeall)

local GuideRpc = class("GuideRpc", BaseRpc)

function GuideRpc:sendGetGuideInfoRequest(callback, callbackObj)
	local req = GuideModule_pb.GetGuideInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function GuideRpc:onReceiveGetGuideInfoReply(resultCode, msg)
	if resultCode == 0 then
		GuideModel.instance:setGuideList(msg.guideInfos)
		GuideController.instance:dispatchEvent(GuideEvent.GetGuideInfoSuccess)
	end
end

function GuideRpc:sendFinishGuideRequest(guideId, stepId)
	local req = GuideModule_pb.FinishGuideRequest()

	req.guideId = guideId
	req.stepId = stepId

	self:sendMsg(req)
end

function GuideRpc:onReceiveFinishGuideReply(resultCode, msg)
	if resultCode == 0 then
		GuideController.instance:dispatchEvent(GuideEvent.onReceiveFinishGuideReply, msg)
	else
		GuideController.instance:dispatchEvent(GuideEvent.FinishGuideFail)
	end
end

function GuideRpc:onReceiveUpdateGuidePush(resultCode, msg)
	GuideModel.instance:updateGuideList(msg.guideInfos)

	for i = 1, #msg.guideInfos do
		local guideInfo = msg.guideInfos[i]

		logNormal(string.format("<color=#3E7E00>update guide push guide_%d_%d</color>", guideInfo.guideId, guideInfo.stepId))

		local guideMO = GuideModel.instance:getById(guideInfo.guideId)

		if msg.guideInfos[i].stepId == 0 then
			GuideController.instance:dispatchEvent(GuideEvent.StartGuide, guideMO.id)
		else
			GuideStepController.instance:clearFlow(guideMO.id)

			if guideMO.serverStepId > 0 then
				if not guideMO.serverStepId then
					local finishStepId = guideMO.clientStepId

					if finishStepId == -1 then
						local stepCOList = GuideConfig.instance:getStepList(guideMO.id)

						finishStepId = stepCOList[#stepCOList].stepId
					end

					GuideController.instance:dispatchEvent(GuideEvent.FinishStep, guideMO.id, finishStepId)

					if guideMO.isFinish then
						GuideController.instance:dispatchEvent(GuideEvent.FinishGuide, guideMO.id)
					end
				end
			end
		end

		GuideController.instance:statFinishStep(guideMO.id, guideMO.clientStepId, false)
		GuideController.instance:execNextStep(guideMO.id)
	end
end

GuideRpc.instance = GuideRpc.New()

return GuideRpc
