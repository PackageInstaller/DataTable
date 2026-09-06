-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/model/HuarongRoadModel.lua

module("logic.extensions.huarongroad.view.HuarongRoadModel", package.seeall)

local HuarongRoadModel = class("HuarongRoadModel", BaseModel)

HuarongRoadModel.ReadFlag = "HuarongRoadModel.ReadFlag"

function HuarongRoadModel:ctor()
	self.huarongInfos = {}
end

function HuarongRoadModel:onInit()
	self:onReset()
end

function HuarongRoadModel:onReset()
	HuarongRoadModel.super.onReset(self)

	self.huarongInfos = {}
end

function HuarongRoadModel:setData(info)
	if not self.huarongInfos[info.activityId] then
		if info.playCount then
			self.huarongInfos[info.activityId]._playCount = info.playCount
		end

		if info.IncrTimeBuyCount then
			self.huarongInfos[info.activityId]._incrTimeBuyCount = info.IncrTimeBuyCount
		end

		if info.passStageIds then
			self.huarongInfos[info.activityId]._passStageIds = info.passStageIds

			table.sort(self.huarongInfos[info.activityId]._passStageIds)

			local maxLevel = 0

			for i, v in ipairs(self.huarongInfos[info.activityId]._passStageIds) do
				if v == maxLevel + 1 then
					maxLevel = v
				end
			end

			self.huarongInfos[info.activityId]._maxLevel = maxLevel
		end

		if info.allPass then
			self.huarongInfos[info.activityId]._allPass = info.allPass
		end

		self.huarongInfos[info.activityId] = self.huarongInfos[info.activityId]
	end
end

function HuarongRoadModel:getPlayCount(activityId)
	if self.huarongInfos[activityId] then
		return checknumber(self.huarongInfos[activityId]._playCount)
	else
		return 0
	end
end

function HuarongRoadModel:getIncrTimeBuyCount(activityId)
	if self.huarongInfos[activityId] then
		return checknumber(self.huarongInfos[activityId]._incrTimeBuyCount)
	else
		return 0
	end
end

function HuarongRoadModel:getPassStageIds(activityId)
	if self.huarongInfos and self.huarongInfos[activityId] then
		return self.huarongInfos[activityId]._passStageIds
	else
		return {}
	end
end

function HuarongRoadModel:getAllPass(activityId)
	if self.huarongInfos[activityId] then
		return self.huarongInfos[activityId]._allPass
	else
		return false
	end
end

function HuarongRoadModel:getMaxLevel(activityId)
	if self.huarongInfos[activityId] then
		return self.huarongInfos[activityId]._maxLevel
	else
		return 0
	end
end

function HuarongRoadModel:getCompletLevelCount(activityId)
	if self.huarongInfos[activityId] then
		return #(self.huarongInfos[activityId]._passStageIds or {})
	else
		return 0
	end
end

function HuarongRoadModel:getHaveGuide(activityId)
	return not GameUtil.getUserData(HuarongRoadModel.ReadFlag .. activityId)
end

function HuarongRoadModel:setHaveGuide(activityId)
	GameUtil.saveUserData(HuarongRoadModel.ReadFlag .. activityId, true)
end

function HuarongRoadModel:getIsFirstEnter(activityId)
	return not GameUtil.getUserData(HuarongRoadModel.ReadFlag .. "FirstEnter" .. activityId)
end

function HuarongRoadModel:setIsFirstEnter(activityId)
	GameUtil.saveUserData(HuarongRoadModel.ReadFlag .. "FirstEnter" .. activityId, true)
end

function HuarongRoadModel:getGameProgress(activityId, stageId)
	local challengePlanId = HuarongRoadConfig.instance:getChallengePlanId(activityId)

	return GameUtil.getUserData(HuarongRoadModel.ReadFlag .. "GameSave" .. challengePlanId .. "#" .. stageId)
end

function HuarongRoadModel:setGameProgress(activityId, stageId, list, time)
	local challengePlanId = HuarongRoadConfig.instance:getChallengePlanId(activityId)

	if list and time then
		GameUtil.saveUserData(HuarongRoadModel.ReadFlag .. "GameSave" .. challengePlanId .. "#" .. stageId, {
			list = list,
			time = time
		})
	else
		GameUtil.saveUserData(HuarongRoadModel.ReadFlag .. "GameSave" .. challengePlanId .. "#" .. stageId, nil)
	end
