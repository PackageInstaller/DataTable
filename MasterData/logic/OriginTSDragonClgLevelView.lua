-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgLevelView.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgLevelView", package.seeall)

local OriginTSDragonClgLevelView = class("OriginTSDragonClgLevelView", ViewComponent)
local DirectToNum = {
	Down = 2,
	Up = 8,
	LeftDown = 1,
	LeftUp = 7,
	Left = 4,
	RightUp = 9,
	RightDown = 3,
	Right = 6
}

function OriginTSDragonClgLevelView:ctor()
	OriginTSDragonClgLevelView.super.ctor(self)
end

function OriginTSDragonClgLevelView:unbindEvents()
	OriginTSDragonClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginTSDragonClgLevelView:bindEvents()
	OriginTSDragonClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function OriginTSDragonClgLevelView:buildUI()
	OriginTSDragonClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._lines = self:getGo("lines")
	self._lineGos = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._lines, "imgLine_" .. i)

		if go then
			self._lineGos[i] = go
		end
	end

	self._imgLine = self:getGo("imgLine")
	self._puzzleGoList = {}

	for i = 1, 3 do
		for j = 1, 3 do
			self._puzzleGoList[i] = self._puzzleGoList[i] or {}
			self._puzzleGoList[i][j] = self:getGo("stages/stage_" .. i .. "_" .. j)
		end
	end

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginTSDragonClgLevelView:onExit()
	OriginTSDragonClgLevelView.super.onExit(self)
	self._scrollList:dispose()

	for phaseId, map in pairs(self._puzScrollMap) do
		for stageId, scroll in pairs(map) do
			scroll:dispose()

			self._puzScrollMap[phaseId][stageId] = nil
		end
	end
end

