-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/agent/LotusBattleFieldAgent.lua

module("logic.extensions.lotusbattlefield.agent.LotusBattleFieldAgent", package.seeall)

local LotusBattleFieldAgent = class("LotusBattleFieldAgent", BaseAgent)

LotusBattleFieldAgent.LBFInfoRes = "LotusBattleFieldAgent.LBFInfoRes"
LotusBattleFieldAgent.LBFAdjustPackageRes = "LotusBattleFieldAgent.LBFAdjustPackageRes"
LotusBattleFieldAgent.LBFStartMatchRes = "LotusBattleFieldAgent.LBFStartMatchRes"
LotusBattleFieldAgent.LBFCancelMatchRes = "LotusBattleFieldAgent.LBFCancelMatchRes"
LotusBattleFieldAgent.LBFLeaveGameRes = "LotusBattleFieldAgent.LBFLeaveGameRes"
LotusBattleFieldAgent.LBFSelectInitialPetRes = "LotusBattleFieldAgent.LBFSelectInitialPetRes"
LotusBattleFieldAgent.LBFSelectInitialBuffRes = "LotusBattleFieldAgent.LBFSelectInitialBuffRes"
LotusBattleFieldAgent.LBFStartBattleMatchRes = "LotusBattleFieldAgent.LBFStartBattleMatchRes"
LotusBattleFieldAgent.LBFSetFormationRes = "LotusBattleFieldAgent.LBFSetFormationRes"
LotusBattleFieldAgent.LBFSelectBattleBuffRes = "LotusBattleFieldAgent.LBFSelectBattleBuffRes"
LotusBattleFieldAgent.LBFSelectBattleSpoilsRes = "LotusBattleFieldAgent.LBFSelectBattleSpoilsRes"
LotusBattleFieldAgent.LBFSelectSpoilsRes = "LotusBattleFieldAgent.LBFSelectSpoilsRes"
LotusBattleFieldAgent.LBFSimpleBattleRecordRes = "LotusBattleFieldAgent.LBFSimpleBattleRecordRes"
LotusBattleFieldAgent.LBFBattleRecordRes = "LotusBattleFieldAgent.LBFBattleRecordRes"
LotusBattleFieldAgent.LBFGetBattleVideoRes = "LotusBattleFieldAgent.LBFGetBattleVideoRes"
LotusBattleFieldAgent.LBFNotifyMatchingOverTimeRes = "LotusBattleFieldAgent.LBFNotifyMatchingOverTimeRes"
LotusBattleFieldAgent.LBFNotifyMatchFailRes = "LotusBattleFieldAgent.LBFNotifyMatchFailRes"
LotusBattleFieldAgent.LBFNotifyGameStartRes = "LotusBattleFieldAgent.LBFNotifyGameStartRes"
LotusBattleFieldAgent.LBFNotifySelectPetFinishRes = "LotusBattleFieldAgent.LBFNotifySelectPetFinishRes"
LotusBattleFieldAgent.LBFNotifyEnterBattleFieldRes = "LotusBattleFieldAgent.LBFNotifyEnterBattleFieldRes"
LotusBattleFieldAgent.LBFNotifyBattleFieldChangedRes = "LotusBattleFieldAgent.LBFNotifyBattleFieldChangedRes"
LotusBattleFieldAgent.LBFNotifyForceStartMatchRes = "LotusBattleFieldAgent.LBFNotifyForceStartMatchRes"
LotusBattleFieldAgent.LBFNotifyStartBattleRes = "LotusBattleFieldAgent.LBFNotifyStartBattleRes"
LotusBattleFieldAgent.LBFNotifyOpFinishSetFormationRes = "LotusBattleFieldAgent.LBFNotifyOpFinishSetFormationRes"
LotusBattleFieldAgent.LBFNotifyEnterNextSetFormationRes = "LotusBattleFieldAgent.LBFNotifyEnterNextSetFormationRes"
LotusBattleFieldAgent.LBFNotifyEnterSelectBuffRes = "LotusBattleFieldAgent.LBFNotifyEnterSelectBuffRes"
LotusBattleFieldAgent.LBFNotifyFightResultRes = "LotusBattleFieldAgent.LBFNotifyFightResultRes"
LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsOverTimeRes = "LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsOverTimeRes"
LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsSuccessRes = "LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsSuccessRes"
LotusBattleFieldAgent.LBFNotifyGameEndRes = "LotusBattleFieldAgent.LBFNotifyGameEndRes"
LotusBattleFieldAgent.LBFSetFirstStepFormationRes = "LotusBattleFieldAgent.LBFSetFirstStepFormationRes"
LotusBattleFieldAgent.LBFSetSecondStepFormationRes = "LotusBattleFieldAgent.LBFSetSecondStepFormationRes"
LotusBattleFieldAgent.LBFUnlockPackagePosRes = "LotusBattleFieldAgent.LBFUnlockPackagePosRes"
LotusBattleFieldAgent.SetFormError = "LotusBattleFieldAgent.SetFormError"
LotusBattleFieldAgent.SetFormSuccessed = "LotusBattleFieldAgent.SetFormSuccessed"

