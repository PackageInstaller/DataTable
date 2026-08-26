-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballGameView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballGameView", package.seeall)

local PinballGameView = class("PinballGameView", BaseView)

function PinballGameView:onInitView()
	self._goDrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._goDragArea = gohelper.findChild(self.viewGO, "#go_drag_area")
	self._goLine = gohelper.findChild(self.viewGO, "#go_drag/#go_line")
	self._goLine2 = gohelper.findChild(self.viewGO, "#go_drag/#go_line/line")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_name")
	self._resItem = gohelper.findChild(self.viewGO, "Right/list/item")
	self._gobag = gohelper.findChild(self.viewGO, "#go_bag")
	self._btnOpenBag = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_click")
	self._btnCloseBag = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bag/#btn_closebag")
	self._holeItem = gohelper.findChild(self.viewGO, "Left/holes/item")
	self._ballItem = gohelper.findChild(self.viewGO, "Left/balls/item")
	self._golighteff = gohelper.findChild(self.viewGO, "Left/light_eff")
	self._imageCurBall = gohelper.findChildImage(self.viewGO, "#go_drag/#image_icon")
	self._bagItem = gohelper.findChild(self.viewGO, "#go_bag/root/balls/item")
	self._txttask = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_task")
	self._gotaskfinish = gohelper.findChild(self.viewGO, "Right/#go_taskFinished")
	self._transLine = self._goLine.transform
	self._transLine2 = self._goLine2.transform
end

function PinballGameView:addEvents()
	self._btnOpenBag:AddClickListener(self._onClickOpenBag, self)
	self._btnCloseBag:AddClickListener(self._onClickCloseBag, self)
	CommonDragHelper.instance:registerDragObj(self._goDragArea, self._onBeginDrag, self._onDrag, self._onEndDrag, self._checkDrag, self, nil, true)
	PinballController.instance:registerCallback(PinballEvent.GameResRefresh, self._onGameRefresh, self)
	PinballController.instance:registerCallback(PinballEvent.ClickBagItem, self._onClickBagItem, self)
	PinballController.instance:registerCallback(PinballEvent.ClickMarbles, self._onClickBallItem, self)
	PinballController.instance:registerCallback(PinballEvent.DragMarblesEnd, self._onDragBallItem, self)
	PinballController.instance:registerCallback(PinballEvent.MarblesDead, self._onMarblesDead, self)
	PinballController.instance:registerCallback(PinballEvent.GameResChange, self._refreshTask, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function PinballGameView:removeEvents()
	self._btnOpenBag:RemoveClickListener()
	self._btnCloseBag:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self._goDragArea)
	PinballController.instance:unregisterCallback(PinballEvent.GameResRefresh, self._onGameRefresh, self)
	PinballController.instance:unregisterCallback(PinballEvent.ClickBagItem, self._onClickBagItem, self)
	PinballController.instance:unregisterCallback(PinballEvent.ClickMarbles, self._onClickBallItem, self)
	PinballController.instance:unregisterCallback(PinballEvent.DragMarblesEnd, self._onDragBallItem, self)
	PinballController.instance:unregisterCallback(PinballEvent.MarblesDead, self._onMarblesDead, self)
	PinballController.instance:unregisterCallback(PinballEvent.GameResChange, self._refreshTask, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function PinballGameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio12)
	PinballModel.instance:clearGameRes()
	gohelper.setActive(self._goLine, false)
	gohelper.setActive(self._gobag, false)
	PinballEntityMgr.instance:beginTick()
	self:_onScreenResize()
	self:loadMapEntity()
	self:createResItem()
	self:initMarbles()
	self:_refreshTask()
	gohelper.setActive(self._holeItemAnims[1], self._curPlaceList[1] == 0)
end

function PinballGameView:_onScreenResize()
	local x, y = recthelper.getAnchor(self._goDrag.transform)

	self._defaultPos = Vector2(x, y)
end

function PinballGameView:createResItem()
	local allRes = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}

	gohelper.CreateObjList(self, self._createResItem, allRes, nil, self._resItem, PinballGameResItem)
end

function PinballGameView:_createResItem(obj, data, index)
	obj:setData(data)
end

function PinballGameView:_onViewClose(viewName)
	if viewName ~= ViewName.PinballStartLoadingView then
		return
	end

	local dict = PinballModel.instance:getAllMarblesNum()
	local count = 0

	for _, num in pairs(dict) do
		if num > 0 then
			count = count + 1
		end
	end

	if count >= 2 then
		PinballController.instance:dispatchEvent(PinballEvent.GuideUnlockBallInGame)
	end
