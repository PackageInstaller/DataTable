-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgstageView.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgstageView", package.seeall)

local OrigindarkmoyanclgstageView = class("OrigindarkmoyanclgstageView", ViewComponent)

OrigindarkmoyanclgstageView.CellType = {
	BUFF = "BUFF",
	BLOCK = "BLOCK",
	BATTLE = "BATTLE"
}
OrigindarkmoyanclgstageView.LineType = {
	Row = 0,
	Column = 1
}

function OrigindarkmoyanclgstageView:ctor()
	OrigindarkmoyanclgstageView.super.ctor(self)
end

function OrigindarkmoyanclgstageView:unbindEvents()
	OrigindarkmoyanclgstageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnClg)
end

function OrigindarkmoyanclgstageView:bindEvents()
	OrigindarkmoyanclgstageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickbtnClg, self)
end

function OrigindarkmoyanclgstageView:buildUI()
	OrigindarkmoyanclgstageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnReset = self:getGo("btnReset")
	self._btnClg = self:getGo("left/btnClg")
	self._txtEnemyBuff = self:getTxt("left/buff/txtEnemyBuff")
	self._enemybuffconGo = self:getGo("left/buff/enemybuffcon")
	self._singleLineEnemybuffcon = self:getGo("left/buff/enemybuffcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtMyBuff = self:getTxt("left/buff/myBuff/Viewport/Content")
	self._cellGo = self:getGo("cell")
	self._cellconGo = self:getGo("cellcon")
	self._txtStage = self:getTxt("txtStage")
	self._txtScrollEnemyBuff = self:getTxt("left/buff/enemyBuff/viewport/Content")
	self._cellList = {}

	GameUtil.SetActive(self._cellGo, false)
	GameUtil.SetActive(self._txtEnemyBuff, false)
	self:_buildFormation()
end

function OrigindarkmoyanclgstageView:_buildFormation()
	local teamEnemy = self:getGo("left/team")

	self._enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.go = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.go, "icon")
		self._enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.go, false)
	end
end

function OrigindarkmoyanclgstageView:onExit()
	OrigindarkmoyanclgstageView.super.onExit(self)

	local teamEnemy = self:getGo("left/team")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "icon")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end

	GameUtil.clearCells(self._enemybuffconGo, self._clearBuffNode, self, true)
end

