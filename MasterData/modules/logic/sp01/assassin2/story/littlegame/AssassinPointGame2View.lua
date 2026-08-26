-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinPointGame2View.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinPointGame2View", package.seeall)

local AssassinPointGame2View = class("AssassinPointGame2View", BaseView)
local LineStatus = {
	Disconnected = 1,
	Connected = 2
}
local BlockScreenKey = "AssassinPointGame2View"
local DelayCheckConnectPoint = 0.5

function AssassinPointGame2View:onInitView()
	self._gogame1 = gohelper.findChild(self.viewGO, "root/#go_game1")
	self._golines = gohelper.findChild(self.viewGO, "root/#go_game1/#go_lines2")
	self._gopoints1 = gohelper.findChild(self.viewGO, "root/#go_game1/#go_points")
	self._gopoints2 = gohelper.findChild(self.viewGO, "root/#go_game1/#go_points2")
	self._goeyelight = gohelper.findChild(self.viewGO, "root/top/#go_points/#go_point1/#eyelight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinPointGame2View:addEvents()
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnGameAfterStoryDone, self.closeThis, self)
end

function AssassinPointGame2View:removeEvents()
	return
end

function AssassinPointGame2View:_editableInitView()
	self._pointView = self.viewContainer._views[1]

	self:initLines()
	self:initPoints()
end

function AssassinPointGame2View:initLines()
	self._linesTran = self._golines.transform
	self._lineCount = self._linesTran.childCount
	self._lineName2GoDict = {}
	self._lineStatusDict = {}

	for i = 1, self._lineCount do
		local goline = self._linesTran:GetChild(i - 1).gameObject

		if gohelper.isNil(goline) then
			break
		end

		local lineName = goline.name

		self._lineName2GoDict[lineName] = goline
		self._lineStatusDict[lineName] = LineStatus.Disconnected
	end
end

function AssassinPointGame2View:initPoints()
	self._pointGoTab = self:getUserDataTb_()
	self._pointName2GoTab = self:getUserDataTb_()
	self._lineName2ConnectPointDict = {}
	self._point2ConnectLineNameDict = {}
	self._pointsTran = self._gopoints2.transform
	self._pointCount = 1
	self._collectPointCount = 0

	for i = 1, self._pointCount do
		local gopoint = self._pointsTran:GetChild(i - 1).gameObject

		if gohelper.isNil(gopoint) then
			break
		end

		self._pointName2GoTab[gopoint.name] = gopoint
		self._pointGoTab[i] = gopoint

		local connectLineNameList = string.split(gopoint.name, "#")

		for _, connectLineName in ipairs(connectLineNameList) do
			self._lineName2ConnectPointDict[connectLineName] = i
		end

		self._point2ConnectLineNameDict[i] = connectLineNameList
	end
end

function AssassinPointGame2View:onClickLineConnectPoint(pointIndex)
	if self._lastClickPointIndex then
		local connectLineGo = self:getTwoPointConnectLine(self._lastClickPointIndex, pointIndex)

		if connectLineGo then
			gohelper.setActive(connectLineGo, true)

			self._lineStatusDict[connectLineGo.name] = LineStatus.Connected

			self:checkNewLineConnectOtherLine(connectLineGo)
			AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_connectPoint)
		end

		self._pointView:onClickPointError(pointIndex)
		self._pointView:onClickPointError(self._lastClickPointIndex)

		self._lastClickPointIndex = nil

		return
	end

	self._lastClickPointIndex = pointIndex
end

function AssassinPointGame2View:getTwoPointConnectLine(pointName1, pointName2)
	local key1 = string.format("%s_%s", pointName1, pointName2)
	local key2 = string.format("%s_%s", pointName2, pointName1)

	return self._lineName2GoDict[key1] or self._lineName2GoDict[key2]
end

function AssassinPointGame2View:checkNewLineConnectOtherLine(lineGo)
	local lineName = lineGo.name
	local connectPointIndex = self._lineName2ConnectPointDict[lineName]
	local connectLineNameList = connectPointIndex and self._point2ConnectLineNameDict[connectPointIndex]

	if not connectLineNameList or #connectLineNameList <= 0 then
		return
	end

	for _, connectLineName in ipairs(connectLineNameList) do
		if self._lineStatusDict[connectLineName] == LineStatus.Disconnected then
			return
		end
	end

	self:destroyFlow()

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self.lockScreen, self, true))
	self._flow:addWork(DelayDoFuncWork.New(self.onNewLineConnectOtherLine, self, DelayCheckConnectPoint, connectPointIndex))
	self._flow:addWork(FunctionWork.New(self.lockScreen, self, false))
	self._flow:start()
end

function AssassinPointGame2View:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function AssassinPointGame2View:lockScreen(lock)
	AssassinHelper.lockScreen(BlockScreenKey, lock)
end

function AssassinPointGame2View:onNewLineConnectOtherLine(pointIndex)
	local gopoint = self._pointGoTab[pointIndex]

	if not gopoint then
		return
	end

	gohelper.setActive(gopoint, true)
	gohelper.setActive(self._gopoints2, true)
	gohelper.setActive(self._goeyelight, true)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)

	self._collectPointCount = self._collectPointCount + 1

	self:checkIsGameDone()
end

function AssassinPointGame2View:checkIsGameDone()
	local isAllCollect = self._collectPointCount >= self._pointCount

	if isAllCollect then
		gohelper.setActive(self._gopoints1, false)
		gohelper.setActive(self._golines, false)

		local dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_PointGame)

		if dialogIdList then
			if not #dialogIdList then
				local dialogCount = 0

				self._pointView:playDialog(dialogCount, self.onGameDone, self)
			end
		end
	end
end

function AssassinPointGame2View:onGameDone()
	self.viewContainer:stat(StatEnum.Result.Success)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnGameEpisodeFinished, self._episodeId)
end

function AssassinPointGame2View:onOpen()
	self._episodeId = self.viewParam and self.viewParam.episodeId
end

function AssassinPointGame2View:onClose()
	self:destroyFlow()
	self:lockScreen(false)
end

function AssassinPointGame2View:onDestroyView()
	return
end

return AssassinPointGame2View
