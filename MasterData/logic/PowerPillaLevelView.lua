-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaLevelView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaLevelView", package.seeall)

local PowerPillaLevelView = class("PowerPillaLevelView", ViewComponent)

JoyStickDirection = {
	Down = 2,
	Up = 1,
	Right = 4,
	Default = 0,
	Left = 3
}

function PowerPillaLevelView:ctor()
	PowerPillaLevelView.super.ctor(self)

	self._directionParam = 0.707
	self._recycleMapGoList = {}
	self._recycleMaskGoList = {}
	self._mapCellList = {}
	self._maskCellList = {}
	self._joyStickDirection = JoyStickDirection.Default
	self._intervalTime = 0.5
end

function PowerPillaLevelView:buildUI()
	PowerPillaLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("topLeft/btnClose")
	self._btnBuff = self:getBtn("btnBuff")
	self._redpointBtnBuff = self:getGo("btnBuff/redPoint")
	self._goldBar = self:getGo("goldBarCon")
	self._txtLevel = self:getTxt("topLeft/txtTitle")
	self._bg = self:getGo("bg")
	self._signGet = self:getGo("btnSign/get")
	self._redPoint = self:getGo("btnSign/redPoint")
	self._joystickBg = self:getGo("joystickview/joystickArea/joystickbackground")
	self._virtualJoystick = goutil.addComponentOnce(self._joystickBg, typeof(VirtualJoystick))
	self._joystickCtrl = goutil.findChildComponent(self.mainGO, "joystickview", typeof(ClickToShowJoystick))

	self._joystickCtrl.gameObject:SetActive(true)
	GameUtil.SetActive(self:getGo("joystickview/mainActiveArea"), false)
	GameUtil.SetActive(self:getGo("joystickview/joystickArea"), false)

	self._mapLayer = self:getGo("root/mapLayer")
	self._roleLayer = self:getGo("root/roleLayer")
	self._maskLayer = self:getGo("root/maskLayer")
	self._mapCell = self:getGo("root/mapCell")
	self._roleCell = self:getGo("root/roleCell")
	self._maskCell = self:getGo("root/maskCell")
	self._maskGoList = {}
end

function PowerPillaLevelView:bindEvents()
	PowerPillaLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._virtualJoystick:AddDownListener(self._onJoystickDown, self)
	self._virtualJoystick:AddUpListener(self._onJoystickUp, self)
	self._virtualJoystick:AddDragListener(self._onJoystickDrag, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
end

function PowerPillaLevelView:unbindEvents()
	PowerPillaLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._virtualJoystick:RemoveDownListener()
	self._virtualJoystick:RemoveUpListener()
	self._virtualJoystick:RemoveDragListener()
	self._btnBuff:RemoveClickListener()
end

function PowerPillaLevelView:onEnter()
	PowerPillaLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.MPPDoGridEventRes, self._onDoGridEventRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPDoGridEventEndRes, self._onDoGridEventRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGetActInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPTrapActive, self._onTrapActive, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGetGameInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)

	self._activityId = PowerPillaModel.instance:getActivityId()
	self._petPlanId = PowerPillaModel.instance:getPetPlanId()
	self._stagePlanId = PowerPillaModel.instance:getStagePlanId()
	self._cfgActivity = PowerPillaConfig.instance:getActivityCfg(self._activityId)
	self._isSendReqPos = true
	self._isExit = false

	self:_setGoldBar(self._cfgActivity)
	RedPointController.instance:regRedPoint(self._redpointBtnBuff, RedPointModel.ID_POWERPILLA_BUFF_CAN_UPDATE)
	self:_onUpdate()
	MaintainPowerPillaAgent.instance:sendPM_MPPGetActInfoReq(self._activityId)
	MaintainPowerPillaAgent.instance:sendPM_MPPGetBuffInfoReq(self._activityId)
end

