-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/util/RoguePlotUtil.lua

module("logic.extensions.roguelike.util.RoguePlotUtil", package.seeall)

local M = class("RoguePlotUtil")
local BubbleType = SceneEnum.BubbleType
local kRoleAniName = RoguelikeConst.ROGUE_ROLE_ANI
local kAniNameMap = {
	["1"] = kRoleAniName.IDLE,
	["2"] = kRoleAniName.DEATH,
	["3"] = kRoleAniName.FALL,
	["4"] = kRoleAniName.HIT,
	["5"] = kRoleAniName.JUMP,
	["6"] = kRoleAniName.Run,
	["7"] = kRoleAniName.SKILL,
	["8"] = kRoleAniName.WIN
}

function M:ctor()
	self:setEvent(true)
end

function M:clear()
	self:exitPlot()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.RoguePlot)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_PLOT_STEP, self._onShowPlotStep, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_PLOT_STEP, self._onShowPlotStep, self)
	end
end

function M:_onShowPlotStep(sender, index)
	local isFinish = index >= #self._plotList

	if isFinish then
		self:playPlotExit()

		local mapMgr = RogueMgr.instance:getMapMgr()
		local mapRole = mapMgr:getMapRole()
		local targetRole = self._targetRole:getMapRole()

		mapRole.bubble:showName(false)
		targetRole.bubble:showName(false)
	else
		self:showCurStep(self._plotList[index])
	end
end

function M:showCurStep(stepCo)
	local mapMgr = RogueMgr.instance:getMapMgr()
	local mapRole = stepCo.npcId == 0 and mapMgr:getMapRole() or self._targetRole:getMapRole()
	local bubble = mapRole.bubble
	local bubbleData = {}

	bubbleData.type = BubbleType.Talk

	local content = StringUtil.replaceAllRed(stepCo.dialog)

	content = StringUtil.replaceAllSup(content)
	bubbleData.content = StringUtil.replaceAllRed(content)

	if bubbleData.content ~= "" then
		bubble:show(bubbleData)
	end

	if stepCo.showName ~= "" and stepCo.showName ~= "{username}" then
		bubble:showName(true, stepCo.showName)
	elseif stepCo.showName == "{username}" then
		mapMgr:getMapRole().bubble:showName(true, PlayerModel.instance:getNickName())
	end

	if kAniNameMap[stepCo.action] ~= nil then
		local isLoop = kAniNameMap[stepCo.action] == kRoleAniName.IDLE

		mapRole.meshModel:play(kAniNameMap[stepCo.action], isLoop)
	end
end

function M:startPlot(plotCode, callback)
	if plotCode == 0 or plotCode == nil then
		if callback ~= nil then
			callback()
		end

		return
	end

	local plotList = RoguelikeConfig.instance:getPlotListById(plotCode)

	if #plotList > 0 then
		local mapMgr = RogueMgr.instance:getMapMgr()
		local curIndex = RoguelikeModel.instance:getCurRoomIndex()
		local mapUnit = mapMgr:getCurMapUnits()

		if mapUnit[curIndex].mapItem:getMapRole() == nil then
			if enableWarnLog then
				printWarn(string.format("事件配置了剧情%s但是对应位置没有配模型", plotCode))
			end

			if callback ~= nil then
				callback()
			end

			return
		end

		self:playPlot(plotCode, mapUnit[curIndex].mapItem, function()
			if callback ~= nil then
				callback()
			end
		end)
	else
		if RoguelikeConst.IsAllowStory(plotCode) then
			StoryMgr.instance:startSingle(plotCode, false, function()
				if callback ~= nil then
					callback()
				end
			end, self)
		elseif callback ~= nil then
			callback()
		end

		RoguelikeConst.SetStoryPlayed(plotCode)
	end
end

function M:playPlot(plotCode, targetMapRole, callback)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.RoguePlot)

	self._playPlotCallback = callback

	local plots = RoguelikeConfig.instance:getPlotListById(plotCode)

	self._plotList = plots
	self._targetRole = targetMapRole
	self._plotCode = plotCode
	self._curStepIndex = 1

	local work = self:_createWork()

	work:setDoneCaller(self._onWorkFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkUIActive.New())
	sequence:addChild(WorkMapUIActive.New())
	sequence:addChild(WorkChangeCameraFov.New())
	sequence:addChild(WorkMoveRoleToTarget.New())
	work:addChild(sequence)

	local context = {}

	context.isShowMapUI = false
	context.isActive = false
	context.isDown = true
	context.ignoreModel = true
	context.isSecondMap = RoguelikeModel.instance:getIsInSecondRoom()
	context.mapItem = self._targetRole

	work:start(context)
end

function M:playPlotExit()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitWorkFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkUIActive.New())
	sequence:addChild(WorkMapUIActive.New())
	sequence:addChild(WorkChangeCameraFov.New())
	sequence:addChild(WorkMoveRoleToTarget.New())
	work:addChild(sequence)

	local context = {}

	context.isActive = true
	context.isShowMapUI = true
	context.ignoreModel = true
	context.isSecondMap = RoguelikeModel.instance:getIsInSecondRoom()
	context.mapItem = self._targetRole
	context.isDown = false

	work:start(context)
end

function M:_onExitWorkFinish()
	if self._playPlotCallback then
		self._playPlotCallback()

		self._playPlotCallback = nil
	end
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_onWorkFinish()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.RoguePlot)
	self:_onShowPlotStep(nil, 1)
	ViewMgr.instance:openSpecialView(ViewName.RoguePlot, self._plotCode)
end

function M:exitPlot()
	self:_destroyWork()
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

M.instance = M.New()

return M