end

function HuarongRoadModel:createRandomGame(width, height, startPosW, startPosH, randomNum)
	local list = {}

	if not startPosW or width < startPosW then
		startPosW = width
	end

	if not startPosH or height < startPosH then
		startPosH = height
	end

	randomNum = randomNum or 300

	local maxCount = width * height

	for i = 1, maxCount do
		list[i] = i
	end

	local posW = width
	local posH = height

	for i = 1, randomNum do
		local pos = (posH - 1) * width + posW
		local j = math.random(1, 4)

		if j == 1 and posH > 1 then
			list[pos] = list[(posH - 2) * width + posW]
			list[(posH - 2) * width + posW] = maxCount
			posH = posH - 1
		elseif j == 2 and posH < height then
			list[pos] = list[posH * width + posW]
			list[posH * width + posW] = maxCount
			posH = posH + 1
		elseif j == 3 and posW > 1 then
			list[pos] = list[(posH - 1) * width + (posW - 1)]
			list[(posH - 1) * width + (posW - 1)] = maxCount
			posW = posW - 1
		elseif j == 4 and posW < width then
			list[pos] = list[(posH - 1) * width + (posW + 1)]
			list[(posH - 1) * width + (posW + 1)] = maxCount
			posW = posW + 1
		end
	end

	if startPosW < posW then
		for i = posW, startPosW + 1, -1 do
			list[(posH - 1) * width + i] = list[(posH - 1) * width + (i - 1)]
			list[(posH - 1) * width + (i - 1)] = maxCount
		end
	elseif posW < startPosW then
		for i = posW, startPosW - 1 do
			list[(posH - 1) * width + i] = list[(posH - 1) * width + (i + 1)]
			list[(posH - 1) * width + (i + 1)] = maxCount
		end
	end

	posW = startPosW

	if startPosH < posH then
		for i = posH, startPosH + 1, -1 do
			list[(i - 1) * width + posW] = list[(i - 1) * width + posW]
			list[(i - 2) * width + posW] = maxCount
		end
	elseif posH < startPosH then
		for i = posH, startPosH - 1 do
			list[(i - 1) * width + posW] = list[i * width + posW]
			list[i * width + posW] = maxCount
		end
	end

	return list
end

function HuarongRoadModel:createRandomGameByMath(width, height, startPosW, startPosH, randomNum)
	local list = {}

	if not startPosW or width < startPosW then
		startPosW = width
	end

	if not startPosH or height < startPosH then
		startPosH = height
	end

	randomNum = randomNum or 300

	local maxCount = width * height

	for i = 1, maxCount - 1 do
		list[i] = i
	end

	local find = false

	for i = 1, randomNum do
		list = GameUtil.permuteArray(list)

		local inverseNumber = 0

		for i = 1, maxCount - 1 do
			for j = i + 1, maxCount - 1 do
				if list[i] > list[j] then
					inverseNumber = inverseNumber + 1
				end
			end
		end

		if inverseNumber % 2 == 0 then
			find = true

			break
		end
	end

	if find == false then
		return self:createRandomGame(width, height, startPosW, startPosH, randomNum)
	end

	list[maxCount] = maxCount

	local posW = width
	local posH = height

	if startPosW < posW then
		for i = posW, startPosW + 1, -1 do
			list[(posH - 1) * width + i] = list[(posH - 1) * width + (i - 1)]
			list[(posH - 1) * width + (i - 1)] = maxCount
		end
	elseif posW < startPosW then
		for i = posW, startPosW - 1 do
			list[(posH - 1) * width + i] = list[(posH - 1) * width + (i + 1)]
			list[(posH - 1) * width + (i + 1)] = maxCount
		end
	end

	posW = startPosW

	if startPosH < posH then
		for i = posH, startPosH + 1, -1 do
			list[(i - 1) * width + posW] = list[(i - 1) * width + posW]
			list[(i - 2) * width + posW] = maxCount
		end
	elseif posH < startPosH then
		for i = posH, startPosH - 1 do
			list[(i - 1) * width + posW] = list[i * width + posW]
			list[i * width + posW] = maxCount
		end
	end

	return list
end

HuarongRoadModel.instance = HuarongRoadModel.New()

return HuarongRoadModel
