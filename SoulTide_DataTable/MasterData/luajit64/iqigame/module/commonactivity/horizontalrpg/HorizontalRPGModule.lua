-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGModule.lua

local m = {
	enterMazeState = 0,
	continuedTriggerCD = 1,
	globalCid = 0,
	execution_Settlement = false,
	pickedUpBox = {},
	oldMazeInstances = {}
}

require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGConstant")

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local HorizontalRPGScene = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGScene")
local HorizontalRPGPlayerData = require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGPlayerData")
local HorizontalRPGMapData = require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGMapData")
local HorizontalRPGCameraObsData = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGCameraObsData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")
local json = require("Util.json")

function m.Reload(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.dailyDupPOD then
		m.globalCid = m.dailyDupPOD.common.openCount
		m.currDialog = m.dailyDupPOD.horizontalRPGPOD.dialog
		m.currLevelDialog = m.dailyDupPOD.horizontalRPGPOD.levelDialog

		if m.dailyDupPOD.horizontalRPGPOD then
			m.InitData()
		end
	end

	m.AddListeners()
end

function m.AddListeners()
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, m.OnCloseDialog)
	EventDispatcher.AddEventListener(EventID.OpenDialogUI, m.OnOpenDialog)
end

function m.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, m.OnCloseDialog)
	EventDispatcher.RemoveEventListener(EventID.OpenDialogUI, m.OnOpenDialog)
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[27]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 0
end

function m.IsEnter()
	local cfgDailyDupData = CfgDailyDupTable[27]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status == 1
end

function m.CanNotEnter()
	return m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status == 1
end

function m.GetExploreUIAsset()
	local cfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[m.globalCid]

	return cfgHorizontalRPGControlData.ExploreHallUIBG
end

function m.CheckResumeDialog()
	if m.currDialog ~= nil and m.currDialog ~= 0 then
		EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
		DialogModule.OpenDialog(m.currDialog, false, true)

		m.currDialog = nil
	end
end

function m.CheckResumeLevelDialog()
	if m.currLevelDialog ~= nil and m.currLevelDialog ~= 0 then
		DialogModule.OpenDialog(m.currLevelDialog, false, true)

		m.currLevelDialog = nil
	end
end

function m.CheckResume()
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeHorizontalChallenge)

	if unfinishedMazeCid ~= nil then
		MazeModule.SendRestore(unfinishedMazeCid)
	end

	m.CheckResumeLevelDialog()
end

function m.Update(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.IsShow() and m.globalCid ~= m.dailyDupPOD.common.openCount then
		m.globalCid = m.dailyDupPOD.common.openCount

		m.InitData()
	end

	if m.dailyDupPOD.common.status ~= 1 then
		m.EndOfActivity()
	end
end

function m.UpdateRPGElement(type, elementPODs)
	for i, newElementPOD in pairs(elementPODs) do
		if type == HorizontalRPGConstant.ElementUpdateType.Update then
			for k, oldElementPOD in pairs(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element) do
				if oldElementPOD.id == newElementPOD.id then
					m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element[k] = newElementPOD
				end
			end
		elseif type == HorizontalRPGConstant.ElementUpdateType.Delete then
			for k, oldElementPOD in pairs(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element) do
				if oldElementPOD.id == newElementPOD.id then
					m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element[k] = nil
				end
			end
		elseif type == HorizontalRPGConstant.ElementUpdateType.Add then
			local have = false

			for k, oldElementPOD in pairs(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element) do
				if oldElementPOD.id == newElementPOD.id then
					m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element[k] = newElementPOD
					have = true

					break
				end
			end

			if not have then
				table.insert(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element, newElementPOD)
			end
		end
	end

	m.currentHorizontalRPGMapData:RefreshMapData()
	m.horizontalRPGScene:RefreshShowAreas()
end

function m.IsUnlockBoos(boosID)
	if m.dailyDupPOD.horizontalRPGPOD then
		return table.indexOf(m.dailyDupPOD.horizontalRPGPOD.boss, boosID) ~= -1
	end

	return false
end

function m.ExBossOpen()
	if m.dailyDupPOD.horizontalRPGPOD then
		return m.dailyDupPOD.horizontalRPGPOD.exBoss
	end

	return false
end

function m.CheckHorizontalMazeInstance(mazeId)
	return m.oldMazeInstances[mazeId] ~= nil
end

function m.CheckHorizontalTimeByResCid(resCid)
	for k, v in pairs(m.oldMazeInstances) do
		local index = table.indexOf(v.ResId, resCid)

		if index ~= -1 then
			return index
		end
	end

	return 0
end

function m.GetMazeLevelResID(mazeId)
	local cfgData = m.oldMazeInstances[mazeId]

	if cfgData == nil then
		logError("配置错误，HorizontalRPGTime 表中没有 mazeId = " .. mazeId .. "相关配置")

		return
	end

	local weather = m.dailyDupPOD.horizontalRPGPOD.weather or 0
	local index = weather + 1

	return cfgData.ResId[index]
end

function m.PickedUpBoxState(elementID)
	for i, v in pairs(m.pickedUpBox) do
		if v.cid == elementID then
			return 1
		end
	end

	if m.horizontalRPGScene and m.horizontalRPGScene.PutBoxElement[elementID] ~= nil then
		return 2
	end

	return 0
end

function m.IsShowElement(elementCid)
	if m.dailyDupPOD.horizontalRPGPOD and m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs then
		for i, v in pairs(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.element) do
			if v.id == elementCid then
				local state = m.PickedUpBoxState(elementCid)

				if state == 1 then
					return false, v
				end

				return true, v
			end
		end
	end

	return false, nil
end

function m.InitData()
	m.oldMazeInstances = {}

	for i, v in pairsCfg(CfgHorizontalRPGTimeTable) do
		m.oldMazeInstances[v.MazeInstanceId] = v
	end

	m.horizontalRPGPlayerData = HorizontalRPGPlayerData.New(m.dailyDupPOD.horizontalRPGPOD.star, m.dailyDupPOD.horizontalRPGPOD.starUpperLimit)
end

function m.OnCloseDialog()
	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)
