-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/Club.lua

ClubPosition = {
	kMember = 4,
	kDeputyProprieter = 2,
	kElite = 3,
	kProprieter = 1,
	kNone = 0
}
ClubRecordType = {
	kFind = 2,
	kApplay = 1,
	kAudit = 4,
	kClubMember = 3,
	kLog = 5
}

require("dm.gameplay.club.model.ClubResourcesBattle")
require("dm.gameplay.club.model.ClubRecordList")
require("dm.gameplay.club.model.ClubRecord")
require("dm.gameplay.club.model.ClubBasisInfo")
require("dm.gameplay.club.model.ClubBoss")
require("dm.gameplay.club.model.ClubMapPositionList")

ClubRecordConfig = {
	record = {
		[ClubRecordType.kApplay] = ClubApplyRecord,
		[ClubRecordType.kFind] = ClubApplyRecord,
		[ClubRecordType.kClubMember] = ClubMemberRecord,
		[ClubRecordType.kAudit] = ClubAuditRecord,
		[ClubRecordType.kLog] = ClubLogRecord
	}
}
Club = class("Club", objectlua.Object, _M)

Club:has("_info", {
	is = "r"
})
Club:has("_applyRecordList", {
	is = "r"
})
Club:has("_findRecordList", {
	is = "r"
})
Club:has("_memberRecordList", {
	is = "r"
})
Club:has("_auditRecordList", {
	is = "r"
})
Club:has("_logRecordList", {
	is = "r"
})
Club:has("_clubTechList", {
	is = "r"
})
Club:has("_curDonateCount", {
	is = "rw"
})
Club:has("_clubMapPositionList", {
	is = "r"
})

function Club:initialize(player)
	super.initialize(self)

	self._info = ClubBasisInfo:new()
	self._applyRecordList = ClubApplyRecordList:new(ClubRecordType.kApplay)
	self._findRecordList = ClubApplyRecordList:new(ClubRecordType.kApplay)
	self._memberRecordList = ClubRecordList:new(ClubRecordType.kClubMember)
	self._auditRecordList = ClubRecordList:new(ClubRecordType.kAudit)
	self._logRecordList = ClubRecordList:new(ClubRecordType.kLog)
	self._clubTechList = ClubTechnologyList:new(self)
	self._clubBossInfo = ClubBoss:new()
	self._activityClubBossInfo = ClubBoss:new()
	self._clubResourcesBattleInfo = ClubResourcesBattle:new()
	self._curDonateCount = 0
	self._clubMapPositionList = ClubMapPositionList:new()
end

function Club:sync(data)
	if data.info then
		self._info:sync(data.info)
	end
end

function Club:syncClubBossBasicInfo(data)
	self._clubBossInfo:syncBasicInfo(data)
end

function Club:syncActivityClubBossBasicInfo(data)
	self._activityClubBossInfo:syncBasicInfo(data)
end

function Club:synchronizeClubBoss(data, type, scoreData)
	if data then
		if type == nil or type == ClubHallType.kBoss then
			self._clubBossInfo:sync(data)
		end

		if type == ClubHallType.kActivityBoss then
			self._activityClubBossInfo:sync(data, scoreData)
		end
	end
end

function Club:getClubBossInfo(type)
	if type and type == ClubHallType.kActivityBoss then
		return self._activityClubBossInfo
	end

	return self._clubBossInfo
end

function Club:synchronizeClubResourcesBattleData(data)
	if data then
		self._clubResourcesBattleInfo:sync(data)
	end
end

function Club:getClubResourcesBattleInfo()
	return self._clubResourcesBattleInfo
end

function Club:synchronizeClubMapPositionListData(data)
	if data then
		self._clubMapPositionList:syncInfo(data)

		return self._clubMapPositionList:isMemberChange()
	end

	return false
end

function Club:setClubVillageChangeCount(data)
	if data then
		self._clubMapPositionList:setClubVillageChangeCount(data)
	end
end
