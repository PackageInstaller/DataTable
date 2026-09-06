-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/TaskConst.lua

module("logic.extensions.task.model.TaskConst", package.seeall)

local TaskConst = {}

TaskConst.InvalidNpcId = 999
TaskConst.TSTEP_TG_NONE = nil
TaskConst.TSTEP_TG_ENTERSCENE = 1
TaskConst.TSTEP_TG_SCENETRIGGER = 2
TaskConst.TSTEP_TG_GETITEM = 3
TaskConst.TSTEP_TG_CHALLENGE = 4
TaskConst.TSTEP_TG_MOFANG = 5
TaskConst.TSTEP_TG_MAXFP = 6
TaskConst.TASK_S_UNAVAILABLE = 1
TaskConst.TASK_S_DOING = 2
TaskConst.TASK_S_FINISHED = 3
TaskConst.TASK_S_DELETE = 4
TaskConst.TSTEP_S_UNAVAILABLE = 1
TaskConst.TSTEP_S_ACCEPTED = 2
TaskConst.TSTEP_S_COMPELETED = 3
TaskConst.TSTEP_S_FINISHED = 4
TaskConst.TSTEP_TARGET_NONE = nil
TaskConst.TSTEP_TARGET_BATTLE_NPC = 1
TaskConst.TSTEP_TARGET_CHAT_NPC = 2
TaskConst.TSTEP_TARGET_SEARCH = 3
TaskConst.TSTEP_TARGET_COMMITITEM = 4
TaskConst.TSTEP_TARGET_COLLECT = 5
TaskConst.TSTEP_TARGET_USEITEM = 6
TaskConst.TSTEP_TARGET_CHALLENGE = 7
TaskConst.TSTEP_TARGET_CATCHMONSTER = 8
TaskConst.TSTEP_TARGET_PETLEVEL = 9
TaskConst.TSTEP_TARGET_HATCHEGG = 10
TaskConst.TSTEP_TARGET_PVE = 11
TaskConst.TSTEP_TARGET_COLL_PETS = 12
TaskConst.TSTEP_TARGET_TOWER = 13
TaskConst.TSTEP_TARGET_GENIES = 14
TaskConst.TSTEP_TARGET_FROMATION = 15
TaskConst.TSTEP_TARGET_EVOLVE = 16
TaskConst.TSTEP_TARGET_LEVELTO = 17
TaskConst.TSTEP_TARGET_GENIES_LEVEL = 18
TaskConst.TSTEP_TARGET_SANXIAO = 19
TaskConst.TSTEP_TARGET_ONLINEGIFT = 20
TaskConst.TSTEP_TARGET_INNEREVOLVE = 21
TaskConst.TSTEP_TARGET_PETRECORD = 22
TaskConst.TSTEP_TARGET_STARGODHUNTTIMERS = 23
TaskConst.TSTEP_TARGET_STARGODQUALITY = 24
TaskConst.TSTEP_TARGET_CATCHSOURCEMON = 25
TaskConst.TSTEP_TARGET_SOURCEMONLEVEL = 26
TaskConst.TSTEP_TARGET_STARGODLEVEL = 27
TaskConst.TSTEP_TARGET_GENIUSTIMES = 28
TaskConst.TSTEP_TARGET_WUSHENSHOUREWARD = 29
TaskConst.TSTEP_TARGET_DIAMONDACTIVITY = 30
TaskConst.TSTEP_TARGET_PETTRAINNING = 31
TaskConst.TSTEP_TARGET_JJC = 32
TaskConst.TSTEP_TARGET_STORYCOPY = 33
TaskConst.TSTEP_TARGET_EXPEDITIONSTEP = 34
TaskConst.TSTEP_TARGET_AWAKENLEVEL = 35
TaskConst.TSTEP_TARGET_ACHIEVEMENTDATA = 36
TaskConst.TSTEP_TARGET_BREAKFMTTIMES = 37
TaskConst.TSTEP_TARGET_XIAONUOBUYTIMES = 38
TaskConst.TSTEP_TARGET_KINGROAD = 39
TaskConst.TSTEP_TARGET_EQUIPMENTTIMES = 40
TaskConst.TSTEP_TARGET_RESCOPY = 41
TaskConst.TSTEP_TARGET_KINGROADNEW = 42
TaskConst.TSTEP_TARGET_JIUGONGBAZHEN = 43
TaskConst.TSTEP_TARGET_GAINPET = 44
TaskConst.TSTEP_TARGET_USERACTION = 45
TaskConst.TSTEP_TARGET_CSTZ = 46
TaskConst.TSTEP_TARGET_AOQIXUEYUAN = 47
TaskConst.TSTEP_TARGET_DAILYACTIVITY = 48
TaskConst.TSTEP_TARGET_EQUIPMENTLEVELUPTIMES = 49
TaskConst.TSTEP_TARGET_EQUIPSTARGODTIMES = 50
TaskConst.TSTEP_TARGET_SCCOPY = 51
TaskConst.USER_OP_COMMON = 0
TaskConst.USER_OP_COLLECT = 1
TaskConst.USER_OP_SCAN = 2
TaskConst.USER_OP_UNLOCK = 3
TaskConst.USER_OP_PICK = 4
TaskConst.USER_OP_CUTTING = 5
TaskConst.USER_OP_GREET = 6
TaskConst.USER_OP_UI_INTERACTIVE = 7
TaskConst.UI_INTERACTIVE_FRICT = 0
TaskConst.TASK_S_OFFLINE = 0
TaskConst.TASK_S_ONLINE = 1
TaskConst.TASK_S_CLIENT = 2
TaskConst.PERFORMED_TRIGERED = 1
TaskConst.PERFORMED_ACCEPTED = 2
TaskConst.PERFORMED_FINISHED = 3
TaskConst.PERFORMED_CHATNPC = 4
TaskConst.PERFORMED_SEACHZONE = 5
TaskConst.PERFORMED_BATTLERELTFAILED = 6
TaskConst.PERFORMED_BATTLERELTSUCCESS = 7
TaskConst.PERFORMED_USERACTION = 8
TaskConst.PM_NONE = nil
TaskConst.PM_STORY = 1
TaskConst.PM_ANIMATION = 2
TaskConst.PM_DIALOG = 3
TaskConst.PM_VIDEO = 4
TaskConst.PM_CARTOON = 5
TaskConst.PM_PETBATTLE = 6
TaskConst.PM_UI = 7
TaskConst.PM_EVOLVE = 8
TaskConst.GOTONPC = 1
TaskConst.GOTOSCENE = 2
TaskConst.GOTO = 3
TaskConst.GOTOSCENETRIGGER = 4
TaskConst.GOTOMONSTER = 5
TaskConst.GOTOSOURCEMON = 6
TaskConst.DIALOG_NONE = nil
TaskConst.DIALOG_CLOSE = 0
TaskConst.DIALOG_SURE = 1
TaskConst.DIALOG_COMMON = 2
TaskConst.DIALOG_MODEL = 3
TaskConst.ON_TASK_DIALOG_CANCEL = 1
TaskConst.ON_TASK_DIALOG_SURE = 2
TaskConst.ON_TASK_STATE = 31
TaskConst.ON_TASK_PROGRESS = 32
TaskConst.ON_TASK_COLLECT_BREAK = 4
TaskConst.ON_TASK_COLLECT_FINISH = 5
TaskConst.ON_TASK_USEITEM_BREAK = 6
TaskConst.ON_TASK_USEITEM_FINISH = 7
TaskConst.ON_UI_INTERACTIVE_FINISH = 8
TaskConst.BattleStoryTrigger_None = nil
TaskConst.BattleStoryTrigger_Start = 0
TaskConst.BattleStoryTrigger_PetAttacke = 1
TaskConst.BattleStoryTrigger_End = 2
TaskConst.BattleStoryTrigger_Round = 3
TaskConst.BattleType_None = 0
TaskConst.BattleType_Immediately = 1
TaskConst.BattleType_Mission = 2
TaskConst.PetRecordType_Genius = "genius"
TaskConst.PetRecordType_Level = "level"

