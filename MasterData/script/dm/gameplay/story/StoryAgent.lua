-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/StoryAgent.lua

module("story", package.seeall)

BaseStoryAgent = class("BaseStoryAgent", DisposableObject)

BaseStoryAgent:has("_director", {
	is = "rw"
})

local StoryTypes = {
	"elitestory",
	"story",
	"mapstory"
}

function BaseStoryAgent:initialize()
	super.initialize(self)

	self._queuedExecutor = QueuedExecutor:new()

	self._queuedExecutor:switchState("idle")

	self._currentScript = nil
	self._currentScriptCtx = nil
	self._currentScriptName = nil
	self._dialogues = {}
	self._isStatisticSta = false
	self._currentStoryType = ""
	self._onEnd = nil
end

function BaseStoryAgent:dispose()
	if self._queuedExecutor then
		self._queuedExecutor:finalize()

		self._queuedExecutor = nil
	end

	super.dispose(self)
end

function BaseStoryAgent:_save(prefixType, scriptnames)
	if type(scriptnames) ~= "table" and type(scriptnames) ~= "string" then
		return
	end

	if type(scriptnames) ~= "table" then
		scriptnames = {
			scriptnames
		}
	end

	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	for _, scriptname in ipairs(scriptnames) do
		customDataSystem:setValue(prefixType, scriptname, true)
	end
end

function BaseStoryAgent:_isSaved(prefixType, scriptname)
	if type(scriptname) ~= "string" then
		return
	end

	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	return customDataSystem:getValue(prefixType, scriptname, false)
end

function BaseStoryAgent:_runScript(scriptname, setEnv, onEnd)
	if scriptname == nil then
		if onEnd then
			onEnd()
		end

		return
	end

	local autoStatistcBase = StatisticPointConfig._autoStatistcScriptList[scriptname]

	if autoStatistcBase then
		self:openStoryStatistic(autoStatistcBase)
	end

	_G.storysandbox = sandbox

	local succ, err = pcall(require, "stories." .. scriptname)

	if not succ then
		if onEnd then
			onEnd()
		end

		cclog("require story config err:" .. err)

		return
	end

	local stories = sandbox.__stories__

	assert(stories[scriptname] ~= nil, "not find scriptname=" .. scriptname)

	local script = stories[scriptname]()

	if not script then
		if onEnd then
			onEnd()
		end

		cclog("story script object is nil")

		return
	end

	self._curPlayCount = 0

	local context = self:getInjector():instantiate(StoryContext)

	context:initGeneralVariables()
	context:setAgent(self)
	context:setComplexNum(self:_getGuideComplexNum())

	if setEnv then
		setEnv(context)
	end

	self._currentScriptName = scriptname

	self:sendStoryStatistic(scriptname, "begin")
	script:run(context, function()
		if onEnd then
			self._currentScriptName = nil

			onEnd()
		end
	end)

	return script
end

function BaseStoryAgent:setStoryEnd(onEnd)
	self._onEnd = onEnd
end

function BaseStoryAgent:checkSave(scriptnames)
	for _, scriptname in ipairs(scriptnames) do
		if not self:isSaved(scriptname) then
			return false
		end
	end

	return true
end

local GuideComplexityNum = "GuideComplexityNum"

function BaseStoryAgent:_saveGuideComplexNum(complexNum)
	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	customDataSystem:setValue(PrefixType.kGlobal, GuideComplexityNum, complexNum)
end

function BaseStoryAgent:_getGuideComplexNum()
	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	return customDataSystem:getValue(PrefixType.kGlobal, GuideComplexityNum) or kGuideComplexityList.none
end

function BaseStoryAgent:_endScriptList(onEnd)
	self._currentScript = nil
	self._currentScriptCtx = nil
	self._isAutoPlay = false
	self._isAutoPlayOld = nil
	self._isStatisticSta = false
	self._statistcStepNum = 0

	local script = self._currentScript
	local context = self._currentScriptCtx

	if onEnd then
		onEnd(script, context)
	end

	if self._onEnd then
		self._onEnd()

		self._onEnd = nil
	end
end

function BaseStoryAgent:_endScript(scriptname)
	self:sendStoryStatistic(scriptname, "end")
end

