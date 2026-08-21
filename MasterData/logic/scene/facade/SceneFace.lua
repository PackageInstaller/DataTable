-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/facade/SceneFace.lua

module("logic.scene.facade.SceneFace", package.seeall)

local M = class("SceneFace")

M.LogTag = "[Scene]"
M.SceneType2Flow = {
	[SceneType.Room] = RoomSceneFlow,
	[SceneType.House] = HouseSceneFlow,
	[SceneType.Team] = TeamSceneFlow,
	[SceneType.RunGroup] = RogueSceneFlow,
	[SceneType.RunGroupSecondary] = RogueSecondarySceneFlow,
	[SceneType.Profiler] = ProfilerSceneFlow,
	[SceneType.AutoRun] = AutoRunSceneFlow,
	[SceneType.Story] = StorySceneFlow,
	[SceneType.SpecialTraining] = SpecialTrainingFlow,
	[SceneType.AirWorkShop] = AirWorkShopSceneFlow,
	[SceneType.ClawDoll] = ClawDollSceneFlow,
	[SceneType.CharacterPreview] = CharacterPreviewSceneFlow,
	[SceneType.Retrieve] = RetrieveSceneFlow
}
M.SceneIgnoreBack = {
	[SceneType.Battle] = true,
	[SceneType.Dungeon] = true,
	[SceneType.Profiler] = true,
	[SceneType.AutoRun] = true,
	[SceneType.Story] = true
}
M.SceneType2Id = {
	[SceneType.Room] = 9001,
	[SceneType.House] = 3001,
	[SceneType.Team] = 5001,
	[SceneType.Lottery] = 4001,
	[SceneType.Profiler] = 10,
	[SceneType.AutoRun] = 13,
	[SceneType.SpecialTraining] = 5002,
	[SceneType.ClawDoll] = 5003,
	[SceneType.CharacterPreview] = 5004,
	[SceneType.Retrieve] = 7001
}

function M:getSceneFlowCls(sceneType)
	return M.SceneType2Flow[sceneType]
end

function M:ctor()
	self._cacheFlowMap = {}
	self._curSceneTyp = nil
	self._curSceneFlow = false
	self._cacheSceneLeave = nil
	self._enterSceneInfos = {}

	self:setEvent(true)
end

function M:onInit()
	return
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self, 100)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	end
end

function M:_handleJumpViewToMain(e)
	if self._curSceneTyp == SceneType.Room then
		ViewMgr.instance:jumpToMainView(ViewName.MainUIView)
	else
		SceneFace.instance:enterScene({
			sceneId = 9001,
			jumpToMainView = true,
			notOpenUI = false,
			sceneType = SceneType.Room
		}, false)
	end

	self:clearEnterSceneInfo()
end

function M:clearEnterSceneInfo()
	self._enterSceneInfos = {
		{
			sceneId = 9001,
			sceneType = SceneType.Room
		}
	}
end

function M:enterScene(info, isBack)
	if self:getCacheSceneLeave() then
		self:printMsg("已存在暂存场景，注意", false)
	end

	info = info or {}

	if self._curSceneTyp and info.sceneType == self._curSceneTyp then
		self:printMsg(string.format("两次enterScene为同一场景,sceneType=%s,isBack=%s", info.sceneType, isBack), true)
	end

	if info.sceneType then
		local flowObj = false
		local sceneFlowCls = self:getSceneFlowCls(info.sceneType)

		if sceneFlowCls then
			if self._curSceneFlow then
				local model = self._curSceneFlow.model

				if model and model:getSceneType() == info.sceneType and model:getSceneId() == info.sceneId then
					return
				end

				self._curSceneFlow:exitScene()
			end

			flowObj = sceneFlowCls.New()

			flowObj:init()

			self._curSceneFlow = flowObj
			info.isBack = isBack

			self._curSceneFlow:enterScene(info)

			self._curSceneTyp = info.sceneType

			if M.SceneIgnoreBack[info.sceneType] then
				-- block empty
			else
				table.insert(self._enterSceneInfos, info)

				if #self._enterSceneInfos > 20 then
					self:printMsg("退出场景使用backScene")
				end
			end
		end
	end