end

function m.OnOpenDialog()
	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
end

function m.EndOfActivity()
	if m.enterMazeState == 1 then
		MazeModule.SendLeaveMazeOrder()
	elseif m.enterMazeState == 2 then
		m.ExitHorizontalRPGScene()
	end
end

function m.EnterHorizontalRPG()
	if not m.CanNotEnter() then
		return
	end

	if m.dailyDupPOD.horizontalRPGPOD ~= nil and m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs ~= nil then
		m.EnterHorizontalRPGScene(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.id, m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.region)
	else
		local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeHorizontalRPG)

		if unfinishedMazeCid ~= nil then
			MazeModule.SendRestore(unfinishedMazeCid)

			return
		end

		local cfgData = CfgHorizontalRPGControlTable[m.globalCid]

		m.ElementExecutionElse({
			cfgData.Service
		})
	end
end

function m.DoOldMazeExecution(cfgExecutionData)
	m.cfgExecutionData = cfgExecutionData

	MazeModule.SendLeaveMazeOrder()
end

function m.ExitTheOldMaze()
	if not m.CanNotEnter() then
		return
	end

	if m.cfgExecutionData then
		local type = tonumber(m.cfgExecutionData.Params[1])
		local horizontalRPGServiceID = tonumber(m.cfgExecutionData.Params[2])

		log("完全退出老迷宫 执行传送服务 type = " .. type .. " horizontalRPGServiceID = " .. tostring(horizontalRPGServiceID))
		HorizontalRPGModule.ElementExecutionElse({
			horizontalRPGServiceID
		})

		m.cfgExecutionData = nil
	elseif m.enterOldMazeCid == 26070001 then
		m.ExitHorizontalRPGScene()
	else
		m.EnterHorizontalRPG()
	end

	m.enterOldMazeCid = 0
end

function m.GetAmusementParkTaskDataList()
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.HORIZONTAL_RPG_TASK)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.HORIZONTAL_RPG_TASK)

	for i = 1, #processing do
		local taskData = processing[i]
		local taskUIData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(taskUIDataList, taskUIData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgMainQuestData = CfgMainQuestTable[taskCid]

		if cfgMainQuestData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
			local taskUIData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(taskUIDataList, taskUIData)
		end
	end

	return taskUIDataList
end

function m.CheckHorizontalRPGTaskRedPoint()
	local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.HORIZONTAL_RPG_TASK)

	for i, v in pairs(tasks) do
		if v.finNum >= v.tgtNum then
			return true
		end
	end

	return false
end

function m.ChangePlayerStar(lv, state)
	m.horizontalRPGPlayerData.lv = lv

	EventDispatcher.Dispatch(EventID.HorizontalRPGPlayerDataChange)
	m.horizontalRPGScene.HorizontalGamePaler:Refresh(m.horizontalRPGPlayerData, state)
