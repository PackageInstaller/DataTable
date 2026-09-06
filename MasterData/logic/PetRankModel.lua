-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/model/rank/PetRankModel.lua

module("logic.extensions.handbook.model.rank.PetRankModel", package.seeall)

local PetRankModel = class("PetRankModel", BaseModel)

PetRankModel.RankType_1 = 1
PetRankModel.RankType_2 = 2
PetRankModel.RankType_3 = 3
PetRankModel.RankType_4 = 4
PetRankModel.RankType_5 = 5
PetRankModel.RankType_6 = 6
PetRankModel._CheckOpenKey = {
	[PetRankModel.RankType_1] = "hasZdlRank",
	[PetRankModel.RankType_2] = "hasZdlRank",
	[PetRankModel.RankType_3] = "hasExZdlRank",
	[PetRankModel.RankType_4] = "hasExZdlRank",
	[PetRankModel.RankType_5] = "hasGainRank",
	[PetRankModel.RankType_6] = "hasGainRank"
}
PetRankModel._ServerParams = {
	[PetRankModel.RankType_1] = {
		sRT = "zdl_rank",
		sST = 1
	},
	[PetRankModel.RankType_2] = {
		sRT = "zdl_rank",
		sST = 2
	},
	[PetRankModel.RankType_3] = {
		sRT = "ex_zdl_rank",
		sST = 1
	},
	[PetRankModel.RankType_4] = {
		sRT = "ex_zdl_rank",
		sST = 2
	},
	[PetRankModel.RankType_5] = {
		sRT = "gain_rank",
		sST = 1
	},
	[PetRankModel.RankType_6] = {
		sRT = "gain_rank",
		sST = 2
	}
}
PetRankModel.RANK_PRIZE_COMMON_ID = 1
PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID = 2

function PetRankModel:ctor()
	PetRankModel.super.ctor(self)

	self._queryingRankType = nil
	self._queryingRaceId = nil
	self._cacheRankRedPointData = nil
	self._cacheTopRankRedPointData = nil
	self._cacheRankRedPointCount = nil
end

function PetRankModel:onInit()
	PetRankModel.super.onInit(self)
end

function PetRankModel:onReset()
	PetRankModel.super.onReset(self)
end

function PetRankModel:queryRank(rankType, raceId, showNum, bWithKudos)
	showNum = showNum or 100
	bWithKudos = bWithKudos or false

	local params = PetRankModel._ServerParams[rankType]

	PetManualAgent.instance:sendGetRaceZdlRankReq(raceId, params.sRT, params.sST, showNum, bWithKudos)
end

function PetRankModel:kudos(rankType, raceId, userId, handler, handlerObj, errHandler)
	local params = PetRankModel._ServerParams[rankType]

	PetManualAgent.instance:sendRaceRankKudosReq(raceId, params.sRT, params.sST, userId, handler, handlerObj, errHandler)
end

function PetRankModel:handleGainRankPrize(...)
	PowerCheckModel.instance.bHasGainPrize = true
end

function PetRankModel:gainReward(rankType, raceId, handler, handlerObj, errHandler)
	local params = PetRankModel._ServerParams[rankType]

	PetManualAgent.instance:sendGainRankPrizeReq(raceId, params.sRT, params.sST, handler, handlerObj, errHandler)
end

function PetRankModel:getRankData(rankType, raceId)
	local tModel = PowerCheckModel.instance

	return tModel.rankList, tModel.myRank, tModel.bHasGainPrize, tModel.rankSize
end

function PetRankModel:getPetRankConfsByRankType(rankType)
	local allPet = HandbookConfig.instance:getPetRankConfs().dataList
	local key = PetRankModel._CheckOpenKey[rankType]
	local result = {}

	for i = #allPet, 1, -1 do
		local conf = allPet[i]

		if not string.nilorempty(key) and conf[key] == true then
			table.insert(result, conf)
		end
	end

	return result
end

local json = require("cjson")

function PetRankModel.parseJsonWithoutThrowError(str)
	if not string.nilorempty(str) then
		return json.decode(str)
	end
end

local RankOnceKey = "PetRankModel_Rank"
local TopRankOnceKey = "PetRankModel_TopRank"

function PetRankModel:_resetRedPoint()
	GameUtil.whenLocalDataInited(function(...)
		self:_doInitRedPoint()
	end)
end