function BaseStoryAgent:_trigger(scriptnames, setEnv, onEnd)
	if type(scriptnames) ~= "table" and type(scriptnames) ~= "string" then
		if onEnd then
			onEnd()
		end

		return
	end

	if type(scriptnames) ~= "table" then
		scriptnames = {
			scriptnames
		}
	end

	local saves = self:checkSave(scriptnames)

	if saves then
		if onEnd then
			onEnd()
		end

		return
	end

	local queuedExecutor = self._queuedExecutor

	queuedExecutor:exec("idle", nil, function()
		queuedExecutor:switchState("busy")

		self._dialogues = {}

		local index = 1
		local start

		function start()
			local scriptname = scriptnames[index]

			if scriptname == nil then
				queuedExecutor:switchState("idle")
				self:_endScriptList(onEnd)

				return
			end

			index = index + 1

			if not self:isSaved(scriptname) then
				local script = self:_runScript(scriptname, setEnv, function()
					if not self:isSaved(scriptname) then
						self:save(scriptname)
					end

					self:_endScript(scriptname)
					start()
				end)

				self._currentScript = script

				if script and script.context then
					self._currentScriptCtx = script.context
				end
			else
				start()
			end
		end

		start()
	end)
end

function BaseStoryAgent:play(scriptnames, setEnv, onEnd)
	if type(scriptnames) ~= "table" and type(scriptnames) ~= "string" then
		if onEnd then
			onEnd()
		end

		return
	end

	if type(scriptnames) ~= "table" then
		scriptnames = {
			scriptnames
		}
	end

	local queuedExecutor = self._queuedExecutor

	queuedExecutor:exec("idle", nil, function()
		queuedExecutor:switchState("busy")

		local index = 1
		local start

		function start()
			local scriptname = scriptnames[index]

			index = index + 1

			if scriptname == nil then
				queuedExecutor:switchState("idle")
				self:_endScriptList(onEnd)

				return
			end

			local script = self:_runScript(scriptname, setEnv, function()
				self:_endScript(scriptname)
				start()
			end)

			self._currentScript = script
			self._currentScriptCtx = script and script.context
		end

		start()
	end)
end

function BaseStoryAgent:stop()
	local script = self._currentScript

	if script then
		script:abort()

		self._currentScript = nil
		self._currentScriptCtx = nil
	end

	local queuedExecutor = self._queuedExecutor

	if queuedExecutor then
		queuedExecutor:finalize()
		queuedExecutor:switchState("idle")
	end
end

function BaseStoryAgent:skip(result)
	if result == nil then
		result = true
	end

	local script = self._currentScript
	local current = script and script.current

	if current then
		current:abort(result)
	end
end

function BaseStoryAgent:getCurrentScriptCtx()
	return self._currentScriptCtx
end

function BaseStoryAgent:getCurrentScriptName()
	return self._currentScriptName
end

function BaseStoryAgent:openStoryStatistic(statistcStepNum)
	self._isStatisticSta = true

	if statistcStepNum then
		self._statistcStepNum = checkint(statistcStepNum)
	end
end

function BaseStoryAgent:sendStoryStatistic(scriptName, stepName)
	local script = scriptName or self._currentScriptName

	if self._isStatisticSta and script then
		local step = stepName or ""
		local content = {
			type = "loginpoint",
			point = script .. "_" .. step
		}

		StatisticSystem:send(content)
	end
end

function BaseStoryAgent:addStoryStatisticStep(addNum)
	local scriptname = self._currentScriptName

	if self._isStatisticSta and scriptname and self._statistcStepNum > 0 then
		addNum = addNum or 0

		local num = self._statistcStepNum + addNum
		local point = scriptname .. "_" .. tostring(num)

		StatisticPointConfig[point] = num

		StatisticSystem:send({
			type = "loginpoint",
			point = point
		})

		self._statistcStepNum = num
	end
end

function BaseStoryAgent:getStoryType(fileNameStr)
	local storyTypeStr, storeStoryValue

	if fileNameStr == nil then
		fileNameStr = self._currentScriptName

		if self._currentScriptName == nil then
			return
		end
	end

	for i = 1, #StoryTypes do
		local findIndex = string.find((type(fileNameStr) == "table" or nil) and fileNameStr[1], StoryTypes[i])

		if findIndex and findIndex == 1 then
			return true, StoryTypes[i]
		end
	end

	return false
end

function BaseStoryAgent:getStoryAudioPlay(fileNameStr)
	if GameConfigs.autoStory then
		return true
	end

	local isHasType, storyTypeStr = self:getStoryType(fileNameStr)

	return cc.UserDefault:getInstance():getBoolForKey(storyTypeStr, false)
end

