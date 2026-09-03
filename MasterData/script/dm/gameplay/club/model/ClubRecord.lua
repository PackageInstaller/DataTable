-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubRecord.lua

ClubAuditType = {
	kClose = 2,
	kFreeOpen = 0,
	kLimitCondition = 1
}
ApplyClubState = {
	kHas = 1,
	kNotHas = 0
}
ClubMemberOnLineState = {
	kOnline = 1,
	kOffline = 0
}
ClubMemberFriendState = {
	kFriend = 1,
	kNotFriend = 0
}
ClubAuditCondiRecord = class("ClubAuditCondiRecord", objectlua.Object, _M)

ClubAuditCondiRecord:has("_type", {
	is = "r"
})
ClubAuditCondiRecord:has("_level", {
	is = "r"
})
ClubAuditCondiRecord:has("_combat", {
	is = "r"
})

function ClubAuditCondiRecord:initialize()
	super.initialize(self)

	self._level = 0
	self._combat = 0
	self._type = ClubAuditType.kClose
end

function ClubAuditCondiRecord:synchronize(data)
	if data.type then
		self._type = data.type
	end

	if data.level then
		self._level = data.level
	end

	if data.combat then
		self._combat = data.combat
	end
end

ClubMemberBasisRecord = class("ClubMemberBasisRecord", objectlua.Object, _M)

ClubMemberBasisRecord:has("_rank", {
	is = "r"
})
ClubMemberBasisRecord:has("_headId", {
	is = "r"
})
ClubMemberBasisRecord:has("_headFrame", {
	is = "r"
})
ClubMemberBasisRecord:has("_name", {
	is = "r"
})
ClubMemberBasisRecord:has("_level", {
	is = "r"
})
ClubMemberBasisRecord:has("_combat", {
	is = "r"
})
ClubMemberBasisRecord:has("_team", {
	is = "r"
})
ClubMemberBasisRecord:has("_slogan", {
	is = "rw"
})
ClubMemberBasisRecord:has("_vip", {
	is = "r"
})
ClubMemberBasisRecord:has("_rid", {
	is = "r"
})
ClubMemberBasisRecord:has("_gender", {
	is = "rw"
})
ClubMemberBasisRecord:has("_birthday", {
	is = "rw"
})
ClubMemberBasisRecord:has("_city", {
	is = "rw"
})
ClubMemberBasisRecord:has("_tags", {
	is = "rw"
})
ClubMemberBasisRecord:has("_leadStageId", {
	is = "rw"
})
ClubMemberBasisRecord:has("_leadStageLevel", {
	is = "rw"
})
ClubMemberBasisRecord:has("_title", {
	is = "rw"
})

function ClubMemberBasisRecord:initialize(player)
	super.initialize(self)

	self._rank = 0
	self._headId = ""
	self._headFrame = ""
	self._name = "null"
	self._level = 0
	self._combat = 0
	self._team = {}
	self._slogan = ""
	self._vip = 0
	self._rid = ""
	self._leadStageId = ""
	self._leadStageLevel = 0
	self._title = ""
end

function ClubMemberBasisRecord:synchronize(data)
	if data.rank then
		self._rank = data.rank
	end

	if data.headImage then
		self._headId = data.headImage
	end

	if data.headFrame then
		self._headFrame = data.headFrame
	end

	if data.rid then
		self._rid = data.rid
	end

	if data.level then
		self._level = data.level
	end

	if data.nickname then
		self._name = data.nickname
	end

	if data.vip then
		self._vip = data.vip
	end

	if data.combat then
		self._combat = data.combat
	end

	if data.slogan then
		self._slogan = Strings:get(data.slogan)
	end

	if data.gender then
		self._gender = data.gender
	end

	if data.birthday then
		self._birthday = data.birthday
	end

	if data.city then
		self._city = data.city
	end

	if data.tags then
		self._tags = data.tags
	end

	if data.leadStageId then
		self._leadStageId = data.leadStageId
	end

	if data.leadStageLevel then
		self._leadStageLevel = data.leadStageLevel
	end

	if data.title then
		self._title = data.title
	end