end

function PinballGameView:initMarbles()
	local dict, num, rawNum = PinballModel.instance:getAllMarblesNum()
	local leftPlace = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, "")
	local leftPlaceList = string.splitToNumber(leftPlace, "#") or {}

	if num < #leftPlaceList or not self:checkMarble(dict, leftPlaceList) then
		leftPlaceList = {}

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, "")
	end

	local placeData = {}
	local holeData = {}

	self._canPlaceNum = num
	self._curBagDict = dict
	self._curUseList = {}

	PinballStatHelper.instance:setCurUseBallList(self._curUseList)

	self._curPlaceList = placeData

	for i = 1, num do
		holeData[i] = 1

		if leftPlaceList[i] then
			placeData[i] = leftPlaceList[i]
			self._canPlaceNum = self._canPlaceNum - 1
			dict[leftPlaceList[i]] = dict[leftPlaceList[i]] - 1
		else
			placeData[i] = 0
		end
	end

	for i = num + 1, rawNum do
		holeData[i] = 2
	end

	self._holeItemAnims = self:getUserDataTb_()
	self._bagItems = {}
	self._ballItems = {}

	gohelper.CreateObjList(self, self._createHole, holeData, nil, self._holeItem)
	gohelper.CreateObjList(self, self._createBall, placeData, nil, self._ballItem, PinballGameBallItem)

	local allResType = {
		PinballEnum.UnitType.MarblesNormal,
		PinballEnum.UnitType.MarblesDivision,
		PinballEnum.UnitType.MarblesGlass,
		PinballEnum.UnitType.MarblesExplosion,
		PinballEnum.UnitType.MarblesElasticity
	}

	gohelper.CreateObjList(self, self._createBagItem, allResType, nil, self._bagItem, PinballBagItem)

	local holeNum = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)
	local cacheHoleNum = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_4_Act178HoleNum, holeNum)

	if cacheHoleNum < num then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4_Act178HoleNum, num)

		for i = cacheHoleNum + 1, num do
			-- block empty
		end
	end

	self:updateCurUseMarbles()
end

function PinballGameView:checkMarble(dict, list)
	local calcNum = {}

	for _, type in pairs(list) do
		calcNum[type] = (calcNum[type] or 0) + 1
	end

	for type, num in pairs(dict) do
		if calcNum[type] and num < calcNum[type] then
			return false
		end
	end

	return true
end

function PinballGameView:_createHole(obj, data, index)
	self._holeItemAnims[index] = gohelper.findChild(obj, "vx_eff")

	local lock = gohelper.findChild(obj, "#go_lock")

	gohelper.setActive(self._holeItemAnims[index], false)
	gohelper.setActive(lock, data == 2)
end

function PinballGameView:_createBagItem(obj, data, index)
	self._bagItems[data] = obj

	obj:setInfo(data, self._curBagDict[data], self._canPlaceNum)
end

function PinballGameView:_createBall(obj, data, index)
	self._ballItems[index] = obj

	obj:setInfo(data, index, true)
end

function PinballGameView:_onMarblesDead()
	self._isPlaying = false

	if #self._curPlaceList > 0 then
		self:updateCurUseMarbles()
	else
		PinballEntityMgr.instance:pauseTick()
		Activity178Rpc.instance:sendAct178EndEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.gameAddResDict, PinballModel.instance.leftEpisodeId)
	end
end