function PowerPillaLevelView:onExit()
	PowerPillaLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPDoGridEventRes, self._onDoGridEventRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPDoGridEventEndRes, self._onDoGridEventRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetActInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPTrapActive, self._onTrapActive, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetGameInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)
	removetimer(self._onFixedTime, self)
	self:_updateMoveList(nil)
	self:_clearMapCells()
	self:_clearRoleCell()
	self:_clearBgImage()
	self:_clearRole()
	self:_clearBgEffect()
	self._joystickCtrl:StopJoystickMove()
	removetimer(self._onMoveTick, self)
	RedPointController.instance:unregRedPoint(self._redpointBtnBuff)
end

function PowerPillaLevelView:_onClickClose()
	self:close()
end

function PowerPillaLevelView:_onUpdate()
	self:_initMapData()
	self:_clearRole()
	self:_updateAllMap()
end

function PowerPillaLevelView:_initMapData()
	local stage = PowerPillaModel.instance:getCurStage()
	local cfg = PowerPillaConfig.instance:getStageCfgById(self._activityId, stage)
	local rowColumn = cfg.rowColumn
	local arr = string.splitToNumber(rowColumn, "*")

	self._rowNum = arr[1]
	self._columnNum = arr[2]
	self._totalCellCount = self._rowNum * self._columnNum

	local gridSize = cfg.gridSize
	local var_9_0 = {}

	if gridSize then
		var_9_0.x = gridSize[1] or 100
	end

	if gridSize then
		var_9_0.y = gridSize[2] or 100
	end

	self._cellSize = var_9_0
	self._spaceing = {
		x = 1,
		y = 1
	}
	self._totalWidth = self._cellSize.x * self._columnNum + self._spaceing.x * (self._columnNum - 1)
	self._totalHeight = self._cellSize.y * self._rowNum + self._spaceing.y * (self._rowNum - 1)
	self._halfTotalWidth = self._totalWidth * 0.5
	self._halfTotalHeight = self._totalHeight * 0.5
	self._halfCellSize = {
		x = self._cellSize.x * 0.5,
		y = self._cellSize.y * 0.5
	}
	self._mapOriginPos = Vector2.New(self._halfTotalWidth * -1, self._halfTotalHeight)

	local width, height = GameUtil.getWidth(self._mapCell), GameUtil.getHeight(self._mapCell)
	local scale = GameUtil.getLocalScale(self._mapCell)

	self._scale = {
		x = self._cellSize.x / width * scale.x,
		y = self._cellSize.y / height * scale.y,
		scale.z
	}
end

function PowerPillaLevelView:_onClickSignIn()
	if PowerPillaModel.instance:isSignInDaily() then
		FloatWordMgr.instance:show("已签到")
	else
		MaintainPowerPillaAgent.instance:sendPM_MPPGainDailyPrizeReq(self._activityId)
	end
end

function PowerPillaLevelView:_onClickBuff()
	UIStateManager.instance:push(ViewName.PowerPillaBuffTreeView)
end

function PowerPillaLevelView:_onJoystickDown()
	self._joyStickDirection = JoyStickDirection.Default
	self._isMoveImmediately = true

	settimer(self._intervalTime, self._onFixedTime, self)
	self:_setRoleAnim("run")
end

function PowerPillaLevelView:_onJoystickUp()
	if self._roleCellCls then
		-- block empty
	end

	self._joyStickDirection = JoyStickDirection.Default
	self._isMoveImmediately = false

	removetimer(self._onFixedTime, self)
	self:_setRoleAnim("idle")

	if self._isSendReqPos and self._roleCellCls then
		self:_sendUpdateRolePos()
	else
		self._isSendReqPos = true
	end
end

function PowerPillaLevelView:_sendUpdateRolePos()
	local gridId = self:_getIndexByRowAndColumn(self._roleCellCls:getRow(), self._roleCellCls:getColumn())
	local stageId = PowerPillaModel.instance:getCurStage()

	MaintainPowerPillaAgent.instance:sendPM_MPPSaveLocationReq(self._activityId, stageId, gridId)
end

function PowerPillaLevelView:_onJoystickDrag(x, y)
	local lastDirection = self._joyStickDirection

	self._joyStickDirection = x >= self._directionParam and JoyStickDirection.Right or x <= -1 * self._directionParam and JoyStickDirection.Left or y >= self._directionParam and JoyStickDirection.Up or JoyStickDirection.Down

	if lastDirection == JoyStickDirection.Default and self._isMoveImmediately then
		self:_handleRoleMove()
	end
