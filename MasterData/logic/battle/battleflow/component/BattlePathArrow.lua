-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattlePathArrow.lua

module("logic.battle.battleflow.component.BattlePathArrow", package.seeall)

local BattlePathArrow = class("BattlePathArrow", IBattleFlowComp, AbstractGlobalReusable)
local kOutlineRed = "#BF0000"
local kOutlineGreen = "#5092C4"
local kOutlineRedIntensity = 2
local kOutlineGreebIntensity = 0
local kOutlineRedWidth = 0.0015
local kOutlineGreenWidth = 0.005

function BattlePathArrow:onInit()
	self._pathArrow = false
	self._unitSign = false
	self._transportSign = false
	self._terrainSign = false
	self._transportArea = false
	self._goUnitArrowSign = false
	self._selectableRedCollection = BattleGameObjectCollection.New(BattleResourceName.SelectableRedSign)
	self._selectableBlueCollection = BattleGameObjectCollection.New(BattleResourceName.SelectableBlueSign)
	self._skillAreaBlueCollection = BattleGameObjectCollection.New(BattleResourceName.SkillAreaBlueSign)
	self._skillAreaRedCollection = BattleGameObjectCollection.New(BattleResourceName.SkillAreaRedSign)
	self._selectableSignOrUnitList = {}
	self._selectableSignColorList = {}
	self._selectableIsUnitList = {}
	self._areaSignList = {}
	self._currentFocusType = false
	self._currentFocusUnit = false
	self._isFocusOnForecast = false
	self._secondFocusType = false
	self._secondUnionIndex = false
end

function BattlePathArrow:onStart()
	self._boardMgr = self.flow.boardMgr or false
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._unitOperator = self.flow.unitOperator
end

function BattlePathArrow:onResourceLoaded()
	self:_buildPathArrow()
	self:_buildSigns()
	self:_createTransportArea()
end

function BattlePathArrow:onClear()
	self:_destroySigns()
	self:_destroyPathArrow()
	self:_destroyAllSelectableSign()
	self:_destroyAllSkillAreaSign()
	self:_destroyTransportArea()

	self._boardMgr = false
	self._resMgr = false
	self._boardModel = false
	self._currentFocusType = false
	self._currentFocusUnit = false
	self._isFocusOnForecast = false
	self._secondFocusType = false
	self._secondUnionIndex = false
end

function BattlePathArrow:onUpdateTimeScale()
	self:_setCollectionPlaySpeed(self._selectableBlueCollection)
	self:_setCollectionPlaySpeed(self._selectableRedCollection)
	self:_setCollectionPlaySpeed(self._skillAreaBlueCollection)
	self:_setCollectionPlaySpeed(self._skillAreaRedCollection)
end

function BattlePathArrow:showPath(pathIndexList)
	local boardMgr = self._boardMgr
	local pathArrow = self._pathArrow

	pathArrow:Clear()

	for _, pathIndex in pairs(pathIndexList) do
		local position = boardMgr:getCellPosition(pathIndex)

		pathArrow:AddPoint(position.x, position.y, position.z)
	end

	pathArrow:Tritriangulate()
end

function BattlePathArrow:clearPath()
	self._pathArrow:Clear()
end

function BattlePathArrow:_showFocusSign(unionIndex, focusType)
	if self._currentFocusType == BattleEnum.FocusSignType.Target and focusType ~= BattleEnum.FocusSignType.Target then
		self._secondFocusType = focusType
		self._secondUnionIndex = unionIndex

		return
	end

	if self._currentFocusUnit and not self._currentFocusUnit:isDestroyed() then
		self:_hideSelectedUnitSign()
		self:_hideSign(self._unitSign)

		self._currentFocusUnit = false
	end

	self._currentFocusType = focusType

	local unit = self:_getFocusUnit(unionIndex)

	if unit then
		self._currentFocusUnit = unit

		self:_hideSign(self._terrainSign)
		self:_showSign(self._unitSign, unionIndex)
		self:_showSelectedUnitSign(unionIndex)
	else
		self:_hideSign(self._unitSign)
		self:_showSign(self._terrainSign, unionIndex)
	end
