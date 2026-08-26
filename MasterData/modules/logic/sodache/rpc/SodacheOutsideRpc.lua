-- chunkname: @modules/logic/sodache/rpc/SodacheOutsideRpc.lua

module("modules.logic.sodache.rpc.SodacheOutsideRpc", package.seeall)

local SodacheOutsideRpc = class("SodacheOutsideRpc", BaseRpc)

function SodacheOutsideRpc:sendSodacheOutsideGetScene(callback, callobj)
	local req = SodacheOutsideModule_pb.SodacheOutsideGetSceneRequest()

	return self:sendMsg(req, callback, callobj)
end

function SodacheOutsideRpc:onReceiveSodacheOutsideGetSceneReply(resultCode, msg)
	if resultCode == 0 then
		if not msg.scene.prop.rookie then
			self:forceFinishGuide(37006)
			self:forceFinishGuide(37007)
			self:forceFinishGuide(37008)
			self:forceFinishGuide(37010)
			self:forceFinishGuide(37011)
			self:forceFinishGuide(37012)
			self:forceFinishGuide(37013)
			self:forceFinishGuide(37014)
			self:forceFinishGuide(37015)
			self:forceFinishGuide(37016)
		end

		SodacheMapUtil.instance:clear()
		SodacheModel.instance:updateOutsideMo(msg.scene)
	end
end

function SodacheOutsideRpc:forceFinishGuide(guideId)
	local guideMO = GuideModel.instance:getById(guideId)

	if guideMO and not guideMO.isFinish then
		local stepList = GuideConfig.instance:getStepList(guideId)

		for j = #stepList, 1, -1 do
			local stepCO = stepList[j]

			if stepCO.keyStep == 1 then
				GuideRpc.instance:sendFinishGuideRequest(guideId, stepCO.stepId)

				break
			end
		end

		guideMO.isJumpPass = true

		GuideStepController.instance:clearFlow(guideId)
		guideMO:exceptionFinishGuide()
	end
end

function SodacheOutsideRpc:sendSodacheBuildingUpgrade(type, callback, callobj)
	local req = SodacheOutsideModule_pb.SodacheBuildingUpgradeRequest()

	req.type = type

	return self:sendMsg(req, callback, callobj)
end

function SodacheOutsideRpc:onReceiveSodacheBuildingUpgradeReply(resultCode, msg)
	if resultCode == 0 then
		local outsideMo = SodacheModel.instance:getOutsideMo()

		if outsideMo then
			outsideMo:updateBuilding(msg.building)
		end

		SodacheController.instance:dispatchEvent(SodacheEvent.OnBuildingUpgrade, msg.building.type)
		ViewMgr.instance:openView(ViewName.SodacheUpgradeResultView, msg.building)
	end
end

function SodacheOutsideRpc:sendSodacheRelicUpgrade(id)
	local req = SodacheOutsideModule_pb.SodacheRelicUpgradeRequest()

	req.id = id

	return self:sendMsg(req)
end

function SodacheOutsideRpc:onReceiveSodacheRelicUpgradeReply(resultCode, msg)
	if resultCode == 0 then
		local oustSideMo = SodacheModel.instance:getOutsideMo()

		if oustSideMo then
			local relicMo = oustSideMo.relicBox:getRelicMo(msg.relic.id)

			relicMo:update(msg.relic)
			SodacheController.instance:dispatchEvent(SodacheEvent.OnRelicUpgrade, relicMo)
		end
	end
end

function SodacheOutsideRpc:sendSodacheRelicOneKeyUpgrade()
	local req = SodacheOutsideModule_pb.SodacheRelicOneKeyUpgradeRequest()

	return self:sendMsg(req)
end

function SodacheOutsideRpc:onReceiveSodacheRelicOneKeyUpgradeReply(resultCode, msg)
	if resultCode == 0 then
		local oustSideMo = SodacheModel.instance:getOutsideMo()

		if oustSideMo then
			for _, relic in ipairs(msg.relics) do
				local relicMo = oustSideMo.relicBox:getRelicMo(relic.id)

				if relicMo then
					relicMo:update(relic)
				else
					logError(string.format("本地不存在遗物ID: %s，请查看配置表", relic.id))
				end
			end
		end

		SodacheController.instance:dispatchEvent(SodacheEvent.OnRelicUpgradeOneKey, msg.relics)
	end
end