end

function PowerPillaLevelView:_onFixedTime()
	if self._joyStickDirection ~= JoyStickDirection.Default then
		self:_handleRoleMove()
	end
end

function PowerPillaLevelView:_onDoGridEventRes(msg)
	if msg then
		local reqStageId, reqGridId = msg.reqStageId, msg.reqGridId

		if msg.mapInfo then
			local newStage = msg.mapInfo.stageId
			local stageData = PowerPillaConfig.instance:getStageCfgById(self._activityId, reqStageId)
			local newStageData = PowerPillaConfig.instance:getStageCfgById(self._activityId, newStage)

			if stageData and stageData.mainStageId <= 0 then
				local gridData = PowerPillaConfig.instance:getGridDataByStage(self._activityId, reqStageId, reqGridId)

				if gridData and gridData.eventType == PPLMapCell.Exit then
					local maxStage = PowerPillaController.instance:getMaxMainStage(self._activityId)

					if maxStage <= reqStageId then
						self:_onClickClose()

						return
					end
				end
			end

			if not PowerPillaModel.instance:isOpenByCurrentStage(true, newStageData.stagePlanId, newStage) then
				self:_onClickClose()

				return
			end

			if newStage and newStage ~= reqStageId then
				MaintainPowerPillaAgent.instance:sendPM_MPPGetGameInfoReq(self._activityId, newStage)
				MaintainPowerPillaAgent.instance:sendPM_MPPGetActInfoReq(self._activityId)

				return
			end
		end
	end

	self:_updateMapLayer()
	self:_updateRoleLayer()
	self:_updateMaskLayer()
end

function PowerPillaLevelView:_onTrapActive(gridId)
	printInfo("test 陷阱激活", self._roleCellCls:getGridId(), gridId)

	if self._roleCellCls and self._roleCellCls:getGridId() == gridId then
		self:_handleTrapEvent(self._mapCellList[gridId], gridId)
	end
end

function PowerPillaLevelView:_updateAllMap()
	local stage = PowerPillaModel.instance:getCurStage()

	self._gridCfgs = PowerPillaConfig.instance:getGridDataListByStage(self._activityId, stage)

	local cfg = PowerPillaConfig.instance:getStageCfgById(self._activityId, stage)

	self._isExistMask = cfg.isShowMask

	self:_loadBgEffect(stage)
	self:_initMapLayer()
	self:_initRoleLayer()
	self:_initMaskLayer()
	self:_setTxtLevel(stage)
	self:_setBgImage(self._stagePlanId, stage)
end

function PowerPillaLevelView:_initMapLayer()
	self:_clearMapCells()

	local stage = PowerPillaModel.instance:getCurStage()
	local cfg = PowerPillaConfig.instance:getStageCfgById(self._activityId, stage)

	for i = 1, self._totalCellCount do
		local go = self:_getMapGo()

		go.name = "mapCell" .. i

		go.transform:SetAsLastSibling()

		local cls = GameUtil.AddLuaOnce(go, PPLMapCell)
		local param = {}

		param.index = i
		param.eventType = self._gridCfgs[i].eventType
		param.cfg = self._gridCfgs[i]
		param.pos, param.row, param.column = self:_caculateMapPos(i)
		param.scale = self._scale
		param.activityId = self._activityId
		param.stage = stage
		param.view = self

		cls:init(param)
		table.insert(self._mapCellList, cls)
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickCell, self, param))
	end

	local blockType, array, index
	local data = {}

	for i = 1, self._rowNum do
		array = {}
		data[i - 1] = array

		for j = 1, self._columnNum do
			local eventType = self._gridCfgs[(i - 1) * self._columnNum + j].eventType

			blockType = eventType == PPLMapCell.Obstacle and LuaPathfinder_Const.BlockType_Wall or LuaPathfinder_Const.BlockType_None
			array[j - 1] = {
				weight = 20,
				x = i - 1,
				y = j - 1,
				blockType = blockType
			}
		end
	end

	self._internalFinder = LuaAStarPathfinder.New()

	self._internalFinder:reload(data, self._rowNum, self._columnNum, LuaPathfinder_Const.CostFlag_Dir_4, LuaPathfinder_Const.HeuristicFlag_Manhattan)
	removetimer(self._onMoveTick, self)
	settimer(0, self._onMoveTick, self)
