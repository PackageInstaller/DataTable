-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryModel.lua

module("logic.extensions.goddessglory.model.GoddessGloryModel", package.seeall)

local GoddessGloryModel = class("GoddessGloryModel", BaseModel)

function GoddessGloryModel:onInit()
	self:onReset()
end

function GoddessGloryModel:onReset()
	self._challengeMOs = nil
	self._currGoddessGloryId = 0
	self._currGoddessGloryStageId = 0
	self._justFinishEventId = 0
	self._bloodLossHp = 0
end

function GoddessGloryModel:setCurGoddessGloryId(id)
	self._currGoddessGloryId = id

	if id == 0 then
		self._currGoddessGloryId = self:getDefaultGoddesGloryId()
	end
end

function GoddessGloryModel:getCurGoddessGloryId()
	if self._currGoddessGloryId == 0 then
		self._currGoddessGloryId = self:getDefaultGoddesGloryId()
	end

	return self._currGoddessGloryId
end

function GoddessGloryModel:setCurStageId(id)
	self._currGoddessGloryStageId = id
end

function GoddessGloryModel:getCurStageId()
	return self._currGoddessGloryStageId
end

function GoddessGloryModel:getJustFinishedEvtId()
	return self._justFinishEventId
end

function GoddessGloryModel:resetJustFinishedEvtId()
	self._justFinishEventId = 0
end

function GoddessGloryModel:setGoddessGlory(id)
	self._challengeMOs = self._challengeMOs or {}
	self._justFinishEventId = 0

	local challengeMO = GoddessGloryChallengeMO.New()

	challengeMO.challengeId = id
	challengeMO.storyId = GoddessGloryConfig.instance:getParamInt("STORY_ID")

	local key = self:getGoddessGloryStoryKey(id)

	challengeMO.hasPlayedStory = checknumber(UnityEngine.PlayerPrefs.GetInt(key)) ~= 0
	challengeMO.stages = {}

	local stageCos = GoddessGloryConfig.instance:getStageCos(id)

	for i = 1, #stageCos do
		local stage = GoddessGloryStageMO.New()

		stage.stageId = stageCos[i].stageId
		stage.stageName = stageCos[i].desc
		stage.tips = stageCos[i].tips
		stage.startTime = stageCos[i].startTime
		stage.icon = stageCos[i].icon
		stage.image = GoddessGloryModel.getSpineUrl(stageCos[i].image)
		stage.storyId = stageCos[i].storyId

		local keyStory = self:getGoddessGloryStageStoryKey(id, stage.stageId)

		stage.hasPlayedStory = checknumber(UnityEngine.PlayerPrefs.GetInt(keyStory)) ~= 0

		table.insert(challengeMO.stages, stage)
	end

	self._challengeMOs[id] = challengeMO
end

function GoddessGloryModel:getGoddessGlory(id)
	if not self._challengeMOs then
		return
	end

	return self._challengeMOs[id]
end

function GoddessGloryModel:resetGoddessGlory(challengeId, stageId)
	self._justFinishEventId = 0

	local challengeMO = self._challengeMOs[challengeId]

	if not challengeMO then
		return
	end

	challengeMO.weeklyTasks = nil

	local stageMo = self:getGoddessGloryStage(challengeId, stageId)

	if not stageMo then
		return
	end

	stageMo.stageInfos = nil
	stageMo.leftEventsCount = 0
	stageMo.tasks = nil
	stageMo.isBossAppear = false
end

function GoddessGloryModel:setGoddessGloryStageInfo(challengeId, stageId, msg)
	self._justFinishEventId = 0

	local stageMo = self:getGoddessGloryStage(challengeId, stageId)

	if not stageMo then
		return
	end

	stageMo.stageInfos = GoddessGloryStageInfoMO.New()
	stageMo.stageInfos.energy = msg.energy
	stageMo.stageInfos.petIds = msg.petIds
	stageMo.stageInfos.eventList = msg.eventList
	stageMo.isBossAppear = false

	local currExecuting = stageMo:getCurExecutingEvts()

	if currExecuting then
		for i = 1, #currExecuting do
			local evtCo = GoddessGloryConfig.instance:getEventCo(currExecuting[i].eventId)

			if evtCo.type == GoddessGloryEvtType.Challenge and evtCo.isBossEvent then
				stageMo.isBossAppear = true

				break
			end
		end
	end

	GoddessGloryPetsModel.instance:setPets(challengeId, stageId, msg.petIds)
end

function GoddessGloryModel:getGoddessGloryStage(id, stageId)
	if not self._challengeMOs then
		return
	end

	local challengeMO = self._challengeMOs[id]

	if not challengeMO then
		return
	end

	for i = 1, #challengeMO.stages do
		if challengeMO.stages[i].stageId == stageId then
			return challengeMO.stages[i]
		end
	end
end