function TaskConst.isDialogBlockTask(dialog)
	return dialog == TaskConst.DIALOG_SURE or dialog == TaskConst.DIALOG_COMMON or dialog == TaskConst.DIALOG_MODEL
end

function TaskConst.getTaskTrigger(task)
	local taskCo = task.taskCo

	if not taskCo.trigger or #taskCo.trigger == 0 then
		return TaskConst.TSTEP_TG_NONE
	end

	local triggerType = tonumber(taskCo.trigger[1])
	local trigger = {
		trigger = triggerType,
		task = task
	}

	if triggerType == TaskConst.TSTEP_TG_ENTERSCENE then
		trigger.sceneId = tonumber(taskCo.trigger[2])
		trigger.showOnUI = taskCo.trigger[3] and checknumber(taskCo.trigger[3]) ~= 0
	elseif triggerType == TaskConst.TSTEP_TG_MOFANG then
		trigger.mofangLevel = tonumber(taskCo.trigger[2])
		trigger.showOnUI = taskCo.trigger[3] and checknumber(taskCo.trigger[3]) ~= 0
	elseif triggerType == TaskConst.TSTEP_TG_MAXFP then
		trigger.maxFightingPower = tonumber(taskCo.trigger[2])
		trigger.showOnUI = taskCo.trigger[3] and checknumber(taskCo.trigger[3]) ~= 0
	elseif triggerType == TaskConst.TSTEP_TG_SCENETRIGGER then
		trigger.sceneId = tonumber(taskCo.trigger[2])
		trigger.triggerId = tonumber(taskCo.trigger[3])
		trigger.showOnUI = taskCo.trigger[4] and checknumber(taskCo.trigger[4]) ~= 0
	elseif triggerType == TaskConst.TSTEP_TG_GETITEM then
		trigger.itemId = tonumber(taskCo.trigger[3])
		trigger.showOnUI = taskCo.trigger[4] and checknumber(taskCo.trigger[4]) ~= 0
	elseif triggerType == TaskConst.TSTEP_TG_CHALLENGE then
		trigger.challengeId = tonumber(taskCo.trigger[2])
		trigger.challengeParseId = tonumber(taskCo.trigger[3])
		trigger.challengeBranchId = tonumber(taskCo.trigger[4])
		trigger.showOnUI = taskCo.trigger[5] and checknumber(taskCo.trigger[5]) ~= 0
	end

	return trigger
