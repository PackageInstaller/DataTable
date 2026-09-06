-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/agent/MahjongBattleAgent.lua

module("logic.extensions.mahjongbattle.agent.MahjongBattleAgent", package.seeall)

local MahjongBattleAgent = class("MahjongBattleAgent", BaseAgent)

function MahjongBattleAgent:sendPM_MahjongBattleInfoReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleInfoRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleGetInfoRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleDrawGenreReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleDrawGenreReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleDrawGenreRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleDrawGenreRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleSelectGenreReq(activityId, isRandom, genreId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleSelectGenreReq()

	req.activityId = activityId
	req.isRandom = isRandom
	req.genreId = genreId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleSelectGenreRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleSelectGenreRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleMatchFightReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleMatchFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleMatchFightRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleMatchOpponentRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleCancelMatchReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleCancelMatchRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleFightReq(activityId, form)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleFightReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MahjongBattleAgent:sendPM_MahjongDrawMahjongReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongDrawMahjongReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongDrawMahjongRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleDrawMahjongRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleselectMahjongReq(activityId, selectMahjongId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleselectMahjongReq()

	req.activityId = activityId
	req.selectMahjongId = selectMahjongId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleselectMahjongRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleSelectMahjongRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleDropMahjongReq(activityId, dropMahjongId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleDropMahjongReq()

	req.activityId = activityId
	req.dropMahjongId = dropMahjongId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleDropMahjongRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleDropMahjongRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleSummonReq(activityId, summonType, operaMahjongId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleSummonReq()

	req.activityId = activityId
	req.summonType = summonType

	for i, v1 in ipairs(operaMahjongId) do
		req.operaMahjongId:append(v1)
	end

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleSummonRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleSummonRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleSelectSummonPetReq(activityId, selectSummonPetId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleSelectSummonPetReq()

	req.activityId = activityId

	for i, v1 in ipairs(selectSummonPetId) do
		req.selectSummonPetId:append(v1)
	end

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleSelectSummonPetRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleSelectSummonPetRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleSelectSummonBuffReq(activityId, summonBuffId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleSelectSummonBuffReq()

	req.activityId = activityId
	req.summonBuffId = summonBuffId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleSelectSummonBuffRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleSelectSummonBuffRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleDropPetReq(activityId, dropPetId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleDropPetReq()

	req.activityId = activityId
	req.dropPetId = dropPetId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleDropPetRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleDropPetRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleGiveUpReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleGiveUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleGiveUpRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleGiveUpRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleViewBtlReportReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleViewBtlReportReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleViewBtlReportRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleBtlReportRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleRankViewReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleRankViewRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleRankViewRes(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleRandomCarkLuckReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleRandomCarkLuckReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleRandomCarkLuckRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleRandomCardLuckRes(msg)
	end
end

function MahjongBattleAgent:handlePM_MahjongBattleNotifyFightRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleNotifyFightResult(msg)
	end
end

function MahjongBattleAgent:handlePM_MahjongBattleNotifyDrawMahjongRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleNotifyDrawMahjong(msg)
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleShareBattleResultReq(activityId)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleShareBattleResultReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleShareBattleResultRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MahjongBattleAgent:sendPM_MahjongBattleTeachFightReq(activityId, form_pb)
	local req = MahjongBattleExtension_pb.PM_MahjongBattleTeachFightReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MahjongBattleAgent:handlePM_MahjongBattleTeachFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MahjongBattleAgent:handlePM_MahjongBattleNotifyTeachFightRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleNotifyTeachFightResult(msg)
	end
end

MahjongBattleAgent.instance = MahjongBattleAgent.New()

return MahjongBattleAgent