end

function PowerPillaLevelView:_onClickCell(param)
	if self._internalFinder then
		local oldRow = self._roleCellCls:getRow()
		local oldColumn = self._roleCellCls:getColumn()
		local startNode = self._internalFinder:getNode(oldRow - 1, oldColumn - 1)
		local endNode = self._internalFinder:getNode(param.row - 1, param.column - 1)

		if startNode and endNode then
			local pathList = self._internalFinder:search(startNode, endNode)

			if pathList then
				local length = #pathList
				local indexList = {}

				for j = 1, length, 2 do
					local idx = self:_getIndexByRowAndColumn(pathList[j] + 1, pathList[j + 1] + 1)

					table.insert(indexList, idx)
				end

				self:_updateMoveList(indexList)
			end
		end
	end
end

function PowerPillaLevelView:_updateMoveList(indexList)
	self._pathIndexList = indexList
	self._curMoveStepIdx = 1

	if indexList and #indexList > 0 then
		local curIdx = self._roleCellCls:getGridId()
		local nexIdx = self._pathIndexList[self._curMoveStepIdx]

		self:_updateRoleDir(curIdx, nexIdx)
		self:_setRoleAnim("run")
	else
		self:_setRoleAnim("idle")
		self._joystickCtrl:StopJoystickMove()
	end
end

function PowerPillaLevelView:_onMoveTick()
	if self._pathIndexList and #self._pathIndexList >= self._curMoveStepIdx then
		local destIdx = self._pathIndexList[self._curMoveStepIdx]

		if not self:_checkCanMoveTo(destIdx) then
			self:_updateMoveList(nil)

			local curRoleIdx = self._roleCellCls:getGridId()

			self:_sendUpdateRolePos()
			self:_doEvent(curRoleIdx, destIdx)

			return
		end

		local pos, row, column = self:_caculateMapPos(destIdx)
		local rolePos = self._roleCellCls:getPos()
		local dx = pos[1] - rolePos[1]
		local dy = pos[2] - rolePos[2]
		local distance = math.sqrt(dx * dx + dy * dy)
		local angle = math.atan2(dy, dx)
		local speed = 6.5

		if distance < 0.1 then
			PowerPillaModel.instance:onMPPSaveLocationRes(destIdx)

			self._curMoveStepIdx = self._curMoveStepIdx + 1

			self:_updateMaskLayer()

			if self._curMoveStepIdx > #self._pathIndexList then
				self:_updateMoveList(nil)
			else
				local nexIdx = self._pathIndexList[self._curMoveStepIdx]

				self:_updateRoleDir(destIdx, nexIdx)
			end
		else
			local moveDistance = math.min(distance, speed)

			rolePos[1] = rolePos[1] + moveDistance * math.cos(angle)
			rolePos[2] = rolePos[2] + moveDistance * math.sin(angle)
			distance = distance - moveDistance

			local r, c = self:_caculateMapIndexByPos(rolePos)

			self._roleCellCls:updatePos(r, c, rolePos)
		end
	end
end

function PowerPillaLevelView:_updateRoleDir(curIdx, toIdx)
	local _, _, column = self:_caculateMapPos(curIdx)
	local _, _, newColumn = self:_caculateMapPos(toIdx)

	if column < newColumn then
		self._roleCellCls:setLocalScale(1, 1, 1)
	else
		self._roleCellCls:setLocalScale(-1, 1, 1)
	end
end

function PowerPillaLevelView:_updateMapLayer()
	if self._mapCellList then
		for i, v in ipairs(self._mapCellList) do
			v:updateData()
		end
	end
end