end

function BattlePathArrow:_getFocusUnit(unionIndex)
	self._isFocusOnForecast = false

	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if unit and unit:getUnitType() == BattleEnum.UnitType.Terrain then
		return false
	end

	if unit and unit.property:getForecastUnit() then
		self._isFocusOnForecast = true
		unit = unit.property:getForecastUnit()
	end

	local transportForecastUnit = self._unitMgr:getForecastUnit(BattleEnum.ForecastUnitType.Transport)

	if transportForecastUnit and BoardIndexConverter.coordinatesToUnionIndex(transportForecastUnit.transform:getCoordinates()) == unionIndex then
		self._isFocusOnForecast = true
		unit = transportForecastUnit
	end

	return unit
end

function BattlePathArrow:removeForecastUnit()
	if self._isFocusOnForecast then
		self._isFocusOnForecast = false
		self._currentFocusUnit = false

		self:_hideSign(self._unitSign)

		self._currentFocusType = false
	end
end

function BattlePathArrow:removeCurrentFocus()
	self._currentFocusUnit = false
	self._currentFocusType = false

	self:_hideSign(self._unitSign)
end

function BattlePathArrow:_hideFocusSign(focusType)
	if self._secondFocusType == focusType then
		self._secondFocusType = false
		self._secondUnionIndex = false
	end

	if self._currentFocusType == focusType then
		self._currentFocusType = false

		if self._currentFocusUnit then
			self:_hideSign(self._unitSign)

			if not self._currentFocusUnit:isDestroyed() then
				self:_hideSelectedUnitSign()
			end
		else
			self:_hideSign(self._terrainSign)
		end

		if focusType == BattleEnum.FocusSignType.Target and self._secondFocusType then
			self:_showFocusSign(self._secondUnionIndex, self._secondFocusType)
		end
	end
end

function BattlePathArrow:showFocusSign(unionIndex)
	BattleMainViewFacade.instance:showAdditionalTerrainTips(unionIndex)
	self:_showFocusSign(unionIndex, BattleEnum.FocusSignType.Focus)
end

function BattlePathArrow:showOperatableFocusSign(unionIndex)
	BattleMainViewFacade.instance:showAdditionalTerrainTips(unionIndex)
	self:_showFocusSign(unionIndex, BattleEnum.FocusSignType.Operatable)
end

function BattlePathArrow:hideFocusSign()
	BattleMainViewFacade.instance:hideAdditionalTerrainTips()
	self:_hideSelectedUnitSign()
	self:_hideFocusSign(BattleEnum.FocusSignType.Operatable)
	self:_hideFocusSign(BattleEnum.FocusSignType.Focus)
end

function BattlePathArrow:showTargetSign(unionIndex)
	self:_showFocusSign(unionIndex, BattleEnum.FocusSignType.Target)
end

function BattlePathArrow:hideTargetSign()
	self:_hideFocusSign(BattleEnum.FocusSignType.Target)
end

function BattlePathArrow:showTransportSign(unionIndex)
	self._unitOperator:createTransportForecastAndSetPos(unionIndex)
	self:_showSign(self._transportSign, unionIndex)
	self:_showFocusSign(unionIndex, BattleEnum.FocusSignType.Target)
end

function BattlePathArrow:hideTransportSign()
	self._unitOperator:clearTransportForecastUnit()
	self:_hideSign(self._transportSign)
end

function BattlePathArrow:showTransportArea(unionIndexList)
	self._transportArea:Clear()

	for _, unionIndex in ipairs(unionIndexList) do
		self._transportArea:AddVertex(BoardIndexConverter.unionIndexToCoordinates(unionIndex))
	end

	self._transportArea:Rebuild()
end

function BattlePathArrow:clearTranportArea()
	self._transportArea:Clear()
