-- chunkname: @modules/logic/achievement/controller/AchievementStatController.lua

module("modules.logic.achievement.controller.AchievementStatController", package.seeall)

local AchievementStatController = class("AchievementStatController", BaseController)

function AchievementStatController:onInit()
	self.startTime = nil
	self.entrance = nil
end

function AchievementStatController:reInit()
	self.startTime = nil
	self.entrance = nil
end

function AchievementStatController:addConstEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function AchievementStatController:onOpenViewCallBack(viewName, viewParam)
	self:onOpenTragetView(viewName, viewParam)

	if viewName == ViewName.AchievementMainView then
		self:onEnterAchievementMainView()
	end
end

function AchievementStatController:onCloseViewCallBack(viewName)
	if viewName == ViewName.AchievementMainView then
		self:onExitAchievementMainView()
	end
end

function AchievementStatController:onExitAchievementMainView()
	if not self.startTime then
		return
	end

	local useTime = Mathf.Ceil(Time.realtimeSinceStartup - self.startTime)
	local collectAchievementNameList = self:getCollectAchievementList()

	if not self.entrance then
		StatController.instance:track(StatEnum.EventName.ExitAchievementMainView, {
			[StatEnum.EventProperties.Time] = useTime or 0,
			[StatEnum.EventProperties.CollectAchievmentsName] = collectAchievementNameList,
			[StatEnum.EventProperties.Entrance] = tostring(self.entrance)
		})

		self.startTime = nil
	end
end

function AchievementStatController:onSaveDisplayAchievementsSucc()
	local showStr = PlayerModel.instance:getShowAchievement()
	local singeTaskSet, groupTaskSet = AchievementUtils.decodeShowStr(showStr)
	local achievementNameList = self:getAchievementNameListByTaskId(singeTaskSet)
	local groupNameList = self:getGroupNameListByTaskId(groupTaskSet)

	StatController.instance:track(StatEnum.EventName.SaveDisplayAchievementSucc, {
		[StatEnum.EventProperties.DisplaySingleAchievementName] = achievementNameList,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = groupNameList
	})
end

function AchievementStatController:getAchievementNameListByTaskId(taskSet)
	local achievementNameList = {}
	local achievementIdDict = {}

	if taskSet and #taskSet > 0 then
		for _, taskId in ipairs(taskSet) do
			local taskCO = AchievementConfig.instance:getTask(taskId)

			if taskCO and not achievementIdDict[taskCO.achievementId] then
				local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)

				if achievementCfg then
					if not achievementCfg.name then
						local achievementName = ""

						table.insert(achievementNameList, achievementName)

						achievementIdDict[taskCO.achievementId] = true
					end
				end
			end
		end
	end

	return achievementNameList
end

function AchievementStatController:getGroupNameListByTaskId(taskSet)
	local groupNameList = {}
	local groupIdDict = {}

	if taskSet and #taskSet > 0 then
		for _, taskId in ipairs(taskSet) do
			local taskCO = AchievementConfig.instance:getTask(taskId)

			if taskCO then
				local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)
				local groupId = achievementCfg and achievementCfg.groupId
				local groupCfg = AchievementConfig.instance:getGroup(groupId)

				if groupCfg and not groupIdDict[groupId] then
					if groupCfg then
						if not groupCfg.name then
							local groupName = ""

							table.insert(groupNameList, groupName)

							groupIdDict[groupId] = true
						end
					end
				end
			end
		end
	end

	return groupNameList
end

function AchievementStatController:getCollectAchievementList()
	local achievmentNameList = {}
	local achievementIdDict = {}
	local finishTaskList = AchievementModel.instance:getList()

	if finishTaskList then
		for _, v in ipairs(finishTaskList) do
			if v.hasFinished and not achievementIdDict[v.cfg.achievementId] then
				local achievementCfg = AchievementConfig.instance:getAchievement(v.cfg.achievementId)

				achievementIdDict[v.cfg.achievementId] = true

				table.insert(achievmentNameList, achievementCfg.name)
			end
		end
	end

	return achievmentNameList
end

function AchievementStatController:onOpenAchievementGroupPreView(viewName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if viewContainer then
		if viewContainer.viewParam then
			local activityId = viewContainer.viewParam.activityId

			if activityId and activityId ~= 0 then
				local activityConfig = ActivityConfig.instance:getActivityCo(activityId)

				if activityConfig then
					return string.format("Activity_%s", activityConfig.name)
				end
			end
		end
	end
end

function AchievementStatController:setAchievementEntrance(viewName)
	return viewName
end

function AchievementStatController:checkBuildEntranceOpenHandleFuncDict()
	self._entranceOpenHandleFuncDict = self._entranceOpenHandleFuncDict or {
		[ViewName.MainView] = AchievementStatController.setAchievementEntrance,
		[ViewName.PlayerView] = AchievementStatController.setAchievementEntrance,
		[ViewName.AchievementGroupPreView] = AchievementStatController.onOpenAchievementGroupPreView
	}
end

function AchievementStatController:onOpenTragetView(viewName, viewParam)
	self:checkBuildEntranceOpenHandleFuncDict()

	if viewName and self._entranceOpenHandleFuncDict[viewName] then
		return self._entranceOpenHandleFuncDict[viewName](self, viewName, viewParam) or ""
	end
end

function AchievementStatController:onEnterAchievementMainView()
	self.startTime = Time.realtimeSinceStartup

	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	if openViewNameList then
		for i = #openViewNameList, 1, -1 do
			local viewName = openViewNameList[i]
			local entranceOpenFunc = self._entranceOpenHandleFuncDict[viewName]

			if entranceOpenFunc then
				self.entrance = entranceOpenFunc(self, viewName)

				break
			end
		end
	end
end

AchievementStatController.instance = AchievementStatController.New()

return AchievementStatController
