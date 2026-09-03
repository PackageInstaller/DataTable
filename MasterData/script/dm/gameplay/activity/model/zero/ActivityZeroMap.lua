-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/zero/ActivityZeroMap.lua

require("dm.gameplay.activity.model.zero.ActivityZeroStep")

ActivityZeroMap = class("ActivityZeroMap", objectlua.Object, _M)

ActivityZeroMap:has("_id", {
	is = "r"
})
ActivityZeroMap:has("_config", {
	is = "r"
})
ActivityZeroMap:has("_roundCount", {
	is = "r"
})
ActivityZeroMap:has("_rewards", {
	is = "r"
})
ActivityZeroMap:has("_explorePoint", {
	is = "r"
})
ActivityZeroMap:has("_curStep", {
	is = "r"
})
ActivityZeroMap:has("_allStep", {
	is = "r"
})
ActivityZeroMap:has("_labArray", {
	is = "r"
})
ActivityZeroMap:has("_storySet", {
	is = "r"
})
ActivityZeroMap:has("_bossRate", {
	is = "r"
})
ActivityZeroMap:has("_rate", {
	is = "r"
})
ActivityZeroMap:has("_stepCount", {
	is = "r"
})
ActivityZeroMap:has("_stepIdList", {
	is = "r"
})
ActivityZeroMap:has("_isOpen", {
	is = "r"
})
ActivityZeroMap:has("_bubble", {
	is = "r"
})
ActivityZeroMap:has("_showBubbleIndex", {
	is = "r"
})

function ActivityZeroMap:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("ActivityMonopMap", self._id)
	self._roundCount = 0
	self._rewards = {}
	self._explorePoint = 0
	self._curStep = "Re0_Map1_Step1"
	self._allStep = {}
	self._labArray = {}
	self._storySet = {}
	self._bossRate = 1
	self._stepCount = 0
	self._stepIdList = {}
	self._isOpen = false
	self._showBubbleIndex = nil
end

function ActivityZeroMap:synchronize(data)
	local synchStep
	local setRewardRate = false

	for k, v in pairs(data) do
		if k == "allStep" then
			synchStep = v
		elseif k == "roundCount" then
			self._isOpen = true
			self._allStep = {}
			self._stepCount = 0
			self._stepIdList = {}
			self._roundCount = v
		elseif k == "explorePoint" then
			self._explorePoint = v
			setRewardRate = true
		elseif k == "rewards" then
			self._rewards = v
			setRewardRate = true
		else
			self["_" .. k] = v
		end
	end

	if synchStep then
		self:synchStep(synchStep)
	end

	if setRewardRate then
		self:setRewardRate()
		self:setBubble()
	end
end

function ActivityZeroMap:synchStep(allStep)
	for stepId, v in pairs(allStep) do
		if not self._allStep[stepId] then
			self._allStep[stepId] = ActivityZeroStep:new(stepId)
			self._stepCount = self._stepCount + 1
		end

		self._allStep[stepId]:synchronize(v)
	end
end