end

ClubApplyRecord = class("ClubApplyRecord", objectlua.Object, _M)

ClubApplyRecord:has("_rank", {
	is = "r"
})
ClubApplyRecord:has("_clubImg", {
	is = "r"
})
ClubApplyRecord:has("_memberCount", {
	is = "rw"
})
ClubApplyRecord:has("_memberLimitCount", {
	is = "r"
})
ClubApplyRecord:has("_clubName", {
	is = "r"
})
ClubApplyRecord:has("_clubLevel", {
	is = "r"
})
ClubApplyRecord:has("_applayState", {
	is = "rw"
})
ClubApplyRecord:has("_propHeadImg", {
	is = "r"
})
ClubApplyRecord:has("_headFrame", {
	is = "r"
})
ClubApplyRecord:has("_propName", {
	is = "r"
})
ClubApplyRecord:has("_propManifesto", {
	is = "r"
})
ClubApplyRecord:has("_auditCondition", {
	is = "r"
})
ClubApplyRecord:has("_clubId", {
	is = "r"
})
ClubApplyRecord:has("_propLevel", {
	is = "r"
})
ClubApplyRecord:has("_propVipLevel", {
	is = "r"
})
ClubApplyRecord:has("_propRid", {
	is = "r"
})
ClubApplyRecord:has("_propCombat", {
	is = "r"
})
ClubApplyRecord:has("_heros", {
	is = "r"
})
ClubApplyRecord:has("_master", {
	is = "r"
})
ClubApplyRecord:has("_slogan", {
	is = "r"
})
ClubApplyRecord:has("_propGender", {
	is = "rw"
})
ClubApplyRecord:has("_propBirthday", {
	is = "rw"
})
ClubApplyRecord:has("_propCity", {
	is = "rw"
})
ClubApplyRecord:has("_propTags", {
	is = "rw"
})
ClubApplyRecord:has("_leadStageId", {
	is = "rw"
})
ClubApplyRecord:has("_leadStageLevel", {
	is = "rw"
})

function ClubApplyRecord:initialize(player)
	super.initialize(self)

	self._applayState = ApplyClubState.kHas
	self._rank = -1
	self._clubImg = ""
	self._memberCount = 0
	self._memberLimitCount = 0
	self._clubName = ""
	self._clubLevel = 0
	self._propCombat = 0
	self._propHeadImg = ""
	self._headFrame = ""
	self._propName = ""
	self._propVipLevel = 0
	self._propManifesto = ""
	self._propRid = ""
	self._auditCondition = ClubAuditCondiRecord:new()
	self._clubId = ""
	self._slogan = ""
	self._propLevel = 0
	self._heros = {}
	self._master = {}
	self._leadStageId = ""
	self._leadStageLevel = 0
end

function ClubApplyRecord:synchronize(data)
	if data.state then
		self._limitState = data.state
	end

	if data.announce then
		self._slogan = data.announce
	end

	if data.presidentLevel then
		self._propLevel = data.presidentLevel
	end

	if data.presidentCombat then
		self._propCombat = data.presidentCombat
	end

	if data.heros then
		self._heros = data.presidentHeroes
	end

	if data.presidentMasterId then
		self._master = data.presidentMasterId
	end

	if data.president then
		self._propRid = data.president
	end

	if data.presidentVip then
		self._propVipLevel = data.presidentVip
	end

	if data.isApply then
		self._applayState = data.isApply
	end

	if data.clubId then
		self._clubId = data.clubId
	end

	if data.threshold then
		self._auditCondition:synchronize(data.threshold)
	end

	if data.rank then
		self._rank = data.rank
	end

	if data.headImg then
		self._clubImg = data.headImg
	end

	if data.playerCount then
		self._memberCount = data.playerCount
	end

	if data.playerMax then
		self._memberLimitCount = data.playerMax
	end

	if data.clubName then
		self._clubName = data.clubName
	end

	if data.level then
		self._clubLevel = data.level
	end

	if data.presidentImg then
		self._propHeadImg = data.presidentImg
	end

	if data.presidentHeadFrame then
		self._headFrame = data.presidentHeadFrame
	end

	if data.presidentName then
		self._propName = data.presidentName
	end

	if data.presidentSlogan then
		self._propManifesto = Strings:get(data.presidentSlogan)
	end

	if data.presidentHeroes then
		self._heros = data.presidentHeroes
	end

	if data.presidentGender then
		self._propGender = data.presidentGender
	end

	if data.presidentBirthday then
		self._propBirthday = data.presidentBirthday
	end

	if data.presidentCity then
		self._propCity = data.presidentCity
	end

	if data.presidentTags then
		self._propTags = data.presidentTags
	end

	if data.leadStageId then
		self._leadStageId = data.leadStageId
	end

	if data.leadStageLevel then
		self._leadStageLevel = data.leadStageLevel
	end
