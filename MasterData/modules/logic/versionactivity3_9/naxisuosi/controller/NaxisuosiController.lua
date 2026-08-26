-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/controller/NaxisuosiController.lua

module("modules.logic.versionactivity3_9.naxisuosi.controller.NaxisuosiController", package.seeall)

local NaxisuosiController = class("NaxisuosiController", BaseController)
local LEFT = NaxisuosiPipeEnum.dir.left
local RIGHT = NaxisuosiPipeEnum.dir.right
local DOWN = NaxisuosiPipeEnum.dir.down
local UP = NaxisuosiPipeEnum.dir.up

function NaxisuosiController:onInit()
	return
end

function NaxisuosiController:onInitFinish()
	return
end

function NaxisuosiController:addConstEvents()
	return
end

function NaxisuosiController:reInit()
	self._rule = nil
	self._curEpisodeCo = nil
end

function NaxisuosiController:getAct220NaxisuosiInfo(cb, cbObj)
	local actId = NaxisuosiModel.instance:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, cb, cbObj)
end

function NaxisuosiController:enterEpisodeLevelView()
	self.getAct220NaxisuosiInfo(self, self._openEpisodeLevelViewAfterGetInfo, self)
end

function NaxisuosiController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local curActId = NaxisuosiModel.instance:getActId()
	local activityMo = ActivityModel.instance:getActMO(curActId)

	if activityMo and msg.activityId == curActId then
		if activityMo.config then
			if activityMo.config and activityMo.config > 0 and not StoryModel.instance:isStoryFinished(activityMo.config) then
				local storyParam = {}

				storyParam.mark = true

				StoryController.instance:playStory(activityMo.config, storyParam, self.openEpisodeLevelView, self)
			else
				self:openEpisodeLevelView()
			end
		end
	end
end

function NaxisuosiController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.NaxisuosiLevelView)
end

function NaxisuosiController:openTaskView()
	local actId = NaxisuosiModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.NaxisuosiTaskView, {
		actId = actId
	})
end

function NaxisuosiController:clickEpisodeLevel(episodeId, index)
	local actId = NaxisuosiModel.instance:getActId()
	local act220MO = Activity220Model.instance:getById(actId)
	local episodeMO = act220MO and act220MO:getEpisodeInfo(episodeId)

	if not episodeMO then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	local episodeCfg = episodeMO.config
	local storyBefore = episodeCfg.storyBefore
	local param = {
		episodeCfg = episodeCfg
	}

	if storyBefore and storyBefore > 0 then
		local storyParam = {}

		storyParam.mark = true

		StoryController.instance:playStory(storyBefore, storyParam, self._afterPlayLevelBeforeStory, self, param)
	else
		self:_afterPlayLevelBeforeStory(param)
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, index)
end

function NaxisuosiController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId = cfg.episodeId
	local gameId = cfg.gameId

	if gameId ~= 0 then
		self._curEpisodeCo = cfg

		NaxisuosiPipeModel.instance:initByEpisodeCo(cfg)
		self:checkInit()
		self:refreshAllConnection()
		self:updateConnection()
		ViewMgr.instance:openView(ViewName.NaxisuosiGameView)
		self:dispatchEvent(NaxisuosiPipeEvent.GuideOpenGameView, episodeId)
	else
		self:finishEpisodeLevel(episodeId)
	end
end

function NaxisuosiController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.NaxisuosiGameView) then
		ViewMgr.instance:closeView(ViewName.NaxisuosiGameView)
	end

	local actId = NaxisuosiModel.instance:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

function NaxisuosiController:checkInit()
	self._rule = self._rule or NaxisuosiPipeRule.New()

	local w, h = NaxisuosiPipeModel.instance:getGameSize()

	self._rule:setGameSize(w, h)
end

function NaxisuosiController:resetGame()
	local episodeCo = NaxisuosiPipeModel.instance:getEpisodeCo()

	self:sendGameStat(episodeCo.episodeId, StatEnum.Result.Reset, 0)
	NaxisuosiPipeModel.instance:initByEpisodeCo(episodeCo)
	self:checkInit()
	self:refreshAllConnection()
	self:updateConnection()
	self:dispatchEvent(NaxisuosiPipeEvent.ResetGameRefresh)
end

function NaxisuosiController:changeDirection(x, y, needRefresh)
	local mo = self._rule:changeDirection(x, y)

	if needRefresh then
		self:refreshConnection(mo)
	end
end

function NaxisuosiController:refreshAllConnection()
	local w, h = NaxisuosiPipeModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = NaxisuosiPipeModel.instance:getData(x, y)

			self:refreshConnection(mo)
		end
	end
end

function NaxisuosiController:refreshConnection(mo)
	local x, y = mo.x, mo.y

	self._rule:setSingleConnection(x - 1, y, RIGHT, LEFT, mo)
	self._rule:setSingleConnection(x + 1, y, LEFT, RIGHT, mo)
	self._rule:setSingleConnection(x, y + 1, DOWN, UP, mo)
	self._rule:setSingleConnection(x, y - 1, UP, DOWN, mo)
