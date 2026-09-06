-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarGameView.lua

module("logic.extensions.clearstargame.view.ClearStarGameView", package.seeall)

local ClearStarGameView = class("ClearStarGameView", ViewComponent)

function ClearStarGameView:ctor()
	ClearStarGameView.super.ctor(self)
end

function ClearStarGameView:unbindEvents()
	ClearStarGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnBoom)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnShuffle)

	for i, cell in ipairs(self._changeColorCells) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function ClearStarGameView:bindEvents()
	ClearStarGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnChange, GameUtil.handler(self._onClickUseItem, self, 1))
	GameUtil.addClickHandler(self._btnBoom, GameUtil.handler(self._onClickUseItem, self, 2))
	GameUtil.addClickHandler(self._btnShuffle, GameUtil.handler(self._onClickUseItem, self, 3))

	for i, cell in ipairs(self._changeColorCells) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._changeColor, self, i))
	end
end

function ClearStarGameView:buildUI()
	ClearStarGameView.super.buildUI(self)

	self._UIStarTypeNum = 5
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTips = self:getGo("leftTop/btnTips")
	self._scoreCells = {}

	for i = 1, self._UIStarTypeNum do
		local cell = {}

		cell.go = self:getGo("scores/type" .. i)
		cell.txtCurScore = goutil.findChildTextComponent(cell.go, "txtCurScore")
		cell.txtAddScore = goutil.findChildTextComponent(cell.go, "txtAddScore")
		self._scoreCells[i] = cell
	end

	self._btnBoom = self:getGo("itemBoom/btn")
	self._txtBtnBoom = self:getTxt("itemBoom/btn/txt")
	self._effPosBtnBoom = self:getGo("itemBoom/eff")
	self._btnShuffle = self:getGo("itemShuffle/btn")
	self._txtBtnShuffle = self:getTxt("itemShuffle/btn/txt")
	self._btnChange = self:getGo("itemChange/btn")
	self._txtBtnChange = self:getTxt("itemChange/btn/txt")
	self._effPosBtnChange = self:getGo("itemChange/eff")
	self._changePlane = self:getGo("changePlane")
	self._changeColorCells = {}

	for i = 1, self._UIStarTypeNum do
		local cell = {}

		cell.go = self:getGo("changePlane/bg/btn_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		self._changeColorCells[i] = cell
	end

	self._goStarCell = self:getGo("starCell")
	self._starCom = self:getGo("starCom")
	self._goTips2 = self:getGo("txtTips2")
	self._goTips1 = self:getGo("txtTips1")
end

function ClearStarGameView:destroyUI()
	self._curStarList = self._curStarList or {}

	for i, star in ipairs(self._curStarList) do
		star:clear()
	end

	table.clear(self._curStarList)
end

function ClearStarGameView:onExit()
	ClearStarGameView.super.onExit(self)

	for i, star in ipairs(self._curStarList) do
		star:reset()
	end

	if not self._isPractise and not self._normalExit then
		self:_sendEndGame(false)
	end

	self:_clearAllEff()
end

function ClearStarGameView:onEnter()
	ClearStarGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ClearStarGameSelectStar, self._onClickStar, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameStartGame, self._handleStartGame, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameEndGame, self._handleEndGame, self)
	goutil.setActive(self._changePlane, false)
	goutil.setActive(self._goTips1, false)
	goutil.setActive(self._goTips2, false)
	goutil.setActive(self._goStarCell, false)

	self._normalExit = false

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 479001
	end

	self._isPractise = checkbool(params[2])
	self._starMaxTypeId = checknumber(params[3])

	self:_initCfg()
	self:_initGame()
	self:_enterGame()

	local userDataKey = string.format("%s_first_open_", ViewName.ClearStarGameView, self._activityId)

	if checknumber(GameUtil.getUserData(userDataKey)) <= 0 then
		GameUtil.saveUserData(userDataKey, 1)
		self:_onClickTips()
	end