end

function BattlePathArrow:_showSelectedUnitSign(unionIndex)
	if BattleCampAdjustmentModel.instance:isDragging() then
		return
	end

	local x, y, z = self._boardMgr:getCellPositionXYZ(unionIndex)
	local size = self._currentFocusUnit.meshModel:getBodySize()

	y = y + size.y + 0.3

	Astral.TransformUtil.SetLocalPos(self._goUnitArrowSign.transform, x, y, z)
	goutil.setActive(self._goUnitArrowSign, true)
	BattleUnitUtil.setUnitSelected(self._currentFocusUnit, true)
end

function BattlePathArrow:_hideSelectedUnitSign()
	goutil.setActive(self._goUnitArrowSign, false)
	BattleUnitUtil.setUnitSelected(self._currentFocusUnit, false)
end

function BattlePathArrow:_getSelectableUnit(unionIndex)
	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if unit and unit.transform:isComposite() then
		return false
	end

	if unit and not OOPUtil.isInstanceOf(unit, BattleUnit) then
		return false
	end

	return unit
end

function BattlePathArrow:showSelectableSign(pathIndex, isBlue)
	local selectableUnit = self:_getSelectableUnit(pathIndex)

	if selectableUnit then
		self._selectableSignOrUnitList[pathIndex] = selectableUnit
		self._selectableIsUnitList[pathIndex] = true

		if self._boardMgr:getCellHasBeenDrawn(pathIndex) then
			selectableUnit.material:turnOnLayerMask(RenderingLayerMask.Layer20)
			selectableUnit.material:turnOffLayerMask(RenderingLayerMask.Layer8)
			selectableUnit.material:setOutlineWidth(isBlue and kOutlineGreenWidth or kOutlineRedWidth)
			selectableUnit.material:doOutlineColor(isBlue and kOutlineGreen or kOutlineRed, isBlue and kOutlineGreebIntensity or kOutlineRedIntensity)
		end
	else
		local signsRoot = BattleGameObjectRootUtil.signsRoot
		local position = self._boardMgr:getCellPosition(pathIndex)
		local goSign = isBlue and self._selectableBlueCollection:createInstance(signsRoot) or self._selectableRedCollection:createInstance(signsRoot)
		local effectControl = EffectControl.Get(goSign)

		effectControl:SetPlaySpeed(BattleTime.timeScale)
		Astral.TransformUtil.SetLocalPos(goSign.transform, position.x, position.y + BattleConst.YOffsetSign, position.z)

		if self._boardMgr:getCellHasBeenDrawn(pathIndex) then
			goutil.setActive(goSign, true)
		else
			goutil.setActive(goSign, false)
		end

		self._selectableSignOrUnitList[pathIndex] = goSign
		self._selectableIsUnitList[pathIndex] = false
	end

	self._selectableSignColorList[pathIndex] = isBlue
end

function BattlePathArrow:hideSelectableSign(pathIndex)
	if self._selectableSignOrUnitList[pathIndex] then
		if self._selectableIsUnitList[pathIndex] then
			local selectableUnit = self._selectableSignOrUnitList[pathIndex]

			selectableUnit.material:turnOffLayerMask(RenderingLayerMask.Layer20)
			selectableUnit.material:turnOnLayerMask(RenderingLayerMask.Layer8)
		else
			local goSign = self._selectableSignOrUnitList[pathIndex]

			if self._selectableSignColorList[pathIndex] then
				self._selectableBlueCollection:releaseInstance(goSign)
			else
				self._selectableRedCollection:releaseInstance(goSign)
			end
		end

		self._selectableSignOrUnitList[pathIndex] = nil
		self._selectableSignColorList[pathIndex] = nil
		self._selectableIsUnitList[pathIndex] = nil
	end
end