function PowerPillaLevelView:_getMapGo()
	local count = #self._recycleMapGoList

	if count > 0 then
		local go = table.remove(self._recycleMapGoList, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._mapCell, self._mapLayer.transform, "mapCell")

		goutil.setActive(go, true)

		return go
	end
end

function PowerPillaLevelView:_recycleMapGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		table.insert(self._recycleMapGoList, go)
	end
end

function PowerPillaLevelView:_clearMapCells()
	for i, v in ipairs(self._mapCellList) do
		local go = v:getGo()

		GameUtil.rmClickHandler(go)
		v:reset()
		self:_recycleMapGo(go)
	end

	table.clear(self._mapCellList)
end

function PowerPillaLevelView:_getRowAndColumn(index)
	local row = Mathf.Floor((index - 1) / self._columnNum) + 1
	local column = (index - 1) % self._columnNum + 1

	return row, column
end

function PowerPillaLevelView:_getIndexByRowAndColumn(row, column)
	return (row - 1) * self._columnNum + column
end

function PowerPillaLevelView:_caculateMapPos(index)
	local row, column = self:_getRowAndColumn(index)
	local x = self._mapOriginPos.x + (column - 1) * (self._cellSize.x + self._spaceing.x) + self._halfCellSize.x
	local y = self._mapOriginPos.y + -1 * ((row - 1) * (self._cellSize.y + self._spaceing.y) + self._halfCellSize.y)

	return {
		x,
		y
	}, row, column
end

function PowerPillaLevelView:_caculateMapIndexByPos(pos)
	local posx, posy = pos[1], pos[2]
	local col = 1 + (posx - self._mapOriginPos.x - self._halfCellSize.x) / (self._cellSize.x + self._spaceing.x)
	local row = 0 - (posy - self._mapOriginPos.y - self._halfCellSize.y) / (self._cellSize.y + self._spaceing.y)

	return math.round(row), math.round(col)
end

function PowerPillaLevelView:_getInitIndex()
	local gridId = PowerPillaModel.instance:getCurGridId()

	if gridId <= 0 then
		for i, v in ipairs(self._gridCfgs) do
			if v.eventType == PPLMapCell.Entrance then
				gridId = i

				break
			end
		end
	end

	if gridId <= 0 then
		gridId = 1
	end

	return gridId
end

function PowerPillaLevelView:_initRoleLayer()
	if not self._roleCellGo then
		self._roleCellGo = goutil.cloneAndSetParent(self._roleCell, self._mapLayer.transform, "roleCell")

		goutil.setActive(self._roleCellGo, true)
	end

	self._roleCellCls = self._roleCellCls or GameUtil.AddLuaOnce(self._roleCellGo, PPLRoleCell)

	self:_loadRole()

	local index = self:_getInitIndex()
	local row, column = self:_getRowAndColumn(index)
	local param = {}

	param.columnNum = self._columnNum
	param.row = row
	param.column = column
	param.pos = self._mapCellList[index]:getPos()

	self._roleCellCls:init(param)
end

function PowerPillaLevelView:_updateRoleLayer()
	if self._mapCellList and self._roleCellCls then
		local curGridId = self:_getInitIndex()
		local pos = self._mapCellList[curGridId]:getPos()
		local row, column = self:_getRowAndColumn(curGridId)

		self._roleCellCls:updatePos(row, column, {
			pos[1],
			pos[2]
		})
	end
end

function PowerPillaLevelView:_clearRoleCell()
	return
end

