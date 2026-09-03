-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubBasisInfo.lua

ClubAuditRedPointState = {
	kNo = 0,
	kYes = 1
}
ClubBasisInfo = class("ClubBasisInfo", objectlua.Object, _M)

ClubBasisInfo:has("_name", {
	is = "rw"
})
ClubBasisInfo:has("_clubId", {
	is = "rw"
})
ClubBasisInfo:has("_level", {
	is = "rw"
})
ClubBasisInfo:has("_rank", {
	is = "rw"
})
ClubBasisInfo:has("_slogan", {
	is = "rw"
})
ClubBasisInfo:has("_icon", {
	is = "rw"
})
ClubBasisInfo:has("_headFrame", {
	is = "rw"
})
ClubBasisInfo:has("_position", {
	is = "rw"
})
ClubBasisInfo:has("_playerCount", {
	is = "rw"
})
ClubBasisInfo:has("_memberCount", {
	is = "rw"
})
ClubBasisInfo:has("_memberLimitCount", {
	is = "rw"
})
ClubBasisInfo:has("_eliteCount", {
	is = "rw"
})
ClubBasisInfo:has("_eliteLimitCount", {
	is = "rw"
})
ClubBasisInfo:has("_dProprieterCount", {
	is = "rw"
})
ClubBasisInfo:has("_dProprieterLimitCount", {
	is = "r"
})
ClubBasisInfo:has("_proprieterName", {
	is = "rw"
})
ClubBasisInfo:has("_sendMailCount", {
	is = "rw"
})
ClubBasisInfo:has("_auditCondition", {
	is = "r"
})
ClubBasisInfo:has("_recruitTime", {
	is = "rw"
})
ClubBasisInfo:has("_welcomeMsg", {
	is = "rw"
})
ClubBasisInfo:has("_selfEditWelMsg", {
	is = "rw"
})
ClubBasisInfo:has("_welcomeIndex", {
	is = "rw"
})
ClubBasisInfo:has("_auditRedPoint", {
	is = "rw"
})
ClubBasisInfo:has("_todayDonation", {
	is = "rw"
})
ClubBasisInfo:has("_lastJoinTime", {
	is = "rw"
})
ClubBasisInfo:has("_battleRank", {
	is = "rw"
})
ClubBasisInfo:has("_joinedClubCount", {
	is = "rw"
})
ClubBasisInfo:has("_lastQuitTime", {
	is = "rw"
})

function ClubBasisInfo:initialize(player)
	super.initialize(self)

	self._auditRedPoint = ClubAuditRedPointState.kNo
	self._name = ""
	self._lastQuitTime = 0
	self._clubId = ""
	self._playerCount = 0
	self._welcomeMsg = ""
	self._selfEditWelMsg = ""
	self._welcomeIndex = 1
	self._level = 0
	self._rank = 0
	self._slogan = ""
	self._position = ClubPosition.kNone
	self._memberCount = 0
	self._memberLimitCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_MemberLimit", "content")
	self._eliteCount = 0
	self._eliteLimitCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Third_Number", "content")
	self._dProprieterCount = 0
	self._dProprieterLimitCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Second_Number", "content")
	self._proprieterName = ""
	self._sendMailCount = 0
	self._auditCondition = ClubAuditCondiRecord:new()
	self._recruitTime = 0
	self._todayDonation = 0
	self._lastJoinTime = 0
	self._battleRank = 0
	self._joinedClubCount = 0
end

function ClubBasisInfo:canAuditMember()
	return self._position == ClubPosition.kProprieter or self._position == ClubPosition.kDeputyProprieter or self._position == ClubPosition.kElite
end

function ClubBasisInfo:sync(data)
	dump(data, "data___ClubBasisInfo")

	if data.lastQuitTime then
		self._lastQuitTime = data.lastQuitTime
	end

	if data.clubName then
		self._name = data.clubName
	end

	if data.threshold then
		self._auditCondition:synchronize(data.threshold)
	end

	if data.lastRecruitTime then
		self._recruitTime = data.lastRecruitTime
	end

	if data.level then
		self._level = data.level
	end

	if data.rank then
		self._rank = data.rank
	end

	if data.presidentName then
		self._proprieterName = data.presidentName
	end

	if data.sendMailCount then
		self._sendMailCount = data.sendMailCount
	end

	if data.announce then
		self._slogan = data.announce
	end

	if data.headImg then
		self._icon = data.headImg
	end

	if data.headFrame then
		self._headFrame = data.headFrame
	end

	if data.playerCount then
		self._playerCount = data.playerCount
	end

	if data.normalCount then
		self._memberCount = data.normalCount
	end

	if data.eliteCount then
		self._eliteCount = data.eliteCount
	end

	if data.dProprieterCount then
		self._dProprieterCount = data.dProprieterCount
	end

	if data.position then
		self._position = data.position
	end

	if data.clubDonation and data.clubDonation.todayDonation then
		self._todayDonation = data.clubDonation.todayDonation
	end

	if data.battleRank then
		self._battleRank = data.battleRank
	end
end