end

function m.EnterHorizontalRPGScene(mapID, areaID)
	m.pickedUpBox = {}
	m.currentHorizontalRPGMapData = HorizontalRPGMapData.New(mapID, areaID)

	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.HorizontalRPG, m.OnSceneLoaded)
end

function m.ExitHorizontalRPGScene()
	CommonActivitySceneModule.Jump(m.DisposeHorizontalRPGScene, 10901011)
end

function m.EnterMapArea(areaID)
	if m.currentHorizontalRPGMapData.currentAreaID ~= areaID then
		m.currentHorizontalRPGMapData:ChangeArea(areaID)
		m.horizontalRPGScene:RefreshShowAreas()
	end
end

function m.ExecutionTalkEndService(chatID, elementID)
	local cfgData = CfgHorizontalRPGChatTable[chatID]

	if #cfgData.ServiceID > 0 then
		log("对话结束 对话ID = " .. chatID .. "调用服务端接口，执行对话服务 " .. tableToString(cfgData.ServiceID))
		m.ElementExecutionElse(cfgData.ServiceID)
	end
end

function m.PlaceTheBox()
	local putElementData = table.remove(m.pickedUpBox, 1)

	if putElementData then
		putElementData:UpDateState(true, putElementData.horizontalRPGElementPOD)
		log("放下的箱子 " .. putElementData.cid)
		m.horizontalRPGScene:PlaceTheBoxInScene(putElementData)
		EventDispatcher.Dispatch(EventID.HorizontalRPGBoxPickingEvent, putElementData.cid)
	end
end

function m.PickUpTheBox(elementCid)
	local element = m.horizontalRPGScene.HorizontalSceneObjManager:GetElementByID(elementCid)

	if element == nil then
		logError("没有找到箱子 " .. elementCid)

		return
	end

	local delElementData = element.ElementData

	if delElementData == nil then
		return
	end

	table.insert(m.pickedUpBox, delElementData)
	delElementData:UpDateState(false, delElementData.horizontalRPGElementPOD)
	m.horizontalRPGScene:RemoveBoxElement(element)
	EventDispatcher.Dispatch(EventID.HorizontalRPGBoxPickingEvent, elementCid)
end

function m.TriggerElementService(triggerType, elementCid)
	log("触发元素服务 TriggerType = " .. triggerType .. " 元素ID = " .. elementCid)

	local element = m.horizontalRPGScene.HorizontalSceneObjManager:GetElementByID(elementCid)

	if element == nil then
		logError("没有找到元素 " .. elementCid)

		return
	end

	if triggerType == HorizontalRPGConstant.ElementTriggerType.CollisionElementByBullet and element.ElementFireCtrl and element.ElementFireCtrl.bulletData and not element.ElementFireCtrl.bulletData:GetCfgData().IsLoop then
		element.ElementFireCtrl:Fire()
	end

	if element.ElementData then
		local haveService, successfulService = element.ElementData:GetSuccessfulService(triggerType)

		if haveService then
			local services = {}

			for serverID, executions in pairs(successfulService) do
				table.insert(services, serverID)
			end

			log("调用服务端接口，执行服务：" .. tableToString(services) .. " 服务对应的执行：" .. tableToString(successfulService))

			if m.horizontalRPGScene.HorizontalGamePaler:PlayerIsDie() and GameEntry.Base.DevMode then
				log("角色已死亡，不再请求服务端执行服务")
			end

			m.ElementExecution(m.currentHorizontalRPGMapData.cid, m.currentHorizontalRPGMapData.currentAreaID, elementCid, triggerType)
		end
	end
end

function m.ExecutionResult(horizontalRPGResPods)
	for i, v in pairs(horizontalRPGResPods) do
		local userDataTab = json.decode(v.info)

		log(tableToString(userDataTab))
		m.ExecuteServices(v.type, userDataTab)
	end
end

