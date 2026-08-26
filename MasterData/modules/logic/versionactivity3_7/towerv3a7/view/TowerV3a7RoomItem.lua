-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7RoomItem.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7RoomItem", package.seeall)

local TowerV3a7RoomItem = class("TowerV3a7RoomItem", ListScrollCellExtend)

function TowerV3a7RoomItem:onInitView()
	self._goSelfBG = gohelper.findChild(self.viewGO, "#go_SelfBG")
	self._goEnemyBG = gohelper.findChild(self.viewGO, "#go_EnemyBG")
	self._goAttack = gohelper.findChild(self.viewGO, "#go_Attack")
	self._goAttacked = gohelper.findChild(self.viewGO, "#go_Attacked")
	self._goCanMove = gohelper.findChild(self.viewGO, "#go_CanMove")
	self._goPath = gohelper.findChild(self.viewGO, "#go_Path")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerV3a7RoomItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function TowerV3a7RoomItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function TowerV3a7RoomItem:_btnclickOnClick()
	if not self._canMove then
		return
	end

	TowerV3a7ChessManModel.instance:moveChess(self._roomMo)
end

function TowerV3a7RoomItem:_editableInitView()
	self._oldShowCamp1 = true
	self._curShowCamp1 = true

	gohelper.setActive(self._goSelfBG, true)
	gohelper.setActive(self._goEnemyBG, true)
	gohelper.setActive(self._goAttack, false)
	gohelper.setActive(self._goAttacked, false)
	gohelper.setActive(self._goCanMove, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._chessList = {}
	self._canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
	self._canvasGroup.alpha = 0
	self._canvasGroup.interactable = false
	self._canvasGroup.blocksRaycasts = false

	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.SelectChessMan, self._onSelectChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.SrcMoveChessMan, self._onSrcMoveChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.DstMoveChessMan, self._onDstMoveChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.MoveFinishChessMan, self._onMoveFinishChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.DeadChessMan, self._onDeadChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.DragFinishChessMan, self._onDragFinishChessMan, self)
	self:_initPath()
end

function TowerV3a7RoomItem:_initPath()
	self._pathGoMap = self:getUserDataTb_()

	for k, v in pairs(TowerV3a7Enum.PathDir) do
		local go = gohelper.findChild(self._goPath, k)

		gohelper.setActive(go, false)

		local WW = gohelper.findChild(go, "W_W")
		local WB = gohelper.findChild(go, "W_B")
		local BB = gohelper.findChild(go, "B_B")
		local BW = gohelper.findChild(go, "B_W")

		self._pathGoMap[v] = {
			go = go,
			[TowerV3a7Enum.PathStatus.WW] = WW,
			[TowerV3a7Enum.PathStatus.WB] = WB,
			[TowerV3a7Enum.PathStatus.BB] = BB,
			[TowerV3a7Enum.PathStatus.BW] = BW
		}
	end
end

function TowerV3a7RoomItem:updatePath(roomCampStatus)
	local roomConnectList = TowerV3a7RoomModel.instance:getRoomConnectList()
	local list = roomConnectList[self._roomId]

	if list == nil then
		return
	end

	local showCamp1 = roomCampStatus[self._roomId]

	for i, id in ipairs(list) do
		local targetShowCamp1 = roomCampStatus[id]
		local dir = self:_getDir(self._roomId, id)
		local status = self:_getCampStatus(showCamp1, targetShowCamp1)
		local pathInfo = self._pathGoMap[dir]

		if pathInfo then
			gohelper.setActive(pathInfo.go, true)

			for k, v in pairs(TowerV3a7Enum.PathStatus) do
				gohelper.setActive(pathInfo[v], v == status)
			end
		end
	end
end