end

ClubMemberRecord = class("ClubMemberRecord", ClubMemberBasisRecord, _M)

ClubMemberRecord:has("_position", {
	is = "r"
})
ClubMemberRecord:has("_lastOnlineTime", {
	is = "r"
})
ClubMemberRecord:has("_contribution", {
	is = "r"
})
ClubMemberRecord:has("_isOnline", {
	is = "r"
})
ClubMemberRecord:has("_friendState", {
	is = "r"
})
ClubMemberRecord:has("_heroes", {
	is = "r"
})
ClubMemberRecord:has("_master", {
	is = "r"
})
ClubMemberRecord:has("_dayContribution", {
	is = "r"
})
ClubMemberRecord:has("_joinDay", {
	is = "r"
})
ClubMemberRecord:has("_lastWeekCon", {
	is = "r"
})
ClubMemberRecord:has("_joinTime", {
	is = "r"
})
ClubMemberRecord:has("_todayCon", {
	is = "r"
})
ClubMemberRecord:has("_clubId", {
	is = "r"
})
ClubMemberRecord:has("_slogan", {
	is = "r"
})
ClubMemberRecord:has("_isFriend", {
	is = "r"
})

function ClubMemberRecord:initialize(player)
	super.initialize(self)

	self._state = ApplyClubState.kNotHas
	self._rank = -1
	self._level = 0
	self._position = ClubPosition.kMember
	self._contribution = 0
	self._isOnline = ClubMemberOnLineState.kOffline
	self._lastOnlineTime = 0
	self._friendState = ClubMemberFriendState.kNotFriend
	self._heroes = {}
	self._master = {}
	self._dayContribution = 0
	self._joinDay = 0
	self._lastWeekCon = 0
	self._todayCon = 0
	self._clubId = ""
	self._slogan = ""
end

function ClubMemberRecord:synchronize(data)
	super.synchronize(self, data)

	if data.state then
		self._state = data.state
	end

	if data.heroes then
		self._heroes = data.heroes
	end

	if data.master then
		self._master = data.master
	end

	if data.slogan then
		self._slogan = data.slogan
	end

	if data.joinTime then
		self._joinTime = data.joinTime
	end

	if data.clubId then
		self._clubId = data.clubId
	end

	if data.todayCon then
		self._todayCon = data.todayCon
	end

	if data.rank then
		self._rank = data.rank
	end

	if data.joinDay then
		self._joinDay = data.joinDay
	end

	if data.dayContribution then
		self._dayContribution = data.dayContribution
	end

	if data.isFriend then
		self._friendState = data.isFriend
	end

	if data.level then
		self._level = data.level
	end

	if data.position then
		self._position = data.position
	end

	if data.lastWeekCon then
		self._lastWeekCon = data.lastWeekCon
	end

	if data.contribution then
		self._contribution = data.contribution
	end

	if data.online then
		self._isOnline = data.online
	end

	if data.lastOffTime then
		self._lastOnlineTime = data.lastOffTime
	end
end

ClubAuditRecord = class("ClubAuditRecord", ClubMemberBasisRecord, _M)

ClubAuditRecord:has("_applyTime", {
	is = "r"
})