function BattlePathArrow:onCellSpread(x, z)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)
	local selectableUnit = self._selectableSignOrUnitList[unionIndex]

	if selectableUnit then
		if self._selectableIsUnitList[unionIndex] then
			if not selectableUnit:isDestroyed() then
				local isBlue = self._selectableSignColorList[unionIndex]

				selectableUnit.material:turnOnLayerMask(RenderingLayerMask.Layer20)
				selectableUnit.material:turnOffLayerMask(RenderingLayerMask.Layer8)
				selectableUnit.material:setOutlineWidth(isBlue and kOutlineGreenWidth or kOutlineRedWidth)
				selectableUnit.material:doOutlineColor(isBlue and kOutlineGreen or kOutlineRed, isBlue and kOutlineGreebIntensity or kOutlineRedIntensity)
			end
		else
			goutil.setActive(selectableUnit, true)
		end
	end

	local goSign = self._areaSignList[unionIndex]

	if goSign then
		goutil.setActive(goSign, true)
	end
end

function BattlePathArrow:hideAllSelectableSign()
	for unionIndex, v in pairs(self._selectableSignOrUnitList) do
		if self._selectableIsUnitList[unionIndex] then
			local selectableUnit = self._selectableSignOrUnitList[unionIndex]

			selectableUnit.material:turnOffLayerMask(RenderingLayerMask.Layer20)
			selectableUnit.material:turnOnLayerMask(RenderingLayerMask.Layer8)
			selectableUnit.material:killAll(true)
		end
	end

	self._selectableRedCollection:clear()
	self._selectableBlueCollection:clear()
	BattleTableUtil.clearTable(self._selectableSignOrUnitList)
	BattleTableUtil.clearTable(self._selectableSignColorList)
	BattleTableUtil.clearTable(self._selectableIsUnitList)
end

function BattlePathArrow:signSkillAreaCell(cellIndex, isBlue, needWait)
	local signsRoot = BattleGameObjectRootUtil.signsRoot
	local position = self._boardMgr:getCellPosition(cellIndex)
	local goSign = isBlue and self._skillAreaBlueCollection:createInstance(signsRoot) or self._skillAreaRedCollection:createInstance(signsRoot)
	local effectControl = EffectControl.Get(goSign)

	effectControl:SetPlaySpeed(BattleTime.timeScale)
	Astral.TransformUtil.SetLocalPos(goSign.transform, position.x, position.y + BattleConst.YOffsetSign, position.z)

	if self._boardMgr:getCellHasBeenDrawn(cellIndex) then
		goutil.setActive(goSign, true)
	else
		goutil.setActive(goSign, false)

		self._areaSignList[cellIndex] = goSign
	end
end

function BattlePathArrow:clearSkillArea()
	self._skillAreaBlueCollection:clear()
	self._skillAreaRedCollection:clear()
	BattleTableUtil.clearTable(self._areaSignList)
end

function BattlePathArrow:_destroyAllSelectableSign()
	for unionIndex, v in pairs(self._selectableSignOrUnitList) do
		if self._selectableIsUnitList[unionIndex] then
			local selectableUnit = self._selectableSignOrUnitList[unionIndex]

			if not selectableUnit:isDestroyed() then
				selectableUnit.material:turnOffLayerMask(RenderingLayerMask.Layer20)
				selectableUnit.material:turnOnLayerMask(RenderingLayerMask.Layer8)
			end
		end
	end

	self._selectableRedCollection:clear()
	self._selectableBlueCollection:clear()
	BattleTableUtil.clearTable(self._selectableSignOrUnitList)
	BattleTableUtil.clearTable(self._selectableSignColorList)
	BattleTableUtil.clearTable(self._selectableIsUnitList)
end

function BattlePathArrow:getSelectableSignList()
	return self._selectableSignOrUnitList
end

function BattlePathArrow:_destroyAllSkillAreaSign()
	self._skillAreaBlueCollection:clear()
	self._skillAreaRedCollection:clear()
	BattleTableUtil.clearTable(self._areaSignList)
end

