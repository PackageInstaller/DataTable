-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaChallengeView.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaChallengeView", package.seeall)

local DivineKingNuoYaChallengeView = class("DivineKingNuoYaChallengeView", ViewComponent)
local ROW = 4
local COL = 4
local CELL_SPACING = 120
local ChangeMode = {
	Right = 1,
	RightDown = COL + 1,
	Down = COL,
	LeftDown = COL - 1
}
local ChangeRotation = {
	Down = -180,
	Right = -90,
	RightDown = -135,
	LeftDown = -225
}
local ChangeName = {
	Down = "Down",
	Right = "Right",
	RightDown = "RightDown",
	LeftDown = "LeftDown"
}
local ShowMode = {
	Forbid = 3,
	Dark = 2,
	Light = 1,
	None = 0
}

function DivineKingNuoYaChallengeView:ctor()
	DivineKingNuoYaChallengeView.super.ctor(self)
end

function DivineKingNuoYaChallengeView:bindEvents()
	DivineKingNuoYaChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineKingNuoYaChallengeView:unbindEvents()
	DivineKingNuoYaChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineKingNuoYaChallengeView:buildUI()
	DivineKingNuoYaChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtPlayRule = self:getTxt("rule/tip/scrView/Viewport/Content")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._txtProgress = self:getTxt("total/txtProgress")
	self._txtLight = self:getTxt("tipProgress/txtLight")
	self._txtDark = self:getTxt("tipProgress/txtDark")
	self._txtBuffProgress = self:getTxt("tipProgress/txtBuffProgress")
	self._frobidCell = self:getGo("tableview/tablecell")
	self._tableviewForbid = self:getGo("tableview")
	self._forbidScrollList = ScrollerList.create(self._tableviewForbid, self._frobidCell, GameUtil.handler(self._updateForbidCell, self), GameUtil.handler(self._clearForbidCell, self))
	self._cellNodeList = {}

	for i = 1, ROW * COL do
		local cur = {}

		cur.go = self:getGo("challenge/cell" .. i)
		cur.imgChangeComp = self:getGo("challenge/cell" .. i .. "/imgBg"):GetComponent(ComponentType.UIImageSpriteChange)
		cur.bg = self:getGo("challenge/cell" .. i .. "/bg")
		cur.imgBgChangeComp = self:getGo("challenge/cell" .. i .. "/bg"):GetComponent(ComponentType.UIImageSpriteChange)
		cur.imgForbidGo = self:getGo("challenge/cell" .. i .. "/imgForbid")
		cur.imgChoose = self:getGo("challenge/cell" .. i .. "/imgChoose")
		cur.idx = i
		cur.changeModeDic = {}

		table.insert(self._cellNodeList, cur)
	end

	self._dragObj = self:getGo("dragObj")
	self._dragContainer = self:getGo("dragContainer")
	self._lines = self:getGo("lines")
	self._lineCell = self:getGo("lines/lineCell")
	self._linePivot = self:getGo("linePivot")
end

function DivineKingNuoYaChallengeView:onExit()
	DivineKingNuoYaChallengeView.super.onExit(self)
	self._scrollList:dispose()
	self._forbidScrollList:dispose()

	for cell, handlers in pairs(self._dragHandlerMap) do
		BeginDragHandler.Get(cell.gameObject):RemoveLuaHandler(handlers.beginDragHandler)
		DragHandler.Get(cell.gameObject):RemoveLuaHandler(handlers.moveDragHandler)
		EndDragHandler.Get(cell.gameObject):RemoveLuaHandler(handlers.endDragHandler)
	end

	for curCell, handlers in pairs(self._pointEnterHandlerMap) do
		local cellGo = curCell.go

		PointerEnterHandler.Get(cellGo):RemoveLuaHandler(handlers.pointEnterHandler)
		PointerExitHandler.Get(cellGo):RemoveLuaHandler(handlers.pointExitHandler)
	end

	PointerEnterHandler.Get(self._dragContainer):RemoveLuaHandler(self._pointEnterDragContainerHandler)
	PointerExitHandler.Get(self._dragContainer):RemoveLuaHandler(self._pointExitDragContainerHandler)

	self._dragHandlerMap = nil
	self._pointEnterHandlerMap = nil

	self._moveItemPool:clear()

	self._stageData = nil

	self:_clearLineUI()
	self:_clearLinesData()
