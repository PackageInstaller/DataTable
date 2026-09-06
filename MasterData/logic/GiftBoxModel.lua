-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/model/GiftBoxModel.lua

module("logic.extensions.giftbox.model.GiftBoxModel", package.seeall)

local GiftBoxModel = class("GiftBoxModel", BaseModel)

GiftBoxModel.ReadFlag = "GiftBoxModel.ReadFlag"

function GiftBoxModel:onInit()
	self:onReset()
end

function GiftBoxModel:onReset()
	self._gainMyLuckCount = 0
	self._score = 0
	self._todayGainLuckTimes = 0
	self._leftScore = 0
	self._gainSharePrizeMap = {}
	self._poolMap = {}
	self._boxTypeMap = {}
	self._shareList = {}
	self._todayGainLuckPlayerIds = {}
	self._isInit = false
end

function GiftBoxModel:getCurActId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.GiftBox)
end

function GiftBoxModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._poolMap = {}

	for i, poolInfo in ipairs(info.poolList or {}) do
		self._poolMap[poolInfo.poolId] = self._poolMap[poolInfo.poolId] or {}

		for j, boxinfo in ipairs(poolInfo.openBoxList or {}) do
			self._poolMap[poolInfo.poolId][boxinfo.boxId] = boxinfo
		end
	end

	self._actId = info.actId
	self._score = info.score

	if info.leftScore then
		self._score = info.leftScore
	end

	self._todayGainLuckTimes = info.todayGainLuckTimes
	self._maxScore = info.score
	self._gainMyLuckCount = info.gainMyLuckCount
	self._boxTypeMap = {}

	for i, boxTypeInfo in ipairs(info.typeList or {}) do
		self._boxTypeMap[boxTypeInfo.type] = self._boxTypeMap[boxTypeInfo.type] or {}

		for j, superPrizeId in ipairs(boxTypeInfo.gainSuperPrizeIds or {}) do
			self._boxTypeMap[boxTypeInfo.type][superPrizeId] = true
		end
	end

	self._gainSharePrizeMap = {}

	for i, sharePrizeId in ipairs(info.gainSharePrizeIds or {}) do
		self._gainSharePrizeMap[sharePrizeId] = true
	end

	self._isInit = true
	self._todayGainLuckPlayerIds = info.todayGainLuckPlayerIds
end

function GiftBoxModel:setBoxOpen(msg)
	local var_5_0 = {
		boxId = msg.boxId,
		normalPrizeId = msg.normalPrizeId
	}

	var_5_0.superPrizeId = msg.superPrizeId or nil
	self._poolMap[msg.poolId] = self._poolMap[msg.poolId] or {}
	self._poolMap[msg.poolId][msg.boxId] = var_5_0
	self._score = self._score + msg.incScore or 0
	self._maxScore = self._maxScore + msg.incScore or 0

	if msg.superPrizeId then
		self:_setSuperPrizeGet(msg.actId, msg.poolId, msg.boxId, msg.superPrizeId)
	end
end

function GiftBoxModel:_setSuperPrizeGet(actId, poolId, boxId, superPrizeId)
	local poolCfg = GiftBoxConfig.instance:getPoolCfg(actId, poolId)
	local boxPlanCfg = GiftBoxConfig.instance:getBoxCfgs(poolCfg.boxPlanId)
	local boxType = boxPlanCfg[boxId].boxType

	self._boxTypeMap[boxType] = self._boxTypeMap[boxType] or {}
	self._boxTypeMap[boxType][superPrizeId] = true
end

function GiftBoxModel:isMatchPoolCondition(targetPoolId, conditionStr)
	if string.nilorempty(conditionStr) or self._actId <= 0 then
		return true
	end

	local poolCfg = GiftBoxConfig.instance:getPoolCfg(self._actId, targetPoolId)

	if not poolCfg then
		return true
	end

	local boxCfgs = GiftBoxConfig.instance:getBoxCfgs(poolCfg.boxPlanId)
	local conditionList = string.split(conditionStr, "#")
	local isMatch = true

	for i, v in ipairs(conditionList) do
		local conditionInfo = string.split(v, ":")
		local targetType = checknumber(conditionInfo[1])
		local needCount = checknumber(conditionInfo[2])
		local haveCount = 0

		for j, boxInfo in pairs(self._poolMap[targetPoolId]) do
			if boxCfgs[boxInfo.boxId].boxType == targetType then
				haveCount = haveCount + 1
			end
		end

		if haveCount < needCount then
			isMatch = false

			break
		end
	end

	return isMatch