function ActivityZeroMap:getStepList()
	self._stepIdList = {}

	local startPoint = self._config.StartPoint

	if not startPoint[self._roundCount] then
		local startId = startPoint[#startPoint]

		for i = 1, self._stepCount do
			table.insert(self._stepIdList, startPoint[self._roundCount])

			if self._allStep[startPoint[self._roundCount]] then
				startId = self._allStep[startPoint[self._roundCount]]:getConfig().NextStep
			end
		end

		return self._stepIdList
	end
end

function ActivityZeroMap:getStep(stepId)
	return self._allStep[stepId]
end

function ActivityZeroMap:getScene()
	local data = {}

	for row, value in ipairs(self._config.Scene) do
		data[row] = {}

		for col, img in ipairs(value) do
			data[row][col] = "asset/ui/zeromap/" .. img .. ".jpg"
		end
	end

	return data
end

function ActivityZeroMap:getAllStepSize()
	local data = {}

	for stepId, step in pairs(self._allStep) do
		local p = step:getConfig().Site

		data[stepId] = cc.p(p[1], p[2])
	end

	return data
end

function ActivityZeroMap:setRewardRate(point)
	local curPoint = point or self._explorePoint

	if not self._rate then
		local list = {}

		for point, rewardId in pairs(self._config.Rate) do
			local p = tonumber(point)

			list[#list + 1] = {
				point = tonumber(point),
				rewardId = rewardId
			}
		end

		table.sort(list, function(a, b)
			return a.point < b.point
		end)

		self._rate = list
	end

	local sum = 0
	local ratio

	for i, v in ipairs(self._rate) do
		v.ratio = nil
		v.status = curPoint >= v.point and (self:hasReward(v.point) and ActivityTaskStatus.kGet or ActivityTaskStatus.kFinishNotGet) or ActivityTaskStatus.kUnfinish

		if curPoint <= v.point and not ratio then
			ratio = (curPoint - sum) / (v.point - sum)
			v.ratio = (curPoint - sum) / (v.point - sum)
		end

		sum = v.point
	end

	return self._rate
end

function ActivityZeroMap:hasReward(point)
	local point = tostring(point)

	for key, value in pairs(self._rewards) do
		if value == point then
			return true
		end
	end

	return false
end

function ActivityZeroMap:getNextPoint()
	local point

	for i, v in ipairs(self._rate) do
		if self._explorePoint < v.point then
			point = v.point

			break
		end
	end

	return point
end

function ActivityZeroMap:getHard(team)
	local ratio = self._explorePoint / self._config.Point
	local hurtRate = 0

	self._developSystem = self._developSystem or DmGame:getInstance()._injector:getInstance("DevelopSystem")

	local function hurtValue(ratio)
		local attr = self._config.Attr
		local num = ratio / (attr.AddRate * 100)

		return attr.Hurt * 100 * num
	end

	hurtRate = hurtRate + hurtValue(ratio)

	local nextPoint = self:getNextPoint(self._explorePoint)

	return hurtRate, (nextPoint and nextPoint < self._config.Point or nil) and hurtValue(nextPoint / self._config.Point)
end

function ActivityZeroMap:getMapBgName()
	return self._config.Picture
end

function ActivityZeroMap:getMapName()
	return Strings:get(self._config.Title) or ""
end

function ActivityZeroMap:getMapConditionTime()
	return self._config.ConditionTime
end

function ActivityZeroMap:getMapLine()
	return self._config.Line .. ".png"
end

function ActivityZeroMap:getBubble()
	local function a()
		local list = {}

		for i = 1, 100 do
			local txt = self._explorePoint + i * 100

			list[tostring(txt)] = tostring(txt)
		end

		return list
	end

	return self._config.Bubble or a()
end

function ActivityZeroMap:setBubble(point)
	local curPoint = point or self._explorePoint

	if not self._bubbleList then
		local list = {}

		for point, tips in pairs(self:getBubble()) do
			local p = tonumber(point)

			list[#list + 1] = {
				point = tonumber(point),
				tips = tips
			}
		end

		table.sort(list, function(a, b)
			return a.point < b.point
		end)

		self._bubbleList = list
	end

	for i, v in ipairs(self._bubbleList) do
		if curPoint >= v.point then
			if v.status == nil then
				v.status = ActivityTaskStatus.kGet
			elseif v.status ~= ActivityTaskStatus.kGet then
				v.status = ActivityTaskStatus.kFinishNotGet

				if self._showBubbleIndex == nil then
					self._showBubbleIndex = i
				end
			end
		else
			v.status = ActivityTaskStatus.kUnfinish
		end
	end

	return self._bubbleList
end

function ActivityZeroMap:getBubbleStatus()
	return self._bubbleList[self._showBubbleIndex]
end

function ActivityZeroMap:setBubbleShowEnd()
	if self._bubbleList[self._showBubbleIndex] then
		self._bubbleList[self._showBubbleIndex].status = ActivityTaskStatus.kGet
		self._showBubbleIndex = nil
	end
end