function PowerPillaLevelView:_handleRoleMove()
	local rowMove = 0
	local columnMove = 0

	if self._joyStickDirection == JoyStickDirection.Left then
		rowMove = -1

		self._roleCellCls:setLocalScale(-1, 1, 1)
	elseif self._joyStickDirection == JoyStickDirection.Right then
		rowMove = 1

		self._roleCellCls:setLocalScale(1, 1, 1)
	elseif self._joyStickDirection == JoyStickDirection.Up then
		columnMove = -1
	elseif self._joyStickDirection == JoyStickDirection.Down then
		columnMove = 1
	end

	if self._roleCellCls then
		local oldRow = self._roleCellCls:getRow()
		local oldColumn = self._roleCellCls:getColumn()
		local newRow = oldRow + columnMove
		local newColumn = oldColumn + rowMove
		local oldIndex = self:_getIndexByRowAndColumn(oldRow, oldColumn)
		local index = self:_getIndexByRowAndColumn(newRow, newColumn)

		if self:_isMoveSuccess(newRow, newColumn, index) then
			local pos = self._mapCellList[index]:getPos()

			self._roleCellCls:updatePos(newRow, newColumn, {
				pos[1],
				pos[2]
			})
			self:_updateMaskLayer()
			self:_doEvent(oldIndex, index)
		elseif self:_isGridAvailable(newRow, newColumn, index) then
			self:_doEvent(oldIndex, index)
		end
	end
end

function PowerPillaLevelView:_doEvent(curGridId, newGridId)
	local stag = PowerPillaModel.instance:getCurStage()
	local gridData = PowerPillaConfig.instance:getGridDataByStage(self._activityId, stag, newGridId)
	local npcData = PowerPillaConfig.instance:getNpcDataByGrid(gridData.mapId, newGridId)

	if npcData and npcData.storyId > 0 then
		self._playingStoryId = npcData.storyId
		self._endStoryCallBack = GameUtil.handler(self._handleEvent, self, curGridId, newGridId)

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._playingStoryId, StoryModel.StoryType.SCCopy)
	else
		self:_handleEvent(curGridId, newGridId)
	end
end

function PowerPillaLevelView:_onEndStory(storyId)
	if storyId == self._playingStoryId then
		self._playingStoryId = 0

		GameUtil.callBack(self._endStoryCallBack)
	end
end

function PowerPillaLevelView:_handleEvent(curGridId, newGridId)
	local eventType = self._mapCellList[newGridId]:getEventType()
	local eventId = self._mapCellList[newGridId]:getEventId()

	if eventType == PPLMapCell.Obstacle then
		-- block empty
	elseif eventType == PPLMapCell.Entrance then
		-- block empty
	elseif eventType == PPLMapCell.Exit then
		self._isSendReqPos = false
		self._isExit = true

		self:_handleExitEvent(curGridId, newGridId)
	elseif eventType == PPLMapCell.Battle then
		self._isSendReqPos = false

		self:_handleBattleEvent(curGridId, newGridId, eventId)
	elseif eventType == PPLMapCell.Box then
		self._isSendReqPos = false

		self:_handleBoxEvent(curGridId, newGridId)
	elseif eventType == PPLMapCell.Trap then
		self:_handleTrapEvent(self._mapCellList[newGridId], newGridId)
	elseif eventType == PPLMapCell.Game then
		self._isSendReqPos = false

		self:_handleGameEvent(curGridId, newGridId, eventId)
	elseif eventType == PPLMapCell.Boss then
		self._isSendReqPos = false

		self:_handleBattleEvent(curGridId, newGridId, eventId)
	elseif eventType == PPLMapCell.Branch then
		self._isSendReqPos = false
		self._isExit = true

		self:_handleBranchEvent(curGridId, newGridId)
	end
end

function PowerPillaLevelView:_handleTrapEvent(mapCell, newGridId)
	if mapCell:getTrapActive() then
		self:_updateMoveList(nil)

		local stageId = PowerPillaModel.instance:getCurStage()

		MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(self._activityId, stageId, newGridId, newGridId)
	end
end

function PowerPillaLevelView:_handleBoxEvent(curGridId, newGridId)
	local stageId = PowerPillaModel.instance:getCurStage()

	MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(self._activityId, stageId, newGridId, curGridId)
end

