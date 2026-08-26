-- chunkname: @modules/logic/versionactivity3_3/igor/controller/IgorController.lua

module("modules.logic.versionactivity3_3.igor.controller.IgorController", package.seeall)

local IgorController = class("IgorController", BaseController)

function IgorController:onInit()
	return
end

function IgorController:reInit()
	return
end

function IgorController:onInitFinish()
	return
end

function IgorController:addConstEvents()
	return
end

function IgorController:openGameResultView(isWin, episodeCo)
	local param = {}

	param.episodeCo = episodeCo

	if isWin then
		IgorController.instance:statOperation(IgorEnum.StatOperationType.Finish)
		ViewMgr.instance:openView(ViewName.IgorGameSuccessView, param)
	else
		IgorController.instance:statOperation(IgorEnum.StatOperationType.Fail)
		ViewMgr.instance:openView(ViewName.IgorGameFailView, param)
	end
end

function IgorController:enterEpisodeLevelView(actId, episodeId)
	self.openEpisodeId = episodeId
	self.openActivityId = actId

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, self._onReceiveInfo, self)
end

function IgorController:_onReceiveInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local activityId = msg.activityId
		local activityMo = ActivityModel.instance:getActMO(activityId)

		if activityMo then
			::label_7_0::

			local var_7_0 = activityMo.config

			if activityMo.config then
				local storyId = activityMo.config.storyId

				if storyId and storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
					local storyParam = {}

					storyParam.mark = true

					StoryController.instance:playStory(storyId, storyParam, self.openEpisodeLevelView, self)
				else
					self:openEpisodeLevelView()
				end
			end
		end
	end

	self.openEpisodeId = nil
end

function IgorController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.IgorEpisodeLevelView, {
		episodeId = self.openEpisodeId,
		activityId = self.openActivityId
	})
end

function IgorController:openTaskView(actId)
	local viewParam = {}

	viewParam.actId = actId

	ViewMgr.instance:openView(ViewName.IgorTaskView, viewParam)
end

function IgorController:enterGame(episodeConfig)
	if self.isInGame then
		return
	end

	self.isInGame = true

	IgorModel.instance:initGame(episodeConfig)
	ViewMgr.instance:openView(ViewName.IgorGameView)
	UpdateBeat:Add(self._onUpdate, self)
end

function IgorController:exitGame()
	if not self.isInGame then
		return
	end

	self.isInGame = false

	UpdateBeat:Remove(self._onUpdate, self)
end

function IgorController:resetGame()
	IgorModel.instance:resetGame()
end

function IgorController:_onUpdate()
	local deltaTime = Time.deltaTime
	local gameMO = IgorModel.instance:getCurGameMo()

	if not gameMO then
		return
	end

	if not gameMO:canUpdate() then
		return
	end

	gameMO:update(deltaTime)
	IgorController.instance:dispatchEvent(IgorEvent.OnGameFrameUpdate, deltaTime)
end

function IgorController:statOperation(operationType)
	local gameMO = IgorModel.instance:getCurGameMo()

	if not gameMO then
		return
	end

	local startTime = gameMO:getStartTime()

	if not startTime then
		return
	end

	local gameId = gameMO.id
	local useTime = Time.realtimeSinceStartup - startTime

	StatController.instance:track(StatEnum.EventName.IgorOperation, {
		[StatEnum.EventProperties.MapId] = tostring(gameId),
		[StatEnum.EventProperties.OperationType] = operationType,
		[StatEnum.EventProperties.UseTime] = useTime
	})
end

IgorController.instance = IgorController.New()

return IgorController
