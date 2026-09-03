-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/model/Friend.lua

Friend = class("Friend", objectlua.Object, _M)

Friend:has("_rid", {
	is = "rw"
})
Friend:has("_nickName", {
	is = "rw"
})
Friend:has("_level", {
	is = "rw"
})
Friend:has("_combat", {
	is = "rw"
})
Friend:has("_lastOfflineTime", {
	is = "rw"
})
Friend:has("_online", {
	is = "rw"
})
Friend:has("_vipLevel", {
	is = "rw"
})
Friend:has("_unionName", {
	is = "rw"
})
Friend:has("_remark", {
	is = "rw"
})
Friend:has("_canSend", {
	is = "rw"
})
Friend:has("_canReceive", {
	ris = "rw"
})
Friend:has("_headId", {
	is = "rw"
})
Friend:has("_headFrame", {
	is = "rw"
})
Friend:has("_applyTime", {
	is = "rw"
})
Friend:has("_recommendType", {
	is = "rw"
})
Friend:has("_recommendFactor", {
	is = "rw"
})
Friend:has("_familiarity", {
	is = "rw"
})
Friend:has("_unReadMsgCount", {
	is = "rw"
})
Friend:has("_heroes", {
	is = "rw"
})
Friend:has("_master", {
	is = "rw"
})
Friend:has("_slogan", {
	is = "rw"
})
Friend:has("_gender", {
	is = "rw"
})
Friend:has("_birthday", {
	is = "rw"
})
Friend:has("_city", {
	is = "rw"
})
Friend:has("_tags", {
	is = "rw"
})
Friend:has("_leadStageId", {
	is = "rw"
})
Friend:has("_leadStageLevel", {
	is = "rw"
})
Friend:has("_totalStar", {
	is = "rw"
})
Friend:has("_totalHeroes", {
	is = "rw"
})
Friend:has("_totalSurface", {
	is = "rw"
})
Friend:has("_maxStageLevel", {
	is = "rw"
})
Friend:has("_showHeroes", {
	is = "rw"
})
Friend:has("_rtkpRank", {
	is = "rw"
})
Friend:has("_rtpkScore", {
	is = "rw"
})
Friend:has("_stageArenaRank", {
	is = "rw"
})
Friend:has("_stageArenaScore", {
	is = "rw"
})
Friend:has("_recommendDesc", {
	is = "rw"
})

FriendOnLineState = {
	kOnline = 1,
	kOffline = 0
}

function Friend:initialize()
	super.initialize(self)

	self._rid = 0
	self._nickName = ""
	self._level = 0
	self._combat = 0
	self._lastOfflineTime = 0
	self._online = false
	self._vipLevel = 0
	self._headId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_DefaultProtrait", "content")
	self._heroes = {}
	self._slogan = ""
	self._headFrame = ""
	self._totalStar = 0
	self._totalHeroes = 0
	self._totalSurface = 0
	self._maxStageLevel = 0
	self._showHeroes = {}
	self._rtkpRank = 0
	self._rtpkScore = 0
	self._stageArenaRank = 0
	self._stageArenaScore = 0
end

function Friend:synchronize(data)
	if not data then
		return
	end

	if data.rid or data.id then
		self._rid = data.rid or data.id
	end

	if data.nickname then
		self._nickName = data.nickname

		if data.nickname == "" then
			self._nickName = data.rid
		end
	end

	if data.level then
		self._level = data.level
	end

	if data.combat then
		self._combat = data.combat
	end

	if data.lastOffTime or data.lastOfflineTime or data.offlineTime then
		self._lastOfflineTime = data.lastOffTime or data.lastOfflineTime or data.offlineTime
	end

	if data.online ~= nil then
		self._online = data.online
	end

	if data.vip or data.vipLevel then
		self._vipLevel = data.vip or data.vipLevel
	end

	if data.clubName then
		self._unionName = data.clubName
	end

	if data.remark then
		self._remark = data.remark
	end

	if data.canSend ~= nil then
		self._canSend = data.canSend
	end

	if data.canReceive ~= nil then
		self._canReceive = data.canReceive
	end

	if data.headImage then
		self._headId = data.headImage
	elseif data.headImg then
		self._headId = data.headImg
	elseif data.headId then
		self._headId = data.headId
	end

	if data.headFrame then
		self._headFrame = data.headFrame
	end

	if data.applyTime then
		self._applyTime = data.applyTime
	end

	if data.recommendType then
		self._recommendType = data.recommendType
	end

	if data.recommendFactor then
		self._recommendFactor = data.recommendFactor
	end

	if data.close then
		self._familiarity = data.close
	end

	if data.unReadMsgCount then
		self._unReadMsgCount = data.unReadMsgCount
	end

	if data.heroes then
		self._heroes = data.heroes
	end

	if data.master then
		self._master = data.master
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

	if data.totalStar then
		self._totalStar = data.totalStar
	end

	if data.totalHeroes then
		self._totalHeroes = data.totalHeroes
	end

	if data.totalSurface then
		self._totalSurface = data.totalSurface
	end

	if data.maxStageLevel then
		self._maxStageLevel = data.maxStageLevel
	end

	if data.showHeroes then
		self._showHeroes = data.showHeroes
	end

	if data.rtkpRank then
		self._rtkpRank = data.rtkpRank
	end

	if data._rtpkScore then
		self._rtpkScore = data._rtpkScore
	end

	if data.stageArenaRank then
		self._stageArenaRank = data.stageArenaRank
	end

	if data.stageArenaScore then
		self._stageArenaScore = data.stageArenaScore
	end

	self:setRecommendDesc()
end

function Friend:setRecommendDesc()
	local recommendType = self._recommendType
	local param = self._recommendFactor
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_Recommend_Desc", "content")
	local descId = config[recommendType]

	if recommendType == "" or recommendType == nil then
		random = math.random(1, #config.NoReason)
		descId = config.NoReason[random]
	end

	self._recommendDesc = Strings:get((recommendType == "Level" or nil) and (param == "0" and config[recommendType][2] or config[recommendType][1]), {
		factor = param
	})
end