end

function M:enterRoomScene(isLoading, notOpenUI, isBack)
	SceneFace.instance:enterScene({
		sceneId = 9001,
		sceneType = SceneType.Room,
		isLoading = isLoading,
		notOpenUI = notOpenUI
	}, isBack)
end

function M:enterHouseScene()
	SceneFace.instance:enterScene({
		sceneId = 3001,
		sceneType = SceneType.House,
		mainPlayerPos = HouseModel.instance:getCacheMainPlayerPos()
	})
end

function M:enterRetrieveScene()
	SceneFace.instance:enterScene({
		sceneType = SceneType.Retrieve,
		sceneId = M.SceneType2Id[SceneType.Retrieve]
	})
end

function M:enterRunGroupScene(sceneId)
	local _sceneId = sceneId

	SceneFace.instance:enterScene({
		sceneType = SceneType.RunGroup,
		sceneId = _sceneId
	})
end

function M:enterRunGroupSecondaryScene(sceneId)
	local _sceneId = sceneId

	SceneFace.instance:enterScene({
		sceneType = SceneType.RunGroupSecondary,
		sceneId = _sceneId
	})
end

function M:enterTeamScene()
	SceneFace.instance:enterScene({
		sceneId = 5001,
		sceneType = SceneType.Team
	})
end

function M:enterProfilerScene()
	SceneFace.instance:enterScene({
		sceneId = 10,
		sceneType = SceneType.Profiler
	})
end

function M:enterAutoRunScene()
	SceneFace.instance:enterScene({
		sceneId = 13,
		sceneType = SceneType.AutoRun
	})
end

function M:enterSpecialTrainingScene()
	SceneFace.instance:enterScene({
		sceneId = 5002,
		sceneType = SceneType.SpecialTraining
	})
end

function M:enterClawDollScene()
	SceneFace.instance:enterScene({
		sceneId = 5003,
		sceneType = SceneType.ClawDoll
	})
end

function M:enterAirWorkShopScene(sceneCode)
	SceneFace.instance:enterScene({
		sceneType = SceneType.AirWorkShop,
		sceneId = sceneCode
	})
end

function M:enterCharacterPreviewScene(heroId)
	local info = {
		sceneType = SceneType.CharacterPreview,
		sceneId = M.SceneType2Id[SceneType.CharacterPreview],
		heroId = heroId
	}

	SceneFace.instance:enterScene(info)
end

function M:getCurSceneFlow()
	return self._curSceneFlow
end

function M:getCurSceneFlowTyp()
	return self._curSceneTyp
end

function M:isCurScene(sceneType)
	return self:getCurSceneFlowTyp() == sceneType
end

function M:exitScene(removeInStack, removeAll)
	if removeInStack then
		self:removeSceneInStack(self._curSceneTyp, removeAll)
	end

	if self._curSceneFlow then
		self._curSceneFlow:exitScene()
	end

	self._curSceneFlow = false
	self._curSceneTyp = nil

	if self._temporailyChangeSceneFlow then
		self._temporailyChangeSceneFlow:destroyWork()
	end

	if self._cacheSceneLeave and self._cacheSceneLeave.flow then
		self._cacheSceneLeave.flow:exitScene()
	end

	self._cacheSceneLeave = nil
end