function PetRankModel:_doInitRedPoint()
	self._cacheRankRedPointCount = {}
	self._cacheRankRedPointData = GameUtil.getUserData(RankOnceKey) or {}
	self._cacheTopRankRedPointData = GameUtil.getUserData(TopRankOnceKey) or {}

	local tabConfs = HandbookConfig.instance:getPetRankTabConfs()
	local petConfs = HandbookConfig.instance:getPetRankConfs()

	self._tabConfMap = {}

	for i = 1, #tabConfs do
		local tabConf = tabConfs[i]

		if tabConf.bNeedRedDot then
			for _, petConf in ipairs(petConfs) do
				local key = PetRankModel._CheckOpenKey[tabConf.rankType]

				if not string.nilorempty(key) and petConf[key] == true and petConf.bNeedRedDot == true then
					local RankRedPointkey = self:getRankRedPointKey(tabConf.rankType, petConf.raceId)
					local isRed = self:isRaceIdOnceRed(tabConf.rankType, petConf.raceId)

					if isRed then
						if not self._cacheRankRedPointCount[tabConf.rankType] then
							local count = 0

							count = self._cacheRankRedPointCount[tabConf.rankType] + 1
							self._cacheRankRedPointCount[tabConf.rankType] = self._cacheRankRedPointCount[tabConf.rankType]
						end
					end

					RedPointController.instance:setRedPointInfo(RankRedPointkey, isRed)
				end
			end
		end

		self._tabConfMap[tabConf.rankType] = tabConf.bNeedRedDot
	end

	for _, petConf in ipairs(petConfs) do
		local TopRankRedPointkey = self:getTopRankRedPointKey(petConf.raceId)

		RedPointController.instance:setRedPointInfo(TopRankRedPointkey, self:isTopRaceIdOnceRed(petConf.raceId))
	end

	for i = 1, #tabConfs do
		local tabConf = tabConfs[i]

		if tabConf.bNeedRedDot then
			local bRed = self:isTabOnceRed(tabConf.rankType)
			local RankRedTabPointkey = self:getRankTabRedPointKey(tabConf.rankType)

			RedPointController.instance:setRedPointInfo(RankRedTabPointkey, bRed)
		end
	end

	self:checkMainRed()
end

function PetRankModel:checkMainRed()
	local tabConfs = HandbookConfig.instance:getPetRankTabConfs()
	local bAnyRed = false

	for i = 1, #tabConfs do
		local tabConf = tabConfs[i]

		if tabConf.bNeedRedDot then
			local bRed = self:isTabOnceRed(tabConf.rankType)

			if bRed then
				bAnyRed = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PET_RANK, bAnyRed)
end

function PetRankModel:getRankRedPointKey(rankType, raceId)
	return (string.format("%s%d_%d", RedPointModel.ID_PET_RANK_PRE, rankType, raceId))
end

function PetRankModel:getTopRankRedPointKey(raceId)
	return (string.format("%s%d", RedPointModel.ID_PET_TOP_RANK_PRE, raceId))
end

function PetRankModel:getRankTabRedPointKey(rankType)
	return (string.format("%s%d", RedPointModel.ID_PET_RANK_TAB_PRE, rankType))
end

function PetRankModel:isRaceIdOnceRed(rankType, raceId)
	return self._cacheRankRedPointData and self._cacheRankRedPointData[string.format("%s_%s", rankType, raceId)] ~= true
end

function PetRankModel:isTabOnceRed(rankType)
	if self._cacheRankRedPointCount then
		if not self._cacheRankRedPointCount[rankType] then
			local count = 0

			return count > 0
		end
	end

	return false
end

function PetRankModel:saveRaceIdOnceRed(rankType, raceId)
	if not self._tabConfMap[rankType] then
		return
	end

	if self:isRaceIdOnceRed(rankType, raceId) then
		if not self._cacheRankRedPointCount[rankType] then
			local count = 0

			count = count - 1
			self._cacheRankRedPointCount[rankType] = count

			local RankRedTabPointkey = self:getRankTabRedPointKey(rankType)

			RedPointController.instance:setRedPointInfo(RankRedTabPointkey, count > 0)
			self:checkMainRed()
		end
	end

	self._cacheRankRedPointData[string.format("%s_%s", rankType, raceId)] = true

	local key = self:getRankRedPointKey(rankType, raceId)

	RedPointController.instance:setRedPointInfo(key, false)
	GameUtil.saveUserData(RankOnceKey, self._cacheRankRedPointData)
end

function PetRankModel:isTopRaceIdOnceRed(raceId)
	return self._cacheTopRankRedPointData and self._cacheTopRankRedPointData[tostring(raceId)] ~= true
end

function PetRankModel:saveTopRaceIdOnceRed(raceId)
	self._cacheTopRankRedPointData[tostring(raceId)] = true

	local key = self:getTopRankRedPointKey(raceId)

	RedPointController.instance:setRedPointInfo(key, false)
	GameUtil.saveUserData(TopRankOnceKey, self._cacheTopRankRedPointData)
end

PetRankModel.instance = PetRankModel.New()

return PetRankModel