function SodacheOutsideRpc:onReceiveSodacheBagUpdatePush(resultCode, msg)
	if resultCode == 0 then
		if SodacheUtil.isInside() then
			SodacheMapUtil.instance:addPushToFlow("SodacheBagUpdatePush", msg)
		else
			SodacheBagUpdatePushWork.doMsg(msg)
		end
	end
end

function SodacheOutsideRpc:onReceiveSodacheStepPush(resultCode, msg)
	if resultCode == 0 then
		SodacheMapUtil.instance:cacheSteps(msg.steps)
	end
end

function SodacheOutsideRpc:onReceiveSodacheAttrPush(resultCode, msg)
	if resultCode == 0 then
		SodacheMapUtil.instance:addPushToFlow("SodacheAttrPush", msg)
	end
end

function SodacheOutsideRpc:sendSodacheOutsideHotfix1(intParam, strParam, callback, callobj)
	local req = SodacheOutsideModule_pb.SodacheOutsideHotfix1Request()

	if intParam then
		for _, v in ipairs(intParam) do
			table.insert(req.intParam, v)
		end
	end

	if strParam then
		for _, v in ipairs(strParam) do
			table.insert(req.strParam, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheOutsideRpc:onReceiveSodacheOutsideHotfix1Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheOutsideRpc:sendSodacheOutsideHotfix2(intParam, strParam, callback, callobj)
	local req = SodacheOutsideModule_pb.SodacheOutsideHotfix2Request()

	if intParam then
		for _, v in ipairs(intParam) do
			table.insert(req.intParam, v)
		end
	end

	if strParam then
		for _, v in ipairs(strParam) do
			table.insert(req.strParam, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheOutsideRpc:onReceiveSodacheOutsideHotfix2Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheOutsideRpc:sendSodacheOutsideHotfix3(intParam, strParam, callback, callobj)
	local req = SodacheOutsideModule_pb.SodacheOutsideHotfix3Request()

	if intParam then
		for _, v in ipairs(intParam) do
			table.insert(req.intParam, v)
		end
	end

	if strParam then
		for _, v in ipairs(strParam) do
			table.insert(req.strParam, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheOutsideRpc:onReceiveSodacheOutsideHotfix3Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheOutsideRpc:onReceiveMsg(resultCode, cmd, recvProtoName, msg, downTag, socketId)
	SodacheOutsideRpc.super.onReceiveMsg(self, resultCode, cmd, recvProtoName, msg, downTag, socketId)

	if resultCode == 0 and string.find(recvProtoName, "Reply$") then
		SodacheMapUtil.instance:tryStartFlow(recvProtoName, false)
	end
end

function SodacheOutsideRpc:sendSodacheTaskAbandonRequest(ids)
	local req = SodacheOutsideModule_pb.SodacheTaskAbandonRequest()

	for _, id in ipairs(ids) do
		table.insert(req.id, id)
	end

	return self:sendMsg(req)
end

function SodacheOutsideRpc:onReceiveSodacheTaskAbandonReply(resultCode, msg)
	if resultCode == 0 then
		local taskBox = SodacheModel.instance:getOutsideMo().taskBox

		taskBox:abandonTasks(msg.id)
	end
end

function SodacheOutsideRpc:sendSodacheTaskAcceptRequest(ids)
	local req = SodacheOutsideModule_pb.SodacheTaskAcceptRequest()

	for _, id in ipairs(ids) do
		table.insert(req.id, id)
	end

	return self:sendMsg(req)
end

function SodacheOutsideRpc:onReceiveSodacheTaskAcceptReply(resultCode, msg)
	return
end

function SodacheOutsideRpc:sendSodacheTaskGainRewardRequest(ids)
	local req = SodacheOutsideModule_pb.SodacheTaskGainRewardRequest()

	for _, id in ipairs(ids) do
		table.insert(req.id, id)
	end

	return self:sendMsg(req)
end

function SodacheOutsideRpc:onReceiveSodacheTaskGainRewardReply(resultCode, msg)
	return
end

function SodacheOutsideRpc:sendSodacheTaskSubmitRequest(id)
	local req = SodacheOutsideModule_pb.SodacheTaskSubmitRequest()

	req.id = id

	return self:sendMsg(req)
end

function SodacheOutsideRpc:onReceiveSodacheTaskSubmitReply(resultCode, msg)
	return
end

SodacheOutsideRpc.instance = SodacheOutsideRpc.New()

return SodacheOutsideRpc
