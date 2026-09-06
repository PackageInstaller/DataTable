-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/model/GroupRedpackModel.lua

module("logic.extensions.groupredpack.model.GroupRedpackModel", package.seeall)

local GroupRedpackModel = class("GroupRedpackModel", BaseModel)

function GroupRedpackModel:ctor()
	return
end

function GroupRedpackModel:onInit()
	self:onReset()
end

function GroupRedpackModel:onReset()
	self._activityId = nil
	self._redpackList = {}
	self._countList = {}
	self._todayConsolationTimes = 0
	self._groupId = -1
	self._popularValue = 0
	self._recordList = {}
	self._rankInfo = {}
	self._petId2ImgPathMap = {}
	self._index2PetIdMap = {}
	self._newRedpackStack = Stack.New()
	self._redpackTipsList = {}
	self._redpackMap = {}

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GROUP_RED_PACK)

	if actCfg then
		self._activityId = actCfg.activityId
	end

	self._prePetIdCache = ""
end

function GroupRedpackModel:getPetId2ImgPathMap(planId, groupId)
	if self._petId2ImgPathMap[groupId] then
		return self._petId2ImgPathMap[groupId]
	end

	self._petId2ImgPathMap[groupId] = self._petId2ImgPathMap[groupId] or {}

	local coverCfgs = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(planId, groupId)
	local coverIds = string.split(coverCfgs.coverIds, ";")
	local adImgPath = string.split(coverCfgs.adImgPath, ";")
	local coverImgPath = string.split(coverCfgs.coverImgPath, ";")
	local num = #coverIds

	for i = 1, num do
		self._petId2ImgPathMap[groupId][coverIds[i]] = self._petId2ImgPathMap[groupId][coverIds[i]] or {}
		self._petId2ImgPathMap[groupId][coverIds[i]].adImgPath = adImgPath[i]
		self._petId2ImgPathMap[groupId][coverIds[i]].coverImgPath = coverImgPath[i]
	end

	return self._petId2ImgPathMap[groupId]
end

function GroupRedpackModel:getIndex2PetIdMap(planId, groupId)
	if self._index2PetIdMap[groupId] then
		return self._index2PetIdMap[groupId]
	end

	self._index2PetIdMap[groupId] = self._index2PetIdMap[groupId] or {}

	local cfgs = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(planId, groupId)
	local coverIds = string.split(cfgs.coverIds, ";")
	local num = #coverIds

	for i = 1, num do
		self._index2PetIdMap[groupId][i] = self._index2PetIdMap[groupId][i] or {}
		self._index2PetIdMap[groupId][i] = coverIds[i]
	end

	return self._index2PetIdMap[groupId]
end

function GroupRedpackModel:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.GROUP_RED_PACK)
end

function GroupRedpackModel:getRedpackList()
	return self._redpackList
end

function GroupRedpackModel:getCountList()
	return self._countList
end

function GroupRedpackModel:getTodayConsolationTimes()
	return self._todayConsolationTimes
end

function GroupRedpackModel:getRecordList()
	return self._recordList
end

function GroupRedpackModel:getRankInfo()
	return self._rankInfo
end

function GroupRedpackModel:getRankInfoById(id)
	if self._rankInfo[id] then
		return self._rankInfo[id]
	end

	return nil
end

function GroupRedpackModel:getRedpackById(id)
	if self._redpackMap[id] then
		return self._redpackMap[id]
	end

	return nil
end

function GroupRedpackModel:getNewRedpackStack()
	return self._newRedpackStack
end

function GroupRedpackModel:getGroupId()
	return self._groupId
end

function GroupRedpackModel:getPopularValue()
	return self._popularValue
end

function GroupRedpackModel:getPrePetIdCache()
	return self._prePetIdCache
end

function GroupRedpackModel:setPrePetIdCache(value)
	self._prePetIdCache = value
end

function GroupRedpackModel:handleGroupRedPackGetInfoRes(msg)
	self._redpackList = msg.redPackList
	self._countList = msg.countList
	self._todayConsolationTimes = msg.todayConsolationTimes
	self._groupId = msg.groupId
	self._popularValue = msg.msg

	for i, v in ipairs(msg.redPackList) do
		self._redpackMap[v.redPackId] = v
	end

	local tempRedpackList = {}

	while not self._newRedpackStack:isEmpty() do
		local redpack = self._newRedpackStack:pop()
		local updateRedpack = self:getRedpackById(redpack.redPackId)

		if updateRedpack then
			local isExpire = GroupRedpackController.instance:isExpire(updateRedpack)
			local isLimit = GroupRedpackController.instance:isTodayGainLimit(updateRedpack)

			if updateRedpack.remainCount > 0 and not isExpire and not isLimit and updateRedpack.state == 0 then
				table.insert(tempRedpackList, updateRedpack)
			end
		end
	end

	local len = #tempRedpackList

	if len > 0 then
		for i = len, 1, -1 do
			self._newRedpackStack:push(tempRedpackList[i])
		end
	end

	GroupRedpackController.instance:refreshRedpack()
end

function GroupRedpackModel:handleGroupRedPackGetRecordsRes(msg)
	self._recordList = msg.records
end

function GroupRedpackModel:handleGroupRedPackGetRankInfoRes(msg)
	self._rankInfo[msg.groupId] = self._rankInfo[msg.groupId] or {}
	self._rankInfo[msg.groupId].myRank = msg.myRank
	self._rankInfo[msg.groupId].rankInfos = msg.infoList
end

function GroupRedpackModel:handleNotifyNewGroupRedPacksRes(msg)
	for i, v in ipairs(msg.newRedPack) do
		self._newRedpackStack:push(v)
	end

	GroupRedpackController.instance:refreshRedpack()
end

GroupRedpackModel.instance = GroupRedpackModel.New()

return GroupRedpackModel
