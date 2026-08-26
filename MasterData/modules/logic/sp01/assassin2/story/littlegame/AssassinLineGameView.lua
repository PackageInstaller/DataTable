-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinLineGameView.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinLineGameView", package.seeall)

local AssassinLineGameView = class("AssassinLineGameView", BaseView)
local LineStatus = {
	Disconnected = 1,
	Connecting = 3,
	Connected = 2
}
local LockScreenKey = "AssassinLineGameView"
local TriggerConnectDistance = 30
local DelayConnectPoint = 0.3
local Delay2Switch = 2

function AssassinLineGameView:onInitView()
	self._gogame1 = gohelper.findChild(self.viewGO, "root/#go_game1")
	self._golines = gohelper.findChild(self.viewGO, "root/#go_game1/#go_lines")
	self._gopoints = gohelper.findChild(self.viewGO, "root/#go_game1/#go_points")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/top/#txt_title")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._goprogresspoints = gohelper.findChild(self.viewGO, "root/top/#go_points")
	self._goprogressitem = gohelper.findChild(self.viewGO, "root/top/#go_points/#go_point")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLineGameView:addEvents()
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnGameAfterStoryDone, self.closeThis, self)
end

function AssassinLineGameView:removeEvents()
	return
end

function AssassinLineGameView:_editableInitView()
	self:initLines()
	self:initPoints()
	self:initDialogs()
	self:refreshProgress()
end

function AssassinLineGameView:initLines()
	self._linesTran = self._golines.transform
	self._lineCount = self._linesTran.childCount
	self._lineRootGoTab = self:getUserDataTb_()
	self._guideLineGoTab = self:getUserDataTb_()
	self._lineStatusMap = {}

	for i = 1, self._lineCount do
		local golineroot = self._linesTran:GetChild(i - 1).gameObject

		if gohelper.isNil(golineroot) then
			break
		end

		SLFramework.UGUI.UIDragListener.Get(golineroot):AddDragBeginListener(self._onDragBegin, self, i)
		SLFramework.UGUI.UIDragListener.Get(golineroot):AddDragListener(self._onDrag, self, i)
		SLFramework.UGUI.UIDragListener.Get(golineroot):AddDragEndListener(self._onDragEnd, self, i)
		gohelper.setActive(golineroot, false)
		table.insert(self._lineRootGoTab, golineroot)

		local goguideline = gohelper.findChild(self.viewGO, "root/#go_game1/#go_guid/#line" .. i)

		gohelper.setActive(goguideline, false)

		self._guideLineGoTab[i] = goguideline
		self._lineStatusMap[i] = LineStatus.Disconnected
	end
end

function AssassinLineGameView:initPoints()
	self._lineIndex2PointDict = {}
	self._pointGoTab = self:getUserDataTb_()
	self._pointsTran = self._gopoints.transform
	self._pointCount = self._pointsTran.childCount
	self._collectPointCount = 0

	for i = 1, self._pointCount do
		local gopoint = self._pointsTran:GetChild(i - 1).gameObject

		if gohelper.isNil(gopoint) then
			break
		end

		local namePartList = string.splitToNumber(gopoint.name, "_")
		local fromLineIndex = namePartList[1]
		local toLineIndex = namePartList[2]

		self._lineIndex2PointDict[fromLineIndex] = i
		self._lineIndex2PointDict[toLineIndex] = i
		self._pointGoTab[i] = gopoint

		gohelper.setActive(gopoint, false)
	end
end

function AssassinLineGameView:activeGuideLine(lineTab, indexList)
	if not lineTab or not indexList then
		return
	end

	for index, goguideline in pairs(lineTab) do
		local isActive = tabletool.indexOf(indexList, index) ~= nil

		gohelper.setActive(goguideline, isActive)
	end
end

function AssassinLineGameView:getLineConnectKey(fromLineIndex, toLineIndex)
	if toLineIndex < fromLineIndex then
		fromLineIndex = toLineIndex
		toLineIndex = fromLineIndex
	end

	return string.format("%s_%s", fromLineIndex, toLineIndex)
end

function AssassinLineGameView:_onDragBegin(param, pointerEventData)
	self:_processDragEvent(param, pointerEventData)
end

function AssassinLineGameView:_onDrag(param, pointerEventData)
	self:_processDragEvent(param, pointerEventData)
end

function AssassinLineGameView:_onDragEnd(param, pointerEventData)
	self:_processDragEvent(param, pointerEventData)

	self._startDragPosition = nil
end

function AssassinLineGameView:_processDragEvent(param, pointerEventData)
	self._startDragPosition = self._startDragPosition or pointerEventData.position

	local lineIndex = tonumber(param)
	local status = self._lineStatusMap[lineIndex]
	local goline = self._lineRootGoTab[lineIndex]

	if not status or status == LineStatus.Connected or status == LineStatus.Connecting or Vector2.Distance(pointerEventData.position, self._startDragPosition) < TriggerConnectDistance then
		return
	end

	self._lineStatusMap[lineIndex] = LineStatus.Connecting

	gohelper.setActive(self._guideLineGoTab[lineIndex], false)

	local animatorPlayer = SLFramework.AnimatorPlayer.Get(goline)

	animatorPlayer:Play("open", self._onLinePlayOpenAnimDone, {
		self = self,
		lineIndex = lineIndex
	})
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_dragLine)
end