function PowerPillaLevelView:_handleBattleEvent(curGridId, newGridId, eventId)
	local customFmtMo = PowerPillaModel.instance:getCustomFmtMo()
	local stageId = PowerPillaModel.instance:getCurStage()

	customFmtMo:updateParam(self._activityId, stageId, curGridId, newGridId, self._petPlanId, eventId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function PowerPillaLevelView:_handleExitEvent(curGridId, newGridId)
	local stageId = PowerPillaModel.instance:getCurStage()
	local stageData = PowerPillaConfig.instance:getStageCfgById(self._activityId, stageId)

	if stageData.bossEventId > 0 and not PowerPillaModel.instance:isChallengedBoss() then
		FloatWordMgr.instance:show("未对当前关卡boss发起挑战")

		return
	end

	if stageData.mainStageId <= 0 then
		local isPass = PowerPillaModel.instance:isPassOfStage(stageId)

		if isPass then
			local maxStage = PowerPillaController.instance:getMaxMainStage(self._activityId)
			local newStage = Mathf.Min(stageId + 1, maxStage)
			local newStageData = PowerPillaConfig.instance:getStageCfgById(self._activityId, newStage)

			if stageId == maxStage then
				self:_onClickClose()

				return
			end

			if not PowerPillaModel.instance:isOpenByCurrentStage(true, newStageData.stagePlanId, newStage) then
				return
			end
		end
	end

	local function okFunc()
		MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(self._activityId, stageId, newGridId, curGridId)
	end

	if not PowerPillaModel.instance:isGetedAllBox() then
		local text = lang("text_whlz")

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	else
		okFunc()
	end
end

function PowerPillaLevelView:_handleGameEvent(curGridId, newGridId, eventId)
	local gameData = PowerPillaConfig.instance:getGameData(eventId)

	if gameData.gameType == 1 then
		local gameParamsList = string.split(gameData.gameParams, "#")
		local gameActivityId = checknumber(gameParamsList[1])
		local gameStageId = checknumber(gameParamsList[2])
		local params = {}

		params.activityId = self._activityId
		params.stageId = PowerPillaModel.instance:getCurStage()
		params.eventGridId = newGridId
		params.playerGridId = curGridId
		params.isTrigger = PowerPillaModel.instance:isTriggeredEvent(newGridId)

		UIStateManager.instance:push(ViewName.HuarongRoadGameCopyView, gameActivityId, gameStageId, params)
	end
end

function PowerPillaLevelView:_handleBranchEvent(curGridId, newGridId)
	local stageId = PowerPillaModel.instance:getCurStage()

	MaintainPowerPillaAgent.instance:sendPM_MPPDoGridEventReq(self._activityId, stageId, newGridId, curGridId)
end

function PowerPillaLevelView:_isGridAvailable(newRow, newColumn, index)
	return newRow >= 1 and newRow <= self._rowNum and newColumn >= 1 and newColumn <= self._columnNum
end

function PowerPillaLevelView:_isMoveSuccess(newRow, newColumn, index)
	if not self:_isGridAvailable(newRow, newColumn, index) then
		return false
	end

	return self:_checkCanMoveTo(index)
end

function PowerPillaLevelView:_checkCanMoveTo(index)
	local eventType = self._mapCellList[index]:getEventType()
	local eventId = self._mapCellList[index]:getEventId()

	if eventType == PPLMapCell.Obstacle then
		return false
	elseif eventType == PPLMapCell.Entrance then
		return true
	elseif eventType == PPLMapCell.Exit then
		return false
	elseif eventType == PPLMapCell.Battle then
		return PowerPillaModel.instance:isTriggeredEvent(index)
	elseif eventType == PPLMapCell.Box then
		return PowerPillaModel.instance:isTriggeredEvent(index)
	elseif eventType == PPLMapCell.Trap then
		return true
	elseif eventType == PPLMapCell.Game then
		return false
	elseif eventType == PPLMapCell.Boss then
		return false
	elseif eventType == PPLMapCell.Branch then
		return false
	else
		return true
	end
end

function PowerPillaLevelView:_initMaskGos()
	if #self._maskGoList == 0 then
		for i = 1, self._totalCellCount do
			local go = goutil.cloneAndSetParent(self._maskCell, self._maskLayer.transform, "maskCell" .. i)
			local pos = self:_caculateMapPos(i)

			Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), pos[1], pos[2])
			goutil.setActive(go, false)
			table.insert(self._maskGoList, go)
		end
	end
end