function M:backScene()
	local curSceneType = self._curSceneTyp

	if self:_tryLeaveTemporarilyScene() then
		return
	end

	if #self._enterSceneInfos > 1 then
		local info = self._enterSceneInfos[#self._enterSceneInfos - 1]

		table.remove(self._enterSceneInfos, #self._enterSceneInfos - 1)
		table.remove(self._enterSceneInfos, #self._enterSceneInfos)
		self:enterScene(info, true)
	elseif not curSceneType and #self._enterSceneInfos == 1 then
		local info = self._enterSceneInfos[1]

		table.remove(self._enterSceneInfos, #self._enterSceneInfos)
		self:enterScene(info, true)
	else
		self:printMsg(string.format("backScene无法正常执行,sceneTyp[%s]", curSceneType), false, true)
		TableUtil.dump(self._enterSceneInfos)
		self:exitScene()
	end
end

function M:getCurrBackInfo()
	return self._enterSceneInfos[#self._enterSceneInfos]
end

function M:getSceneIndexInStack(sceneType)
	local returnIndex = false
	local len = self._enterSceneInfos and #self._enterSceneInfos or 0

	if len > 0 then
		for i = len, 1, -1 do
			local info = self._enterSceneInfos[i]

			if not returnIndex and info.sceneType == sceneType then
				returnIndex = i
			end
		end
	end

	return returnIndex
end

function M:removeSceneInStack(sceneType, removeAll)
	self:printMsg(string.format("removeSceneInStack scene [%s] removeAll[%s]", sceneType, removeAll), false, true)

	local index = self:getSceneIndexInStack(sceneType)

	if removeAll then
		while index do
			table.remove(self._enterSceneInfos, index)

			index = self:getSceneIndexInStack(sceneType)
		end
	elseif index then
		table.remove(self._enterSceneInfos, index)
	end

	if #self._enterSceneInfos == 0 then
		self:clearEnterSceneInfo()
	end
end

function M:enterSceneById(sceneId)
	local config = sceneId and SceneConfig.instance:getSceneCO(sceneId)

	if not config then
		self:printMsg(string.format("不存在scene配置%s,%s", tostring(sceneId), type(sceneId)), true)

		return
	end

	SceneFace.instance:enterScene({
		sceneType = config.sceneType,
		sceneId = config.code
	})
end

function M:enterStoryScene(sceneId)
	SceneFace.instance:enterScene({
		sceneType = SceneType.Story,
		sceneId = sceneId
	})
end

function M:getCacheSceneLeave()
	return self._cacheSceneLeave
end

function M:getTemporailyChangeSceneFlow()
	if not self._temporailyChangeSceneFlow then
		self._temporailyChangeSceneFlow = TemporailyChangeSceneFlow.New()
	end

	return self._temporailyChangeSceneFlow
end

function M:temporarilyChangeScene(sceneType, sceneId, needLoading, passThroughParam, additionInfo, finishWorkLst)
	if SceneMgr.instance:isInTargetScene(sceneType, sceneId) then
		self:printMsg(string.format("已在场景中:%s,%s", sceneType, sceneId))

		return
	end

	local curScene = SceneMgr.instance:getCurScene()

	if not curScene then
		self:printMsg("当前没有场景", false, true)
		SceneFace.instance:enterScene({
			sceneType = sceneType,
			sceneId = sceneId
		})

		return
	end

	if self._cacheSceneLeave then
		self:printMsg("已存在暂存场景，注意", false)
	end

	local curSceneType = SceneMgr.instance:getCurSceneType()
	local curSceneId = SceneMgr.instance:getCurSceneId()
	local curSceneFlow = self._curSceneFlow

	if curSceneType == SceneType.Battle then
		curSceneFlow = BattleMgr.instance:getActiveBattleFlow()
	end

	self._cacheSceneLeave = {
		sceneType = curSceneType,
		sceneId = curSceneId,
		flow = curSceneFlow,
		passThroughParam = passThroughParam
	}

	local sceneFlowCls = self:getSceneFlowCls(sceneType)
	local nextSceneFlow

	if sceneFlowCls then
		nextSceneFlow = sceneFlowCls.New()

		nextSceneFlow:init()
	end

	self._curSceneFlow = nextSceneFlow
	self._curSceneTyp = sceneType

	local runInfo = {
		sceneType = sceneType,
		sceneId = sceneId,
		flow = nextSceneFlow,
		needLoading = needLoading,
		finishWorkLst = finishWorkLst,
		flowInfo = {
			sceneType = sceneType,
			sceneId = sceneId
		}
	}

	for key, value in pairs(additionInfo or {}) do
		runInfo.flowInfo[key] = value
	end

	local tempporailyChangeSceneflow = self:getTemporailyChangeSceneFlow()

	tempporailyChangeSceneflow:runChangeSceneWork(runInfo)
end

function M:_tryLeaveTemporarilyScene()
	local hasTemporailySceneCache = false

	if self._cacheSceneLeave then
		hasTemporailySceneCache = true

		local sceneType = self._cacheSceneLeave.sceneType
		local sceneId = self._cacheSceneLeave.sceneId
		local flow = self._cacheSceneLeave.flow
		local passThroughParam = self._cacheSceneLeave.passThroughParam
		local tempporailyChangeSceneflow = self:getTemporailyChangeSceneFlow()

		tempporailyChangeSceneflow:runBackSceneWork({
			sceneType = sceneType,
			sceneId = sceneId,
			readyLeaveFlow = self._curSceneFlow,
			readyBackFlow = flow,
			passThroughParam = passThroughParam
		})

		self._cacheSceneLeave = nil
	end

	return hasTemporailySceneCache
end

function M:temporailyLeaveScene(isLeave, passThroughParam)
	if isLeave then
		local curSceneType = SceneMgr.instance:getCurSceneType()
		local curSceneId = SceneMgr.instance:getCurSceneId()
		local curSceneFlow = self._curSceneFlow
		local curScene = SceneMgr.instance:getScene(curSceneType)

		if curSceneType == SceneType.Battle then
			curSceneFlow = BattleMgr.instance:getActiveBattleFlow()
		end

		self._cacheSceneLeave = {
			sceneType = curSceneType,
			sceneId = curSceneId,
			flow = curSceneFlow,
			passThroughParam = passThroughParam
		}

		self:printMsg(string.format("temporaily leave scene [%s][%s]", curSceneType, curSceneId))

		if curScene and curScene.onLeaveScene then
			curScene:onLeaveScene(passThroughParam)
		end

		self:printMsg(string.format("temporaily leave scene flow [%s][%s]", curSceneType, curSceneId))

		if curSceneFlow then
			curSceneFlow:leaveScene(passThroughParam)
		end

		SceneFace.instance:printMsg(string.format("temporaily leave scene [%s][%s] finish", curSceneType, curSceneId))
	else
		if not self._cacheSceneLeave then
			return
		end

		local sceneType = self._cacheSceneLeave.sceneType
		local sceneId = self._cacheSceneLeave.sceneId
		local readyBackFlow = self._cacheSceneLeave.flow
		local _passThroughParam = self._cacheSceneLeave.passThroughParam
		local curScene = SceneMgr.instance:getScene(sceneType)

		self:printMsg(string.format("temporaily return scene [%s][%s]", sceneType, sceneId))

		if curScene and curScene.onReturnScene then
			curScene:onReturnScene(_passThroughParam)
		end

		self:printMsg(string.format("temporaily return scene flow [%s][%s]", sceneType, sceneId))

		if readyBackFlow then
			readyBackFlow:returnScene(_passThroughParam)
		end

		self:printMsg(string.format("temporaily return scene finish [%s][%s]", sceneType, sceneId))

		if curScene and curScene.onReturnSceneFinished then
			curScene:onReturnSceneFinished(_passThroughParam)
		end

		if readyBackFlow then
			readyBackFlow:onReturnSceneFinished(_passThroughParam)
		end

		self:printMsg(string.format("temporaily return scene [%s][%s] all finish", sceneType, sceneId))

		self._cacheSceneLeave = nil
	end
end

function M:jumpScene(sceneType)
	if not sceneType then
		return
	end

	local sceneId = M.SceneType2Id[sceneType]

	if not sceneId then
		return
	end

	local info = {
		sceneType = sceneType,
		sceneId = sceneId
	}

	if sceneType == SceneType.Room then
		info.isLoading = true
	elseif sceneType == SceneType.House then
		info.mainPlayerPos = HouseModel.instance:getCacheMainPlayerPos()
	end

	SceneFace.instance:enterScene(info)
end

function M:printMsg(msgStr, isError, debugTrack)
	if isError then
		printError(string.format("%s %s", M.LogTag, msgStr))
	elseif enableLog then
		if debugTrack then
			printWarn(string.format("%s %s", M.LogTag, msgStr), debug.traceback())
		else
			printWarn(string.format("%s %s", M.LogTag, msgStr))
		end
	end
end

M.instance = M.New()

return M