function PinballGameView:updateCurUseMarbles()
	local showId = 0

	if not self._isPlaying then
		showId = self._curPlaceList[1]
	end

	if self._showId ~= showId then
		self._showId = showId

		gohelper.setActive(self._goDrag, showId > 0)
		gohelper.setActive(self._golighteff, showId > 0)

		if showId > 0 then
			local co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][showId]

			UISpriteSetMgr.instance:setAct178Sprite(self._imageCurBall, co.icon, true)

			local lv = PinballModel.instance:getMarblesLvCache(showId)
			local scaleArr = string.splitToNumber(co.radius, "#") or {}
			local ballScale = (scaleArr[lv] or scaleArr[#scaleArr] or 1000) / 1000
			local scale = PinballConst.Const7_1 * ballScale

			transformhelper.setLocalScale(self._goDrag.transform, scale, scale, scale)
		end
	end
end

function PinballGameView:_onClickOpenBag()
	if PinballHelper.isBanOper() then
		return
	end

	gohelper.setActive(self._gobag, true)
end

function PinballGameView:_onClickCloseBag()
	gohelper.setActive(self._gobag, false)
end

function PinballGameView:_onClickBagItem(resType)
	self._curBagDict[resType] = self._curBagDict[resType] - 1
	self._canPlaceNum = self._canPlaceNum - 1

	local total = #self._curPlaceList
	local index = total - self._canPlaceNum

	self._curPlaceList[index] = resType

	self._ballItems[index]:setInfo(resType, index, index <= total)
	self:_refreshBagAndSaveData()
end

function PinballGameView:_onClickBallItem(index)
	if PinballHelper.isBanOper() then
		return
	end

	if not self._gobag.activeSelf then
		gohelper.setActive(self._gobag, true)

		return
	end

	if self._curPlaceList[index] == 0 or not self._curPlaceList[index] then
		return
	end

	local resType = table.remove(self._curPlaceList, index)

	table.insert(self._curPlaceList, 0)

	self._canPlaceNum = self._canPlaceNum + 1
	self._curBagDict[resType] = self._curBagDict[resType] + 1

	self._ballItems[index]:setInfo(0, index, true)

	if self._curPlaceList[index] == 0 then
		self:_refreshBagAndSaveData()
	else
		for i = index + 1, #self._curPlaceList do
			local callback, callobj

			if i == index + 1 then
				UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")

				callobj = self
				callback = self.onMoveBack
			end

			self._ballItems[i]:moveTo(self._ballItems[i - 1]:getRootPos(), callback, callobj)
		end
	end
end

function PinballGameView:onBallUse()
	self._isPlaying = true

	table.insert(self._curUseList, table.remove(self._curPlaceList, 1))
	self._ballItems[1]:setInfo(0, 1, self._curPlaceList[1] and true or false)

	if #self._curPlaceList > 0 then
		for i = 1, #self._curPlaceList do
			local callback, callobj

			if i == 1 then
				UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")

				callobj = self
				callback = self.onMoveBack
			end

			self._ballItems[i + 1]:moveTo(self._ballItems[i]:getRootPos(), callback, callobj)
		end
	end

	self:updateCurUseMarbles()
end

function PinballGameView:_refreshBagAndSaveData()
	gohelper.setActive(self._holeItemAnims[1], self._curPlaceList[1] == 0)

	for type, bagItem in pairs(self._bagItems) do
		bagItem:setInfo(type, self._curBagDict[type], self._canPlaceNum)
	end

	local all = {}

	for _, id in ipairs(self._curUseList) do
		table.insert(all, id)
	end

	for _, id in ipairs(self._curPlaceList) do
		if id == 0 then
			break
		end

		table.insert(all, id)
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_4_Act178MarblesPlace, table.concat(all, "#"))
	self:updateCurUseMarbles()
end

function PinballGameView:_onDragBallItem(index)
	local toIndex

	for _, ballItem in pairs(self._ballItems) do
		if ballItem:isMouseOver() then
			toIndex = ballItem:getIndex()
		end
	end

	if not toIndex or toIndex == index then
		self._ballItems[index]:moveBack()
	else
		self._curPlaceList[index], self._curPlaceList[toIndex] = self._curPlaceList[toIndex], self._curPlaceList[index]

		UIBlockMgr.instance:startBlock("PinballGameView_Move_Swap")
		self._ballItems[index]:moveTo(self._ballItems[toIndex]:getRootPos(), self.onMoveBack, self)
		self._ballItems[toIndex]:moveTo(self._ballItems[index]:getRootPos())
	end
end

function PinballGameView:onMoveBack()
	UIBlockMgr.instance:endBlock("PinballGameView_Move_Swap")

	local placeLen = #self._curPlaceList

	for index, ballItem in pairs(self._ballItems) do
		if index <= placeLen then
			ballItem:setInfo(self._curPlaceList[index], index, true)
		else
			ballItem:setInfo(self._curUseList[index - placeLen], index, false)
		end
	end

	self:_refreshBagAndSaveData()
end

function PinballGameView:_onGameRefresh()
	if not self._mapCo then
		return
	end

	TaskDispatcher.cancelTask(self._frameAddRes, self)

	local allEntitys = PinballEntityMgr.instance:getAllEntity()

	for _, entity in pairs(allEntitys) do
		if entity:isResType() then
			entity:markDead()
		end
	end

	self._addResList = {}

	for _, unit in pairs(self._mapCo.units) do
		if PinballHelper.isResType(unit.unitType) then
			if unit.speed.x ~= 0 or unit.speed.y ~= 0 then
				PinballEntityMgr.instance:addEntity(unit.unitType, unit)
			else
				table.insert(self._addResList, unit)
			end
		end
	end

	TaskDispatcher.runRepeat(self._frameAddRes, self, 0.02, -1)
end

function PinballGameView:_frameAddRes()
	if not self._addResList or not next(self._addResList) then
		TaskDispatcher.cancelTask(self._frameAddRes, self)

		return
	end

	local count = 0

	for key, unit in pairs(self._addResList) do
		PinballEntityMgr.instance:addEntity(unit.unitType, unit)

		self._addResList[key] = nil
		count = count + 1

		if count > 10 then
			return
		end
	end
end

function PinballGameView:loadMapEntity()
	local episodeCO = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId]

	if not episodeCO then
		return
	end

	local mapId = episodeCO.mapId
	local mapCo = PinballConfig.instance:getMapCo(mapId)

	if not mapCo then
		logError("地图配置不存在" .. mapId)

		return
	end

	self._mapCo = mapCo
	self._episodeCO = episodeCO
	PinballModel.instance.leftEpisodeId = episodeCO.id

	for _, unit in pairs(mapCo.units) do
		PinballEntityMgr.instance:addEntity(unit.unitType, unit)
	end

	self._txtname.text = episodeCO.name
