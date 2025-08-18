-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataFirePlace.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityFirePlaceDetail = require("ClientData/ResOpActivityFirePlaceDetail")
local ResOpActivityFirePlaceRewardPool = require("ClientData/ResOpActivityFirePlaceRewardPool")
local strClassName = "ActivityDataFirePlace"
local ActivityDataFirePlace = Class(strClassName, ActivityDataBase)

function ActivityDataFirePlace:ctor()
	self.detailData = {}
	self.roleData = {}
	self.awards = {}
end

function ActivityDataFirePlace:updateClientData(actId)
	self.actId = actId
	self.detailData = ResOpActivityFirePlaceDetail[actId] or {}

	for i, data in ipairs(self.detailData) do
		if data.time_limit then
			local timeLeft = data.time_limit - ClientUtils.getServerTime()

			if timeLeft >= 0 then
				ClientTimerManager.startGlobalTimer("firePlaceTimer" .. i, timeLeft, Functor(self.onTimerFinish, self, i))
			end
		end
	end
end

function ActivityDataFirePlace:onTimerFinish(index)
	ClientTimerManager.stopGlobalTimer("firePlaceTimer" .. index)
	self.actObject:checkNew()
end

function ActivityDataFirePlace:updateRoleData(roleData)
	self.roleData = {}

	if roleData.fire_place.item then
		for i, rData in ipairs(roleData.fire_place.item) do
			self.roleData[i] = rData
		end
	end

	self.awards = {}

	for i, data in ipairs(self.roleData) do
		if data.awarded then
			self.awards[i] = ClientUtils.getBitsDictFromByteString(data.awarded)
		else
			self.awards[i] = {}
		end
	end
end

function ActivityDataFirePlace:updateMgrData()
	return
end

function ActivityDataFirePlace:getState(index)
	local state = 0
	local data = self.detailData[index]
	local roleData = self.roleData[index]
	local awarded = self.awards[index]
	local awards = ResOpActivityFirePlaceRewardPool[data.reward_pool]

	if data.time_limit then
		if data.time_limit - ClientUtils.getServerTime() <= 0 then
			local hasGot = false

			for idx, award in ipairs(awards) do
				if awarded and awarded[award.index] then
					hasGot = true

					break
				end
			end

			if hasGot == false then
				state = 1
			else
				state = 2
			end
		end
	elseif data.get_need_point then
		if not roleData then
			return state
		end

		local point = roleData.point

		if roleData.times >= data.get_limit then
			state = 2
		elseif point >= data.get_need_point then
			state = 1
		end
	end

	return state
end

function ActivityDataFirePlace:checkNew()
	for i, data in ipairs(self.detailData) do
		local state = self:getState(i)

		if state == 1 then
			return true
		end
	end

	return false
end

return ActivityDataFirePlace