function TowerV3a7RoomItem:_getDir(id, targetId)
	local w = 4
	local curRow = math.ceil(id / w)
	local curCol = (id - 1) % w + 1
	local endRow = math.ceil(targetId / w)
	local endCol = (targetId - 1) % w + 1
	local deltaRow = endRow - curRow
	local deltaCol = endCol - curCol
	local dir = TowerV3a7Enum.PathDir.Left

	if deltaCol == 0 and deltaRow < 0 then
		dir = TowerV3a7Enum.PathDir.Up
	elseif deltaCol == 0 and deltaRow > 0 then
		dir = TowerV3a7Enum.PathDir.Down
	elseif deltaCol > 0 and deltaRow == 0 then
		dir = TowerV3a7Enum.PathDir.Right
	elseif deltaCol < 0 and deltaRow == 0 then
		dir = TowerV3a7Enum.PathDir.Left
	elseif deltaCol > 0 and deltaRow > 0 then
		dir = TowerV3a7Enum.PathDir.RightDown
	elseif deltaCol < 0 and deltaRow > 0 then
		dir = TowerV3a7Enum.PathDir.LeftDown
	elseif deltaCol > 0 and deltaRow < 0 then
		dir = TowerV3a7Enum.PathDir.UpRight
	elseif deltaCol < 0 and deltaRow < 0 then
		dir = TowerV3a7Enum.PathDir.UpLeft
	end

	return dir
end

function TowerV3a7RoomItem:_getCampStatus(value, targetValue)
	local num = (value and 1 or 0) * 10
	local num2 = targetValue and 1 or 0

	return num + num2
end

function TowerV3a7RoomItem:_onDragFinishChessMan(params)
	if not self._canMove then
		return
	end

	local chessTrans = params.chessTrans
	local camera = CameraMgr.instance:getUICamera()
	local screenPoint = camera:WorldToScreenPoint(chessTrans.position)
	local inRoom = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self.viewGO.transform, screenPoint, camera)

	if inRoom then
		params.targetRoomMo = self._roomMo
	end
end

function TowerV3a7RoomItem:_onDeadChessMan(mo)
	local item = self._chessList[mo.id]

	if not item then
		return
	end

	if mo:getLocation() == self._roomId then
		self:_removeChess(mo)
	else
		self:_removeChess(item:getMo(), true)
	end
end

function TowerV3a7RoomItem:_onMoveFinishChessMan(mo)
	local item = self._chessList[mo.id]

	if not item then
		return
	end

	if mo:getTempLocation() == self._roomId then
		mo:moveFinish()
		self._roomMo:removeChess(mo)
		self._roomMo:addChess(mo)
		item:updateState()
		self:_onChessChange()
	else
		self:_removeChess(item:getMo(), true)
	end
end

function TowerV3a7RoomItem:_onSrcMoveChessMan(mo)
	if mo:getLocation() == self._roomId then
		local item = self._chessList[mo.id]

		if item then
			item:updateState()
		end
	end
end

function TowerV3a7RoomItem:_onDstMoveChessMan(mo)
	if mo:getTempLocation() == self._roomId then
		self:addChess(mo)
	end
end

function TowerV3a7RoomItem:_onSelectChessMan(mo)
	local location = mo and mo:getLocation() or 0
	local roomConnectList = TowerV3a7RoomModel.instance:getRoomConnectList()
	local connectList = roomConnectList[location]

	self._canMove = connectList and tabletool.indexOf(connectList, self._roomId) ~= nil

	self:setCanMove(self._canMove)
	gohelper.setActive(self._btnclick, mo and mo:getLocation() ~= self._roomId)
end

function TowerV3a7RoomItem:_editableAddEvents()
	return
end

function TowerV3a7RoomItem:_editableRemoveEvents()
	return
end

function TowerV3a7RoomItem:setCanMove(canMove)
	gohelper.setActive(self._goCanMove, canMove)
end

function TowerV3a7RoomItem:onUpdateMO(roomMo, mapRoomView)
	self._roomMo = roomMo
	self._roomId = roomMo.id
	self._mapRoomView = mapRoomView

	self:_initChessList()

	self._canvasGroup.alpha = 1
	self._canvasGroup.interactable = true
	self._canvasGroup.blocksRaycasts = true