function m.ExecuteServices(executeType, params)
	if GameEntry.Base.DevMode then
		log("返回 元素执行 执行类型 executeType = " .. executeType .. " params = " .. tableToString(params))
	end

	if executeType == HorizontalRPGConstant.ExecutionType.Execution_Dialogue then
		local dialogID = params.dialog

		if dialogID > 0 then
			EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
			DialogModule.OpenDialog(dialogID, false, true)
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_Prompt then
		local noticeID = params.tip

		if noticeID then
			NoticeModule.ShowNotice(noticeID)
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_Bubbles then
		local rpgChatID = params.bubble

		if rpgChatID > 0 then
			UIModule.Open(Constant.UIControllerName.HorizontalRPGChatDialogUI, Constant.UILayer.UI, {
				ChatID = rpgChatID
			})
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_Options then
		local options = params.options

		if options > 0 then
			UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeSelectPanelUI, Constant.UILayer.Mid, {
				selectionCid = options
			})
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ChangeStars then
		local state = params.state

		m.ChangePlayerStar(params.star, state)

		local str = params.value

		if params.value > 0 then
			str = "+" .. params.value
		end

		if state == 0 then
			NoticeModule.ShowNotice(21045122)
		end

		if state == 2 then
			EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
		end

		log("收到修改星星数量返回 state = " .. state .. " star = " .. params.star)
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ChangeMaxStars then
		local num = params.upperLimit

		m.horizontalRPGPlayerData.maxLv = num

		EventDispatcher.Dispatch(EventID.HorizontalRPGPlayerDataChange)
		GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.AddMaxStar, Constant.SoundGroup.ENVIRONMENT)

		if GameEntry.Base.DevMode then
			log("播放加星星上限音效 " .. HorizontalRPGConstant.Sound.AddMaxStar)
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_RefreshMap then
		EventDispatcher.Dispatch(EventID.HorizontalRPGChangeSceneEffect, true)

		local timer = Timer.New(function()
			m.ChangePlayerStar(params.star)

			m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs = params.horizontalRPGMapPOD

			m.currentHorizontalRPGMapData:RefreshMapData()
			m.horizontalRPGScene:RefreshShowAreas()

			if params.type == 0 then
				m.horizontalRPGScene.HorizontalGamePaler.isBirth = false

				m.horizontalRPGScene:GetPlayerBirthPoint()
			end
		end, 0.8)

		timer:Start()
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ChangeDay then
		m.dailyDupPOD.horizontalRPGPOD.weather = params.weather

		m.horizontalRPGScene:RefreshWeather()
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_Drop then
		if #params.item > 0 then
			for i, v in pairs(params.item) do
				if CfgItemTable[v.cid].IsRewardShow then
					NoticeModule.ShowFloatGetItem(v.cid, v.num)
				end
			end
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_Delivery then
		local mapID = params.horizontalRPGMapPOD.id
		local region = params.horizontalRPGMapPOD.region

		m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs = params.horizontalRPGMapPOD

		if m.currentHorizontalRPGMapData and mapID == m.currentHorizontalRPGMapData.cid and m.horizontalRPGScene then
			EventDispatcher.Dispatch(EventID.HorizontalRPGChangeSceneEffect, false)

			local timer = Timer.New(function()
				m.horizontalRPGScene.HorizontalGamePaler.isBirth = false

				m.horizontalRPGScene:GetPlayerBirthPoint()
			end, 0.8)

			timer:Start()
		else
			if m.horizontalRPGScene then
				m.horizontalRPGScene:Dispose()
			end

			m.horizontalRPGScene = nil

			m.EnterHorizontalRPGScene(mapID, region)
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_EnterMaze then
		if params.cid > 0 then
			m.DisposeHorizontalRPGScene()
			MazeModule.SendRestore(params.cid)

			m.enterMazeState = 1
		elseif params.maze then
			m.DisposeHorizontalRPGScene()
			MazeModule.EnterMaze(params.maze)

			m.enterMazeState = 1
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_MoveCamera then
		local elementPos = {}

		for i = 1, #params.lensDisplay do
			local elementCid = params.lensDisplay[i]
			local element = m.horizontalRPGScene.HorizontalSceneObjManager:GetElementByID(elementCid)

			if element then
				local cameraObsData = HorizontalRPGCameraObsData.New(element.View.transform.position, 0.05)

				table.insert(elementPos, cameraObsData)
			end
		end

		HorizontalRPGModule.horizontalRPGScene.ObservationPositions = elementPos
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ChangeTask then
		m.dailyDupPOD.horizontalRPGPOD.task = m.dailyDupPOD.horizontalRPGPOD.task or {}

		if table.indexOf(m.dailyDupPOD.horizontalRPGPOD.task, params.task) == -1 then
			table.insert(m.dailyDupPOD.horizontalRPGPOD.task, params.task)
		end

		EventDispatcher.Dispatch(EventID.HorizontalRPGChangeGuideEvent)
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ChangeTaskObjective then
		m.dailyDupPOD.horizontalRPGPOD.task = m.dailyDupPOD.horizontalRPGPOD.task or {}

		local index = table.indexOf(m.dailyDupPOD.horizontalRPGPOD.task, params.task)

		if index ~= -1 then
			table.remove(m.dailyDupPOD.horizontalRPGPOD.task, index)
		end

		EventDispatcher.Dispatch(EventID.HorizontalRPGChangeGuideEvent)
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_AddElementEffect then
		local elementPOD = params.horizontalRPGElementPODs

		m.UpdateRPGElement(HorizontalRPGConstant.ElementUpdateType.Update, elementPOD)
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_RemoveElement then
		local del = params.del

		m.UpdateRPGElement(HorizontalRPGConstant.ElementUpdateType.Delete, del)
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_AddElement then
		local add = params.add

		m.UpdateRPGElement(HorizontalRPGConstant.ElementUpdateType.Add, add)
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_File then
		m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.born = params.born
		m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.region = params.region
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ElementFire then
		-- block empty
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_RemoveItem then
		-- block empty
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_ClearItem then
		-- block empty
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_AddSoulsToTeam then
		-- block empty
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_AddExp then
		-- block empty
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_AddSkillStrengthen then
		-- block empty
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_UpdatePlayerParams then
		local paramID = params.paramID
		local value = params.value

		PlayerModule.UpdatePlayerParams(paramID, value)

		if GameEntry.Base.DevMode then
			log("更新玩家参数  paramID =" .. paramID .. " value = " .. value)
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_PlaySound then
		if params.id > 0 then
			GameEntry.Sound:PlaySound(params.id, Constant.SoundGroup.ENVIRONMENT)
		end
	elseif executeType == HorizontalRPGConstant.ExecutionType.Execution_Settlement then
		log("退出横版")

		m.execution_Settlement = true

		m.ExitHorizontalRPGScene()
	end
