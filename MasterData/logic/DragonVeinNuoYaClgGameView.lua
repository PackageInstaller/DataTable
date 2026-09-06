-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/view/DragonVeinNuoYaClgGameView.lua

module("logic.extensions.dragonveinnuoyaclg.view.DragonVeinNuoYaClgGameView", package.seeall)

local DragonVeinNuoYaClgGameView = class("DragonVeinNuoYaClgGameView", ViewComponent)
local eventInitPosX = -373.55
local EVENT_POS_Y_LIST = {
	-196.32,
	-21.8
}

function DragonVeinNuoYaClgGameView:ctor()
	DragonVeinNuoYaClgGameView.super.ctor(self)
end

function DragonVeinNuoYaClgGameView:unbindEvents()
	DragonVeinNuoYaClgGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNext)
end

function DragonVeinNuoYaClgGameView:bindEvents()
	DragonVeinNuoYaClgGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
end

function DragonVeinNuoYaClgGameView:buildUI()
	DragonVeinNuoYaClgGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnNext = self:getGo("btnNext")
	self._container = self:getGo("container")
	self._freeContainer = self:getGo("cellPool")
	self._cell = self:getGo("cell")
	self._txtLevel = self:getTxt("txtLevel")
	self._txtNum = self:getTxt("txtNum")
	self._imgEvent = self:getGo("imgEvent")
	self._prizeInfo = self:getGo("prizeInfo")
	self._prizeTableview = self:getGo("prizeTableview")
	self._prizeTableCell = self:getGo("prizeTableview/prizeTableCell")
	self._prizeTabelList = ScrollerList.create(self._prizeTableview, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._chiptableview = self:getGo("chiptableview")
	self._chiptablecell = self:getGo("chiptableview/chiptablecell")
	self._chipTableList = ScrollerList.create(self._chiptableview, self._chiptablecell, GameUtil.handler(self._updateChipCell, self), GameUtil.handler(self._clearChipCell, self))
	self._txtRewardTip = self:getTxt("imgEvent/txtRewardTip")
end

function DragonVeinNuoYaClgGameView:onExit()
	DragonVeinNuoYaClgGameView.super.onExit(self)
	self:_clearMap()
	self._prizeTabelList:dispose()
	self._chipTableList:dispose()
end

function DragonVeinNuoYaClgGameView:onEnter()
	DragonVeinNuoYaClgGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DragonVeinNuoYaClgDigRes, self._PM_DragonVeinNuoYaClgDigRes, self)
	self.addGEvent(self, GlobalNotify.PM_DragonVeinNuoYaClgJump2NextStageRes, self._PM_DragonVeinNuoYaClgJump2NextStageRes, self)

	self._activityId = self:getFirstParam()
	self._stageId = DragonVeinNuoYaClgModel.instance:getStageId(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()
	GameUtil.SetActive(self._cell, false)
	self:_setMapData()
	self:_genarateMap()
	self:_refreshView()
end

function DragonVeinNuoYaClgGameView:_initAoqiGodUI()
	self._txtRewardTip.text = "礼包 挖掘后可点击领取获得随机奖励"

	GameUtil.SetActive(self._prizeInfo, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._prizeTableview, not self._isAoqiGodProcessType)

	local eventY = EVENT_POS_Y_LIST[1]

	if self._isAoqiGodProcessType then
		eventY = EVENT_POS_Y_LIST[2]
		self._txtRewardTip.text = "礼包 奥奇大神中不获得奖励"
	end

	GameUtil.setLocalPos(self._imgEvent, eventInitPosX, eventY, 0)
end

function DragonVeinNuoYaClgGameView:_refreshView()
	if self:_isGameDone() == true then
		FloatWordMgr.instance:show(lang("恭喜你已通关！"))
		self:close()
	end

	local stageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId)

	self._txtLevel.text = langPara("第%s层", GameUtil.getChineseNumber(self._stageId))

	local gridInfos = DragonVeinNuoYaClgModel.instance:getGridInfoList(self._activityId)

	self._txtNum.text = not DragonVeinNuoYaClgModel.instance:isDoneBoss(self._activityId) and stageCfg.itemCount - #gridInfos or lang("∞")

	local openTime = GameUtil.string2time(stageCfg.openTime)
	local nextStageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId + 1)

	GameUtil.SetActive(self._btnNext, DragonVeinNuoYaClgModel.instance:isDoneBoss(self._activityId) and openTime <= ServerTime.now() and nextStageCfg)

	local prizeList = string.split(stageCfg.bossPrize, "#")

	if not self._isAoqiGodProcessType then
		self._prizeTabelList:reloadData(prizeList)
	end

	self._chipTableList:reloadData(DragonVeinNuoYaClgConfig.instance:getStageCfgs(self._activityId))
end