function BattlePathArrow:_showSign(sign, unionIndex)
	goutil.setActive(sign.gameObject, true)

	if sign == self._unitSign then
		local position = self._boardMgr:getCellPosition(unionIndex)
		local boardMgr = BattleMgr.instance:getBoardMgr()
		local y = boardMgr:calculateWorldYOffset(position.x, position.z)

		Astral.TransformUtil.SetPos(sign.transform, position.x, y + BattleConst.YOffsetSign, position.z)
	else
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

		sign:SetVertex(x, z)
	end
end

function BattlePathArrow:_hideSign(sign)
	goutil.setActive(sign.gameObject, false)
end

function BattlePathArrow:_buildPathArrow()
	local resMgr = self._resMgr
	local arrowInst = resMgr:getInst(BattleResourceName.PathArrow)

	BattleGameObjectRootUtil.addToSignsRoot(arrowInst)
	Astral.TransformUtil.SetPos(arrowInst.transform, 0, BattleConst.YOffsetPathArrow, 0)

	self._pathArrow = SpaceX.PathArrowMesh.Get(arrowInst)

	self._pathArrow:Clear()
end

function BattlePathArrow:_buildSigns()
	self._terrainSign = self:_createSign(BattleResourceName.TerrainSign)

	self:_hideSign(self._terrainSign)

	self._unitSign = self:_createSign(BattleResourceName.UnitSign)

	self:_hideSign(self._unitSign)

	self._goUnitArrowSign = self:_createGameObject(BattleResourceName.UnitArrowSign)

	self:_hideSelectedUnitSign()
	self:hideFocusSign()
	self:hideTargetSign()

	self._transportSign = self:_createSign(BattleResourceName.TerrainSign)

	self:hideTransportSign()
end

function BattlePathArrow:_destroyPathArrow()
	if self._pathArrow then
		goutil.destroy(self._pathArrow.gameObject)

		self._pathArrow = false
	end
end

function BattlePathArrow:_destroySigns()
	if self._unitSign then
		goutil.destroy(self._unitSign.gameObject)

		self._unitSign = false
	end

	if self._transportSign then
		goutil.destroy(self._transportSign.gameObject)

		self._transportSign = false
	end

	if self._terrainSign then
		goutil.destroy(self._terrainSign.gameObject)

		self._terrainSign = false
	end

	if self._goUnitArrowSign then
		goutil.destroy(self._goUnitArrowSign)

		self._goUnitArrowSign = false
	end
end

function BattlePathArrow:_createGameObject(resPath)
	local resMgr = self._resMgr
	local goSign = resMgr:getInst(resPath)

	BattleGameObjectRootUtil.addToSignsRoot(goSign)

	return goSign
end

function BattlePathArrow:_createSign(resPath)
	local resMgr = self._resMgr
	local goSign = resMgr:getInst(resPath)

	BattleGameObjectRootUtil.addToSignsRoot(goSign)

	local boardMO = self._boardModel:getActiveBoardMO()
	local position = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(goSign.transform, position.x, BattleConst.YOffsetSign, position.z)

	return SpaceX.FocusSign.Get(goSign)
end

function BattlePathArrow:_setCollectionPlaySpeed(collection)
	local instList = collection:getInstList()

	for _, go in pairs(instList) do
		local effectControl = EffectControl.Get(go)

		effectControl:SetPlaySpeed(BattleTime.timeScale)
	end
end

function BattlePathArrow:_createTransportArea()
	local goSign = self._resMgr:getInst(BattleResourceName.TransportAreaSign)

	BattleGameObjectRootUtil.addToSignsRoot(goSign)

	local boardMO = self._boardModel:getActiveBoardMO()
	local position = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(goSign.transform, position.x, BattleConst.YOffsetBoard, position.z)

	self._transportArea = SpaceX.BorderCell.Get(goSign)
end

function BattlePathArrow:_destroyTransportArea()
	if self._transportArea then
		goutil.destroy(self._transportArea.gameObject)

		self._transportArea = false
	end
end

return BattlePathArrow