end

function m.DisposeHorizontalRPGScene()
	m.pickedUpBox = {}

	if m.horizontalRPGScene then
		m.horizontalRPGScene:Dispose()
	end

	m.horizontalRPGScene = nil
end

function m.OnSceneLoaded()
	m.horizontalRPGScene = HorizontalRPGScene.New()
	m.enterMazeState = 2
	m.execution_Settlement = false
end

function m.Shutdown()
	m.DisposeHorizontalRPGScene()

	m.pickedUpBox = {}
	m.enterMazeState = 0
	m.enterOldMazeCid = 0
	m.cfgExecutionData = nil
	m.globalCid = 0

	m.RemoveListeners()

	m.dailyDupPOD = nil
	m.horizontalRPGPlayerData = nil
	m.currentHorizontalRPGMapData = nil
	m.currDialog = nil
	m.currLevelDialog = nil
	m.execution_Settlement = false
end

function m.ElementExecutionElse(service)
	if not m.CanNotEnter() then
		return
	end

	log("执行服务  " .. tableToString(service))
	net_horizontalRPG.elementExecutionElse(service)
end

function m.ElementExecution(map, region, element, type)
	if not m.CanNotEnter() then
		return
	end

	log("请求元素执行 map = " .. tostring(map) .. " region = " .. tostring(region) .. "element = " .. tostring(element) .. " 触发类型 " .. type)
	net_horizontalRPG.elementExecution(map, region, element, type)
end

function m.CombatTraining(bossId, formationId, isFree)
	if not m.CanNotEnter() then
		return
	end

	net_horizontalRPG.combatTraining(bossId, formationId, isFree)
end

function m.BossTraining(formationId)
	if not m.CanNotEnter() then
		return
	end

	net_horizontalRPG.bossTraining(formationId)
end

function m.ModifyWeather(resCid)
	if not m.CanNotEnter() then
		return
	end

	local state = m.CheckHorizontalTimeByResCid(resCid)

	net_horizontalRPG.modifyWeather(state)
end

function m.QuickChallenge(bossId, number)
	if not m.CanNotEnter() then
		return
	end

	net_horizontalRPG.quickChallenge(bossId, number)
end

function m.Challenge(levelCid, formationId)
	if not m.CanNotEnter() then
		return
	end

	local formation = 0

	if formationId then
		formation = formationId
	end

	net_horizontalRPG.challenge(levelCid, formation)
end

function m.ElementExecutionElseResult()
	return
end

function m.ElementExecutionResult()
	return
end

function m.CombatTrainingResult()
	return
end