function PowerPillaLevelView:_initMaskLayer()
	if self._isExistMask then
		goutil.setActive(self._maskLayer, true)
		self:_initMaskGos()
		self:_updateMaskLayer()
	else
		goutil.setActive(self._maskLayer, false)
		self:_updateRoleIndex()
	end
end

function PowerPillaLevelView:_updateMaskLayer()
	if self._isExistMask then
		local row = self._roleCellCls:getRow()
		local column = self._roleCellCls:getColumn()
		local maxRow = self._rowNum
		local maxColumn = self._columnNum
		local hideMaskGrids = {}

		hideMaskGrids[self._roleCellCls:getGridId()] = true

		if maxRow >= row + 1 then
			local gridId = self:_getIndexByRowAndColumn(row + 1, column)

			hideMaskGrids[gridId] = true
		end

		if row - 1 >= 1 then
			local gridId = self:_getIndexByRowAndColumn(row - 1, column)

			hideMaskGrids[gridId] = true
		end

		if maxColumn >= column + 1 then
			local gridId = self:_getIndexByRowAndColumn(row, column + 1)

			hideMaskGrids[gridId] = true
		end

		if column - 1 >= 1 then
			local gridId = self:_getIndexByRowAndColumn(row, column - 1)

			hideMaskGrids[gridId] = true
		end

		for i, v in ipairs(self._maskGoList) do
			goutil.setActive(v, not hideMaskGrids[i])
		end
	end

	self:_updateRoleIndex()
end

function PowerPillaLevelView:_updateRoleIndex()
	if self._roleCellGo then
		local idx = self._roleCellCls:getGridId()

		self._roleCellGo.transform:SetSiblingIndex(idx)
	end
end

function PowerPillaLevelView:_setGoldBar(cfg)
	local matMo = string.splitToNumber(cfg.gameCoin, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
end

function PowerPillaLevelView:_setTxtLevel(stage)
	local cfg = PowerPillaConfig.instance:getStageCfgById(self._activityId, stage)

	self._txtLevel.text = cfg.stageName
end

function PowerPillaLevelView:_setBgImage(stagePlanId, stage)
	local cfg = PowerPillaConfig.instance:getStageCfg(stagePlanId, stage)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("game/powerpilla", cfg.mapPath), function()
		self._bg:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
end

function PowerPillaLevelView:_clearBgImage()
	uGuiUtil.clearImage(self._bg)
end

function PowerPillaLevelView:_loadRole()
	if self._aoqiRole or not self._roleCellGo then
		return
	end

	local path = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"

	self._aoqiRole = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, -18, 0)

		self._skeletonGraphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")
		self._skeletonGraphic.startingAnimation = "idle"

		self._skeletonGraphic.AnimationState:SetAnimation(0, "idle", true)
		self._skeletonGraphic:Update(0)
	end)

	self._aoqiRole:setParent(self._roleCellGo.transform)
	self._aoqiRole:setScale(0.2)
end

function PowerPillaLevelView:_clearRole()
	if self._aoqiRole then
		UIEffectManager.instance:stopEffect(self._aoqiRole)

		self._aoqiRole = nil
	end

	self._skeletonGraphic = nil
end

function PowerPillaLevelView:_setRoleAnim(animName)
	if self._skeletonGraphic then
		self._skeletonGraphic.AnimationState:SetAnimation(0, animName, true)
		self._skeletonGraphic:Update(0)
	end
end

function PowerPillaLevelView:_getPathByStage(stage)
	local data = PowerPillaConfig.instance:getStageCfgById(self._activityId, stage)

	return data and data.bgEff
end

function PowerPillaLevelView:_loadBgEffect(stage)
	self:_clearBgEffect()

	local path = self:_getPathByStage(stage)

	if not string.nilorempty(path) then
		path = path .. ".prefab"
		self._bgEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

		self._bgEffect:setParent(self._bg.transform)
		self._bgEffect:setScale(1)
		self._bgEffect:setLocalPos(0, 0, 0)
	end
end

function PowerPillaLevelView:_clearBgEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

return PowerPillaLevelView
