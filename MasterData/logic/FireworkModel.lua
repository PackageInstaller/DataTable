-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/model/FireworkModel.lua

module("logic.extensions.firework.model.FireworkModel", package.seeall)

local FireworkModel = class("FireworkModel", BaseModel)

function FireworkModel:ctor()
	FireworkModel.super.ctor(self)
	self:onReset()
end

function FireworkModel:onReset()
	self.curActId = 145004
	self.normalProgress = 0
	self.worldProgress = {}
	self.gainednormalprizeids = {}
	self.gainedworldprizeids = {}
	self.npcinfos = {}
end

function FireworkModel:setActivityId(activityId)
	self.curActId = activityId
end

function FireworkModel:getInfos(msg)
	local worldProgress = msg.worldProgress
	local gainednormalprizeids = msg.gainedNormalPrizeIds
	local gainedworldprizeids = msg.gainedWorldPrizeIds
	local npcinfos = msg.npcInfos

	self.normalProgress = msg.normalProgress
	self.useTime = msg.useTime

	for i = 1, #worldProgress do
		local wp = worldProgress[i]

		self.worldProgress[wp.id] = wp.progress
	end

	self.gainednormalprizeids = {}

	for i = 1, #gainednormalprizeids do
		self.gainednormalprizeids[gainednormalprizeids[i]] = true
	end

	self.gainedworldprizeids = {}

	for i = 1, #gainedworldprizeids do
		self.gainedworldprizeids[gainedworldprizeids[i]] = true
	end

	for i = 1, #npcinfos do
		local v = npcinfos[i]
		local tab = {}

		for _, m in ipairs(v.NPCIds) do
			tab[m] = true
		end

		self.npcinfos[v.id] = tab
	end
end

function FireworkModel:updateInfos(msg)
	self.normalProgress = self.normalProgress + checknumber(msg.cirticalTimes)
	self.useTime = self.useTime + 1
	self.npcinfos[msg.timeId][msg.npcId] = true
end

function FireworkModel:updateNormalPrizeids(index)
	self.gainednormalprizeids[index] = true
end

function FireworkModel:updateWorldPrizeids(index)
	self.gainedworldprizeids[index] = true
end

function FireworkModel:getWorldTotal()
	local total = 0

	for k, v in pairs(self.worldProgress) do
		if v then
			total = total + checknumber(v)
		end
	end

	return total
end

function FireworkModel:isNpcFireOver(timeId, npcId)
	if not self.npcinfos[timeId] then
		return false
	end

	return self.npcinfos[timeId][npcId] == true
end

function FireworkModel:isHaveTimes()
	local maxTimes = FireworkConfig.instance:getPlanCfg(FireworkModel.instance.curActId).dailyTimes

	return maxTimes > FireworkModel.instance.useTime
end

function FireworkModel:isHaveWorldPrize()
	local prizeCfgs = FireworkConfig.instance:getWorldPrizeCfgs(FireworkModel.instance.curActId)
	local totalTimes = FireworkModel.instance:getWorldTotal()

	for i, v in ipairs(prizeCfgs) do
		if totalTimes < v.progress then
			break
		elseif FireworkModel.instance.gainedworldprizeids[v.id] == nil then
			return true
		end
	end

	return false
end

function FireworkModel:getCurPrizePlan(ids, restTime)
	local idList = string.splitToNumber(ids, ",")

	if idList == nil or #idList == 0 then
		return 1, nil
	end

	local timeList = string.split(restTime, ",")

	if timeList == nil or #timeList == 0 then
		return idList[1], nil
	end

	local index = idList[1]
	local curTime = ServerTime.now()

	for i, v in ipairs(timeList) do
		if curTime < GameUtil.string2time(v) then
			index = idList[i]

			break
		end
	end

	return index, timeList[index]
end

FireworkModel.instance = FireworkModel.New()

return FireworkModel