end

function TaskConst.getTaskStepTargetType(targetConfig)
	if not targetConfig or #targetConfig == 0 then
		return TaskConst.TSTEP_TARGET_NONE
	end

	return tonumber(targetConfig[1])
end

function TaskConst.getTaskStepTarget(targetConfig, taskStep)
	local tType = TaskConst.getTaskStepTargetType(targetConfig)

	if tType == TaskConst.TSTEP_TARGET_NONE then
		return nil
	end

	local target = {
		targetType = tType,
		taskStep = taskStep
	}

	if tType == TaskConst.TSTEP_TARGET_BATTLE_NPC then
		target.monsterId = tonumber(targetConfig[2])
		target.monsterTimes = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_CHALLENGE then
		target.challengeId = tonumber(targetConfig[2])
		target.parseId = tonumber(targetConfig[3])
		target.brancheId = tonumber(targetConfig[4])

		if not targetConfig[5] or tonumber(targetConfig[5]) == 0 then
			target.needGoToNpc = true
		end

		if targetConfig[6] then
			target.battleStoryId = StoryFacade.instance:parseGenderStory(tonumber(targetConfig[6]))
			target.battleStoryMode = tonumber(targetConfig[7])

			if target.battleStoryMode == TaskConst.BattleStoryTrigger_Round then
				target.battleStoryRound = tonumber(targetConfig[8])
			elseif target.battleStoryMode == TaskConst.BattleStoryTrigger_PetAttacke then
				target.battleStoryPet = tonumber(targetConfig[8])
			end
		end
	elseif tType == TaskConst.TSTEP_TARGET_PVE then
		target.pveId = tonumber(targetConfig[2])
		target.directStart = targetConfig[3] and tonumber(targetConfig[3]) ~= 0
		target.battleNpc = UnlockConfig.instance:getNpcByFuncParams(NpcFuncType.WuShenShou, target.pveId)
		target.battleNeedSuccess = not targetConfig[4] or tonumber(targetConfig[4]) ~= 0
		target.needCompInUI = tonumber(targetConfig[5]) ~= 0
		target.failedStoryId = StoryFacade.instance:parseGenderStory(checknumber(targetConfig[6]))
		target.successStoryId = StoryFacade.instance:parseGenderStory(checknumber(targetConfig[7]))

		if not target.battleNpc or target.battleNpc == 0 then
			target.battleNpc = checknumber(targetConfig[8])
			target.battleNpcOpenUI = true
		end

		if targetConfig[9] then
			target.battleStoryId = StoryFacade.instance:parseGenderStory(tonumber(targetConfig[9]))
			target.battleStoryMode = tonumber(targetConfig[10])

			if target.battleStoryMode == TaskConst.BattleStoryTrigger_Round then
				target.battleStoryRound = tonumber(targetConfig[11])
			elseif target.battleStoryMode == TaskConst.BattleStoryTrigger_PetAttacke then
				target.battleStoryPet = tonumber(targetConfig[11])
			end
		end
	elseif tType == TaskConst.TSTEP_TARGET_CHAT_NPC then
		target.chatNpcId = tonumber(targetConfig[2])

		if targetConfig[3] then
			target.chatStoryId = StoryFacade.instance:parseGenderStory(tonumber(targetConfig[3]))
		end
	elseif tType == TaskConst.TSTEP_TARGET_SEARCH then
		target.sceneId = tonumber(targetConfig[2] or 0)
		target.triggerId = tonumber(targetConfig[3] or 0)

		if targetConfig[4] then
			target.chatStoryId = StoryFacade.instance:parseGenderStory(tonumber(targetConfig[4] or 0))
		end

		if targetConfig[5] then
			target.followNpcs = TaskConst.readNumArray(targetConfig[5])
		end
	elseif tType == TaskConst.TSTEP_TARGET_EQUIPMENTTIMES then
		target.times = tonumber(targetConfig[2] or 0)
	elseif tType == TaskConst.TSTEP_TARGET_EQUIPMENTLEVELUPTIMES then
		target.times = tonumber(targetConfig[2] or 0)
	elseif tType == TaskConst.TSTEP_TARGET_EQUIPSTARGODTIMES then
		target.times = tonumber(targetConfig[2] or 0)
	elseif tType == TaskConst.TSTEP_TARGET_COLLECT then
		target.itemId = tonumber(targetConfig[2])
		target.itemNum = tonumber(targetConfig[3])
		target.collectNpcId = tonumber(targetConfig[4] or 0)
	elseif tType == TaskConst.TSTEP_TARGET_USERACTION then
		target.actionType = tonumber(targetConfig[2])
		target.collectNpcId = tonumber(targetConfig[3])
		target.sceneId = tonumber(targetConfig[4] or 0)
		target.triggerId = tonumber(targetConfig[5] or 0)
		target.chatStoryId = StoryFacade.instance:parseGenderStory(tonumber(targetConfig[6] or 0))
		target.times = tonumber(targetConfig[7] or 0)
		target.uiActionType = tonumber(targetConfig[8] or 0)
		target.storyIndex = tonumber(targetConfig[9] or 0)

		if target.times == 0 then
			target.times = 1
		end

		if target.storyIndex == 0 then
			target.storyIndex = 1
		end
	elseif tType == TaskConst.TSTEP_TARGET_USEITEM then
		target.itemId = tonumber(targetConfig[2])
		target.sceneId = tonumber(targetConfig[3] or 0)
		target.triggerId = tonumber(targetConfig[4] or 0)
	elseif tType == TaskConst.TSTEP_TARGET_COMMITITEM then
		target.itemId = tonumber(targetConfig[2])
		target.itemNum = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_HATCHEGG then
		target.petId = tonumber(targetConfig[2])
		target.hatchTimes = tonumber(targetConfig[3])
		target.battleNpc = UnlockConfig.instance:getFuncNpc(NpcFuncType.PetEgg)
	elseif tType == TaskConst.TSTEP_TARGET_PETLEVEL then
		target.petId = tonumber(targetConfig[2])
		target.levelTimes = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_CATCHMONSTER then
		target.petId = tonumber(targetConfig[2])
		target.catchTimes = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_CATCHSOURCEMON then
		target.sourceMonType = tonumber(targetConfig[2])
		target.catchTimes = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_COLL_PETS then
		target.petId = tonumber(targetConfig[2])
		target.petNumber = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_TOWER then
		target.towerId = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_KINGROAD then
		target.kingRoadId = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_KINGROADNEW then
		target.kingRoadId = tonumber(targetConfig[2])
		target.kingRoadLevelId = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_JIUGONGBAZHEN then
		-- block empty
	elseif tType == TaskConst.TSTEP_TARGET_PETTRAINNING then
		target.levelId = tonumber(targetConfig[2])
		target.uiName = targetConfig[3]
		target.uiParams = targetConfig[4]
		target.uiTab = targetConfig[5]
	elseif tType == TaskConst.TSTEP_TARGET_GENIES then
		target.petIds = TaskConst.readNumArray(targetConfig[2])
		target.geniusLevel = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_FROMATION then
		target.formationId = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_EVOLVE then
		target.petId = tonumber(targetConfig[2])
		target.uiName = targetConfig[3]
		target.uiParams = targetConfig[4]
		target.uiTab = targetConfig[5]
	elseif tType == TaskConst.TSTEP_TARGET_LEVELTO then
		target.petIds = TaskConst.readNumArray(targetConfig[2])
		target.level = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_PETRECORD then
		target.recordType = targetConfig[2]
		target.level = tonumber(targetConfig[3])
		target.petNumber = tonumber(targetConfig[4])
		target.uiName = targetConfig[5]
		target.uiParams = targetConfig[6]
		target.uiTab = targetConfig[7]
	elseif tType == TaskConst.TSTEP_TARGET_STARGODHUNTTIMERS then
		target.times = tonumber(targetConfig[2])
		target.uiName = targetConfig[3]
		target.uiParams = targetConfig[4]
		target.uiTab = targetConfig[5]
	elseif tType == TaskConst.TSTEP_TARGET_STARGODQUALITY then
		target.times = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_SOURCEMONLEVEL then
		target.sourceMonType = tonumber(targetConfig[2])
		target.times = tonumber(targetConfig[3])
		target.level = tonumber(targetConfig[4])
		target.uiName = targetConfig[5]
		target.uiParams = targetConfig[6]
		target.uiTab = targetConfig[7]
	elseif tType == TaskConst.TSTEP_TARGET_STARGODLEVEL then
		target.times = tonumber(targetConfig[4])

		if target.times <= 0 then
			target.times = 1
		end

		target.uiName = targetConfig[5]
		target.uiParams = targetConfig[6]
		target.uiTab = targetConfig[7]
	elseif tType == TaskConst.TSTEP_TARGET_GENIUSTIMES then
		target.petId = checknumber(targetConfig[2])
		target.times = tonumber(targetConfig[3])

		if target.times <= 0 then
			target.times = 1
		end

		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_WUSHENSHOUREWARD then
		target.rewardId = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_DIAMONDACTIVITY then
		target.times = tonumber(targetConfig[4])
	elseif tType == TaskConst.TSTEP_TARGET_INNEREVOLVE then
		target.petIds = {}
		target.petIds[1] = tonumber(targetConfig[2])
		target.petIds[2] = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_GENIES_LEVEL then
		target.petIds = TaskConst.readNumArray(targetConfig[2])
		target.levelTimes = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_SANXIAO then
		target.times = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_ONLINEGIFT then
		target.times = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_JJC then
		target.times = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	elseif tType == TaskConst.TSTEP_TARGET_EXPEDITIONSTEP then
		target.times = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_XIAONUOBUYTIMES then
		target.times = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_BREAKFMTTIMES then
		target.times = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_STORYCOPY then
		target.copyId = tonumber(targetConfig[2])
		target.levelId = tonumber(targetConfig[3])
	elseif tType == TaskConst.TSTEP_TARGET_SCCOPY then
		target.activityId = tonumber(targetConfig[2])
		target.typeId = tonumber(targetConfig[3])
		target.chapterId = tonumber(targetConfig[4])
	elseif tType == TaskConst.TSTEP_TARGET_CSTZ then
		target.copyId = tonumber(targetConfig[2])
		target.levelId = tonumber(targetConfig[3])
		target.battleType = tonumber(targetConfig[4])
		target.battleNpc = UnlockConfig.instance:getNpcByFuncParams(NpcFuncType.Legend, target.copyId)
	elseif tType == TaskConst.TSTEP_TARGET_AOQIXUEYUAN then
		target.copyId = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_DAILYACTIVITY then
		target.number = tonumber(targetConfig[2])
	elseif tType == TaskConst.TSTEP_TARGET_RESCOPY then
		target.copyId = tonumber(targetConfig[2])
		target.levelId = tonumber(targetConfig[3])
		target.battleType = tonumber(targetConfig[4])
	elseif tType == TaskConst.TSTEP_TARGET_ACHIEVEMENTDATA then
		target.achievementId = tonumber(targetConfig[2])
		target.times = tonumber(targetConfig[3])
		target.uiName = targetConfig[4]
		target.uiParams = targetConfig[5]
		target.uiTab = targetConfig[6]
	end

	return target