function BaseStoryAgent:calculateStoryTotalPlayCount(scriptName)
	local hasBranch = 0
	local allCount = 0
	local path = "script/stories/" .. scriptName .. ".lua"
	local content = io.readfile(path)

	if not content then
		path = "script/stories/" .. scriptName .. ".luac"
		content = io.readfile("script/stories/" .. scriptName .. ".luac")
	end

	if content then
		local speakCount = 0

		for i in string.gfind(content, "'speak'") do
			speakCount = speakCount + 1
		end

		local printerCount = 0

		for i in string.gfind(content, "'printerEffect'") do
			printerCount = printerCount + 1
		end

		printerCount = printerCount * 0.5

		local chooseCount = 0

		for i in string.gfind(content, "'dialogueChoose'") do
			chooseCount = chooseCount + 1
		end

		if chooseCount > 0 then
			hasBranch = 1
		end

		local newsCount = 0

		for i in string.gfind(content, "'newsNode'") do
			newsCount = newsCount + 1
		end

		newsCount = newsCount * 0.5
		allCount = speakCount + printerCount + chooseCount + newsCount
	end

	return allCount, hasBranch
end

function BaseStoryAgent:addStoryValidPlayCount()
	self._curPlayCount = self._curPlayCount + 1
end

function BaseStoryAgent:getStoryStatisticsData(scriptname)
	return {
		amount = self._curPlayCount
	}
end

StoryAgent = class("StoryAgent", BaseStoryAgent)

function StoryAgent:initialize()
	super.initialize(self)

	self._skipCheckSave = false
	self._isAutoPlay = false
	self._isAutoPlayOld = false
	self._isHideUI = false
end

function StoryAgent:dispose()
	super.dispose(self)
end

function StoryAgent:trigger(scriptnames, setEnv, onEnd)
	if GameConfigs.closeStory then
		if onEnd then
			onEnd()
		end

		return
	end

	self._isAutoPlay = self:getStoryAudioPlay(scriptnames)
	self._isHideUI = false

	self:_trigger(scriptnames, setEnv, onEnd)
end

function StoryAgent:save(scriptnames)
	self:_save(PrefixType.kStory, scriptnames)
end

function StoryAgent:isSaved(scriptname)
	if self._skipCheckSave then
		return false
	end

	return self:_isSaved(PrefixType.kStory, scriptname)
end

function StoryAgent:saveGuideComplexNum(complexNum)
	self:_saveGuideComplexNum(complexNum)
end

function StoryAgent:getGuideComplexNum()
	return self:_getGuideComplexNum()
end

function StoryAgent:setSkipCheckSave(state)
	self._skipCheckSave = state
end

function StoryAgent:showSkipChoose()
	return
end