function DragonVeinNuoYaClgGameView:_setMapData()
	local stageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId)

	self._totalGridNum = stageCfg.mapGridCount
	self._mapCol = stageCfg.colCount
	self._mapRow = math.ceil(self._totalGridNum / self._mapCol)

	local gridIndex = 1

	self._mapData = {}

	for i = 1, self._mapRow do
		self._mapData[i] = {}

		for j = 1, self._mapCol do
			self._mapData[i][j] = gridIndex
			gridIndex = gridIndex + 1
		end
	end
end

function DragonVeinNuoYaClgGameView:getCellSize()
	return {
		x = 100,
		y = 100
	}
end

function DragonVeinNuoYaClgGameView:getCellOffset()
	return {
		x = 0,
		y = 0
	}
end

function DragonVeinNuoYaClgGameView:_genarateMap()
	self:_clearMap()

	self._mapObject = {}

	local cellSize = self:getCellSize()
	local cellCellOffset = self:getCellOffset()
	local posX, poxY = 0, 0
	local step = {
		x = cellSize.x + cellCellOffset.x,
		y = -(cellSize.y + cellCellOffset.y)
	}

	for row = 1, self._mapRow do
		for col = 1, self._mapCol do
			local obj = self:_genarateCell(self._mapData[row][col])

			self._mapObject[row] = self._mapObject[row] or {}
			self._mapObject[row][col] = obj

			GameUtil.setAnchoredPos(obj, -((cellSize.x + cellCellOffset.x) * self._mapCol + cellCellOffset.x) / 2 + step.x * (col - 1), ((cellSize.y + cellCellOffset.y) * self._mapRow + cellCellOffset.y) / 2 + step.y * (row - 1))
		end
	end
end

function DragonVeinNuoYaClgGameView:_disposeFunc(obj)
	return
end

function DragonVeinNuoYaClgGameView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
	GameUtil.SetActive(obj.gameObject, false)
end

function DragonVeinNuoYaClgGameView:_genarateCell(cellInfo)
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._cellPools = self._cellPools or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPools then
		cellObj = self._cellPools:fetchObject()
	end

	if not cellObj then
		if self._cell then
			cellObj = goutil.cloneAndSetParent(self._cell, self._container.gameObject.transform)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._container.gameObject.transform)
	end

	GameUtil.SetActive(cellObj.gameObject, true)
	self:_updateCell(cellObj, cellInfo)

	return cellObj
end

function DragonVeinNuoYaClgGameView:_updateCell(cell, data)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local imgBg = goutil.findChild(go, "bg")
	local imgBlock = goutil.findChild(go, "imgBlock")
	local blockChange = imgBlock:GetComponent(ComponentType.UIImageSpriteChange)
	local btnClick = goutil.findChild(go, "btnClick")
	local enemyGo = goutil.findChild(content, "enemy")
	local chipGo = goutil.findChild(content, "chip")
	local prizeBox = goutil.findChild(content, "prizeBox")
	local bossGo = goutil.findChild(content, "boss")
	local uiChangeGroup = content:GetComponent(ComponentType.UIChangeGroup)
	local info = DragonVeinNuoYaClgModel.instance:getGridInfo(self._activityId, data)

	GameUtil.SetActive(enemyGo, info and info.type == DragonVeinNuoYaClgModel.TYPE_NORMALTEAM and not info.done)
	GameUtil.SetActive(chipGo, info and info.type == DragonVeinNuoYaClgModel.TYPE_CHIP and not info.done)
	GameUtil.SetActive(prizeBox, info and info.type == DragonVeinNuoYaClgModel.TYPE_PRIZEBOX and not info.done)
	GameUtil.SetActive(bossGo, info and info.type == DragonVeinNuoYaClgModel.TYPE_BOSSTEAM and not info.done)
	uiChangeGroup:SetState(self._stageId - 1)
	GameUtil.SetActive(content, info)
	GameUtil.SetActive(imgBg, false)
	blockChange:SetState(math.random(0, 5))
	GameUtil.SetActive(imgBlock, not info)
	GameUtil.SetActive(btnClick, not info)
	GameUtil.addClickHandler(btnClick, function()
		if info and info.type == DragonVeinNuoYaClgModel.TYPE_PRIZEBOX then
			DragonVeinNuoYaClgAgent.instance:sendPM_DragonVeinNuoYaClgGainBoxReq(self._activityId, data)
		end

		self:_onClickGrid(data)
	end)
	GameUtil.addClickHandler(content, function()
		self:_onClickGrid(data)
	end)
end

function DragonVeinNuoYaClgGameView:_clearMap()
	for row, v in ipairs(self._mapObject or {}) do
		for col, obj in ipairs(v) do
			self._cellPools:returnObject(obj)
		end
	end

	self._mapObject = nil
end

function DragonVeinNuoYaClgGameView:_disposeMap()
	self:_clearMap()
	self._cellPools:clear()