end

function DivineKingNuoYaChallengeView:onEnter()
	DivineKingNuoYaChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineKingNoahClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineKingNoahClgSetBanItemsRes, self._onUpdate, self)

	self._dragHandlerMap = {}
	self._pointEnterHandlerMap = {}

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 471001
	end

	self._activityType = 471
	self._actCfg = DivineKingNuoYaConfig.instance:getActCfg(self._activityId)

	local prizePlanId = checknumber(self._actCfg.progressPlanId)

	if prizePlanId > 0 then
		self._prizeCfg = DivineKingNuoYaConfig.instance:getPrizeCfg(prizePlanId)
	end

	self._info = DivineKingNuoYaModel.instance:getInfo(self._activityId)
	self._stageLists = self._info and self._info.stageLists
	self._forbidData = self._info and self._info.banItemPosIds
	self._isDraging = false
	self._isTouchingContainer = false
	self._moveItems = {}
	self._lineRootPos = GameUtil.getLocalPos(self._linePivot)
	self._showRootDic = {
		[ShowMode.Light] = {},
		[ShowMode.Dark] = {}
	}
	self._lightLineMap = {}
	self._darkLineMap = {}
	self._lineDic = {
		[ShowMode.Light] = self._lightLineMap,
		[ShowMode.Dark] = self._darkLineMap
	}

	local cell = self._cellNodeList[1]
	local pos = GameUtil.getLocalPos(cell.go)

	self:_initLineCells()
	self:_onSetUI()
	DivineKingNuoYaController.instance:sendPM_DivineKingNoahClgGetInfoReq(self._activityId)
end

function DivineKingNuoYaChallengeView:_onSetUI()
	self._txtPlayRule.text = self._actCfg.ruleTip

	self:_setDragContainer()
end

function DivineKingNuoYaChallengeView:_setDragContainer()
	self._pointEnterDragContainerHandler = PointerEnterHandler.Get(self._dragContainer):AddLuaHandler(function(_go, eventData)
		self:_onMoveInDragContainer()
	end)
	self._pointExitDragContainerHandler = PointerExitHandler.Get(self._dragContainer):AddLuaHandler(function(_go, eventData)
		self:_onMoveOutDragContainer()
	end)
end

function DivineKingNuoYaChallengeView:_initLineCells()
	self._lineItems = {}

	local function createFunc()
		local go = goutil.cloneAndSetParent(self._lineCell, self._lines.transform)

		return {
			gameObject = go,
			transform = go.transform,
			class = GameUtil.AddLuaOnce(go, DivineKingNuoYaLineCell)
		}
	end

	local function disposeFunc(item)
		return
	end

	local function resetFunc(item)
		item.class:onExit()
		goutil.setActive(item.gameObject, false)
	end

	self._moveItemPool = ObjectPool.New(5, createFunc, disposeFunc, resetFunc)

	GameUtil.SetActive(self._lineCell, false)
end

function DivineKingNuoYaChallengeView:_onUpdate()
	self:_updateData()
	self:_setLineMapData()
	self:_updateUI()
	self:_setLineMapUI()
end

function DivineKingNuoYaChallengeView:_updateData()
	self._info = DivineKingNuoYaModel.instance:getInfo(self._activityId)
	self._stageLists = self._info and self._info.stageLists
	self._forbidData = self._info and self._info.banItemPosIds
	self._banScrollData = DivineKingNuoYaController.instance:getBanData(self._activityId)

	local dataList = {}

	if self._stageLists then
		for i = 1, ROW * COL do
			local stageInfo = self._stageLists[i]

			if stageInfo then
				table.insert(dataList, stageInfo.lineState)
			else
				table.insert(dataList, 0)
			end
		end
	end

	self._stageData = dataList
end