end

function ClearStarGameView:_sendEndGame(isSaveData)
	self._isRuning = false

	local scores_pb_Ary = {}

	for i, score in pairs(self._starScoreMap) do
		table.insert(scores_pb_Ary, {
			scoreType = i,
			num = score
		})
	end

	local useItems_pb_Ary = {}

	for i, num in pairs(self._useItemMap) do
		table.insert(useItems_pb_Ary, {
			id = i,
			num = num
		})
	end

	ClearStarGameController.instance:endGame(self._activityId, isSaveData, scores_pb_Ary, useItems_pb_Ary)
end

function ClearStarGameView:_handleStartGame()
	self:_playGame()
end

function ClearStarGameView:_handleEndGame()
	self._normalExit = true

	self:close()
end

function ClearStarGameView:_initCfg()
	self._actCfg = ClearStarGameConfig.instance:getActivityCfgById(self._activityId)
	self._scoreCfgs = ClearStarGameConfig.instance:getScorePlanCfgsById(self._actCfg.scorePlanId)
	self._mapCfgs = ClearStarGameConfig.instance:getMapPlanCfgsById(self._actCfg.mapPlanId) or {}
	self._itemCfgs = ClearStarGameConfig.instance:getItemCfgsById(self._activityId) or {}
	self._convertCfgs = ClearStarGameConfig.instance:getConvertCfgsById(self._activityId) or {}
	self._itemCountMap = {}

	for i, cfg in ipairs(self._itemCfgs or {}) do
		local cost = cfg.cost
		local matType, id, matNum = MaterialMgr.getMatParams(cost)
		local count = MaterialModel.instance:getMaterialsNumber(matType, id)

		self._itemCountMap[i] = Mathf.Floor(count / matNum)
	end
end

function ClearStarGameView:_initGame()
	self:_resetGame()
	self:_initMapData()
	self:_initStarList()
	self:_updateUI()
end

function ClearStarGameView:_resetGame()
	self._starScoreMap = self._starScoreMap or {}

	table.clear(self._starScoreMap)

	self._useItemMap = self._useItemMap or {}

	table.clear(self._useItemMap)
	self:_resetStarList()

	self._isRuning = false
	self._isUseBoom = false
	self._newChangeTypeId = -1
	self._lastSelcetStar = nil
	self._lastStarZoneList = {}
end