function m.BossTrainingResult()
	return
end

function m.QuickChallengeResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function m.ModifyWeatherResult(state)
	m.dailyDupPOD.horizontalRPGPOD.weather = state
end

function m.ChallengeResult(levelCid, mazePOD, horizontalRPGMapPOD, levelDialogCid)
	local cfg = CfgHorizontalRPGListTable[levelCid]

	if cfg.Type == HorizontalRPGConstant.PosStateType.Type_plot then
		DialogModule.OpenDialog(levelDialogCid, false, true)
	elseif cfg.Type == HorizontalRPGConstant.PosStateType.Type_flight then
		-- block empty
	elseif cfg.Type == HorizontalRPGConstant.PosStateType.Type_HorizontalScene then
		m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs = horizontalRPGMapPOD

		if m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs ~= nil then
			m.EnterHorizontalRPGScene(m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.id, m.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.region)
		end
	elseif cfg.Type == HorizontalRPGConstant.PosStateType.Type_HorizontalMaze then
		MazeModule.EnterMaze(mazePOD)

		m.enterMazeState = 1
	end
end

function m.SelectDialogResult(nextDialogCid)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)

	if nextDialogCid == 0 then
		-- block empty
	end
end

function m.SelectLevelDialogResult(nextDialogCid)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)

	if nextDialogCid == 0 then
		-- block empty
	end
end

function m.NotifyCombatTrainingBossEnd(win, cid, dmgRecords, items, openExBoss, freeBossNumber, ticks)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, items, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	local isOld = m.dailyDupPOD.horizontalRPGPOD.exBoss

	m.dailyDupPOD.horizontalRPGPOD.exBoss = openExBoss
	m.dailyDupPOD.horizontalRPGPOD.freeChallengeBossCount = freeBossNumber
	m.dailyDupPOD.horizontalRPGPOD.tickets = ticks

	if openExBoss then
		if not isOld then
			NoticeModule.ShowNoticeByType(1, HorizontalRPGMazeBossDetailUIApi:GetString("OpenHorizontalRPGEXBoss"))
		end

		EventDispatcher.Dispatch(EventID.HorizontalRPGUnlockBossEvent)
	end

	EventDispatcher.Dispatch(EventID.RpgMazeUpdateTicket)
end

function m.NotifyBossTraining(win, cid, dmgRecords)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, nil, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function m.NotifyBossUnlock(boss)
	m.dailyDupPOD.horizontalRPGPOD.boss = boss

	EventDispatcher.Dispatch(EventID.HorizontalRPGUnlockBossEvent)
end

function m.NotifyTicketsUpdate(value)
	m.dailyDupPOD.horizontalRPGPOD.tickets = value

	EventDispatcher.Dispatch(EventID.RpgMazeUpdateTicket)
end

function m.NotifyElementExecution(horizontalRPGResPods)
	m.ExecutionResult(horizontalRPGResPods)
end

function m.NotifyCMD(horizontalRPGPOD)
	m.dailyDupPOD.horizontalRPGPOD = horizontalRPGPOD

	m.InitData()
	m.EndOfActivity()
end

function m.NotifyFinnishLevels(cid)
	m.dailyDupPOD.horizontalRPGPOD.finnishLevels = m.dailyDupPOD.horizontalRPGPOD.finnishLevels or {}

	if table.indexOf(m.dailyDupPOD.horizontalRPGPOD.finnishLevels, cid) == -1 then
		table.insert(m.dailyDupPOD.horizontalRPGPOD.finnishLevels, cid)
	end

	EventDispatcher.Dispatch(EventID.HorizontalRPGUnLockLevelsEvent)
end

function m.NotifyUnlockedDifficulty(difficulty)
	m.dailyDupPOD.horizontalRPGPOD.unlockedDifficulty = m.dailyDupPOD.horizontalRPGPOD.unlockedDifficulty or {}

	if table.indexOf(m.dailyDupPOD.horizontalRPGPOD.unlockedDifficulty) == -1 then
		table.insert(m.dailyDupPOD.horizontalRPGPOD.unlockedDifficulty, difficulty)
	end

	EventDispatcher.Dispatch(EventID.HorizontalRPGUnLockDifficultEvent)
end

function m.NotifyChallengeFightEnd(win, levelCid, dmgRecords, items)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, items, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function m.NotifyChallengeStoryFinished(levelCid, items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function m.NotifyHRPGFinished(levelCid, items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

HorizontalRPGModule = m