end

function NaxisuosiController:updateConnection()
	NaxisuosiPipeModel.instance:resetEntryConnect()

	local entryTable, resultTable = self._rule:getReachTable()

	self._rule:_mergeReachDir(entryTable)
	self._rule:_unmarkBranch()
	self._rule:updateAllStatus(entryTable, resultTable)
	self:_logConnectedNodes()

	local result = self._rule:isGameClear(resultTable)

	NaxisuosiPipeModel.instance:setGameClear(result)
end

function NaxisuosiController:_logConnectedNodes()
	local w, h = NaxisuosiPipeModel.instance:getGameSize()
	local statusNames = {
		[NaxisuosiPipeEnum.LineStatus.Normal] = "Normal",
		[NaxisuosiPipeEnum.LineStatus.Connect] = "Connect",
		[NaxisuosiPipeEnum.LineStatus.Error] = "Error"
	}
	local typeNames = {
		[NaxisuosiPipeEnum.type.first] = "first",
		[NaxisuosiPipeEnum.type.last] = "last",
		[NaxisuosiPipeEnum.type.signsingle] = "signsingle",
		[NaxisuosiPipeEnum.type.wrong] = "wrong",
		[NaxisuosiPipeEnum.type.straight] = "straight",
		[NaxisuosiPipeEnum.type.corner] = "corner",
		[NaxisuosiPipeEnum.type.t_shape] = "t_shape",
		[NaxisuosiPipeEnum.type.zhanwei] = "zhanwei",
		[NaxisuosiPipeEnum.type.connect] = "connect",
		[NaxisuosiPipeEnum.type.x_shape] = "x_shape"
	}
	local dirNames = {
		[NaxisuosiPipeEnum.dir.left] = "left",
		[NaxisuosiPipeEnum.dir.right] = "right",
		[NaxisuosiPipeEnum.dir.up] = "up",
		[NaxisuosiPipeEnum.dir.down] = "down"
	}

	local function valueToDirs(val)
		if val == 0 then
			return "none"
		end

		local names = {}
		local v = val

		while v > 0 do
			local d = v % 10

			table.insert(names, dirNames[d] or tostring(d))

			v = math.floor(v / 10)
		end

		table.sort(names)

		return table.concat(names, "+")
	end

	local sb = {}

	for x = 1, w do
		for y = 1, h do
			local mo = NaxisuosiPipeModel.instance:getData(x, y)

			if mo.status == NaxisuosiPipeEnum.LineStatus.Connect and mo.connectSet and next(mo.connectSet) then
				local connDirNames = {}

				for dir, _ in pairs(mo.connectSet) do
					table.insert(connDirNames, dirNames[dir] or tostring(dir))
				end

				table.sort(connDirNames)

				if not typeNames[mo.typeId] then
					local typeName = tostring(mo.typeId)

					if not statusNames[mo.status] then
						local statusName = tostring(mo.status)
						local rotation = mo:getRotation()

						table.insert(sb, string.format("  (%d,%d) type=%s value=%d[%s] rotation=%d status=%s connectDirs=[%s]", x, y, typeNames[mo.typeId], mo.value, valueToDirs(mo.value), rotation, statusName, table.concat(connDirNames, ",")))
					end
				end
			end
		end
	end

	logNormal(string.format("[Naxisuosi] ConnectedNodes count=%d:\n%s", #sb, table.concat(sb, "\n")))
end

function NaxisuosiController:checkDispatchClear()
	if NaxisuosiPipeModel.instance:getGameClear() then
		self:dispatchEvent(NaxisuosiPipeEvent.PipeGameClear)

		if self._curEpisodeCo then
			local episodeId = self._curEpisodeCo.episodeId

			self:sendGameStat(self._curEpisodeCo, StatEnum.Result.Success)

			if self._curEpisodeCo then
				TaskDispatcher.runDelay(function()
					self:finishEpisodeLevel(episodeId)
				end, self, 2.2)
			end
		end
	end
end

function NaxisuosiController:getIsEntryClear(entryMo)
	return self._rule:getIsEntryClear(entryMo)
end

function NaxisuosiController:endGame()
	ViewMgr.instance:closeView(ViewName.NaxisuosiGameView)

	local episodeCo = NaxisuosiPipeModel.instance:getEpisodeCo()

	self:sendGameStat(episodeCo.episodeId, StatEnum.Result.Exit)
end

function NaxisuosiController:sendGameStat(episodeId, result)
	local nowTime = ServerTime.now()
	local startTime = NaxisuosiPipeModel.instance:getStartTime()
	local useTime = math.max(0, nowTime - startTime)

	StatController.instance:track(StatEnum.EventName.NaxisuosiGame, {
		[StatEnum.EventProperties.NarcissusGameEpisode] = tostring(episodeId),
		[StatEnum.EventProperties.NarcissusResult] = StatEnum.Result2Cn[result],
		[StatEnum.EventProperties.NarcissusUseTime] = useTime
	})
end

NaxisuosiController.instance = NaxisuosiController.New()

return NaxisuosiController