end

function PinballGameView:_refreshTask()
	if not self._episodeCO then
		return
	end

	local arr = string.splitToNumber(self._episodeCO.target, "#")

	if not arr or #arr ~= 2 then
		logError("任务配置错误" .. self._episodeCO.id)

		return
	end

	local type = arr[1]
	local curVal = PinballModel.instance:getGameRes(type)
	local totalVal = arr[2]

	curVal = Mathf.Clamp(curVal, 0, totalVal)

	local resName = ""

	if type == 0 then
		resName = luaLang("pinball_any_res")
	else
		local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][type]

		if resCo then
			resName = resCo.name
		end
	end

	self._txttask.text = GameUtil.getSubPlaceholderLuaLang(luaLang("pinball_game_target"), {
		totalVal,
		resName,
		curVal,
		totalVal
	})

	gohelper.setActive(self._gotaskfinish, totalVal <= curVal)
end

function PinballGameView:_onBeginDrag(_, pointerEventData)
	gohelper.setActive(self._goLine, true)
	self:_calcLineAngleAndLen(pointerEventData)
	PinballController.instance:dispatchEvent(PinballEvent.OnWaitDragEnd)
end

function PinballGameView:_onDrag(_, pointerEventData)
	self:_calcLineAngleAndLen(pointerEventData)
end

function PinballGameView:_calcLineAngleAndLen(pointerEventData)
	local pos = pointerEventData.position - pointerEventData.pressPosition
	local len = math.sqrt(pos.x * pos.x + pos.y * pos.y)

	len = Mathf.Clamp(len, 40, 150)

	recthelper.setWidth(self._transLine2, len * 2)

	self._value = (len - 40) / 110

	local value = math.abs(math.atan2(pos.y, pos.x) / math.pi) - 0.5

	value = Mathf.Clamp(value, -0.5, 0.5)
	self._force = value

	local angle = value * 180

	transformhelper.setLocalRotation(self._transLine, 0, 0, angle)
end

function PinballGameView:_onEndDrag()
	gohelper.setActive(self._goLine, false)

	local entity = PinballEntityMgr.instance:addEntity((isDebugBuild and PinballModel.instance._gmball > 0 or nil) and PinballModel.instance._gmball)

	entity.x = self._defaultPos.x
	entity.y = self._defaultPos.y

	local totalV = self._value * (PinballConst.Const24 - PinballConst.Const23) + PinballConst.Const23
	local vx, vy = PinballHelper.rotateAngle(0, -totalV, self._force * 180)

	entity.vx = vx * entity.speedScale
	entity.vy = vy * entity.speedScale

	entity:tick(0)

	if not isDebugBuild or PinballModel.instance._gmball == 0 then
		self:onBallUse()
	end
end

function PinballGameView:_checkDrag()
	return not self._curPlaceList[1] or self._curPlaceList[1] <= 0 or self._isPlaying
end

function PinballGameView:onClose()
	TaskDispatcher.cancelTask(self._frameAddRes, self)
	PinballEntityMgr.instance:clear()
	UIBlockMgr.instance:endBlock("PinballGameView_Move_Swap")
end

return PinballGameView