function DivineKingNuoYaChallengeView:_updateUI()
	self._txtProgress.text = DivineKingNuoYaModel.instance:getPassStageNum(self._activityId)

	local buffProgress = DivineKingNuoYaController.instance:getBuffProgress(self._activityId)

	self._txtLight.text = string.format("光链条 :%d条", self._info.lightLineCount)
	self._txtDark.text = string.format("暗链条 :%d条", self._info.darkLineCount)
	self._txtBuffProgress.text = string.format("气势进度 :%d/%d", buffProgress, DivineKingNuoYaModel.MaxBuffProgress)

	self:_setCellUI()

	if self._banScrollData then
		self._forbidScrollList:reloadData(self._banScrollData)
	end

	if self._prizeCfg then
		self._scrollList:reloadData(self._prizeCfg)

		local scoreList = {}

		for i, v in ipairs(self._prizeCfg) do
			table.insert(scoreList, v.passStageCount)
		end

		self._scrollList:updateUnderSlider(self._progressSlider, self._info.historyMaxPassStageCount, scoreList)
	end
end

function DivineKingNuoYaChallengeView:_testPrint()
	local lightShowRootDic = self._showRootDic[ShowMode.Light]
	local darkShowRootDic = self._showRootDic[ShowMode.Dark]

	printError("lightShowRootDic")

	for changeName, list in pairs(lightShowRootDic) do
		printError("lightShowRootDic " .. changeName)

		for i, cell in ipairs(list) do
			printError(cell.go.name)

			for k, node in pairs(cell.changeModeDic[ShowMode.Light][changeName]) do
				printError("node: " .. node.go.name)
			end
		end

		printError("***************************************************")
	end

	for changeName, list in pairs(darkShowRootDic) do
		printError("darkShowRootDic " .. changeName)

		for i, cell in ipairs(list) do
			printError(cell.go.name)
		end

		printError("***************************************************")
	end
end

function DivineKingNuoYaChallengeView:_setCellUI()
	local preSelectIdx = DivineKingNuoYaModel.instance:getCurSelectStageIdx(self._activityId)

	for curCellIdx = 1, ROW * COL do
		if self._stageLists[curCellIdx] then
			if not self._stageLists[curCellIdx].lineState then
				local showMode = 0

				if self._forbidData then
					local isForbid = table.indexof(self._forbidData, curCellIdx)
					local curCell = self._cellNodeList[curCellIdx]

					curCell.imgChangeComp:SetState(showMode)
					curCell.imgBgChangeComp:SetState(ShowMode.None)
					GameUtil.SetActive(curCell.imgForbidGo, isForbid)
					GameUtil.SetActive(curCell.imgChoose, curCellIdx == preSelectIdx)
					GameUtil.addClickHandler(curCell.bg, GameUtil.handler(self._onClickCell, self, curCellIdx), self)

					if self._pointEnterHandlerMap[curCell] == nil then
						self._pointEnterHandlerMap[curCell] = {}
						self._pointEnterHandlerMap[curCell].pointEnterHandler = PointerEnterHandler.Get(curCell.go):AddLuaHandler(function(_go, eventData)
							self:_onMoveIn(curCell, curCellIdx)
						end)
						self._pointEnterHandlerMap[curCell].pointExitHandler = PointerExitHandler.Get(curCell.go):AddLuaHandler(function(_go, eventData)
							self:_onMoveOut(curCell)
						end)
					end

					if self._dragHandlerMap[curCell.go] == nil then
						self._dragHandlerMap[curCell.go] = {}
						self._dragHandlerMap[curCell.go].beginDragHandler = BeginDragHandler.Get(curCell.go):AddLuaHandler(function(go, edata)
							self:_OnDragForbidBegin(curCell.go, curCellIdx)
						end)
						self._dragHandlerMap[curCell.go].moveDragHandler = DragHandler.Get(curCell.go):AddLuaHandler(function(_go, edata)
							self:_OnDragForbidMoved(curCell.go, curCellIdx)
						end)
						self._dragHandlerMap[curCell.go].endDragHandler = EndDragHandler.Get(curCell.go):AddLuaHandler(function(_go, edata)
							self:_OnDragForbidEnded(curCell.go, curCellIdx)
						end)
					end
				end
			end
		end
	end
