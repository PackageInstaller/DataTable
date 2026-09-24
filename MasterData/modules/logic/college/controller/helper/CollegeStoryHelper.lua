-- chunkname: @modules/logic/college/controller/helper/CollegeStoryHelper.lua

module("modules.logic.college.controller.helper.CollegeStoryHelper", package.seeall)

local CollegeStoryHelper = class("CollegeStoryHelper")

function CollegeStoryHelper:playStory(storyId, replay, callback, callobj)
	self._callback = callback
	self._callobj = callobj
	self._isReplay = replay

	if self._isLock then
		self._needPlayStoryId = storyId

		return
	end

	self._nowPlayingStory = storyId
	self._needPlayStoryId = nil

	CollegeController.instance:dispatchEvent(CollegeEvent.OnStoryPlayBegin, self._nowPlayingStory)

	local co = lua_college_story_node.configDict[storyId]

	if not co or string.nilorempty(co.playFormat) then
		logError("没有剧情碎片配置" .. tostring(storyId))

		return
	end

	local arr = string.split(co.playFormat, "#")
	local funcName = table.remove(arr, 1)
	local func = self["_playStory_" .. funcName]

	if func then
		self._storyType = funcName

		func(self, co.playConfig, arr)
	else
		logError("没有剧情播放配置" .. tostring(co.playFormat))
	end
end

function CollegeStoryHelper:isPlayingStory()
	return self._isPlayingStory or self._needPlayStoryId
end

function CollegeStoryHelper:isNotPlayingStory()
	return not self:isPlayingStory()
end

function CollegeStoryHelper:getCurStoryType()
	if not self:isPlayingStory() then
		return nil
	end

	return self._storyType
end

function CollegeStoryHelper:setLockPlayStory(isLock)
	self._isLock = isLock

	if not isLock and self._needPlayStoryId then
		self:playStory(self._needPlayStoryId, self._isReplay, self._callback, self._callobj)
	end
end

function CollegeStoryHelper:_onPlayNormalStoryEnd()
	self:_setPlayingStory(false)
end

function CollegeStoryHelper:_onPlayStoryEnd()
	CollegeHelper.instance:setViewVisible("CollegeStoryHelper.Flow", false)

	self.flow = nil

	self:_onPlayNormalStoryEnd()
	self:setPostProcess(true)
end

function CollegeStoryHelper:setPostProcess(isEnable)
	if not isEnable then
		PostProcessingMgr.instance:setUIBlurActive(false)
		PostProcessingMgr.instance:setIgnoreUIBlur(true)
	else
		PostProcessingMgr.instance:setIgnoreUIBlur(false)
		PostProcessingMgr.instance:forceRefreshCloseBlur()
	end
end

function CollegeStoryHelper:_onViewClose(viewName)
	if not self._isPlayingStory then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)

		return
	end

	if viewName == ViewName.DungeonFragmentInfoView or viewName == ViewName.CollegeStoryView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
		self:_setPlayingStory(false)

		if viewName == ViewName.CollegeStoryView then
			self:setPostProcess(true)
		end
	end
end

function CollegeStoryHelper:_setPlayingStory(isPlaying)
	if self._isPlayingStory == isPlaying then
		return
	end

	self._isPlayingStory = isPlaying

	if not isPlaying then
		self._storyType = nil

		if self._callback then
			self._callback(self._callobj, self._nowPlayingStory)
		end

		self._callback = nil
		self._callobj = nil

		CollegeController.instance:dispatchEvent(CollegeEvent.OnStoryPlayEnd, self._nowPlayingStory)
	end
end

function CollegeStoryHelper:_playStory_avg(storyId, param)
	self:_setPlayingStory(true)

	if #param > 0 then
		self:setPostProcess(false)

		self.flow = self:buildStoryFlow(param, {
			CollegeStory_PlayAVG_Work.New(storyId)
		})

		return
	end

	StoryController.instance:playStory(storyId, {
		blur = true,
		hideStartAndEndDark = true
	}, self._onPlayNormalStoryEnd, self)
end

function CollegeStoryHelper:_playStory_chessDialogue(dialogueId, storyParam)
	self:_setPlayingStory(true)

	local firstBubbleId = tonumber(storyParam[1])
	local co = lua_college_bubble_group.configDict[firstBubbleId]

	if not co then
		logError("没有对应的气泡对话ID" .. tostring(firstBubbleId))
	end

	if self._isReplay or not co then
		DialogueController.instance:enterDialogue(dialogueId, self._onPlayNormalStoryEnd, self)
	else
		local pos = Vector3.New()

		if not string.nilorempty(co.pos) then
			local arr = string.splitToNumber(co.pos, "#")

			pos:Set(arr[1], arr[2], arr[3])
		end

		local param = {}

		param[1] = CollegeEnum.SceneType.City
		param[2] = CollegeEnum.StoryParamType.Custom

		local works = {}

		table.insert(works, CollegeStory_MoveToFocusPos_Work.New(pos))
		table.insert(works, CollegeStory_PlayChessBubble_Work.New(firstBubbleId))
		table.insert(works, CollegeStory_BackCamera_Work.New())

		self.flow = self:buildStoryFlow(param, works)
	end