end

function TaskConst.readNumArray(str, del)
	local params = string.split(str, del or "#")
	local cnt = #params
	local a = {}

	for i = 1, cnt do
		a[i] = tonumber(params[i])
	end

	return a
end

function TaskConst.parseChallengeBranchIds(challengeConfig)
	if not levelConfig then
		return nil
	end

	local sep = ","
	local t = {}
	local i = 1

	for str in string.gmatch(levelConfig, "([^" .. sep .. "]+)") do
		t[i] = tonumber(str)
		i = i + 1
	end

	return t
end

function TaskConst.getPerformed(pType, performedStr)
	if not performedStr or #performedStr == 0 then
		return nil
	end

	local method = tonumber(performedStr[1])
	local performed = {
		performedType = pType,
		method = method
	}

	if method == TaskConst.PM_STORY then
		performed.storyId = StoryFacade.instance:parseGenderStory(tonumber(performedStr[2]))
	elseif method == TaskConst.PM_DIALOG then
		performed.dialog = tonumber(performedStr[2])
		performed.content = tonumber(performedStr[3])

		if performed.dialog == TaskConst.DIALOG_MODEL then
			performed.modelId = tonumber(performedStr[4])
			performed.x = tonumber(performedStr[5])
			performed.y = tonumber(performedStr[6])
			performed.z = tonumber(performedStr[7])
			performed.scale = tonumber(performedStr[8])
			performed.time = tonumber(performedStr[9])
		elseif performed.dialog == TaskConst.DIALOG_CLOSE then
			performed.cTextId = tonumber(performedStr[4])
		elseif performed.dialog == TaskConst.DIALOG_SURE then
			performed.sTextId = tonumber(performedStr[4])
		elseif performed.dialog == TaskConst.DIALOG_COMMON then
			performed.sTextId = tonumber(performedStr[4])
			performed.cTextId = tonumber(performedStr[5])
		end
	elseif method == TaskConst.PM_ANIMATION then
		performed.animName = tonumber(performedStr[2])
	elseif method == TaskConst.PM_UI then
		performed.uiName = performedStr[2]
		performed.uiParams = performedStr[3]
	elseif method == TaskConst.PM_VIDEO then
		performed.videoName = tonumber(performedStr[2])
	elseif method == TaskConst.PM_PETBATTLE then
		performed.eveBattleIdA = tonumber(performedStr[2])
		performed.eveBattleIdB = tonumber(performedStr[3])

		if performedStr[4] then
			performed.battleStoryId = StoryFacade.instance:parseGenderStory(tonumber(performedStr[4]))
			performed.battleStoryMode = tonumber(performedStr[5])

			if performed.battleStoryMode == TaskConst.BattleStoryTrigger_Round then
				performed.battleStoryRound = tonumber(performedStr[6])
			elseif performed.battleStoryMode == TaskConst.BattleStoryTrigger_PetAttacke then
				performed.battleStoryPet = tonumber(performedStr[6])
			end
		end
	end

	return performed
end

function TaskConst.getTaskTypeName(taskType)
	if taskType == GameEnum.TaskType.Main then
		return lang("task_main")
	elseif taskType == GameEnum.TaskType.Branch then
		return lang("task_branch")
	elseif taskType == GameEnum.TaskType.Guide then
		return lang("task_guide")
	elseif taskType == GameEnum.TaskType.Daily then
		return lang("task_daily")
	elseif taskType == GameEnum.TaskType.Festival then
		return lang("task_festival")
	end
end

return TaskConst