end

function DivineKingNuoYaChallengeView:_setLineMapUI()
	self:_clearLineUI()

	local lightShowRootDic = self._showRootDic[ShowMode.Light]
	local darkShowRootDic = self._showRootDic[ShowMode.Dark]

	for changeName, list in pairs(lightShowRootDic) do
		for i, cell in ipairs(list) do
			local rotationZ = ChangeRotation[changeName]
			local item = self._moveItemPool:fetchObject()
			local colIdx = cell.idx % ROW - 1
			local rowIdx = math.floor((cell.idx - 1) / ROW)

			colIdx = colIdx < 0 and ROW - 1 or colIdx

			GameUtil.SetActive(item.gameObject, true)
			item.class:setRotation(0, 0, rotationZ)
			item.class:setPos(self._lineRootPos.x + CELL_SPACING * colIdx, self._lineRootPos.y - CELL_SPACING * (rowIdx - 0.25), self._lineRootPos.z)
			item.class:setShowMode(ShowMode.Light)
			table.insert(self._moveItems, item)
			cell.imgBgChangeComp:SetState(ShowMode.Light)

			for i, cellNode in ipairs(cell.changeModeDic[ShowMode.Light][changeName]) do
				if i ~= #cell.changeModeDic[ShowMode.Light][changeName] then
					local rotationZ = ChangeRotation[changeName]
					local item = self._moveItemPool:fetchObject()
					local colIdx = cellNode.idx % ROW - 1

					colIdx = colIdx < 0 and ROW - 1 or colIdx

					local rowIdx = math.floor((cellNode.idx - 1) / ROW)

					GameUtil.SetActive(item.gameObject, true)
					item.class:setRotation(0, 0, rotationZ)
					item.class:setPos(self._lineRootPos.x + CELL_SPACING * colIdx, self._lineRootPos.y - CELL_SPACING * (rowIdx - 0.25), self._lineRootPos.z)
					item.class:setShowMode(ShowMode.Light)
					table.insert(self._moveItems, item)
				end

				cellNode.imgBgChangeComp:SetState(ShowMode.Light)
			end
		end
	end

	for changeName, list in pairs(darkShowRootDic) do
		for i, cell in ipairs(list) do
			local rotationZ = ChangeRotation[changeName]
			local item = self._moveItemPool:fetchObject()
			local colIdx = cell.idx % ROW - 1

			colIdx = colIdx < 0 and ROW - 1 or colIdx

			local rowIdx = math.floor((cell.idx - 1) / ROW)

			GameUtil.SetActive(item.gameObject, true)
			item.class:setRotation(0, 0, rotationZ)
			item.class:setPos(self._lineRootPos.x + CELL_SPACING * colIdx, self._lineRootPos.y - CELL_SPACING * (rowIdx - 0.25), self._lineRootPos.z)
			item.class:setShowMode(ShowMode.Dark)
			table.insert(self._moveItems, item)
			cell.imgBgChangeComp:SetState(ShowMode.Dark)

			for i, cellNode in ipairs(cell.changeModeDic[ShowMode.Dark][changeName]) do
				if i ~= #cell.changeModeDic[ShowMode.Dark][changeName] then
					local rotationZ = ChangeRotation[changeName]
					local item = self._moveItemPool:fetchObject()
					local colIdx = cellNode.idx % ROW - 1

					colIdx = colIdx < 0 and ROW - 1 or colIdx

					local rowIdx = math.floor((cellNode.idx - 1) / ROW)

					GameUtil.SetActive(item.gameObject, true)
					item.class:setRotation(0, 0, rotationZ)
					item.class:setPos(self._lineRootPos.x + CELL_SPACING * colIdx, self._lineRootPos.y - CELL_SPACING * (rowIdx - 0.25), self._lineRootPos.z)
					item.class:setShowMode(ShowMode.Dark)
					table.insert(self._moveItems, item)
				end

				cellNode.imgBgChangeComp:SetState(ShowMode.Dark)
			end
		end
	end