function OrigindarkmoyanclgstageView:onEnter()
	OrigindarkmoyanclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginDarkMoYanClgResetCurrentStageRes, self._onResetCurrentStageRes, self)
	self.addGEvent(self, GlobalNotify.OriginDarkMoYanClgSelectBuffCellRes, self._onSelectBuffCellRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._currSelectCellId = -1
	self._txtStage.text = langPara("第{0}关", self._stageId)

	self:_updateUI()
	OrigindarkmoyanclgController.instance:checkConfirmCI()

	local info = OrigindarkmoyanclgModel.instance:getInfo(self._activityId)

	if info.stageId > self._stageId then
		self:close()
	end
end

function OrigindarkmoyanclgstageView:_onResetCurrentStageRes()
	self._currSelectCellId = -1

	self:_updateUI()
end

function OrigindarkmoyanclgstageView:_onSelectBuffCellRes()
	self:_updateMyBuff()
	self:_updateEnemyBuff()
	self:_updateStageCells()
end

function OrigindarkmoyanclgstageView:_updateUI()
	self:_updateFormation()
	self:_updateStageCells()
	self:_updateMyBuff()
	self:_updateEnemyBuff()

	local x, y = self:_getCellPos(self._currSelectCellId)
	local cellData = OrigindarkmoyanclgModel.instance:getCellData(self._activityId, self._stageId, x, y)
	local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(self._activityId, self._stageId, x, y)

	if cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BATTLE and cellData ~= nil or cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BLOCK then
		GameUtil.SetActive(self._btnClg, false)
	else
		GameUtil.SetActive(self._btnClg, true)
	end
end

function OrigindarkmoyanclgstageView:_updateMyBuff()
	local cellDatas = OrigindarkmoyanclgModel.instance:getCellDatas(self._activityId, self._stageId)
	local buffDescList = {}

	for i, v in ipairs(cellDatas) do
		local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(self._activityId, self._stageId, v.x, v.y)

		if cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BUFF then
			table.insert(buffDescList, cellCfg.buffDesc)
		end
	end

	self._txtMyBuff.text = table.concat(buffDescList, "\n")
end

function OrigindarkmoyanclgstageView:_countCompletedLines(countMap, getCfgsFn)
	local completedCount = 0

	for axisKey, filledCells in pairs(countMap) do
		local lineCfgs = getCfgsFn(axisKey)
		local count = 0

		for _, cellCfg in ipairs(lineCfgs) do
			count = count + 1
		end

		if #filledCells == count then
			completedCount = completedCount + 1
		end
	end

	return completedCount
end

function OrigindarkmoyanclgstageView:_updateBuffNode(cell, data)
	local node = cell.gameObject
	local txt = node:GetComponent(goutil.Type_UIText)

	txt.text = data

	GameUtil.SetActive(node, true)
end

function OrigindarkmoyanclgstageView:_clearBuffNode(cell)
	return
end

function OrigindarkmoyanclgstageView:_updateEnemyBuff()
	local cellDatas = OrigindarkmoyanclgModel.instance:getCellDatas(self._activityId, self._stageId)
	local activityId = self._activityId
	local stageId = self._stageId
	local cfg = OrigindarkmoyanclgConfig.instance
	local xCountMap = {}
	local yCountMap = {}

	for _, v in ipairs(cellDatas) do
		xCountMap[v.x] = xCountMap[v.x] or {}

		table.insert(xCountMap[v.x], v.y)

		yCountMap[v.y] = yCountMap[v.y] or {}

		table.insert(yCountMap[v.y], v.x)
	end

	local lineXCount = self:_countCompletedLines(xCountMap, function(k)
		return cfg:getCellLineCfgsByX(activityId, stageId, k)
	end)
	local lineYCount = self:_countCompletedLines(yCountMap, function(k)
		return cfg:getCellLineCfgsByY(activityId, stageId, k)
	end)
	local datas = {}
	local rowBuffCfg = cfg:getLineBuffCfg(activityId, stageId, OrigindarkmoyanclgstageView.LineType.Row, lineXCount)

	if rowBuffCfg and rowBuffCfg.enemyBuffDesc and rowBuffCfg.enemyBuffDesc ~= "" then
		table.insert(datas, rowBuffCfg.enemyBuffDesc)
	end

	local colBuffCfg = cfg:getLineBuffCfg(activityId, stageId, OrigindarkmoyanclgstageView.LineType.Column, lineYCount)

	if colBuffCfg and colBuffCfg.enemyBuffDesc and colBuffCfg.enemyBuffDesc ~= "" then
		table.insert(datas, colBuffCfg.enemyBuffDesc)
	end

	local content = table.concat(datas, "\n")

	if string.nilorempty(content) then
		content = lang("无")
	end

	self._txtScrollEnemyBuff.text = content
end

function OrigindarkmoyanclgstageView:_updateFormation(cellType)
	for i, v in ipairs(self._enemyCellMap) do
		GameUtil.SetActive(v.go, false)
		MaterialMgr.resetAll(v.con)
	end

	if cellType == OrigindarkmoyanclgstageView.CellType.BATTLE then
		local x, y = self:_getCellPos(self._currSelectCellId)
		local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(self._activityId, self._stageId, x, y)
		local creepsCfg = OrigindarkmoyanclgConfig.instance:getCreepsCfg(cellCfg.creepsMasterId)

		for i, v in ipairs(creepsCfg) do
			local enemyCell = self._enemyCellMap[v.posId]

			if enemyCell then
				MaterialMgr.resetAll(enemyCell.con)
				MaterialMgr.setCell(MatType.Pet, v.raceId, enemyCell.con)
				GameUtil.SetActive(enemyCell.go, true)
			end
		end
	end
end

function OrigindarkmoyanclgstageView:_updateStageCells()
	self:_hideAllCells()

	local cellCfgs = OrigindarkmoyanclgConfig.instance:getCellCfgs(self._activityId, self._stageId)

	for i, v in ipairs(cellCfgs) do
		local id = self:_getCellId(v.x, v.y)
		local cell = self._cellList[id]

		if not cell then
			cell = self:_createCell(id)

			GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickCell, self, id))
		end

		local x, y = self:_getCellPos(id)
		local cellData = OrigindarkmoyanclgModel.instance:getCellData(self._activityId, self._stageId, x, y)

		GameUtil.SetActive(cell.go, true)

		if self._currSelectCellId <= 0 and v.cellType ~= OrigindarkmoyanclgstageView.CellType.BLOCK and not cellData then
			self._currSelectCellId = id

			self:_updateFormation(v.cellType)
		end

		self:_updateCell(cell, v, id, cellData)
	end
end