end

function GiftBoxModel:getPoolInfo()
	return self._poolMap
end

function GiftBoxModel:getBoxInfo(poolId, boxId)
	if self._poolMap and self._poolMap[poolId] and self._poolMap[poolId][boxId] then
		return self._poolMap[poolId][boxId]
	else
		return nil
	end
end

function GiftBoxModel:getSuperPrizeInfo()
	return self._boxTypeMap
end

function GiftBoxModel:getSharePrizeInfo()
	return self._gainSharePrizeMap
end

function GiftBoxModel:getScore()
	return self._score
end

function GiftBoxModel:getMaxScore()
	return self._maxScore
end

function GiftBoxModel:getGainLuckTimes()
	return self._todayGainLuckTimes
end

function GiftBoxModel:getGainMyLuckCount()
	return self._gainMyLuckCount
end

function GiftBoxModel:isCanGetProgressReward(needCount, id)
	return needCount <= self._gainMyLuckCount and not self._gainSharePrizeMap[id]
end

function GiftBoxModel:isGetedProgressReward(id)
	return self._gainSharePrizeMap[id] == true
end

function GiftBoxModel:getShareAllStamp()
	return checknumber(self._shareAllStamp)
end

function GiftBoxModel:setShareAllStamp(stamp)
	self._shareAllStamp = stamp
end

function GiftBoxModel:getShareFriendStamp()
	return checknumber(self._shareFriendStamp)
end

function GiftBoxModel:setShareFriendStamp(stamp)
	self._shareFriendStamp = stamp
end

function GiftBoxModel:isCanShareScore()
	return false
end

function GiftBoxModel:setShareList(msg)
	self._shareList = GameUtil.pbToTable(msg.shareList)
end

function GiftBoxModel:getShareList()
	return self._shareList or {}
end

function GiftBoxModel:setGainLuck(msg, incScore)
	self._todayGainLuckTimes = msg.todayGainLuckTimes
	self._score = self._score + incScore or 0
	self._maxScore = self._maxScore + incScore or 0
end

function GiftBoxModel:saveFirstGainMaxLuck(actId)
	GameUtil.saveUserData(GiftBoxModel.ReadFlag .. "#MaxLuck#" .. actId, true)
end

function GiftBoxModel:getFirstGainMaxLuck(actId)
	return GameUtil.getUserData(GiftBoxModel.ReadFlag .. "#MaxLuck#" .. actId)
end

function GiftBoxModel:setSharePrize(prizeId)
	if self._gainSharePrizeMap then
		self._gainSharePrizeMap[prizeId] = true
	end
end

function GiftBoxModel:getIsInit()
	return self._isInit
end

function GiftBoxModel:getSelectPool()
	return self._selectPool or 1
end

function GiftBoxModel:setSelectPool(poolId)
	self._selectPool = poolId
end

function GiftBoxModel:isExistGainLuckUserId(userId)
	local isExist = false

	for i, v in ipairs(self._todayGainLuckPlayerIds or {}) do
		if checknumber(userId) == checknumber(v) then
			isExist = true
		end
	end

	return isExist
end

function GiftBoxModel:addGainPlayerId(userId)
	self._todayGainLuckPlayerIds = self._todayGainLuckPlayerIds or {}

	table.insert(self._todayGainLuckPlayerIds, userId)
end

function GiftBoxModel:saveFirstOpenShare(actId)
	GameUtil.saveUserData(GiftBoxModel.ReadFlag .. "#OpenShare#" .. actId, true)
end

function GiftBoxModel:getFirstOpenShare(actId)
	return GameUtil.getUserData(GiftBoxModel.ReadFlag .. "#OpenShare#" .. actId)
end

GiftBoxModel.instance = GiftBoxModel.New()

return GiftBoxModel