end

function DivineKingNuoYaChallengeView:_setLineMapData()
	self:_clearLinesData()

	for curCellIdx = 1, ROW * COL do
		local root = self._cellNodeList[curCellIdx]
		local showMode = self._stageData[curCellIdx]

		if showMode > 0 then
			self:_getConnectData(root, curCellIdx, ChangeName.Right)
			self:_getConnectData(root, curCellIdx, ChangeName.RightDown)
			self:_getConnectData(root, curCellIdx, ChangeName.LeftDown)
			self:_getConnectData(root, curCellIdx, ChangeName.Down)

			if root.changeModeDic[showMode] then
				local rightNum = self:_getDirctNodeLen(root, showMode, ChangeName.Right)
				local rightDownNum = self:_getDirctNodeLen(root, showMode, ChangeName.RightDown)
				local leftDownNum = self:_getDirctNodeLen(root, showMode, ChangeName.LeftDown)
				local downNum = self:_getDirctNodeLen(root, showMode, ChangeName.Down)

				if rightNum >= 3 then
					self._showRootDic[showMode][ChangeName.Right] = self._showRootDic[showMode][ChangeName.Right] or {}

					table.insert(self._showRootDic[showMode][ChangeName.Right], root)
				end

				if rightDownNum >= 3 then
					self._showRootDic[showMode][ChangeName.RightDown] = self._showRootDic[showMode][ChangeName.RightDown] or {}

					table.insert(self._showRootDic[showMode][ChangeName.RightDown], root)
				end

				if leftDownNum >= 3 then
					self._showRootDic[showMode][ChangeName.LeftDown] = self._showRootDic[showMode][ChangeName.LeftDown] or {}

					table.insert(self._showRootDic[showMode][ChangeName.LeftDown], root)
				end

				if downNum >= 3 then
					self._showRootDic[showMode][ChangeName.Down] = self._showRootDic[showMode][ChangeName.Down] or {}

					table.insert(self._showRootDic[showMode][ChangeName.Down], root)
				end
			end
		end
	end
end

function DivineKingNuoYaChallengeView:_getConnectData(root, curCellIdx, changeName)
	local changeMode = ChangeMode[changeName]
	local nextIdx = curCellIdx + changeMode
	local nextCell = self._cellNodeList[nextIdx]
	local curShowMode = self._stageData[curCellIdx]
	local nextShowMode = self._stageData[nextIdx]

	if self:_isEdge(curCellIdx, changeName) then
		return
	end

	if nextCell and nextShowMode and curShowMode == nextShowMode then
		self:_addDirctNode(root, curShowMode, changeName, nextCell)
		self:_getConnectData(root, nextIdx, changeName)
	end
end

function DivineKingNuoYaChallengeView:_isEdge(curCellIdx, changeName)
	if changeName == ChangeName.RightDown or changeName == ChangeName.Right then
		if curCellIdx % ROW == 0 then
			return true
		end
	elseif changeName == ChangeName.LeftDown then
		if (curCellIdx - 1) % ROW == 0 then
			return true
		end
	else
		return false
	end
end

function DivineKingNuoYaChallengeView:_inOneRow(curCellIdx, nextIdx)
	local preRow = math.floor((curCellIdx - 1) / 4)
	local nextRow = math.floor((nextIdx - 1) / 4)

	return preRow == nextRow
end

function DivineKingNuoYaChallengeView:_addDirctNode(root, showMode, changeName, cellNode)
	local showLineDic = self._lineDic[showMode]

	if showLineDic then
		showLineDic[changeName] = showLineDic[changeName] or {}

		local changeModeDic = showLineDic[changeName]

		if changeModeDic[cellNode] then
			return
		else
			changeModeDic[cellNode] = 1
		end
	end

	root.changeModeDic[showMode] = root.changeModeDic[showMode] or {}
	root.changeModeDic[showMode][changeName] = root.changeModeDic[showMode][changeName] or {}

	table.insert(root.changeModeDic[showMode][changeName], cellNode)