function OrigindarkmoyanclgstageView:_updateCell(cell, cellCfg, id, cellData)
	GameUtil.SetActive(cell.block, cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BLOCK)
	GameUtil.SetActive(cell.icon, cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BATTLE)
	GameUtil.SetActive(cell.buff, cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BUFF)
	GameUtil.SetActive(cell.tagPass, false)
	GameUtil.SetActive(cell.tagSelect, false)
	GameUtil.SetActive(cell.select, self._currSelectCellId == id)

	if cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BATTLE then
		if cellData then
			GameUtil.SetActive(cell.tagPass, true)

			local proxy = MaterialMgr.setCell(MatType.Pet, cellData.lockRaceId, cell.icon)

			if proxy then
				proxy.binder:setAutoTips(false)
			end
		else
			MaterialMgr.setCell(MatType.Pet, tonumber(cellCfg.param), cell.icon)
		end
	elseif cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BUFF then
		if cellData then
			GameUtil.SetActive(cell.tagSelect, true)
		end
	elseif cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BLOCK then
		-- block empty
	end
end

function OrigindarkmoyanclgstageView:_hideAllCells()
	for i, v in ipairs(self._cellList) do
		GameUtil.SetActive(v.go, false)
	end
end

function OrigindarkmoyanclgstageView:_getCellId(x, y)
	return y * 10 + x
end

function OrigindarkmoyanclgstageView:_getCellPos(id)
	return id % 10, math.floor(id / 10)
end

function OrigindarkmoyanclgstageView:_createCell(id)
	local cellGo = goutil.cloneAndSetParent(self._cellGo, self._cellconGo.transform, "cell_" .. id)
	local cell = {}

	cell.go = cellGo
	cell.btn = goutil.findChild(cellGo, "btn")
	cell.tagPass = goutil.findChild(cellGo, "tagPass")
	cell.tagSelect = goutil.findChild(cellGo, "buff/tagSelect")
	cell.icon = goutil.findChild(cellGo, "icon")
	cell.buff = goutil.findChild(cellGo, "buff")
	cell.block = goutil.findChild(cellGo, "block")
	cell.select = goutil.findChild(cellGo, "select")
	self._cellList[id] = cell

	local x, y = self:_getCellPos(id)
	local posx = (x - 1) * 140 + 50
	local posy = -(y - 1) * 140 - 50

	Framework.TransformUtil.SetAnchoredPos(cell.go.transform, posx, posy)

	return cell
end

function OrigindarkmoyanclgstageView:_onClickReset()
	UIStateManager.instance:push(ViewName.OrigindarkmoyanclgresetView, self._activityId, self._stageId)
end

function OrigindarkmoyanclgstageView:_onClickbtnClg()
	if self._currSelectCellId <= 0 then
		TipsFacade.instance:openTipWindowNoXExt("提示", "请先选择挑战的关卡")

		return
	end

	local x, y = self:_getCellPos(self._currSelectCellId)
	local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(self._activityId, self._stageId, x, y)

	if cellCfg.cellType ~= OrigindarkmoyanclgstageView.CellType.BATTLE then
		TipsFacade.instance:openTipWindowNoXExt("提示", "请先选择挑战的关卡")

		return
	end

	local cellData = OrigindarkmoyanclgModel.instance:getCellData(self._activityId, self._stageId, x, y)

	if cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BATTLE and cellData ~= nil then
		TipsFacade.instance:openTipWindowNoXExt("提示", "已通关该关卡")

		return
	end

	local customFmtMo = OrigindarkmoyanclgModel.instance:getFmtMo()

	customFmtMo:initParams(self._activityId, self._stageId, cellCfg.x, cellCfg.y)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OrigindarkmoyanclgstageView:_onClickCell(id)
	local x, y = self:_getCellPos(id)
	local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(self._activityId, self._stageId, x, y)

	if cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BATTLE then
		self._currSelectCellId = id
	elseif cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BUFF then
		UIStateManager.instance:push(ViewName.OrigindarkmoyanclgbuffView, self._activityId, self._stageId, x, y)

		self._currSelectCellId = id
	elseif cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BLOCK then
		self._currSelectCellId = id
	end

	self:_updateFormation(cellCfg.cellType)
	self:_updateStageCells()

	local cellData = OrigindarkmoyanclgModel.instance:getCellData(self._activityId, self._stageId, x, y)

	if cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BATTLE and cellData ~= nil or cellCfg.cellType == OrigindarkmoyanclgstageView.CellType.BLOCK then
		GameUtil.SetActive(self._btnClg, false)
	else
		GameUtil.SetActive(self._btnClg, true)
	end
end

return OrigindarkmoyanclgstageView