function StoryAgent:addDialogue(args, t)
	if args == nil then
		return
	end

	local name = args.name
	local content = args.content

	if content ~= nil and type(content) == "table" then
		for i, v in pairs(content) do
			if name ~= nil and type(name) == "string" then
				local n = {}

				n.t = "N"
				n.content = name
				self._dialogues[#self._dialogues + 1] = n
			end

			if v ~= nil and type(v) == "string" then
				local d = {}

				d.t = t
				d.content = v
				self._dialogues[#self._dialogues + 1] = d
			end
		end
	elseif content ~= nil and type(content) == "string" then
		if name ~= nil and type(name) == "string" then
			local n = {}

			n.t = "N"
			n.content = name
			self._dialogues[#self._dialogues + 1] = n
		end

		local d = {}

		d.t = t
		d.content = content
		self._dialogues[#self._dialogues + 1] = d
	end
end

function StoryAgent:addEnterFollowAction(name)
	if self._enterSceneAction then
		self._enterSceneAction:addNextAction(name)
	end
end

function StoryAgent:setEnterSceneAction(action)
	self._enterSceneAction = action
end

function StoryAgent:sendAddStoryLove(id)
	local gallerySystem = self:getInjector():getInstance("GallerySystem")
	local question = id

	if question ~= nil and question ~= "" then
		if gallerySystem:getPartyManage():getStoryLoveSta(question) then
			return
		end

		local storyService = self:getInjector():getInstance("StoryService")
		local params = {}

		params.storyLoveId = id

		storyService:requestStoryLove(params, true, function(response)
			if response.resCode == GS_SUCCESS then
				self:showAddStoryLove(id)
			end
		end)
	end
end

function StoryAgent:showAddStoryLove(id)
	local ctx = self:getCurrentScriptCtx()

	if ctx ~= nil then
		local scene = ctx:getScene()
		local actor = scene:getChildById("storyLove")

		if actor == nil then
			actor = StageNodeFactory:createStoryLove(scene)
		end

		if actor then
			actor:show(id)
		end
	end
end

function StoryAgent:showAddMazeClue(id)
	local ctx = self:getCurrentScriptCtx()

	if ctx ~= nil then
		local scene = ctx:getScene()
		local actor = scene:getChildById("mazeClue")

		if actor == nil then
			actor = StageNodeFactory:createMazeClue(scene)
		end

		if actor then
			actor:show(id)
		end
	end
end

function StoryAgent:pushMazeClue(id)
	if id == nil or id == "" then
		return
	end

	self._mazeClueList = self._mazeClueList or {}
	self._mazeClueList[#self._mazeClueList + 1] = id

	self:showAddMazeClue(id)
end

function StoryAgent:popAllMazeClue()
	if self._mazeClueList == nil or #self._mazeClueList == 0 then
		return nil
	end

	self._mazeClueList = nil

	return self._mazeClueList
end

function StoryAgent:resetSaved(scriptname, callback)
	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	customDataSystem:delValues(PrefixType.kStory, {
		scriptname
	}, callback)
end

function StoryAgent:isAutoPlayState()
	return self._isAutoPlay
end

function StoryAgent:isGuiding()
	return self._queuedExecutor:isStateMatched("busy")
end

function StoryAgent:setAutoPlayState(isAutoPlay, isPasue)
	if isPasue then
		if isAutoPlay and self._isAutoPlayOld then
			isAutoPlay = true
			self._isAutoPlayOld = nil
		else
			isAutoPlay = false

			if self._isAutoPlay then
				self._isAutoPlayOld = true
			end
		end
	end

	self._isAutoPlay = isAutoPlay

	local isHasType, storyTypeStr = self:getStoryType()

	if isHasType then
		local storeStoryValue = cc.UserDefault:getInstance():getBoolForKey(storyTypeStr, false)

		if self._isAutoPlay ~= storeStoryValue then
			cc.UserDefault:getInstance():setBoolForKey(storyTypeStr, self._isAutoPlay)
		end
	end

	local ctx = self:getCurrentScriptCtx()

	if ctx ~= nil then
		local scene = ctx:getScene()

		if scene then
			local nodes = scene:getChildren()

			for i, v in ipairs(nodes) do
				if v.updateAutoPlayState then
					v:updateAutoPlayState(isAutoPlay)
				end
			end
		end
	end
end

function StoryAgent:isHideUIState()
	return self._isHideUI
end

function StoryAgent:setHideUIState(isHide)
	self._isHideUI = isHide

	local ctx = self:getCurrentScriptCtx()

	if ctx ~= nil then
		local scene = ctx:getScene()

		if scene then
			local nodes = scene:getChildren()

			for i, v in ipairs(nodes) do
				if v.updateHideUIState then
					v:updateHideUIState(isHide)
				end
			end
		end
	end
end

GuideAgent = class("GuideAgent", BaseStoryAgent)

function GuideAgent:initialize()
	super.initialize(self)

	self._guideScript = nil
	self._guideScriptCtx = nil
	self._guidePassNames = {}
end

function GuideAgent:dispose()
	super.dispose(self)
end

function GuideAgent:trigger(scriptnames, setEnv, onEnd)
	if GameConfigs.closeGuide then
		if onEnd then
			onEnd()
		end

		return
	end

	self:openStoryStatistic()
	self:_trigger(scriptnames, setEnv, onEnd)
end

function GuideAgent:save(scriptnames)
	local names = scriptnames

	if type(names) ~= "table" then
		names = {
			names
		}
	end

	for _, name in ipairs(names) do
		self._guidePassNames[name] = true
	end

	self:_save(PrefixType.kGuide, scriptnames)
end

function GuideAgent:isSaved(scriptname)
	if self:_isSaved(PrefixType.kGuide, "GUIDE_SKIP_ALL") then
		return true
	end

	if GameConfigs.closeGuide then
		return true
	end

	if type(scriptname) == "table" then
		scriptname = scriptname[1]
	end

	if self._guidePassNames[scriptname] then
		return true
	end

	return self:_isSaved(PrefixType.kGuide, scriptname)
end

function GuideAgent:isGuiding()
	return self._queuedExecutor:isStateMatched("busy")
end

function GuideAgent:saveGuideStep(scriptnames)
	local isSaved = self:isSaved(scriptnames)

	if isSaved then
		return
	end

	self:save(scriptnames)
end

function GuideAgent:resetSaved(scriptname, callback)
	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")

	customDataSystem:delValues(PrefixType.kGuide, {
		scriptname
	}, callback)
end

function GuideAgent:showExitGameTips()
	local data = {
		noClose = true,
		title = Strings:get("UPDATE_UI7"),
		content = Strings:get("UI_TEXT_EXIT_GAME"),
		sureBtn = {},
		cancelBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			cc.Director:getInstance():endToLua()
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	DmGame:getInstance():dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		isAreaIndependent = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end