end

function TowerV3a7RoomItem:update()
	self._roomMo:update()
	self:_updateItems(self._roomMo.camp1List)
	self:_updateItems(self._roomMo.camp2List)
end

function TowerV3a7RoomItem:_updateItems(list)
	for i, v in pairs(list) do
		local item = self._chessList[v.id]

		if item then
			item:updateHp()
		end
	end
end

function TowerV3a7RoomItem:_initChessList()
	for i, v in ipairs(self._roomMo.chessList) do
		self:addChess(v, true)
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryAddChessMan, v)
	end
end

function TowerV3a7RoomItem:addChess(mo, fromInit)
	if self._chessList[mo.id] then
		logError("addChess error, chess already exist id:", mo.id)

		return
	end

	local path = self._mapRoomView.viewContainer._viewSetting.otherRes.combatItem
	local chessGo = self._mapRoomView:getResInst(path, self._gocontainer, "chess_" .. tostring(mo.id))
	local chessItem = MonoHelper.addNoUpdateLuaComOnceToGo(chessGo, TowerV3a7CombatItem)

	self._chessList[mo.id] = chessItem

	chessItem:initMapRoomView(self._mapRoomView)
	chessItem:onUpdateMO(mo, fromInit, self._roomId)
	self:_onChessChange()
end

function TowerV3a7RoomItem:removeChess(mo)
	self:_removeChess(mo, true)
end

function TowerV3a7RoomItem:_removeChess(mo, isDestroy)
	local id = mo.id

	self._roomMo:removeChess(mo)

	local chessItem = self._chessList[id]

	if chessItem and isDestroy then
		gohelper.destroy(chessItem.viewGO)
	end

	self._chessList[id] = nil

	self:_onChessChange()
end

function TowerV3a7RoomItem:_onChessChange()
	local camp1Num = self._roomMo:getCamp1Num()
	local camp2Num = self._roomMo:getCamp2Num()
	local showCamp1 = camp2Num < camp1Num
	local showCamp2 = camp1Num < camp2Num
	local animName = ""

	if showCamp1 then
		animName = "switch_self"
		self._curShowCamp1 = true
	end

	if showCamp2 then
		animName = "switch_enemy"
		self._curShowCamp1 = false
	end

	local showCamp1Attack = showCamp1 and camp2Num > 0
	local showCamp2Attack = showCamp2 and camp1Num > 0

	gohelper.setActive(self._goAttack, showCamp1Attack)
	gohelper.setActive(self._goAttacked, showCamp2Attack)

	if showCamp1 or showCamp2 then
		self._oldShowCamp1 = showCamp1
		self._oldShowCamp2 = showCamp2
	end

	if camp1Num == camp2Num then
		if self._oldShowCamp1 then
			animName = "switch_self"
			self._curShowCamp1 = true
		end

		if self._oldShowCamp2 then
			animName = "switch_enemy"
			self._curShowCamp1 = false
		end

		showCamp1Attack = self._oldShowCamp1 and camp1Num > 0
		showCamp2Attack = self._oldShowCamp2 and camp2Num > 0

		gohelper.setActive(self._goAttack, showCamp1Attack)
		gohelper.setActive(self._goAttacked, showCamp2Attack)
	end

	if showCamp1Attack then
		AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio9)
	end

	if showCamp2Attack then
		AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio8)
	end

	if self._lastAnimName == animName then
		return
	end

	if self._lastAnimName then
		self._animator:Play(animName)
	else
		local name = string.gsub(animName, "switch_", "idle_")

		self._animator:Play(name)
	end

	self._lastAnimName = animName
end

function TowerV3a7RoomItem:getCampStatus()
	return self._curShowCamp1
end

function TowerV3a7RoomItem:onDestroyView()
	return
end

return TowerV3a7RoomItem
