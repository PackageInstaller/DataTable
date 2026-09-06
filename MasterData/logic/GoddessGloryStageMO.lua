-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryStageMO.lua

module("logic.extensions.goddessglory.model.GoddessGloryStageMO", package.seeall)

local GoddessGloryStageMO = class("GoddessGloryStageMO")

function GoddessGloryStageMO:ctor()
	self.stageId = 0
	self.stageName = nil
	self.startTime = nil
	self.icon = nil
	self.image = nil
	self.storyId = 0
	self.hasPlayedStory = false
	self.tips = nil
	self.stageInfos = nil
	self.tasks = nil
	self.rankList = nil
	self.isBossAppear = false
end

function GoddessGloryStageMO:getLeftEventCount()
	if not self.stageInfos then
		return 0
	end

	local cnt = 0

	for i = 1, #self.stageInfos.eventList do
		local evt = self.stageInfos.eventList[i]

		if evt.eventState ~= GoddessGloryEvtStatus.Finished then
			cnt = cnt + 1
		end
	end

	return cnt
end

function GoddessGloryStageMO:getEvent(instanceId)
	if not self.stageInfos then
		return
	end

	for i = 1, #self.stageInfos.eventList do
		local evt = self.stageInfos.eventList[i]

		if evt.instanceId == instanceId then
			return evt
		end
	end
end

function GoddessGloryStageMO:getCurExecutingEvts()
	if not self.stageInfos then
		return {}
	end

	local evts = {}

	for i = 1, #self.stageInfos.eventList do
		local evt = self.stageInfos.eventList[i]

		if evt.eventState == GoddessGloryEvtStatus.Executing then
			evts = evts or {}

			table.insert(evts, evt)
		end
	end

	return evts
end

function GoddessGloryStageMO:getAllEvents()
	if not self.stageInfos then
		return {}
	end

	local evts = {}

	for i = 1, #self.stageInfos.eventList do
		local evt = self.stageInfos.eventList[i]

		evts = evts or {}

		table.insert(evts, evt)
	end

	return evts
end

function GoddessGloryStageMO:isRankListValid()
	if not self.rankList then
		return false
	end

	if self.rankList.lastGetDataTime == 0 then
		return false
	end

	local time = UnityEngine.Time.unscaledTime

	return time - self.rankList.lastGetDataTime < 60
end

function GoddessGloryStageMO:setRankList(myRank, rankSize, rankList)
	self.rankList = self.rankList or GoddessGloryRankMO.New()
	self.rankList.lastGetDataTime = UnityEngine.Time.unscaledTime
	self.rankList.myRank = myRank
	self.rankList.rankSize = rankSize
	self.rankList.rankList = rankList
end

function GoddessGloryStageMO:getRankList()
	if not self.rankList then
		return
	end

	return self.rankList.rankList
end

function GoddessGloryStageMO:getMyRank()
	if not self.rankList then
		return 0
	end

	return self.rankList.myRank
end

function GoddessGloryStageMO:getEnergy()
	if not self.stageInfos then
		return 0
	end

	return self.stageInfos.energy
end

function GoddessGloryStageMO:hasTaskCompeleted()
	if not self.tasks then
		return false
	end

	for i = 1, #self.tasks do
		local taskData = self.tasks[i]
		local taskCo = GoddessGloryConfig.instance:getTaskCo(taskData.taskPlanId, taskData.type, taskData.taskId)

		if not taskData:hasGainPrize(taskData.taskId) and taskData.progress >= taskCo.maxProgress then
			return true
		end
	end

	return false
end

return GoddessGloryStageMO