function ClearStarGameView:_initMapData()
	self._curActTypeNum = #self._convertCfgs

	if self._curActTypeNum > self._UIStarTypeNum then
		printError("当前预制缺少对应的星星type,请检查配置配置,修改代码")

		return
	end

	for i = 1, self._UIStarTypeNum do
		local isExist = i <= self._curActTypeNum
		local changeColorCell = self._changeColorCells[i]
		local scoreCell = self._scoreCells[i]

		goutil.setActive(changeColorCell.go, isExist)
		goutil.setActive(scoreCell.go, isExist)
	end

	local mapId = math.random(1, #self._mapCfgs)
	local curMapData = self._mapCfgs[mapId].mapData

	if not curMapData.typeList then
		for i, typeId in ipairs(curMapData.typeList) do
			if typeId > self._curActTypeNum then
				printError(string.format("当前地图类型存在多余type,请检查配置,当前地图id = %d, 多余类型id = %d", mapId, typeId))

				return
			end
		end

		self._typeIdMap = {}

		if self._starMaxTypeId > 0 then
			local maxMapTypeId = curMapData.maxTypeId

			self._typeIdMap[maxMapTypeId] = self._starMaxTypeId
		end

		local leftStarTypeList = {}

		for i = 1, self._curActTypeNum do
			if i ~= self._starMaxTypeId then
				table.insert(leftStarTypeList, i)
			end
		end

		GameUtil.permuteArray(leftStarTypeList)

		for i = 1, self._curActTypeNum do
			if checknumber(self._typeIdMap[i]) <= 0 then
				self._typeIdMap[i] = table.remove(leftStarTypeList)
			end
		end

		self._mapColumnsNum = curMapData.colNum
		self._mapRowNum = curMapData.rowNum
		self._initMapDataList = curMapData.list or {}
	end
end

function ClearStarGameView:_resetStarList()
	self._curStarList = self._curStarList or {}

	for i, starCell in ipairs(self._curStarList) do
		starCell:reset()
	end

	self._starCellMap = self._starCellMap or {}

	table.clear(self._starCellMap)
end

function ClearStarGameView:_initStarList()
	for i, data in ipairs(self._initMapDataList) do
		local index = data.index
		local starRow = Mathf.Floor(index / self._mapColumnsNum) + 1
		local starColumns = index % self._mapColumnsNum + 1
		local star = self:_getStarCellByIndex(index + 1)

		star:setPosParams(self._mapRowNum, self._mapColumnsNum, 65)
		star:setTypeId(self._typeIdMap[data.typeId])
		star:setRowAndCol(starRow, starColumns)

		self._starCellMap[starRow] = self._starCellMap[starRow] or {}
		self._starCellMap[starRow][starColumns] = star
	end
end

function ClearStarGameView:_updateUI()
	for i = 1, self._curActTypeNum do
		local scoreCell = self._scoreCells[i]

		scoreCell.txtCurScore.text = checknumber(self._starScoreMap[i])
		scoreCell.txtAddScore.text = ""
	end

	self._txtBtnChange.text = string.format("x%s", self:_getLeftItemNum(1))
	self._txtBtnBoom.text = string.format("x%s", self:_getLeftItemNum(2))
	self._txtBtnShuffle.text = string.format("x%s", self:_getLeftItemNum(3))

	for i = 1, self._mapRowNum do
		for j = 1, self._mapColumnsNum do
			local star = self._starCellMap[i][j]

			if star then
				star:updateUI()
			end
		end
	end
end

function ClearStarGameView:_enterGame()
	if self._isPractise then
		self:_playGame()
	else
		ClearStarGameController.instance:startGame(self._activityId)
	end
end

function ClearStarGameView:_createStarCell(index)
	local go = goutil.cloneAndSetParent(self._goStarCell, self._starCom.transform, "cell" .. index)
	local star = ClearStarCell.New(go)

	GameUtil.addClickHandler(star.goCom, GameUtil.handler(self._onClickStar, self, star))

	return star
end

function ClearStarGameView:_getStarCellByIndex(index)
	self._curStarList = self._curStarList or {}

	local star = self._curStarList[index]

	if not star then
		star = self:_createStarCell(index)
		self._curStarList[index] = star
	end

	return star
end

function ClearStarGameView:_getStarByRowAndCol(row, col)
	if self._starCellMap and self._starCellMap[row] and self._starCellMap[row][col] then
		return self._starCellMap[row][col]
	end
end

function ClearStarGameView:_playGame()
	self._isRuning = true

	self:_checkEnd()
end

function ClearStarGameView:_endGame()
	if self._isPractise then
		printError("游戏结束")
		self:close()

		return
	end

	UIStateManager.instance:push(ViewName.ClearStarGameResultView, self._activityId, self._useItemMap, self._starScoreMap)
end

function ClearStarGameView:_clearLastSelcetState()
	if self._lastStarZoneList and #self._lastStarZoneList > 0 then
		for i, star in ipairs(self._lastStarZoneList) do
			star:setSubSelect(false)
		end
	end

	table.clear(self._lastStarZoneList)

	if self._lastSelcetStar then
		self._lastSelcetStar:setSelect(false)

		local typeId = self._lastSelcetStar:getTypeId()
		local scoreCell = self._scoreCells[typeId]

		if scoreCell then
			scoreCell.txtAddScore.text = ""
		end
	end

	self._lastSelcetStar = nil
	self._newChangeTypeId = -1
	self._isUseBoom = false

	goutil.setActive(self._goTips1, false)
	goutil.setActive(self._goTips2, false)
	goutil.setActive(self._changePlane, false)
	self:_playSelectEff()
end

function ClearStarGameView:_selectStar(star)
	self:_clearLastSelcetState()

	self._lastSelcetStar = star

	if self._lastSelcetStar then
		self._lastSelcetStar:setSelect(true)

		local row, col = star:getRowAndCol()

		self._lastStarZoneList = self:_getConnectedZoneListByRowAndCol(row, col)

		for i, substar in ipairs(self._lastStarZoneList) do
			substar:setSubSelect(true)
		end

		local starNum = #self._lastStarZoneList

		if starNum > 1 then
			local typeId = self._lastSelcetStar:getTypeId()
			local scoreCell = self._scoreCells[typeId]

			if scoreCell then
				scoreCell.txtAddScore.text = string.format("%s连消，+%s", starNum, self:_calculateScore(starNum))
			end
		end
	end
end

function ClearStarGameView:_isLastStarZoneListInclude(star)
	if self._lastStarZoneList and #self._lastStarZoneList > 0 then
		return table.keyof(self._lastStarZoneList, star)
	end

	return false
end

function ClearStarGameView:_checkIsClearLastStarZoneList()
	if self._lastStarZoneList and #self._lastStarZoneList > 1 then
		return true
	end

	return false
end

function ClearStarGameView:_clearLastStarZone(isUseItem)
	if self._lastStarZoneList then
		if isUseItem then
			for i, star in ipairs(self._lastStarZoneList) do
				self:_addTypeScore(star:getTypeId(), 1)
			end
		else
			local scores = self:_calculateScore(#self._lastStarZoneList)

			self:_addTypeScore(self._lastSelcetStar:getTypeId(), scores)
		end

		for i, star in ipairs(self._lastStarZoneList) do
			local row, col = star:getRowAndCol()

			self._starCellMap[row][col] = nil

			self:_playClearEffect(star)
			star:reset()
		end

		self._lastSelcetStar = nil

		table.clear(self._lastStarZoneList)

		for col = 1, self._mapColumnsNum do
			local writeRow = 1

			for readRow = 1, self._mapRowNum do
				if self._starCellMap[readRow] and self._starCellMap[readRow][col] then
					if writeRow ~= readRow then
						self._starCellMap[writeRow][col] = self._starCellMap[readRow][col]
						self._starCellMap[readRow][col] = nil
					end

					writeRow = writeRow + 1
				end
			end
		end

		local writeCol = 1

		for readCol = 1, self._mapColumnsNum do
			local isEmpty = true

			for row = 1, self._mapRowNum do
				if self._starCellMap[row][readCol] then
					isEmpty = false

					break
				end
			end

			if not isEmpty then
				if writeCol ~= readCol then
					for row = 1, self._mapRowNum do
						self._starCellMap[row][writeCol] = self._starCellMap[row][readCol]
						self._starCellMap[row][readCol] = nil
					end
				end

				writeCol = writeCol + 1
			end
		end
	end

	for i = 1, self._mapRowNum do
		for j = 1, self._mapColumnsNum do
			local star = self._starCellMap[i][j]

			if star then
				star:moveToPos(i, j)
			end
		end
	end

	self:_checkEnd()
end

local fourDirs = {
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	}
}

function ClearStarGameView:_getConnectedZoneListByRowAndCol(row, col)
	local curSelectTypeId = self:_getStarTypeByRowCol(row, col)

	if curSelectTypeId < 0 then
		return {}
	end

	local visited = {}
	local zoneList = {}

	for i = 1, self._mapRowNum do
		visited[i] = {}

		for j = 1, self._mapColumnsNum do
			visited[i][j] = false
		end
	end

	local queue = {
		{
			row,
			col
		}
	}

	visited[row][col] = true

	while #queue > 0 do
		local current = table.remove(queue, 1)

		table.insert(zoneList, self:_getStarByRowAndCol(current[1], current[2]))

		for _, dir in ipairs(fourDirs) do
			local newRow, newCol = current[1] + dir[1], current[2] + dir[2]

			if self:_getStarTypeByRowCol(newRow, newCol) == curSelectTypeId and not visited[newRow][newCol] then
				visited[newRow][newCol] = true

				table.insert(queue, {
					newRow,
					newCol
				})
			end
		end
	end

	return zoneList
end

function ClearStarGameView:_checkIsMatchEnd()
	local visited = {}

	for row = 1, self._mapRowNum do
		for col = 1, self._mapColumnsNum do
			visited[row] = visited[row] or {}
			visited[row][col] = false
		end
	end

	for row = 1, self._mapRowNum do
		for col = 1, self._mapColumnsNum do
			local curSelectTypeId = self:_getStarTypeByRowCol(row, col)

			if not visited[row][col] and curSelectTypeId > 0 then
				local zoneNum = 0
				local queue = {
					{
						row,
						col
					}
				}

				visited[row][col] = true

				while #queue > 0 and zoneNum < 2 do
					local current = table.remove(queue, 1)

					zoneNum = zoneNum + 1

					if zoneNum > 1 then
						return false
					end

					for _, dir in ipairs(fourDirs) do
						local newRow, newCol = current[1] + dir[1], current[2] + dir[2]

						if self:_getStarTypeByRowCol(newRow, newCol) == curSelectTypeId and not visited[newRow][newCol] then
							visited[newRow][newCol] = true

							table.insert(queue, {
								newRow,
								newCol
							})
						end
					end
				end
			end
		end
	end

	return true
end

function ClearStarGameView:_checkEnd()
	if self:_checkIsMatchEnd() then
		self:_endGame()
	end
end

function ClearStarGameView:_getStarTypeByRowCol(row, col)
	if row < 0 or row > self._mapRowNum or col < 0 or col > self._mapColumnsNum then
		return -1
	end

	local star = self:_getStarByRowAndCol(row, col)

	if star then
		return star:getTypeId()
	end

	return -1
end

function ClearStarGameView:_getLeftItemNum(itemType)
	if self._itemCountMap[itemType] then
		return self._itemCountMap[itemType] - checknumber(self._useItemMap[itemType])
	else
		return 0
	end
end

function ClearStarGameView:_calculateScore(starNum)
	local clearStarNum = checknumber(starNum)

	if clearStarNum > 1 then
		for i, cfg in ipairs(self._scoreCfgs) do
			if starNum <= cfg.popNum then
				return Mathf.Ceil(cfg.scoreRate * starNum)
			end
		end

		return Mathf.Ceil(self._scoreCfgs[#self._scoreCfgs].scoreRate * starNum)
	else
		return 0
	end
end

function ClearStarGameView:_addTypeScore(typeId, addSocre)
	if not self._starScoreMap[typeId] then
		self._starScoreMap[typeId] = self._starScoreMap[typeId] + addSocre

		local cell = self._scoreCells[typeId]

		if cell then
			cell.txtCurScore.text = self._starScoreMap[typeId]
			cell.txtAddScore.text = ""
		end
	end
end

function ClearStarGameView:_checkItemNum(itemType)
	if self._isPractise then
		return true
	end

	if not self._useItemMap[itemType] then
		local curNum = 0

		if not self._itemCountMap[itemType] then
			local curItemNum = 0

			if curItemNum >= curNum + 1 then
				return true
			else
				TipsFacade.instance:openCommonTips("道具不足，升级圣骑岛或通关片区关卡可获得")

				return false
			end
		end
	end
end

function ClearStarGameView:_useItem(itemType)
	if self._isPractise then
		return
	end

	if not self._useItemMap[itemType] then
		local curNum = 0

		curNum = curNum + 1
		self._useItemMap[itemType] = curNum
		self._txtBtnChange.text = string.format("x%s", self:_getLeftItemNum(1))
		self._txtBtnBoom.text = string.format("x%s", self:_getLeftItemNum(2))
		self._txtBtnShuffle.text = string.format("x%s", self:_getLeftItemNum(3))
	end
end

function ClearStarGameView:_dealBoom()
	self._isUseBoom = true

	goutil.setActive(self._goTips2, true)
	self:_playSelectEff(self._effPosBtnBoom)
end

local eightDirs = {
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	},
	{
		1,
		1
	},
	{
		-1,
		-1
	},
	{
		1,
		-1
	},
	{
		-1,
		1
	}
}

function ClearStarGameView:_realDealBoom(star)
	goutil.setActive(self._goTips2, false)

	self._isUseBoom = false

	if star and star:getTypeId() > 0 then
		self._lastStarZoneList = self._lastStarZoneList or {}

		table.insert(self._lastStarZoneList, star)

		local row, col = star:getRowAndCol()

		for _, dir in ipairs(eightDirs) do
			local newRow, newCol = row + dir[1], col + dir[2]

			if self:_getStarTypeByRowCol(newRow, newCol) > 0 then
				table.insert(self._lastStarZoneList, self._starCellMap[newRow][newCol])
			end
		end

		self:_clearLastStarZone(true)
		self:_useItem(2)
	end

	self:_playSelectEff()
end

function ClearStarGameView:_dealShuffle()
	local text = "是否将全部颜色方块重新排列？"

	local function func()
		self:_realDealShuffle()
	end

	TipsFacade.instance:openPopupWindow("提示", text, func, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function ClearStarGameView:_realDealShuffle()
	self:_playBianBaiEff()
	self:_useItem(3)

	local shufffList = {}

	for i = 1, self._mapRowNum do
		for j = 1, self._mapColumnsNum do
			local star = self._starCellMap[i][j]

			if star then
				table.insert(shufffList, star)
			end
		end
	end

	for i = #shufffList, 2, -1 do
		local j = math.random(i)
		local exchangeTypeId = shufffList[i]:getTypeId()

		shufffList[i]:setTypeId(shufffList[j]:getTypeId())
		shufffList[j]:setTypeId(exchangeTypeId)
	end

	self:_checkEnd()
end

function ClearStarGameView:_dealChange()
	self._newChangeTypeId = -1

	for i, cell in ipairs(self._changeColorCells) do
		goutil.setActive(cell.select, i == self._newChangeTypeId)
	end

	goutil.setActive(self._changePlane, true)
	self:_playSelectEff(self._effPosBtnChange)
end

function ClearStarGameView:_realDealChange(star)
	goutil.setActive(self._goTips1, false)

	if star and star:getTypeId() > 0 then
		local text = "是否将该方块变色？"

		local function func()
			self:_playChangeEff(star)
			star:setTypeId(self._newChangeTypeId)
			self:_useItem(1)

			self._newChangeTypeId = -1

			self:_checkEnd()
			self:_playSelectEff()
		end

		local function calFunc()
			self._newChangeTypeId = -1

			self:_playSelectEff()
		end

		TipsFacade.instance:openPopupWindow("提示", text, func, calFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
	end
end

function ClearStarGameView:_onClickStar(star)
	if not self._isRuning then
		return
	end

	if self._isUseBoom then
		self:_realDealBoom(star)

		return
	end

	if self._newChangeTypeId > 0 then
		self:_realDealChange(star)

		return
	end

	local isInclude = self:_isLastStarZoneListInclude(star)

	if isInclude then
		if self:_checkIsClearLastStarZoneList() then
			self:_clearLastStarZone(false)
		else
			if self._lastSelcetStar then
				self._lastSelcetStar:setSelect(false)
			end

			self._lastSelcetStar = star

			self._lastSelcetStar:setSelect(true)
		end
	else
		self:_selectStar(star)
	end
end

function ClearStarGameView:_onClickClose()
	if not self._isRuning then
		self:close()

		return
	end

	if self._isPractise then
		self:close()
	else
		self:_endGame()
	end
end

function ClearStarGameView:_onClickUseItem(itemType)
	if self._isUseBoom and itemType == 2 then
		self:_clearLastSelcetState()

		return
	end

	if GameUtil.GetActive(self._changePlane) and itemType == 1 then
		self:_clearLastSelcetState()

		return
	end

	self:_clearLastSelcetState()

	if self:_checkItemNum(itemType) then
		if itemType == 1 then
			self:_dealChange()
		elseif itemType == 2 then
			self:_dealBoom()
		elseif itemType == 3 then
			self:_dealShuffle()
		end
	end
end

function ClearStarGameView:_changeColor(typeId)
	self._newChangeTypeId = typeId

	for i, cell in ipairs(self._changeColorCells) do
		goutil.setActive(cell.select, i == self._newChangeTypeId)
	end

	goutil.setActive(self._changePlane, false)
	goutil.setActive(self._goTips1, true)
end

function ClearStarGameView:_onClickTips()
	local ruleCfg = ClearStarGameConfig.instance:getImgRuleCfgs(self._activityId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.imgPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList)
end

function ClearStarGameView:_playClearEffect(star)
	self:_clearClearEffect(star)

	local effPath = "20250530/fangkuai/fx_ui_fangkuai_xiaochu.prefab"

	self._clearEffMap[star] = UIEffectManager.instance:playEffect(self, effPath, star.effPos.transform, 0, 0, false, false, nil, function(target, eff)
		eff:setParent(star.effPos.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)
end

function ClearStarGameView:_clearClearEffect(star)
	self._clearEffMap = self._clearEffMap or {}

	if self._clearEffMap[star] then
		UIEffectManager.instance:stopEffect(self._clearEffMap[star])

		self._clearEffMap[star] = nil
	end
end

function ClearStarGameView:_clearAllEff()
	for i, star in ipairs(self._curStarList) do
		self:_clearClearEffect(star)
	end

	table.clear(self._clearEffMap)

	if self._lastChangeEff then
		UIEffectManager.instance:stopEffect(self._lastChangeEff)

		self._lastChangeEff = nil
	end

	if self._lastSelectEff then
		UIEffectManager.instance:stopEffect(self._lastSelectEff)

		self._lastSelectEff = nil
	end

	if self._lastBianBaiEff then
		UIEffectManager.instance:stopEffect(self._lastBianBaiEff)

		self._lastBianBaiEff = nil
	end
end

function ClearStarGameView:_playChangeEff(star)
	if self._lastChangeEff then
		UIEffectManager.instance:stopEffect(self._lastChangeEff)

		self._lastChangeEff = nil
	end

	local effPath = "20250530/fangkuai/fx_ui_fangkuai_huanse.prefab"

	self._lastChangeEff = UIEffectManager.instance:playEffect(self, effPath, star.effPos.transform, 0, 0, false, false, nil, function(target, eff)
		eff:setParent(star.effPos.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)
end

function ClearStarGameView:_playSelectEff(pos)
	if self._lastSelectEff then
		UIEffectManager.instance:stopEffect(self._lastSelectEff)

		self._lastSelectEff = nil
	end

	if pos then
		local effPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self._lastSelectEff = UIEffectManager.instance:playEffect(self, effPath, pos.transform, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(pos.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScaleXYZ(1, 1, 1)
			eff:setClipping(self.mainGO.transform)
		end)
	end
end

function ClearStarGameView:_playBianBaiEff()
	if self._lastBianBaiEff then
		UIEffectManager.instance:stopEffect(self._lastBianBaiEff)

		self._lastBianBaiEff = nil
	end

	local effPath = "20241220/zhongyanzhizhan/fx_ui_bianbai.prefab"

	self._lastSelectEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScaleXYZ(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)
end

return ClearStarGameView
