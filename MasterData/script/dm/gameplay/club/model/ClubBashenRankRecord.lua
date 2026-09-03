-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubBashenRankRecord.lua

ClubBashenRankRecord = class("ClubBashenRankRecord", objectlua.Object, _M)

ClubBashenRankRecord:has("_rank", {
	is = "r"
})
ClubBashenRankRecord:has("_score", {
	is = "r"
})
ClubBashenRankRecord:has("_headImg", {
	is = "r"
})
ClubBashenRankRecord:has("_headFrame", {
	is = "r"
})
ClubBashenRankRecord:has("_playerName", {
	is = "r"
})
ClubBashenRankRecord:has("_rid", {
	is = "r"
})

function ClubBashenRankRecord:initialize()
	super.initialize(self)

	self._rank = 0
	self._score = 0
	self._headImg = ""
	self._headFrame = ""
	self._playerName = ""
end

function ClubBashenRankRecord:synchronize(data)
	if data.rank then
		self._rank = data.rank
	end

	if data.value then
		self._score = data.value
	end

	if data.headImage then
		self._headImg = data.headImage
	end

	if data.headFrame then
		self._headFrame = data.headFrame
	end

	if data.nickname then
		self._playerName = data.nickname
	end

	if data.rid then
		self._rid = data.rid
	end
end

function ClubBashenRankRecord:getRankGemsInfo()
	local scoreRule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShen_RankScoreRule", "content")
	local gemsInfoList = {}
	local leaveScore = self._score

	if scoreRule then
		for k, scoreData in pairs(scoreRule) do
			local gemsNum = math.floor(leaveScore / scoreData.score)

			if gemsNum > 0 then
				leaveScore = leaveScore - scoreData.score * gemsNum

				local gemsInfo = {}

				gemsInfo.gemsNum = gemsNum
				gemsInfo.quality = ConfigReader:getDataByNameIdAndKey("ItemConfig", scoreData.id, "Quality")
				gemsInfoList[#gemsInfoList + 1] = gemsInfo
			end
		end
	end

	return gemsInfoList
end