end

function DivineKingNuoYaChallengeView:_getDirctNodeLen(root, showMode, changeName)
	if root.changeModeDic[showMode] and root.changeModeDic[showMode][changeName] then
		return #root.changeModeDic[showMode][changeName] + 1
	end

	return 0
end

function DivineKingNuoYaChallengeView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyChallenge

	TipsFacade.instance:openRulesView(key)
end

function DivineKingNuoYaChallengeView:_onClickCell(cellIdx)
	if table.indexof(self._forbidData, cellIdx) then
		FloatWordMgr.instance:show("已被禁用，请移除该关卡禁用道具后挑战")

		return
	end

	DivineKingNuoYaModel.instance:setCurSelectStageIdx(self._activityId, cellIdx)
	DivineKingNuoYaController.instance:enterBattleClg(self._activityId, cellIdx)
end

function DivineKingNuoYaChallengeView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local hasGet = false
	local passNum = DivineKingNuoYaModel.instance:getPassStageNum(self._activityId)

	if not self._info.gainPrizeIds then
		hasGet = table.indexof(self._info.gainPrizeIds, data.prizeId) ~= false
		txtScore.text = data.passStageCount

		MaterialMgr.setCellByCfg(data.prize, item)
		GameUtil.SetActive(geted, hasGet)
	end
end

function DivineKingNuoYaChallengeView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function DivineKingNuoYaChallengeView:_clearLineUI()
	for k, v in ipairs(self._moveItems) do
		GameUtil.SetActive(v.gameObject, false)
		self._moveItemPool:returnObject(v)
	end
end

function DivineKingNuoYaChallengeView:_clearLinesData()
	self._showRootDic = {
		[ShowMode.Light] = {},
		[ShowMode.Dark] = {}
	}
	self._lightLineMap = {}
	self._darkLineMap = {}
	self._lineDic = {
		[ShowMode.Light] = self._lightLineMap,
		[ShowMode.Dark] = self._darkLineMap
	}

	for i, cell in ipairs(self._cellNodeList) do
		cell.changeModeDic = {}
	end
end

function DivineKingNuoYaChallengeView:_updateForbidCell(view, cell, data)
	local imgBg = goutil.findChild(cell, "imgForbid")
	local emptyRaycast = cell.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))

	GameUtil.SetActive(imgBg.gameObject, true)

	if data then
		if self._dragHandlerMap[cell.gameObject] == nil then
			self._dragHandlerMap[cell.gameObject] = {}
			self._dragHandlerMap[cell.gameObject].beginDragHandler = BeginDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, edata)
				self:_OnDragForbidBegin(cell, nil)
			end)
			self._dragHandlerMap[cell.gameObject].moveDragHandler = DragHandler.Get(cell.gameObject):AddLuaHandler(function(_go, edata)
				self:_OnDragForbidMoved(cell, nil)
			end)
			self._dragHandlerMap[cell.gameObject].endDragHandler = EndDragHandler.Get(cell.gameObject):AddLuaHandler(function(_go, edata)
				self:_OnDragForbidEnded(cell, nil)
			end)
		end
	else
		GameUtil.SetActive(imgBg, data)

		emptyRaycast.enabled = data
	end
end

function DivineKingNuoYaChallengeView:_clearForbidCell(cell)
	local dragHandler = self._dragHandlerMap[cell.gameObject]

	if dragHandler then
		BeginDragHandler.Get(cell.gameObject):RemoveLuaHandler(dragHandler.beginDragHandler)
		DragHandler.Get(cell.gameObject):RemoveLuaHandler(dragHandler.moveDragHandler)
		EndDragHandler.Get(cell.gameObject):RemoveLuaHandler(dragHandler.endDragHandler)
	end

	self._dragHandlerMap[cell.gameObject] = nil
end