function AssassinLineGameView._onLinePlayOpenAnimDone(params)
	local view = params and params.self
	local lineIndex = params and params.lineIndex

	if lineIndex % 2 ~= 0 then
		view:activeLineAndGuide(lineIndex + 1, true)
	end

	view._lineStatusMap[lineIndex] = LineStatus.Connected

	view:_checkIsLineConnect2OtherLine(lineIndex)
end

function AssassinLineGameView:_checkIsLineConnect2OtherLine(lineIndex)
	local pointIndex = self._lineIndex2PointDict[lineIndex]

	if not pointIndex then
		return
	end

	for _lineIndex, _pointIndex in pairs(self._lineIndex2PointDict) do
		if _lineIndex ~= lineIndex and _pointIndex == pointIndex then
			local otherLineIndex = _lineIndex
			local otherLineStatus = self._lineStatusMap[otherLineIndex]

			if otherLineStatus ~= LineStatus.Connected then
				return
			end
		end
	end

	self:destroyConnectPointFlow()

	self._connectLineFlow = FlowSequence.New()

	self._connectLineFlow:addWork(FunctionWork.New(self.lockScreen, self, true))
	self._connectLineFlow:addWork(DelayDoFuncWork.New(self.onConnect2Point, self, DelayConnectPoint, pointIndex))
	self._connectLineFlow:addWork(DelayDoFuncWork.New(self.switch2NextGame, self, Delay2Switch))
	self._connectLineFlow:addWork(FunctionWork.New(self.lockScreen, self, false))
	self._connectLineFlow:start()
end

function AssassinLineGameView:onConnect2Point(pointIndex)
	local gopoint = self._pointGoTab[pointIndex]

	if not gopoint then
		return
	end

	self._collectPointCount = self._collectPointCount + 1

	gohelper.setActive(gopoint, true)
	self:playLineCloseAnim(pointIndex)
	self:refreshProgress()
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)
end

function AssassinLineGameView:playLineCloseAnim(pointIndex)
	for lineIndex, _pointIndex in pairs(self._lineIndex2PointDict) do
		if _pointIndex == pointIndex then
			local animatorPlayer = SLFramework.AnimatorPlayer.Get(self._lineRootGoTab[lineIndex])

			animatorPlayer:Play("close", self._onPlayLineCloseAnimDone, self)
		end
	end
end

function AssassinLineGameView:_onPlayLineCloseAnimDone()
	return
end

function AssassinLineGameView:switch2NextGame()
	if self._collectPointCount >= self._pointCount then
		self:onGameDone()
	else
		VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(self._dialogIdList[2], self.reallySwitch2NextGroup, self)
	end
end

function AssassinLineGameView:reallySwitch2NextGroup()
	self:activeLineAndGuide(3, true)
end

function AssassinLineGameView:refreshProgress()
	gohelper.CreateObjList(self, self._refreshSingleProgressPoint, self._pointGoTab, self._goprogresspoints, self._goprogressitem)
end

function AssassinLineGameView:_refreshSingleProgressPoint(obj, data, index)
	local goeyelight = gohelper.findChild(obj, "#eyelight")

	gohelper.setActive(goeyelight, index <= self._collectPointCount)
end

function AssassinLineGameView:initDialogs()
	self._dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_LineGame)

	VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(self._dialogIdList[1], self.reallyStartGame, self)
end

function AssassinLineGameView:reallyStartGame()
	self:activeLineAndGuide(1, true)
end

function AssassinLineGameView:activeLineAndGuide(index, active)
	gohelper.setActive(self._lineRootGoTab[index], active)
	gohelper.setActive(self._guideLineGoTab[index], active)
end

function AssassinLineGameView:onGameDone()
	self.viewContainer:stat(StatEnum.Result.Success)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnGameEpisodeFinished, self._episodeId)
end

function AssassinLineGameView:destroyConnectPointFlow()
	if self._connectLineFlow then
		self._connectLineFlow:destroy()

		self._connectLineFlow = nil
	end
end

function AssassinLineGameView:releaseAllListener()
	if self._lineRootGoTab then
		for _, goline in pairs(self._lineRootGoTab) do
			SLFramework.UGUI.UIDragListener.Get(goline):RemoveDragBeginListener()
			SLFramework.UGUI.UIDragListener.Get(goline):RemoveDragListener()
			SLFramework.UGUI.UIDragListener.Get(goline):RemoveDragEndListener()
		end
	end
end

function AssassinLineGameView:lockScreen(lock)
	AssassinHelper.lockScreen(LockScreenKey, lock)
end

function AssassinLineGameView:onOpen()
	self._episodeId = self.viewParam and self.viewParam.episodeId
end

function AssassinLineGameView:onClose()
	self:lockScreen(false)
	self:releaseAllListener()
	self:destroyConnectPointFlow()
end

function AssassinLineGameView:onDestroyView()
	return
end

return AssassinLineGameView