end

function CollegeStoryHelper:_playStory_fragment(fragmentId)
	self:_setPlayingStory(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
		notShowToast = true,
		fragmentId = fragmentId
	})
end

function CollegeStoryHelper:_playStory_imageText1(dialogueId, param)
	self:_playCustomStoryByType(CollegeEnum.StoryType.ImageText1, dialogueId, param)
end

function CollegeStoryHelper:_playStory_imageText2(dialogueId, param)
	self:_playCustomStoryByType(CollegeEnum.StoryType.ImageText2, dialogueId, param)
end

function CollegeStoryHelper:_playCustomStoryByType(type, dialogueId, param)
	local stepList = lua_college_story_dialog.configDict[dialogueId]

	if not stepList then
		logError("没有剧情对话配置" .. tostring(dialogueId))

		return
	end

	self:_setPlayingStory(true)
	self:setPostProcess(false)

	if #param > 0 then
		self.flow = self:buildStoryFlow(param, {
			CollegeStory_PlayDialogue_Work.New({
				steps = stepList,
				type = type
			})
		})

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	ViewMgr.instance:openView(ViewName.CollegeStoryView, {
		steps = stepList,
		type = type
	})
end

function CollegeStoryHelper:buildStoryFlow(param, works)
	for i, v in ipairs(param) do
		param[i] = tonumber(v) or 0
	end

	local flow = FlowSequence.New()
	local context = {}
	local sceneMo = CollegeModel.instance:getSceneMo()
	local mapType = param[1]
	local paramType, pos, buildingId, buildingMo = param[2]

	if paramType == CollegeEnum.StoryParamType.Pos then
		context.toPos = Vector3(param[3], param[4], param[5])
	elseif paramType == CollegeEnum.StoryParamType.BuildingId then
		buildingId = param[3]
		buildingMo = sceneMo.buildingBox:getBuildingMo(param[3]) or sceneMo.worldMap:getAreaMo(buildingId)
		context.toPos = buildingMo.pos
		context.toFocusData = buildingMo
	end

	local curFocusData = CollegeModel.instance.curFocusData
	local curSceneType = CollegeModel.instance.curSceneType

	if curFocusData then
		context.fromFocusData = curFocusData

		if paramType ~= CollegeEnum.StoryParamType.BuildingId or curFocusData.type ~= mapType or curFocusData.id ~= buildingId then
			flow:addWork(CollegeStory_BackCamera_Work.New())
		end
	end

	if curSceneType ~= mapType then
		context.fromSceneType = curSceneType
		context.toSceneType = mapType

		flow:addWork(CollegeStory_SwitchScene_Work.New(mapType))
	end

	if paramType == CollegeEnum.StoryParamType.Pos then
		flow:addWork(CollegeStory_MoveToPos_Work.New())
	elseif paramType == CollegeEnum.StoryParamType.BuildingId then
		flow:addWork(CollegeStory_MoveToFocus_Work.New(buildingMo))
	end

	for i, work in ipairs(works) do
		flow:addWork(work)
	end

	if buildingMo and (not curFocusData or buildingId ~= curFocusData.id) then
		flow:addWork(CollegeStory_BackCamera_Work.New())
	end

	if curSceneType ~= mapType then
		flow:addWork(CollegeStory_SwitchScene_Work.New(curSceneType))
	end

	if curFocusData and curFocusData.id ~= buildingId then
		flow:addWork(CollegeStory_MoveToFocus_Work.New(curFocusData))
	end

	flow:registerDoneListener(self._onPlayStoryEnd, self)
	CollegeHelper.instance:setViewVisible("CollegeStoryHelper.Flow", true)
	flow:start(context)

	return flow
end

function CollegeStoryHelper:clear()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end

	self:setPostProcess(true)
	CollegeHelper.instance:setViewVisible("CollegeStoryHelper.Flow", false)

	self._isPlayingStory = false
	self._isLock = false
	self._needPlayStoryId = false
	self._storyType = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

CollegeStoryHelper.instance = CollegeStoryHelper.New()

return CollegeStoryHelper
