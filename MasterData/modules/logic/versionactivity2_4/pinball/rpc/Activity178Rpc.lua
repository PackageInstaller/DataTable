-- chunkname: @modules/logic/versionactivity2_4/pinball/rpc/Activity178Rpc.lua

module("modules.logic.versionactivity2_4.pinball.rpc.Activity178Rpc", package.seeall)

local Activity178Rpc = class("Activity178Rpc", BaseRpc)

function Activity178Rpc:sendGetAct178Info(activityId)
	local req = Activity178Module_pb.GetAct178InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveGetAct178InfoReply(resultCode, msg)
	if resultCode == 0 then
		PinballModel.instance:initData(msg.info)
	end
end

function Activity178Rpc:sendAct178StartEpisode(activityId, episodeId, callback, callobj)
	local req = Activity178Module_pb.Act178StartEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	return self:sendMsg(req, callback, callobj)
end

function Activity178Rpc:onReceiveAct178StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity178Rpc:sendAct178EndEpisode(activityId, currency, episodeId)
	PinballStatHelper.instance:sendGameFinish()

	local req = Activity178Module_pb.Act178EndEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	for type, num in pairs(currency) do
		local currencyTb = Activity178Module_pb.Act178CurrencyNO()

		currencyTb.type = type
		currencyTb.num = num

		table.insert(req.currencys, currencyTb)
	end

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveAct178EndEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.PinballResultView, msg)

		PinballModel.instance.oper = PinballEnum.OperType.Episode

		PinballController.instance:dispatchEvent(PinballEvent.OperChange)
		PinballModel.instance:onCurrencyChange(msg.currencys)
		PinballController.instance:dispatchEvent(PinballEvent.OnCurrencyChange)
	else
		ViewMgr.instance:closeView(ViewName.PinballGameView)
	end
end

function Activity178Rpc:sendAct178EndRound(activityId)
	local req = Activity178Module_pb.Act178EndRoundRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveAct178EndRoundReply(resultCode, msg)
	if resultCode == 0 then
		local preData = {
			day = PinballModel.instance.day
		}

		preData.preScore, preData.nextScore = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
		preData.preComplaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
		preData.preMaxProsperity = PinballModel.instance.maxProsperity

		PinballModel.instance:initData(msg.info)

		preData.nextScore = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
		preData.nextComplaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
		preData.nextMaxProsperity = PinballModel.instance.maxProsperity

		ViewMgr.instance:openView(ViewName.PinballDayEndView, preData)
	end
end

function Activity178Rpc:sendAct178Rest(activityId)
	local req = Activity178Module_pb.Act178RestRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveAct178RestReply(resultCode, msg)
	if resultCode == 0 then
		PinballModel.instance.oper = PinballEnum.OperType.Rest

		PinballController.instance:dispatchEvent(PinballEvent.OperChange)
		ViewMgr.instance:openView(ViewName.PinballRestLoadingView)
	end
end

function Activity178Rpc:sendAct178Reset(activityId)
	local req = Activity178Module_pb.Act178ResetRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveAct178ResetReply(resultCode, msg)
	if resultCode == 0 then
		GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
		MessageBoxController.instance:clearOption(MessageBoxIdDefine.PinballRestConfirm, MsgBoxEnum.optionType.NotShow)
		PinballModel.instance:initData(msg.info)
	end
end

function Activity178Rpc:sendAct178UnlockTalent(activityId, talentId, callback, callobj)
	local req = Activity178Module_pb.Act178UnlockTalentRequest()

	req.activityId = activityId
	req.talentId = talentId

	return self:sendMsg(req, callback, callobj)
end

function Activity178Rpc:onReceiveAct178UnlockTalentReply(resultCode, msg)
	if resultCode == 0 then
		PinballModel.instance:unlockTalent(msg.talentId)
		PinballController.instance:dispatchEvent(PinballEvent.LearnTalent)
	end
end

function Activity178Rpc:sendAct178Build(activityId, configId, oper, index)
	local req = Activity178Module_pb.Act178BuildRequest()

	req.activityId = activityId
	req.configId = configId
	req.oper = oper
	req.index = index

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveAct178BuildReply(resultCode, msg)
	if resultCode == 0 then
		if msg.oper == PinballEnum.BuildingOperType.Build then
			PinballModel.instance:addBuilding(msg.configId, msg.index)
		elseif msg.oper == PinballEnum.BuildingOperType.Upgrade then
			PinballModel.instance:upgradeBuilding(msg.index)
		else
			PinballModel.instance:removeBuilding(msg.index)
		end

		PinballController.instance:dispatchEvent(PinballEvent.OperBuilding)
	end
end

function Activity178Rpc:sendAct178GetReward(activityId, buildingIndex, callback, callobj)
	local req = Activity178Module_pb.Act178GetRewardRequest()

	req.activityId = activityId
	req.buildingIndex = buildingIndex

	return self:sendMsg(req, callback, callobj)
end

function Activity178Rpc:onReceiveAct178GetRewardReply(resultCode, msg)
	if resultCode == 0 then
		if msg.buildingIndex == 0 then
			for _, buildingMo in pairs(PinballModel.instance._buildingInfo) do
				buildingMo.food = 0
			end
		else
			local info = PinballModel.instance:getBuildingInfo(msg.buildingIndex)

			if info then
				info.food = 0
			end
		end

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio5)
		PinballController.instance:dispatchEvent(PinballEvent.GetReward, msg.buildingIndex)
	end
end

function Activity178Rpc:sendAct178Interact(activityId, buildingIndex, callback, callobj)
	local req = Activity178Module_pb.Act178InteractRequest()

	req.activityId = activityId
	req.buildingIndex = buildingIndex

	return self:sendMsg(req, callback, callobj)
end

function Activity178Rpc:onReceiveAct178InteractReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity178Rpc:sendAct178GuideAddGrain(activityId)
	local req = Activity178Module_pb.Act178GuideAddGrainRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity178Rpc:onReceiveAct178GuideAddGrainReply(resultCode, msg)
	if resultCode == 0 then
		PinballModel.instance.isGuideAddGrain = true
	end
end

function Activity178Rpc:onReceiveAct178CurrencyChangePush(resultCode, msg)
	if resultCode == 0 then
		PinballModel.instance:onCurrencyChange(msg.currencys)
		PinballController.instance:dispatchEvent(PinballEvent.OnCurrencyChange)
	end
end

Activity178Rpc.instance = Activity178Rpc.New()

return Activity178Rpc