function ClubAuditRecord:initialize(player)
	super.initialize(self)

	self._time = 0
end

function ClubAuditRecord:synchronize(data)
	super.synchronize(self, data)

	if data.applyTime then
		self._applyTime = data.applyTime
	end
end

ClubLogRecord = class("ClubLogRecord", objectlua.Object, _M)

ClubLogRecord:has("_time", {
	is = "r"
})
ClubLogRecord:has("_customData", {
	is = "r"
})
ClubLogRecord:has("_logConfigId", {
	is = "r"
})
ClubLogRecord:has("_timeStr", {
	is = "r"
})
ClubLogRecord:has("_dateStr", {
	is = "r"
})

function ClubLogRecord:initialize(player)
	super.initialize(self)

	self._customData = nil
	self._timeStr = ""
	self._dateStr = ""
	self._logConfigId = ""
end

function ClubLogRecord:synchronize(data)
	if data.time then
		self._time = data.time
		self._dateStr = TimeUtil:localDate(Strings:get("Club_Text176"), data.time / 1000)
		self._timeStr = TimeUtil:localDate(Strings:get("Club_Text177"), data.time / 1000)
	end

	if data.customData then
		self._customData = data.customData
	end

	if data.logConfigId then
		self._logConfigId = data.logConfigId
	end
end

ClubTechPoint = class("ClubTechPoint", objectlua.Object, _M)

ClubTechPoint:has("_pointId", {
	is = "r"
})
ClubTechPoint:has("_level", {
	is = "r"
})
ClubTechPoint:has("_exp", {
	is = "r"
})
ClubTechPoint:has("_config", {
	is = "r"
})
ClubTechPoint:has("_donationList", {
	is = "rw"
})

function ClubTechPoint:initialize(pointId)
	super.initialize(self)

	self._pointId = pointId
	self._config = ConfigReader:getRecordById("ClubTechnologyPoint", pointId)
	self._level = 1
	self._exp = 0
	self._donationList = {}

	local donationIdList = ConfigReader:getKeysOfTable("ClubDonation")

	for i = 1, #donationIdList do
		local donationId = donationIdList[i]

		self._donationList[#self._donationList + 1] = ClubDonation:new(donationId)
	end

	table.sort(self._donationList, function(a, b)
		return a:getOrder() < b:getOrder()
	end)
end

function ClubTechPoint:synchronize(data)
	if data.level then
		self._level = data.level
	end

	if data.exp then
		self._exp = data.exp
	end
end

function ClubTechPoint:getUnlockCondition()
	return self._config.Unlock
end

function ClubTechPoint:getMaxLevel()
	return self._config.MaxLevel
end

function ClubTechPoint:getIcon()
	return self._config.Icon
end

function ClubTechPoint:getName()
	return Strings:get(self._config.Name)
end

function ClubTechPoint:getUpgradeExp()
	local expList = self._config.Exp

	return expList[self._level] or expList[#expList]
end

function ClubTechPoint:getDescByIndex(index)
	local key = "Desc" .. index

	return self._config[key]
end

function ClubTechPoint:getDescValue(index, level)
	local key = "Value" .. index
	local values = self._config[key]

	return values[level] or -1
end

ClubDonation = class("ClubDonation", objectlua.Object, _M)

ClubDonation:has("_config", {
	is = "r"
})
ClubDonation:has("_id", {
	is = "r"
})

function ClubDonation:initialize(donationId)
	super.initialize(self)

	self._id = donationId
	self._config = ConfigReader:getRecordById("ClubDonation", donationId)
end

function ClubDonation:getType()
	return self._config.Type
end

function ClubDonation:getDemand()
	return self._config.Demand
end

function ClubDonation:getClubExp()
	return self._config.ClubExp
end

function ClubDonation:getName()
	return self._config.Name
end

function ClubDonation:getReward()
	return self._config.Reward
end

function ClubDonation:getVipLimit()
	return self._config.Vip_limited
end

function ClubDonation:getBoardIcon()
	return self._config.BoardIcon
end

function ClubDonation:getOrder()
	return self._config.Order
end
