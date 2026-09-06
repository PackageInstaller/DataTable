-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/agent/FreeScuffleAgent.lua

module("logic.extensions.freescuffle.agent.FreeScuffleAgent", package.seeall)

local FreeScuffleAgent = class("FreeScuffleAgent", BaseAgent)

function FreeScuffleAgent:sendPM_FreeScuffleGetInfoReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleGetInfoRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleGetInfoRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleGainCoinReq(activityId, blockIds)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleGainCoinReq()

	req.activityId = activityId

	if blockIds then
		for _, v in ipairs(blockIds) do
			req.blockIds:append(v)
		end
	end

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleGainCoinRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleGainCoinRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleUnlockBlockReq(activityId, blockId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleUnlockBlockReq()

	req.activityId = activityId
	req.blockId = blockId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleUnlockBlockRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleUnlockBlockRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleUpgradlePetReq(activityId, raceId, upLevel)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleUpgradlePetReq()

	req.activityId = activityId
	req.raceId = raceId
	req.upLevel = upLevel

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleUpgradlePetRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleUpgradlePetRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleLotteryReq(activityId, lotteryTimes, type)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleLotteryReq()

	req.activityId = activityId
	req.lotteryTimes = lotteryTimes
	req.type = type

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleLotteryRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleLotteryRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleTaskInfoReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleTaskInfoRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleTaskInfoRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleGainTaskPrizeReq(activityId, taskId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleGainTaskPrizeRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleGainTaskPrizeRes(msg)
	end
end

function FreeScuffleAgent:handlePM_FreeScuffleTaskNotifyRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleTaskNotifyRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleScheduleReq(activityId, petScheduleList)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleScheduleReq()

	req.activityId = activityId

	if petScheduleList then
		local info = FreeScuffleExtension_pb.PM_FreeScufflePetSchedule()

		for _, v in ipairs(petScheduleList) do
			info.blockId = v.blockId
			info.raceId = v.raceId

			req.petScheduleList:add():ParseFromString(info:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleScheduleRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleScheduleRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleStartEasterEggGameReq(activityId, clientKey)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleStartEasterEggGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleStartEasterEggGameRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleStartEasterEggGameRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleEndEasterEggGameReq(activityId, clickTimes, encryptedKey)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleEndEasterEggGameReq()

	req.activityId = activityId
	req.clickTimes = clickTimes
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleEndEasterEggGameRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleEndEasterEggGameRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleDeliverPackageReq(activityId, packageId, blockId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleDeliverPackageReq()

	req.activityId = activityId
	req.packageId = packageId
	req.blockId = blockId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleDeliverPackageRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleDeliverPackageRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleRandomEventLotteryReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleRandomEventLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleRandomEventLotteryRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleRandomEventLotteryRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleExitInterfaceReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleExitInterfaceReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleExitInterfaceRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleExitInterfaceRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleGainTaskProgressPrizeReq(activityId, progressId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleGainTaskProgressPrizeReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleGainTaskProgressPrizeRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleGainTaskProgressPrizeRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleResetNextPackageReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleResetNextPackageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleResetNextPackageRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleResetNextPackageRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleEnterInterfaceReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleEnterInterfaceReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleEnterInterfaceRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleEnterInterfaceRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleBattleInfoReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleBattleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleBattleInfoRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleBattleInfoRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleSetFormReq(activityId, form, petSkillList, heroSkill, heroSkillCreepsId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleSetFormReq()

	req.activityId = activityId
	req.form.heroSkill = heroSkill or 0
	req.form.heroSkillCreepsId = heroSkillCreepsId

	req.form.form:ParseFromString(form:SerializeToString())

	if petSkillList then
		for _, v in ipairs(petSkillList) do
			local info = req.petSkillList:add()

			info.creepsId = v.creepsId

			for _, vv in pairs(v.skillIds) do
				info.skillIds:append(vv)
			end
		end
	end

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleSetFormRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleSetFormRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleChangeSkillReq(activityId, petList)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleChangeSkillReq()

	req.activityId = activityId

	if petList then
		for _, v in ipairs(petList) do
			local info = req.petList:add()

			info.creepsId = v.creepsId

			for _, vv in pairs(v.skillIds) do
				info.skillIds:append(vv)
			end
		end
	end

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleChangeSkillRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleChangeSkillRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleMatchReq(activityId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleMatchRes(status, msg)
	FreeScuffleController.instance:handlePM_FreeScuffleMatchRes(status, msg)
end

function FreeScuffleAgent:sendPM_FreeScuffleBattleReq(activityId, form, heroSkill, heroSkillCreepsId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleBattleReq()

	req.activityId = activityId
	req.form.heroSkill = heroSkill or 0
	req.form.heroSkillCreepsId = heroSkillCreepsId

	req.form.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleBattleRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleBattleRes(msg)
	end
end

function FreeScuffleAgent:sendPM_FreeScuffleRankViewReq(activityId, rankId)
	local req = FreeScuffleExtension_pb.PM_FreeScuffleRankViewReq()

	req.activityId = activityId
	req.rankId = rankId

	self:sendMsg(req)
end

function FreeScuffleAgent:handlePM_FreeScuffleRankViewRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleRankViewRes(msg)
	end
end

function FreeScuffleAgent:handlePM_FreeScuffleBattleNotifyRes(status, msg)
	if status == 0 then
		FreeScuffleController.instance:handlePM_FreeScuffleBattleNotifyRes(msg)
	end
end

FreeScuffleAgent.instance = FreeScuffleAgent.New()

return FreeScuffleAgent