end

function DragonVeinNuoYaClgGameView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "icon")
	local txtNum = goutil.findChildTextComponent(go, "icon/txt")
	local matType, matId, matNum = MaterialMgr.getMatParams(data)

	MaterialMgr.resetAll(con)
	MaterialMgr.setIcon(con, matType, matId)

	txtNum.text = string.format("x%d", matNum)
end

function DragonVeinNuoYaClgGameView:_clearPrizeCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(con)
end

function DragonVeinNuoYaClgGameView:_updateChipCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)
	local passStageNum = DragonVeinNuoYaClgModel.instance:getStageId(self._activityId) - 1

	if DragonVeinNuoYaClgModel.instance:isDoneBoss(self._activityId) then
		passStageNum = passStageNum + 1
	end

	imgChange:SetState(data.stageId - 1)

	if passStageNum >= data.stageId then
		GameUtil.SetGray(go, false)
	else
		GameUtil.SetGray(go, true)
	end
end

function DragonVeinNuoYaClgGameView:_clearChipCell(cell)
	return
end

function DragonVeinNuoYaClgGameView:gridIdToPos(gridId)
	local col = gridId % self._mapCol

	if col == 0 then
		col = self._mapCol
	end

	local row = math.ceil(gridId / self._mapCol)

	return col, row
end

function DragonVeinNuoYaClgGameView:_updateGrid(gridId)
	local col, row = self:gridIdToPos(gridId)
	local obj = self._mapObject[row][col]

	self:_updateCell(obj, gridId)
end

function DragonVeinNuoYaClgGameView:_isAllDone()
	local stageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	local gridInfos = DragonVeinNuoYaClgModel.instance:getGridInfoList(self._activityId)
	local isDone = #gridInfos >= stageCfg.mapGridCount

	for i, v in ipairs(gridInfos) do
		if not v.done then
			isDone = false

			break
		end
	end

	return isDone
end

function DragonVeinNuoYaClgGameView:_isGameDone()
	local nextStageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId + 1)

	return self:_isAllDone() == true and not nextStageCfg
end

function DragonVeinNuoYaClgGameView:_onClickGrid(gridId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DragonVeinNuoYaClg, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local isNeedBattle = DragonVeinNuoYaClgModel.instance:isNeedBattle(self._activityId)
	local info = DragonVeinNuoYaClgModel.instance:getGridInfo(self._activityId, gridId)

	if not info then
		if not isNeedBattle then
			DragonVeinNuoYaClgAgent.instance:sendPM_DragonVeinNuoYaClgDigReq(self._activityId, gridId)
		else
			FloatWordMgr.instance:show(lang("您已触发事件，请您完成事件后继续探索其他地块"))
		end
	elseif info and not info.done then
		if info.type == DragonVeinNuoYaClgModel.TYPE_NORMALTEAM then
			local fmtMo = DragonVeinNuoYaClgModel.instance:getFmtMo()

			fmtMo:initParams(self._activityId, gridId, info.normalTeamId)
			CustomFmtController.instance:showMissionView(fmtMo)
		elseif info.type == DragonVeinNuoYaClgModel.TYPE_BOSSTEAM then
			local stageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId)
			local fmtMo = DragonVeinNuoYaClgModel.instance:getFmtMo()

			fmtMo:initParams(self._activityId, gridId, stageCfg.bossTeamId)
			CustomFmtController.instance:showMissionView(fmtMo)
		elseif info.type == DragonVeinNuoYaClgModel.TYPE_PRIZEBOX then
			DragonVeinNuoYaClgAgent.instance:sendPM_DragonVeinNuoYaClgGainBoxReq(self._activityId, gridId)
		end
	end
end

function DragonVeinNuoYaClgGameView:_onClickNext()
	local stageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	local nextStageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, self._stageId + 1)
	local openTime = GameUtil.string2time(stageCfg.openTime)

	if openTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到开启时间"))
	elseif nextStageCfg and DragonVeinNuoYaClgModel.instance:isDoneBoss(self._activityId) then
		if self:_isAllDone() == false then
			FloatWordMgr.instance:show(lang("必须探索完所有格子才可进入下一层"))
		else
			DragonVeinNuoYaClgAgent.instance:sendPM_DragonVeinNuoYaClgJump2NextStageReq(self._activityId)
		end
	end
end

function DragonVeinNuoYaClgGameView:_PM_DragonVeinNuoYaClgDigRes(gridId)
	self:_updateGrid(gridId)
	self:_refreshView()
end

function DragonVeinNuoYaClgGameView:_PM_DragonVeinNuoYaClgJump2NextStageRes()
	self._stageId = DragonVeinNuoYaClgModel.instance:getStageId(self._activityId)

	self:_setMapData()
	self:_genarateMap()
	self:_refreshView()
end

return DragonVeinNuoYaClgGameView