function OriginTSDragonClgLevelView:onEnter()
	OriginTSDragonClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginTSDragonClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginTSDragonResetRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 591001
	end

	self._puzScrollMap = {}
	self._selectStage = nil

	local tempPhaseId, tempStageId = OriginTSDragonClgModel.instance:getTempSelect()

	if tempPhaseId and tempStageId then
		self._selectStage = {
			tempPhaseId,
			tempStageId
		}
	end

	self._cellSpacingX = 30
	self._cellSpacingY = 58
	self._cellWidth = 200
	self._cellHeight = 140
	self._phaseCfgs = OriginTSDragonClgConfig.instance:getPhaseCfgs(self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	OriginTSDragonClgController.instance:sendPM_OriginTSDragonClgInfoReq(self._activityId)

	if OriginTSDragonClgModel.instance:getTempChangeSetId() ~= nil then
		MaterialController.instance:showChangeSetInTemp(OriginTSDragonClgModel.instance:getTempChangeSetId())
		OriginTSDragonClgModel.instance:setTempChangeSetId(nil)
	end
end

function OriginTSDragonClgLevelView:_onUpdate()
	self._info = OriginTSDragonClgModel.instance:getInfo(self._activityId)
	self._phaseInfoMaps = OriginTSDragonClgModel.instance:getPhaseInfoMaps(self._activityId)

	self._scrollList:reloadData(self._phaseCfgs)
	self:_updatePuz()
	GameUtil.SetActive(self._imgLine, false)
end

function OriginTSDragonClgLevelView:_addBePointedPuzzle(phaseId, stageId, puzzleId)
	self._bePointedToMap[phaseId] = self._bePointedToMap[phaseId] or {}
	self._bePointedToMap[phaseId][stageId] = self._bePointedToMap[phaseId][stageId] or {}

	table.insert(self._bePointedToMap[phaseId][stageId], puzzleId)
end

function OriginTSDragonClgLevelView:_updateBePointedToMap(phaseId, stageId, puzzleId, puzzleType)
	local colIdx = stageId
	local leftCan = colIdx - 1 > 0
	local rightCan = colIdx + 1 <= OriginTSDragonClgController.ColNum

	if leftCan then
		self:_addBePointedPuzzle(phaseId, stageId - 1, puzzleId)
	end

	if rightCan then
		self:_addBePointedPuzzle(phaseId, stageId + 1, puzzleId)
	end

	if puzzleType ~= OriginTSDragonClgController.PuzType.AllDirect then
		return
	end

	local rowIdx = phaseId
	local upCan = rowIdx - 1 > 0
	local downCan = rowIdx + 1 <= OriginTSDragonClgController.RowNum

	if upCan then
		self:_addBePointedPuzzle(phaseId - 1, stageId, puzzleId)
	end

	if downCan then
		self:_addBePointedPuzzle(phaseId + 1, stageId, puzzleId)
	end

	if leftCan and upCan then
		self:_addBePointedPuzzle(phaseId - 1, stageId - 1, puzzleId)
	end

	if leftCan and downCan then
		self:_addBePointedPuzzle(phaseId + 1, stageId - 1, puzzleId)
	end

	if rightCan and upCan then
		self:_addBePointedPuzzle(phaseId - 1, stageId + 1, puzzleId)
	end

	if rightCan and downCan then
		self:_addBePointedPuzzle(phaseId + 1, stageId + 1, puzzleId)
	end
end

function OriginTSDragonClgLevelView:_createArrow(phaseId, stageId, puzzleId, puzzleType)
	GameUtil.SetActive(self._lines, true)

	local colIdx = stageId
	local leftCan = colIdx - 1 > 0
	local rightCan = colIdx + 1 <= OriginTSDragonClgController.ColNum

	for i = 1, 9 do
		GameUtil.SetActive(self._lineGos[i], false)

		if self._lineGos[i] then
			local uichange = self._lineGos[i]:GetComponent(ComponentType.UIImageSpriteChange)

			uichange:SetState(puzzleType - 1)
		end
	end

	local posX, posY = self:_calStagePosLocalXY(phaseId, stageId)

	GameUtil.setAnchoredPos(self._lines, posX, posY)

	if leftCan then
		self:_setLine(posX, posY, DirectToNum.Left)
	end

	if rightCan then
		self:_setLine(posX, posY, DirectToNum.Right)
	end

	if puzzleType ~= OriginTSDragonClgController.PuzType.AllDirect then
		return
	end

	local rowIdx = phaseId
	local upCan = rowIdx - 1 > 0
	local downCan = rowIdx + 1 <= OriginTSDragonClgController.RowNum

	if upCan then
		self:_setLine(posX, posY, DirectToNum.Up)
	end

	if downCan then
		self:_setLine(posX, posY, DirectToNum.Down)
	end

	if leftCan and upCan then
		self:_setLine(posX, posY, DirectToNum.LeftUp)
	end

	if leftCan and downCan then
		self:_setLine(posX, posY, DirectToNum.LeftDown)
	end

	if rightCan and upCan then
		self:_setLine(posX, posY, DirectToNum.RightUp)
	end

	if rightCan and downCan then
		self:_setLine(posX, posY, DirectToNum.RightDown)
	end
end

function OriginTSDragonClgLevelView:_updatePuz()
	self._bePointedToMap = {}

	self:_clearLines()

	for phaseId, goList in ipairs(self._puzzleGoList) do
		for stageId, cellGo in ipairs(goList) do
			local imgPuzzle = goutil.findChild(cellGo, "imgPuzzle")
			local tableviewPuz = goutil.findChild(cellGo, "tableviewPuz")
			local tablecell = goutil.findChild(cellGo, "tableviewPuz/tablecell")
			local passTag = goutil.findChild(cellGo, "passTag")
			local bgSpriteChangeComp = goutil.findChild(cellGo, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
			local puzzleImageChange = imgPuzzle:GetComponent(ComponentType.UIImageSpriteChange)
			local var_11_0 = self._phaseInfoMaps

			if self._phaseInfoMaps then
				var_11_0 = self._phaseInfoMaps[phaseId]

				if self._phaseInfoMaps[phaseId] then
					local puzzleId = self._phaseInfoMaps[phaseId][stageId]
					local hasPassed = OriginTSDragonClgModel.instance:hasPassed(self._activityId, phaseId, stageId)
					local selectGo = goutil.findChild(cellGo, "select")
					local bgState = checknumber(puzzleId) > 0 and 1 or 0

					GameUtil.SetActive(selectGo, false)

					if checknumber(puzzleId) > 0 then
						local puzzleCfg = OriginTSDragonClgConfig.instance:getPuzzleCfg(self._activityId, phaseId, puzzleId)
						local puzzleType = puzzleCfg.puzzleType

						self:_updateBePointedToMap(phaseId, stageId, puzzleId, puzzleType)
						puzzleImageChange:ChangeSprite(puzzleCfg.puzImageName)

						if self._selectStage and self._selectStage[1] == phaseId and self._selectStage[2] == stageId then
							self:_createArrow(phaseId, stageId, puzzleId, puzzleType)
							GameUtil.SetActive(selectGo, true)
						end
					end

					GameUtil.SetActive(passTag, hasPassed)
					GameUtil.SetActive(imgPuzzle, checknumber(puzzleId) > 0)
					bgSpriteChangeComp:SetState(bgState)
					GameUtil.addClickHandler(cellGo, GameUtil.handler(self._onClickBtnStage, self, phaseId, stageId, hasPassed))
				end
			end
		end
	end

	for phaseId, goList in ipairs(self._puzzleGoList) do
		for stageId, cellGo in ipairs(goList) do
			local tableviewPuz = goutil.findChild(cellGo, "tableviewPuz")
			local tablecell = goutil.findChild(cellGo, "tableviewPuz/tablecell")

			self._bePointedToMap[phaseId] = self._bePointedToMap[phaseId] or {}

			if not self._bePointedToMap[phaseId][stageId] then
				self._puzScrollMap[phaseId] = self._puzScrollMap[phaseId] or {}

				local scroll = self._puzScrollMap[phaseId][stageId]

				if scroll == nil then
					self._puzScrollMap[phaseId][stageId] = ScrollerList.create(tableviewPuz, tablecell, GameUtil.handler(self._updatePuzCell, self), GameUtil.handler(self._clearPuzCell, self))
					scroll = self._puzScrollMap[phaseId][stageId]
				end

				local cfgList = {}

				for i, v in ipairs(self._bePointedToMap[phaseId][stageId]) do
					local puzzleCfg = OriginTSDragonClgConfig.instance:getPuzzleCfg(self._activityId, phaseId, v)

					table.insert(cfgList, puzzleCfg)
				end

				scroll:reloadData(cfgList)
				GameUtil.SetActive(tableviewPuz, #cfgList > 0)
			end
		end
	end
end

function OriginTSDragonClgLevelView:_clearPuz()
	for phaseId, goList in ipairs(self._puzzleGoList) do
		for stageId, cellGo in ipairs(goList) do
			local imgPuzzle = goutil.findChild(cellGo, "imgPuzzle")

			uGuiUtil.clearImage(imgPuzzle)
			GameUtil.rmClickHandler(cellGo)

			if self._puzScrollMap[phaseId] then
				local scroll = self._puzScrollMap[phaseId][stageId]

				scroll:dispose()

				self._puzScrollMap[phaseId][stageId] = nil
			end
		end
	end
end

function OriginTSDragonClgLevelView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtPuzzle = goutil.findChildTextComponent(cell, "txtPuzzle")
	local curPuzNum = OriginTSDragonClgModel.instance:getCurPuzNum(self._activityId, data.phaseId)

	txtName.text = data.name
	txtPuzzle.text = string.format(lang("碎片:%s/%s"), curPuzNum, data.puzzleLimit)
end

function OriginTSDragonClgLevelView:_clearCell(cell)
	return
end

function OriginTSDragonClgLevelView:_updatePuzCell(view, cell, data)
	local imgPuz = goutil.findChild(cell, "imgPuz")
	local puzzleImageChange = imgPuz:GetComponent(ComponentType.UIImageSpriteChange)

	puzzleImageChange:ChangeSprite(data.puzImageName)
end

function OriginTSDragonClgLevelView:_clearPuzCell(cell)
	local imgPuz = goutil.findChild(cell, "imgPuz")
end

function OriginTSDragonClgLevelView:_getArrowObjectPool()
	local function createFunc()
		local go = goutil.cloneAndSetParent(self._imgLine, self._lines.transform, "line")

		goutil.setActive(go, true)

		return go
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		go.name = "line(recycle)"

		goutil.setActive(go, false)
	end

	return ObjectPool.New(10, createFunc, disposeFunc, resetFunc)
end

function OriginTSDragonClgLevelView:_setLine(posX, posY, arrowNum)
	GameUtil.SetActive(self._lineGos[arrowNum], true)
end

function OriginTSDragonClgLevelView:_clearLines()
	GameUtil.SetActive(self._lines, false)

	if self._lineList then
		for i, go in ipairs(self._lineList) do
			self._arrowObjectPool:returnObject(go)
		end
	end

	self._lineList = {}
end

function OriginTSDragonClgLevelView:_calStagePosLocalXY(phaseId, stageId)
	local rowIdx = phaseId
	local colIdx = stageId
	local posX = 0
	local diffNum = colIdx - (OriginTSDragonClgController.ColNum % 2 == 1 and math.ceil(OriginTSDragonClgController.ColNum / 2) or OriginTSDragonClgController.ColNum / 2 + 0.5)

	posX = diffNum * (self._cellSpacingX + self._cellWidth)

	local diffNum = (OriginTSDragonClgController.RowNum % 2 == 1 and math.ceil(OriginTSDragonClgController.RowNum / 2) or OriginTSDragonClgController.RowNum / 2 + 0.5) - rowIdx

	return posX, diffNum * (self._cellSpacingY + self._cellHeight)
end

function OriginTSDragonClgLevelView:_onClickBtnStage(phaseId, stageId, hasPassed)
	if hasPassed then
		self._selectStage = {
			phaseId,
			stageId
		}

		OriginTSDragonClgModel.instance:saveTempSelect(phaseId, stageId)
		self:_updatePuz()
	else
		OriginTSDragonClgController.instance:saveCurPointerMap(self._bePointedToMap)
		OriginTSDragonClgController.instance:enterBattleClg(self._activityId, phaseId, stageId)
	end
end

function OriginTSDragonClgLevelView:_onClickBtnReset()
	local tipsContent = lang("是否确认重置所有关卡")

	local function okFunc()
		OriginTSDragonClgController.instance:sendPM_OriginTSDragonResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindowWithX(lang("提示"), tipsContent, okFunc, nil, lang("确定"), lang("取消"))
end

function OriginTSDragonClgLevelView:_onClickClose()
	OriginTSDragonClgModel.instance:saveTempSelect(nil, nil)
	self:close()
end

return OriginTSDragonClgLevelView