function GoddessGloryModel:getEvent(id, stageId, instanceId)
	local stageMO = self:getGoddessGloryStage(id, stageId)

	if not stageMO then
		return
	end

	return stageMO:getEvent(instanceId)
end

function GoddessGloryModel:getGoddessGloryStoryId(id)
	if not self._challengeMOs then
		return 0
	end

	local challengeMO = self._challengeMOs[id]

	if challengeMO then
		return challengeMO.storyId or 0
	end

	return 0
end

function GoddessGloryModel:hasGoddessGloryStoryPlayed(id)
	if not self._challengeMOs then
		return false
	end

	local challengeMO = self._challengeMOs[id]

	return challengeMO and challengeMO.hasPlayedStory
end

function GoddessGloryModel:setGoddessGloryStoryPlayed(id)
	if not self._challengeMOs then
		return
	end

	local challengeMO = self._challengeMOs[id]

	if not challengeMO then
		return
	end

	local key = self:getGoddessGloryStoryKey(id)

	UnityEngine.PlayerPrefs.SetInt(key, 1)

	challengeMO.hasPlayedStory = true
end

function GoddessGloryModel:setGoddessGloryStageStoryPlayed(id, stageId)
	local stageMO = self:getGoddessGloryStage(id, stageId)

	if not stageMO then
		return
	end

	local key = self:getGoddessGloryStageStoryKey(id, stageId)

	UnityEngine.PlayerPrefs.SetInt(key, 1)

	stageMO.hasPlayedStory = true
end

function GoddessGloryModel:setGoddessGloryStageRulesShowed(id, stageId, saveUserDay)
	if saveUserDay then
		local key = self:getGoddessGloryStageRuleKey(id, stageId)

		GameUtil.saveUserDayData(key, 1)
	end
end

function GoddessGloryModel:hasShowedGoddessGloryStageRules(id, stageId)
	local key = self:getGoddessGloryStageRuleKey(id, stageId)

	return checknumber(GameUtil.getUserDayData(key)) == 1
end

function GoddessGloryModel:clearTasks(challengeId, stageId)
	local challengeMO = self:getGoddessGlory(challengeId)

	if not challengeMO then
		return
	end

	challengeMO.weeklyTasks = nil

	local stageMO = self:getGoddessGloryStage(challengeId, stageId)

	if not stageMO then
		return
	end

	stageMO.tasks = nil
end

function GoddessGloryModel:setGoddessGloryGetWeeklyTasks(challengeId, msg)
	local challengeMO = self:getGoddessGlory(challengeId)

	if not challengeMO then
		return
	end

	challengeMO.weeklyTasks = {}

	local taskInfos = msg.taskInfos

	for i = 1, #taskInfos do
		local taskMo = GoddessGloryWeeylyTaskMO.New()

		taskMo.challengeId = challengeId
		taskMo.type = taskInfos[i].type
		taskMo.progress = taskInfos[i].curProgress
		taskMo.gainPrizeIds = taskInfos[i].gainPrizeIds

		taskMo:calCurTaskId()
		table.insert(challengeMO.weeklyTasks, taskMo)
	end
end

function GoddessGloryModel:setGoddessGloryTaskInfo(challengeId, stageId, taskInfos)
	local stageMO = self:getGoddessGloryStage(challengeId, stageId)

	if not stageMO then
		return
	end

	local stageCo = GoddessGloryConfig.instance:getStageCo(challengeId, stageId)

	stageMO.tasks = {}

	for i = 1, #taskInfos do
		local taskMo = GoddessGloryTaskMO.New()

		taskMo.taskPlanId = stageCo.taskPlanId
		taskMo.type = taskInfos[i].type
		taskMo.progress = taskInfos[i].curProgress
		taskMo.gainPrizeIds = taskInfos[i].gainPrizeIds

		taskMo:calCurTaskId()
		table.insert(stageMO.tasks, taskMo)
	end
end

function GoddessGloryModel:gainGoddessGloryTaskPrize(challengeId, stageId, typeId, taskId)
	local stageMO = self:getGoddessGloryStage(challengeId, stageId)

	if not stageMO then
		return
	end

	for i = 1, #stageMO.tasks do
		local taskMo = stageMO.tasks[i]

		if taskMo.type == typeId then
			taskMo.gainPrizeIds = taskMo.gainPrizeIds or {}

			table.insert(taskMo.gainPrizeIds, taskId)
			taskMo:calCurTaskId()

			break
		end
	end
end

function GoddessGloryModel:gainGoddessGloryWeeklyTaskPrize(challengeId, typeId, taskId)
	local challengeMO = self:getGoddessGlory(challengeId)

	if not challengeMO then
		return
	end

	for i = 1, #challengeMO.weeklyTasks do
		local taskMo = challengeMO.weeklyTasks[i]

		if taskMo.type == typeId then
			taskMo.gainPrizeIds = taskMo.gainPrizeIds or {}

			table.insert(taskMo.gainPrizeIds, taskId)
			taskMo:calCurTaskId()

			break
		end
	end
