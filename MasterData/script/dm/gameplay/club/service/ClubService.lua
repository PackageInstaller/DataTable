-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/service/ClubService.lua

ClubService = class("ClubService", Service, _M)

local opType = {
	OPCODE_CLUB_GET_VILLAGE_INFO = 12312,
	CLUBBOSSUPDATETEAM = 12310,
	OPCODE_CLUB_FINISH_BATTLE = 12306,
	OPCODE_CLUB_BOSS_SET_TIP_READ_TIME = 12308,
	OPCODE_CLUB_OPEN_BOSS = 12303,
	OPCODE_CLUB_START_BATTLE = 12305
}

function ClubService:initialize()
	super.initialize(self)
end

function ClubService:dispose()
	super.dispose(self)
end

function ClubService:requestUpdateTeam(params, callback, blockUI)
	local request = self:newRequest(opType.CLUBBOSSUPDATETEAM, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubInfo(params, blockUI, callback)
	local request = self:newRequest(11901, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestApplyList(params, blockUI, callback)
	local request = self:newRequest(11902, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:getOtherPlayerList(params, blockUI, callback)
	local request = self:newRequest(11903, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:searchClub(params, blockUI, callback)
	local request = self:newRequest(11907, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:quickJoinClub(params, blockUI, callback)
	local request = self:newRequest(11905, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:createClub(params, blockUI, callback)
	local request = self:newRequest(11906, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:changeClubHeadImg(params, blockUI, callback)
	local request = self:newRequest(11909, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:quitClub(params, blockUI, callback)
	local request = self:newRequest(11912, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:kickoutPlayer(params, blockUI, callback)
	local request = self:newRequest(11922, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:setWelcomeMsg(params, blockUI, callback)
	local request = self:newRequest(11920, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestAuditList(params, blockUI, callback)
	local request = self:newRequest(11914, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestLogList(params, blockUI, callback)
	local request = self:newRequest(11913, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestApplyEnterClub(params, blockUI, callback)
	local request = self:newRequest(11904, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:changeClubName(params, blockUI, callback)
	local request = self:newRequest(11910, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:changePlayerPos(params, blockUI, callback)
	local request = self:newRequest(11923, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:agreeEnterClubApply(params, blockUI, callback)
	local request = self:newRequest(11915, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:refuseEnterClubApply(params, blockUI, callback)
	local request = self:newRequest(11916, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:getClubThresholdMax(params, blockUI, callback)
	local request = self:newRequest(11917, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:setClubThreshold(params, blockUI, callback)
	local request = self:newRequest(11918, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:changeClubAnnounce(params, blockUI, callback)
	local request = self:newRequest(11911, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:sendRecruitMsg(params, blockUI, callback)
	local request = self:newRequest(11919, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:sendClubMail(params, blockUI, callback)
	local request = self:newRequest(11921, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:cancelJoinClubApply(params, blockUI, callback)
	local request = self:newRequest(11908, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubSimpleInfo(params, blockUI, callback)
	local request = self:newRequest(11924, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestTargetClubInfo(params, blockUI, callback)
	local request = self:newRequest(11925, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestTargetDonationInfo(params, blockUI, callback)
	local request = self:newRequest(12301, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubDonate(params, blockUI, callback)
	local request = self:newRequest(12302, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubOpenBoss(blockUI, callback)
	local request = self:newRequest(opType.OPCODE_CLUB_OPEN_BOSS, {}, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubStartBattle(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_CLUB_START_BATTLE, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubFinishBattle(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_CLUB_FINISH_BATTLE, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:listenPushClubChange(callback)
	self:addPushHandler(1008, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function ClubService:listenPushClubPlayerChange(callback)
	self:addPushHandler(1009, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function ClubService:listenPushClubPosChange(callback)
	self:addPushHandler(1010, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function ClubService:listenPushClubRedPoint(callback)
	self:addPushHandler(1011, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function ClubService:requestClubBossInfo(params, blockUI, callback)
	local request = self:newRequest(12303, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestGainClubBossDayHurtReward(params, blockUI, callback)
	local request = self:newRequest(12304, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestGainClubBossPointReward(params, blockUI, callback)
	local request = self:newRequest(12307, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubBossSetTipReadTime(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_CLUB_BOSS_SET_TIP_READ_TIME, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubBossBlockPointRewardByPonitID(params, blockUI, callback)
	local request = self:newRequest(12309, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubVillageInfo(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_CLUB_GET_VILLAGE_INFO, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubVillageDetail(params, blockUI, callback)
	local request = self:newRequest(12315, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestReopenPack(params, blockUI, callback)
	local request = self:newRequest(12316, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestGetAnnounce(params, blockUI, callback)
	local request = self:newRequest(12317, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestGetBashenRank(params, blockUI, callback)
	local request = self:newRequest(12318, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestOpenNewPack(params, blockUI, callback)
	local request = self:newRequest(12319, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestBashenManualFinish(params, blockUI, callback)
	local request = self:newRequest(12320, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubBattleData(params, blockUI, callback)
	return
end

function ClubService:requestClubBattleReward(params, blockUI, callback)
	local request = self:newRequest(14102, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubBossRecordData(params, blockUI, callback)
	local request = self:newRequest(12311, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestOpenClubVillageData(params, blockUI, callback)
	local request = self:newRequest(12312, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubVillageChangeData(params, blockUI, callback)
	local request = self:newRequest(12313, params, callback)

	self:sendRequest(request, blockUI)
end

function ClubService:requestClubDetailInfoData(params, blockUI, callback)
	local request = self:newRequest(12314, params, callback)

	self:sendRequest(request, blockUI)
end
