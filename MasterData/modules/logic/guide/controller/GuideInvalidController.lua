-- chunkname: @modules/logic/guide/controller/GuideInvalidController.lua

module("modules.logic.guide.controller.GuideInvalidController", package.seeall)

local GuideInvalidController = class("GuideInvalidController", BaseController)
local InvalidEndFight = "EndFight"
local InvalidEndActivity = "ActivityEnd"
local InvalidCondition = "InvalidCondition"
local checkFinishedGuideCondition = "checkFinishGuide"
local checkFinishGuideAndValidActCondition = "checkFinishGuideAndValidAct"
local FinishElement = "FinishElement"
local InvalidNotInWindows = "InvalidNotInWindows"

function GuideInvalidController:addConstEvents()
	PlayerController.instance:registerCallback(PlayerEvent.PlayerLevelUp, self._checkFinishGuideInMainView, self)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, self._onStartGuide, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishedGuide, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
	FightController.instance:registerCallback(FightEvent.OnEndFightForGuide, self._onEndFight, self)
	ActivityController.instance:registerCallback(ActivityEvent.CheckGuideOnEndActivity, self._onActivityEnd, self)
end

function GuideInvalidController:isInvalid(guideId)
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if not guideCO or guideCO.isOnline == 0 then
		return true
	end

	local invalidList = GuideConfig.instance:getInvalidList(guideId)
	local isInvalid = false

	if not invalidList then
		return isInvalid
	end

	local guideMO = GuideModel.instance:getById(guideId)

	for i, paramList in ipairs(invalidList) do
		local invalidType = paramList[1]
		local param1 = paramList[2]

		if invalidType == "PlayerLv" then
			local level = tonumber(param1)

			isInvalid = level <= PlayerModel.instance:getPlayinfo().level
		elseif invalidType == "EpisodeFinish" then
			local configEpisodeId = tonumber(param1)
			local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
			local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)

			isInvalid = episodeMO and episodeMO.star > DungeonEnum.StarType.None

			if isInvalid and episodeCO then
				isInvalid = episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)
			end
		elseif invalidType == "FinishTask" then
			local taskId = tonumber(param1)
			local taskMO = TaskModel.instance:getTaskById(taskId)

			isInvalid = taskMO and taskMO.finishCount > 0
		elseif invalidType == "EnterEpisode" then
			local episodeId = tonumber(param1)
			local fightParam = FightModel.instance:getFightParam()

			if fightParam then
				::label_2_0::

				local var_2_0 = fightParam.episodeId

				if fightParam.episodeId and episodeId then
					::label_2_1::

					local episodeMatch = fightParam.episodeId == episodeId

					isInvalid = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and episodeMatch
				end
			end
		elseif invalidType == "ExitEpisode" then
			isInvalid = guideMO ~= nil and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight
		elseif invalidType == FinishElement then
			local elementId = tonumber(param1)

			isInvalid = DungeonMapModel.instance:elementIsFinished(elementId)
		elseif invalidType == InvalidEndFight then
			isInvalid = guideMO ~= nil and self._hasEndFight
		elseif invalidType == InvalidCondition then
			local func = GuideInvalidCondition[param1]

			isInvalid = func(guideId, paramList)
		elseif invalidType == InvalidEndActivity then
			local actId = tonumber(param1)
			local actMo = ActivityModel.instance:getActMO(actId)

			if actMo then
				local status = ActivityHelper.getActivityStatus(actId)

				isInvalid = guideMO ~= nil and status == ActivityEnum.ActivityStatus.Expired
			end
		else
			isInvalid = invalidType == InvalidNotInWindows and not BootNativeUtil.isWindows() or false
		end

		if isInvalid then
			break
		end
	end

	return isInvalid
end

function GuideInvalidController:_checkFinishGuideInMainView()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		self:_checkFinishGuide()
	end
end

function GuideInvalidController:hasInvalidGuide()
	local coList = GuideConfig.instance:getGuideList()

	for _, co in ipairs(coList) do
		local guideId = co.id
		local guideMO = GuideModel.instance:getById(guideId)
		local notFinish = guideMO == nil or not guideMO.isFinish

		if notFinish and self:isInvalid(guideId) then
			return true
		end
	end

	return false