end

function GoddessGloryModel:onGoddessGloryDoEventOver(msg)
	self._justFinishEventId = 0

	local stageMo = self:getGoddessGloryStage(msg.challengeId, msg.stageId)

	if not stageMo then
		return
	end

	local currExecuting = stageMo:getCurExecutingEvts()

	stageMo.stageInfos.energy = msg.energy
	stageMo.stageInfos.petIds = msg.petIds

	for i = 1, #msg.eventList do
		local evtNew = msg.eventList[i]

		for j = 1, #stageMo.stageInfos.eventList do
			local evt = stageMo.stageInfos.eventList[j]

			if evtNew.instanceId == evt.instanceId then
				stageMo.stageInfos.eventList[j] = evtNew

				break
			end
		end
	end

	for i = 1, #msg.eventList do
		local evtNew = msg.eventList[i]
		local found = false

		for j = 1, #stageMo.stageInfos.eventList do
			local evt = stageMo.stageInfos.eventList[j]

			if evtNew.instanceId == evt.instanceId then
				found = true

				break
			end
		end

		if not found then
			table.insert(stageMo.stageInfos.eventList, evtNew)
		end
	end

	stageMo.isBossAppear = false

	local newExecuting = stageMo:getCurExecutingEvts()

	for i = 1, #newExecuting do
		local evtCo = GoddessGloryConfig.instance:getEventCo(newExecuting[i].eventId)

		if evtCo.type == GoddessGloryEvtType.Challenge and evtCo.isBossEvent then
			local isBossAppear = true

			for j = 1, #currExecuting do
				if currExecuting[j].instanceId == newExecuting[i].instanceId then
					isBossAppear = false

					break
				end
			end

			if isBossAppear then
				stageMo.isBossAppear = true

				break
			end
		end
	end

	if msg.isFinish then
		self._justFinishEventId = msg.instanceId
	end

	self._bloodLossHp = msg.BloodLoss
end

function GoddessGloryModel:getBossBloodLossHp()
	return self._bloodLossHp
end

function GoddessGloryModel:onGoddessGloryViewRank(challengeId, stageId, msg)
	local stageMo = self:getGoddessGloryStage(challengeId, stageId)

	if not stageMo then
		return
	end

	stageMo:setRankList(msg.myRank, msg.rankSize, msg.rankList)
end

function GoddessGloryModel:getGoddessGloryStoryKey(id)
	return "goddessglorystory_" .. RoleModel.instance:getUserId() .. "_" .. id
end

function GoddessGloryModel:getGoddessGloryStageStoryKey(id, stageId)
	return "goddessglorystory_" .. RoleModel.instance:getUserId() .. "_" .. id .. "_" .. stageId
end

function GoddessGloryModel:getGoddessGloryStageRuleKey(id, stageId)
	return "goddessgloryrules_" .. RoleModel.instance:getUserId() .. "_" .. id .. "_" .. stageId
end

function GoddessGloryModel:getGoddessGloryName()
	return GoddessGloryConfig.instance:getParamString("GODDESS_GLORY_NAME")
end

function GoddessGloryModel:getTipsKey()
	return "tips_goddessglory"
end

function GoddessGloryModel:getExchangePushItem()
	return GoddessGloryConfig.instance:getParamString("PUSH_ITEM")
end

function GoddessGloryModel:getExchangePushItemTips()
	return GoddessGloryConfig.instance:getParamString("PUSH_ITEM_TIPS")
end

function GoddessGloryModel:getDefaultGoddesGloryId()
	return GoddessGloryConfig.instance:getParamInt("CHALLENGE_ID")
end

function GoddessGloryModel:getMainImage()
	local resName = GoddessGloryConfig.instance:getParamString("MAIN_IMAGE")

	return GoddessGloryModel.getSpineUrl(resName)
end

function GoddessGloryModel:getMainImagePose()
	local pose = GoddessGloryConfig.instance:getParamString("MAIN_IMAGE_POSE")
	local poseArr = string.split(pose, ",")

	return poseArr[1] or 0, poseArr[2] or 0, poseArr[3] or 1
end

function GoddessGloryModel:getEnergyItemId()
	return 1209
end

function GoddessGloryModel:getItemMatType()
	return GoddessGloryConfig.instance:getParamString("ITEM_MAT_TYPE")
end

function GoddessGloryModel:getTaskRedPointId()
	return GoddessGloryConfig.instance:getParamInt("RED_POINT_ID")
end

function GoddessGloryModel.getSpineUrl(path)
	local resPath

	return string.find(path, "_lihui") and GameUrl.getLihuiSpineUIUrl(path) or GameUrl.getSpineUIUrl(path)
end

GoddessGloryModel.instance = GoddessGloryModel.New()

return GoddessGloryModel