function LotusBattleFieldAgent:sendPM_LBFInfoReq(activityId)
	local req = LotusBattleFieldExtension_pb.PM_LBFInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFInfoRes(status, msg)
	if status == 0 then
		LotusbattleModel.instance:setBaseInfo(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFInfoRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFAdjustPackageReq(activityId, creepIds)
	local req = LotusBattleFieldExtension_pb.PM_LBFAdjustPackageReq()

	req.activityId = activityId

	for i, v in ipairs(creepIds) do
		req.creepIds:append(v)
	end

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFAdjustPackageRes(status, msg)
	if status == 0 then
		LotusbattleModel.instance:updateNangCreepIds(msg.creepIds)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFAdjustPackageRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFStartMatchReq(activityId, modelId)
	local req = LotusBattleFieldExtension_pb.PM_LBFStartMatchReq()

	req.activityId = activityId
	req.modelId = modelId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFStartMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFStartMatchRes)
	else
		LotusbattleController.instance:matchFail()
	end
end

function LotusBattleFieldAgent:sendPM_LBFCancelMatchReq(activityId)
	local req = LotusBattleFieldExtension_pb.PM_LBFCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFCancelMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFCancelMatchRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFLeaveGameReq(activityId)
	local req = LotusBattleFieldExtension_pb.PM_LBFLeaveGameReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFLeaveGameRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:leaveGame()
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFLeaveGameRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSelectInitialPetReq(creepsIds)
	local req = LotusBattleFieldExtension_pb.PM_LBFSelectInitialPetReq()

	for i, v in ipairs(creepsIds) do
		req.creepsIds:append(v)
	end

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSelectInitialPetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSelectInitialPetRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSelectInitialBuffReq(buffId)
	local req = LotusBattleFieldExtension_pb.PM_LBFSelectInitialBuffReq()

	req.buffId = buffId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSelectInitialBuffRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSelectInitialBuffRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFStartBattleMatchReq()
	local req = LotusBattleFieldExtension_pb.PM_LBFStartBattleMatchReq()

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFStartBattleMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFStartBattleMatchRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSetFormationReq(form)
	local req = LotusBattleFieldExtension_pb.PM_LBFSetFormationReq()

	req.form = form

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSetFormationRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSetFormationRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSelectBattleBuffReq(buffId)
	local req = LotusBattleFieldExtension_pb.PM_LBFSelectBattleBuffReq()

	req.buffId = buffId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSelectBattleBuffRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSelectBattleBuffRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSelectBattleSpoilsReq(creepsId)
	local req = LotusBattleFieldExtension_pb.PM_LBFSelectBattleSpoilsReq()

	req.creepsId = creepsId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSelectBattleSpoilsRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSelectBattleSpoilsRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSelectSpoilsReq(activityId, creepsIds)
	local req = LotusBattleFieldExtension_pb.PM_LBFSelectSpoilsReq()

	req.activityId = activityId

	for i, v in ipairs(creepsIds) do
		req.creepsIds:append(v)
	end

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSelectSpoilsRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSelectSpoilsRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSimpleBattleRecordReq(activityId)
	local req = LotusBattleFieldExtension_pb.PM_LBFSimpleBattleRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSimpleBattleRecordRes(status, msg)
	if status == 0 then
		local battlerecord = msg.battleRecord

		LotusbattleModel.instance:setRecordInfo(battlerecord)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSimpleBattleRecordRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFBattleRecordReq(activityId, fieldId)
	local req = LotusBattleFieldExtension_pb.PM_LBFBattleRecordReq()

	req.activityId = activityId
	req.fieldId = fieldId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFBattleRecordRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:battleRecordDetailRes(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFBattleRecordRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFGetBattleVideoReq(battleId)
	local req = LotusBattleFieldExtension_pb.PM_LBFGetBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFGetBattleVideoRes(status, msg)
	if status == 0 then
		local battleresult = msg.battleResult

		LotusbattleController.instance:getBattleVideoRes(battleresult)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFGetBattleVideoRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:matchFail()
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyMatchingOverTimeRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyMatchFailRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:matchFail()
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyMatchFailRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyGameStartRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:selectInitBagPets(msg.creepsIds, msg.bagCreepIds)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyGameStartRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifySelectPetFinishRes(status, msg)
	if status == 0 then
		local creepsids = msg.creepsIds
		local bagCreepIds = msg.bagCreepIds

		LotusbattleModel.instance:inserPets(creepsids)
		LotusbattleModel.instance:inserPets(bagCreepIds)
		LotusbattleController.instance:selectBuff(msg.buffIds, true)
		UIStateManager.instance:popByName(ViewName.LotusbattlepetselectView)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifySelectPetFinishRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyEnterBattleFieldRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifyEnterBattleField(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyEnterBattleFieldRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyBattleFieldChangedRes(status, msg)
	if status == 0 then
		local battleField = msg.battleField

		LotusbattleModel.instance:setPrepareBattlefield(battleField)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyBattleFieldChangedRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyForceStartMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyForceStartMatchRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyStartBattleRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifyStartBattle(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyStartBattleRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyOpFinishSetFormationRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyOpFinishSetFormationRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyEnterNextSetFormationRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifyEnterNextSetFormation(msg)
		LotusbattleController.instance:setCanSetFormationFlag(true)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyEnterNextSetFormationRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyEnterSelectBuffRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifyEnterSelectBuff(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyEnterSelectBuffRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyFightResultRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifyFightResult(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyFightResultRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifySelectBattleSpoilsOverTimeRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifySelectBattleSpoils(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsOverTimeRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifyGameEndRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifyGameEndRes(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifyGameEndRes)
	end
end

function LotusBattleFieldAgent:handlePM_LBFNotifySelectBattleSpoilsSuccessRes(status, msg)
	if status == 0 then
		LotusbattleController.instance:notifySelectBattleSpoils(msg)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsSuccessRes)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSetFirstStepFormationReq(form)
	local req = LotusBattleFieldExtension_pb.PM_LBFSetFirstStepFormationReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSetFirstStepFormationRes(status, msg)
	LotusbattleController.instance:setCanSetFormationFlag(status ~= 0)

	if status == 0 then
		FloatWordMgr.instance:show("提交布阵成功")
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSetFirstStepFormationRes)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.SetFormSuccessed)
	else
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.SetFormError)
	end
end

function LotusBattleFieldAgent:sendPM_LBFSetSecondStepFormationReq(form)
	local req = LotusBattleFieldExtension_pb.PM_LBFSetSecondStepFormationReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFSetSecondStepFormationRes(status, msg)
	LotusbattleController.instance:setCanSetFormationFlag(status ~= 0)

	if status == 0 then
		FloatWordMgr.instance:show("提交布阵成功")
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFSetSecondStepFormationRes)
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.SetFormSuccessed)
	else
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.SetFormError)
	end
end

function LotusBattleFieldAgent:sendPM_LBFUnlockPackagePosReq(activityId)
	local req = LotusBattleFieldExtension_pb.PM_LBFUnlockPackagePosReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LotusBattleFieldAgent:handlePM_LBFUnlockPackagePosRes(status, msg)
	if status == 0 then
		LotusbattleModel.instance:unlockPackage()
		GlobalDispatcher:dispatch(LotusBattleFieldAgent.LBFUnlockPackagePosRes)
	end
end

LotusBattleFieldAgent.instance = LotusBattleFieldAgent.New()

return LotusBattleFieldAgent