end

function GuideInvalidController:checkInvalid()
	self:_checkFinishGuide()
end

function GuideInvalidController:_checkFinishGuide()
	local coList = GuideConfig.instance:getGuideList()

	for _, co in ipairs(coList) do
		local guideId = co.id
		local guideMO = GuideModel.instance:getById(guideId)
		local notFinish = guideMO == nil or not guideMO.isFinish

		if notFinish and self:isInvalid(guideId) then
			GuideController.instance:oneKeyFinishGuide(guideId, true)
		end
	end
end

function GuideInvalidController:_onStartGuide(guideId)
	if not GuideModel.instance:isGMStartGuide(guideId) then
		local guideMO = GuideModel.instance:getById(guideId)
		local notFinish = guideMO == nil or not guideMO.isFinish

		if notFinish and self:isInvalid(guideId) then
			GuideController.instance:oneKeyFinishGuide(guideId, true)
		end
	end
end

function GuideInvalidController:_onFinishedGuide(finishedGuideId)
	local list = GuideModel.instance:getList()

	for i = 1, #list do
		local guideMO = list[i]
		local guideId = guideMO.id
		local notFinish = guideMO == nil or not guideMO.isFinish
		local invalidList = GuideConfig.instance:getInvalidList(guideId)

		if notFinish and invalidList then
			for _, paramList in ipairs(invalidList) do
				local invalidType = paramList[1]
				local param = paramList[2]

				if invalidType == InvalidCondition and (param == checkFinishedGuideCondition or param == checkFinishGuideAndValidActCondition) then
					local func = GuideInvalidCondition[param]
					local isInvalid = func(guideId, paramList)

					if isInvalid then
						GuideController.instance:oneKeyFinishGuide(guideId, true)
					end
				end
			end
		end
	end
end

function GuideInvalidController:_onEnterOneSceneFinish(curSceneType, curSceneId)
	if curSceneType == SceneType.Fight then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		self:_checkFinishGuide()

		self._hasEnterBattle = true
	else
		if self._hasEnterBattle then
			self:_checkFinishGuide()
		end

		self._hasEnterBattle = nil
	end
end

function GuideInvalidController:_respBeginFight()
	self._hasEndFight = false
end

function GuideInvalidController:_onEndFight()
	self._hasEndFight = true

	local list = GuideModel.instance:getList()

	for i = 1, #list do
		local guideId = list[i].id
		local invalidTypeList = GuideConfig.instance:getInvalidTypeList(guideId)

		if invalidTypeList and tabletool.indexOf(invalidTypeList, InvalidEndFight) then
			local guideMO = GuideModel.instance:getById(guideId)
			local notFinish = guideMO == nil or not guideMO.isFinish

			if notFinish and self:isInvalid(guideId) then
				GuideController.instance:oneKeyFinishGuide(guideId, true)
			end
		end
	end
end

function GuideInvalidController:_onActivityEnd()
	local list = GuideModel.instance:getList()

	for i = 1, #list do
		local guideId = list[i].id
		local invalidTypeList = GuideConfig.instance:getInvalidTypeList(guideId)

		if invalidTypeList and tabletool.indexOf(invalidTypeList, InvalidEndActivity) then
			local guideMO = GuideModel.instance:getById(guideId)
			local notFinish = guideMO == nil or not guideMO.isFinish

			if notFinish and self:isInvalid(guideId) then
				GuideController.instance:oneKeyFinishGuide(guideId, true)
			end
		end
	end
end

function GuideInvalidController:setGuideInvalid(guideId, force)
	local guideMO = GuideModel.instance:getById(guideId)
	local notFinish = guideMO == nil or not guideMO.isFinish

	if notFinish and (force or self:isInvalid(guideId)) then
		GuideController.instance:oneKeyFinishGuide(guideId, true)
	end
end

GuideInvalidController.instance = GuideInvalidController.New()

return GuideInvalidController