function DivineKingNuoYaChallengeView:_OnDragForbidBegin(cell, data)
	local imgBg = goutil.findChild(cell, "imgForbid")

	if data then
		local hasBaned = table.indexof(self._forbidData, data)

		if self._isDraging == false and hasBaned then
			self._isDraging = true

			local idx = table.indexof(self._forbidData, data)

			if idx then
				table.remove(self._forbidData, idx)
			end

			local go = goutil.clone(imgBg.gameObject)
			local imgComp = go:GetComponent(goutil.Type_UIImage)

			imgComp.raycastTarget = false

			goutil.clearChildren(self._dragObj)
			goutil.addChildToParent(go, self._dragObj)
			GameUtil.setAnchoredPos(go, 0, 0)
			GameUtil.SetActive(self._dragObj, true)
			GameUtil.SetActive(imgBg.gameObject, false)

			self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
			self._dragForbidStageId = data
		end
	elseif self._isDraging == false then
		self._isDraging = true

		local go = goutil.clone(imgBg.gameObject)
		local imgComp = go:GetComponent(goutil.Type_UIImage)

		imgComp.raycastTarget = false

		goutil.clearChildren(self._dragObj)
		goutil.addChildToParent(go, self._dragObj)
		GameUtil.setAnchoredPos(go, 0, 0)
		GameUtil.SetActive(self._dragObj, true)
		GameUtil.SetActive(imgBg.gameObject, false)

		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
	end
end

function DivineKingNuoYaChallengeView:_OnDragForbidMoved(go, data)
	if self._isDraging then
		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()

		GameUtil.SetActive(self._dragContainer, true)
	end
end

function DivineKingNuoYaChallengeView:_OnDragForbidEnded(cell, data)
	local imgBg = goutil.findChild(cell, "imgForbid")

	if self._isDraging == true then
		self._isDraging = false

		if self._isTouchingContainer then
			GameUtil.SetActive(imgBg, false)
			DivineKingNuoYaController.instance:sendPM_DivineKingNoahClgSetBanItemsReq(self._activityId, self._forbidData)
		else
			GameUtil.SetActive(self._dragObj, false)

			local hasBaned = table.indexof(self._forbidData, self._touchingIdx)

			if self._touchingIdx and not hasBaned then
				local lastTouchingIdx = self._touchingIdx

				if self._stageLists[lastTouchingIdx] then
					local lineState = self._stageLists[lastTouchingIdx].lineState
					local hasChallenged = checknumber(lineState) > 0

					if hasChallenged then
						local tipsContent = "是否放置在此处，放置后该格子的挑战记录将被清空，后续若更改需要重新挑战"

						local function okFunc()
							if not table.indexof(self._forbidData, lastTouchingIdx) then
								table.insert(self._forbidData, lastTouchingIdx)
							end

							DivineKingNuoYaController.instance:sendPM_DivineKingNoahClgSetBanItemsReq(self._activityId, self._forbidData)
						end

						local function cencelFunc()
							GameUtil.SetActive(imgBg, true)

							if data and not table.indexof(self._forbidData, data) then
								table.insert(self._forbidData, data)
							end
						end

						TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
					else
						if not table.indexof(self._forbidData, lastTouchingIdx) then
							table.insert(self._forbidData, lastTouchingIdx)
						end

						DivineKingNuoYaController.instance:sendPM_DivineKingNoahClgSetBanItemsReq(self._activityId, self._forbidData)
					end
				end
			else
				GameUtil.SetActive(imgBg, true)

				if data and not table.indexof(self._forbidData, data) then
					table.insert(self._forbidData, data)
				end
			end
		end

		self._touchingIdx = nil
	end

	GameUtil.SetActive(self._dragContainer, false)
	goutil.clearChildren(self._dragObj)
end

function DivineKingNuoYaChallengeView:_onMoveIn(curCell, curCellIdx)
	if self._isDraging == true then
		self._touchingIdx = curCellIdx
	end
end

function DivineKingNuoYaChallengeView:_onMoveOut(curCell)
	self._touchingIdx = nil
end

function DivineKingNuoYaChallengeView:_onMoveInDragContainer()
	self._isTouchingContainer = true
end

function DivineKingNuoYaChallengeView:_onMoveOutDragContainer()
	self._isTouchingContainer = false
end

return DivineKingNuoYaChallengeView
