-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleCheckerBoardMgr.lua

module("logic.battle.battleflow.component.BattleCheckerBoardMgr", package.seeall)

local BattleCheckerBoardMgr = class("BattleCheckerBoardMgr", IBattleFlowComp)
local tempVec3 = Vector3.New()

function BattleCheckerBoardMgr:onInit()
	self._activeCheckerBoard = false
	self._checkerBoardStentil = false
	self._goBoardOpenEffect = false
	self._timeWaiter = TimeWaiter.New()
	self._visibleSignAmount = SignalAmount.New()
end

function BattleCheckerBoardMgr:onStart()
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitOperator = self.flow.unitOperator or false
	self._pathArrow = self.flow.pathArrow or false
	self._pathFinder = self.flow.pathFinder or false
	self._unitMgr = self.flow.unitMgr or false
	self._releaseSkillAgent = self.flow.releaseSkillAgent or false

	self._visibleSignAmount:clear()
end

function BattleCheckerBoardMgr:onClear()
	self:_destroyActiveBaord()
	self:_destroyCheckerBoardOpenEffect()
	self._timeWaiter:clear()

	self._resMgr = false
	self._unitOperator = false
	self._boardModel = false
	self._pathArrow = false
	self._pathFinder = false
	self._unitMgr = false
	self._releaseSkillAgent = false
end

function BattleCheckerBoardMgr:onResourceLoaded()
	local model = self.flow.model

	self:setActiveCheckerBoard(model:getSceneCode())
end

function BattleCheckerBoardMgr:setActiveCheckerBoard(checkerBoardCode)
	self:_destroyActiveBaord()
	self:_destroyCheckerBoardOpenEffect()
	self._boardModel:setActiveBoardCode(checkerBoardCode)

	local boardMO = self._boardModel:getActiveBoardMO()

	self._activeCheckerBoard = self:_createCheckerBoard(boardMO)
	self._checkerBoardStentil = self:_createCheckerBoardOpenEffect(boardMO)

	local position = boardMO:getInitPosition()

	VirtualCameraMgr.instance:setConfinerPosition(position.x, 0, position.z)
end

function BattleCheckerBoardMgr:exchangeUnitToUnionIndex(unit, unionIndex)
	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local oldUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if oldUnit then
		self._boardModel:removeUnit(unit)
		self:setUnitToUnionIndex(oldUnit, unitUnionIndex)
	end

	self:setUnitToUnionIndex(unit, unionIndex)
end

function BattleCheckerBoardMgr:setUnitToUnionIndex(unit, unionIndex, isForecast)
	self._boardModel:setUnitToUnionIndex(unit, unionIndex, isForecast)

	if not isForecast then
		local position = self:getCellPosition(unionIndex)

		unit.mover:setPosDirectly(position.x, position.z)
		BattleDispatcher:dispatchEvent(BattleEventType.OnEntityMove, unit.property:getEntityId())
	end
end

function BattleCheckerBoardMgr:setForecastUnionIndex(unit, unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	unit.transform:setCoordinates(x, z)

	local position = self:getCellPosition(unionIndex)

	unit.mover:setPosDirectly(position.x, position.z)
end

function BattleCheckerBoardMgr:removeUnit(unit)
	self._boardModel:removeUnit(unit)
end

function BattleCheckerBoardMgr:getCellPosition(unionIndex)
	local position = tempVec3
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local wx, wy, wz = self._activeCheckerBoard:GetCellPosition(x, z, 0, 0, 0)

	position:Set(wx, wy, wz)

	return position
end

function BattleCheckerBoardMgr:getCellPositionXYZ(unionIndex)
	local position = self:getCellPosition(unionIndex)

	return position:Get()
end

function BattleCheckerBoardMgr:getCellHasBeenDrawn(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	return self._activeCheckerBoard:GetCellHasBeenDrawn(x, z)
end

function BattleCheckerBoardMgr:setVisibleByKey(visible, key)
	if visible then
		self._visibleSignAmount:remove(key)
	else
		self._visibleSignAmount:addUnique(key)
	end

	visible = self._visibleSignAmount:isUnactive()

	self._activeCheckerBoard:SetVisible(visible)
end

function BattleCheckerBoardMgr:getActiveCheckerBoard()
	return self._activeCheckerBoard
end

function BattleCheckerBoardMgr:spreadCheckerBoard(unit, skillId, useTween)
	local unitMgr = self._unitMgr
	local attackableColorIndex = BattleSkillAssist.judgeAttackableCellColorIndex(skillId, unit.skill:getSkillStatus())
	local walkableColorIndex = BattleSkillAssist.judgeWalkableCellColorIndex(skillId, unit.skill:getSkillStatus())
	local activeBoard = self:getActiveCheckerBoard()
	local boardStentil = self._checkerBoardStentil
	local resultNodeArray = self._pathFinder:getNodeArray()
	local minx, maxx, minz, maxz = BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN, BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN

	boardStentil:Clear()

	for _, resultNode in resultNodeArray:ipairs() do
		local x, z = resultNode:getCoordinates()
		local layerColorIndex = BattleEnum.CellColor.NORMAL
		local fillColorIndex = BattleEnum.CellColor.NORMAL
		local layer = BattleEnum.CellLayer.NORMAL

		if resultNode.isStopable then
			layer = BattleEnum.CellLayer.STOPABLE
			fillColorIndex = BattleEnum.CellColor.STOPABLE
			layerColorIndex = BattleEnum.CellColor.STOPABLE
		elseif resultNode.isWalkable then
			layer = BattleEnum.CellLayer.STOPABLE
			fillColorIndex = walkableColorIndex
			layerColorIndex = BattleEnum.CellColor.STOPABLE
		elseif resultNode.isAttackable then
			local targetUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)
			local targetUnit = unitMgr:getUnitOnUnionIndex(targetUnionIndex)

			if resultNode.isEnable and (not targetUnit or self._releaseSkillAgent:isValidSkillTarget(unit, targetUnionIndex, skillId)) then
				fillColorIndex = attackableColorIndex
			end

			layer = BattleEnum.CellLayer.ATTACKABLE
			layerColorIndex = attackableColorIndex
		end

		if layerColorIndex ~= BattleEnum.CellColor.NORMAL then
			minx = math.min(minx, x)
			maxx = math.max(maxx, x)
			minz = math.min(minz, z)
			maxz = math.max(maxz, z)
		end

		if useTween and layerColorIndex == BattleEnum.CellColor.STOPABLE then
			boardStentil:AddVertex(x, z)
		end

		activeBoard:SetCellColor(x, z, layer, layerColorIndex, fillColorIndex)
	end

	if useTween then
		local centerX, centerZ = unit.transform:getCoordinates()

		activeBoard:DOTriangulate(centerX, centerZ)
		self:_playOpenEffect(centerX, centerZ)
	else
		activeBoard:Triangulate()
	end

	self:_dispatchVisualRectUpdate(minx, maxx, minz, maxz)
end

function BattleCheckerBoardMgr:_playOpenEffect(centerX, centerZ)
	self._checkerBoardStentil:Rebuild()
	self._checkerBoardStentil:SetVisible(true)

	local wx, wy, wz = self._activeCheckerBoard:GetCellPosition(centerX, centerZ, 0, 0, 0)

	Astral.TransformUtil.SetPos(self._goBoardOpenEffect.transform, wx, wy + BattleConst.YOffsetBoard, wz)
	goutil.setActive(self._goBoardOpenEffect, false)
	goutil.setActive(self._goBoardOpenEffect, true)
	self._timeWaiter:start(BattleConst.DelayOne, self._onOpenSceneEffectFinish, self)
end

function BattleCheckerBoardMgr:_onOpenSceneEffectFinish()
	self._checkerBoardStentil:SetVisible(false)
end

function BattleCheckerBoardMgr:singleSpreadCheckerBoardForSelectable(unit, selectLayer, selectFillColorIndex, selectLayerColorIndex, useTween)
	local unitMgr = self._unitMgr
	local activeBoard = self:getActiveCheckerBoard()
	local resultNodeArray = self._pathFinder:getNodeArray()
	local minx, maxx, minz, maxz = BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN, BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN

	for _, resultNode in resultNodeArray:ipairs() do
		local x, z = resultNode:getCoordinates()
		local layerColorIndex = BattleEnum.CellColor.NORMAL
		local fillColorIndex = BattleEnum.CellColor.NORMAL
		local layer = BattleEnum.CellLayer.NORMAL

		if resultNode.isSelectable then
			layer = selectLayer
			fillColorIndex = selectFillColorIndex
			layerColorIndex = selectLayerColorIndex
		end

		if layerColorIndex ~= BattleEnum.CellColor.NORMAL then
			minx = math.min(minx, x)
			maxx = math.max(maxx, x)
			minz = math.min(minz, z)
			maxz = math.max(maxz, z)
		end

		activeBoard:SetCellColor(x, z, layer, layerColorIndex, fillColorIndex)
	end

	if useTween then
		local centerX, centerZ = unit.transform:getCoordinates()

		activeBoard:DOTriangulate(centerX, centerZ)
	else
		activeBoard:Triangulate()
	end

	self:_dispatchVisualRectUpdate(minx, maxx, minz, maxz)
end

function BattleCheckerBoardMgr:resetAllSign()
	local activeBoard = self._activeCheckerBoard
	local boardMO = self._boardModel:getActiveBoardMO()

	for _, cellMO in boardMO:ipairs() do
		local x, z = cellMO:getCoordinates()

		activeBoard:SetCellColor(x, z, BattleEnum.CellColor.NORMAL, BattleEnum.CellColor.NORMAL, BattleEnum.CellColor.NORMAL)
	end

	activeBoard:Triangulate()
	self._checkerBoardStentil:SetVisible(false)
	self:_dispatchVisualRectUpdate(false)
end

function BattleCheckerBoardMgr:rebuildBoard()
	self._activeCheckerBoard:Triangulate()
end

function BattleCheckerBoardMgr:calculateWorldYOffset(px, pz)
	local x, z = self._activeCheckerBoard:WorldPosition2CellPosition(px, 0, pz, 0, 0)
	local wx, wy, wz = self._activeCheckerBoard:GetCellPosition(x, z, 0, 0, 0)

	return wy
end

function BattleCheckerBoardMgr:calculateBaseWorldYOffset(px, pz)
	local x, z = self._activeCheckerBoard:WorldPosition2CellPosition(px, 0, pz, 0, 0)

	return self._activeCheckerBoard:GetCheckerBoardBaseHeight(x, z)
end

function BattleCheckerBoardMgr:worldPosition2UnionIndex(px, py, pz)
	local x, z = self._activeCheckerBoard:WorldPosition2CellPosition(px, 0, pz, 0, 0)

	if self._boardModel:isValideCoordinates(x, z) then
		return BoardIndexConverter.coordinatesToUnionIndex(x, z)
	end

	return -1
end

function BattleCheckerBoardMgr:interpolateWorldYOffset(px, pz)
	return self._activeCheckerBoard:InterpolateWorldLogicHeight(px, 0, pz)
end

function BattleCheckerBoardMgr:_dispatchVisualRectUpdate(minx, maxx, minz, maxz)
	if minx then
		minx = self._activeCheckerBoard:GetCellPosition(minx, 0, 0, 0, 0)
		maxx = self._activeCheckerBoard:GetCellPosition(maxx, 0, 0, 0, 0)
		_, _, minz = self._activeCheckerBoard:GetCellPosition(0, minz, 0, 0, 0)
		_, _, maxz = self._activeCheckerBoard:GetCellPosition(0, maxz, 0, 0, 0)

		BattleDispatcher:dispatchEvent(BattleEventType.OnVisualRectUpdate, minx, maxx, minz, maxz)
	else
		BattleDispatcher:dispatchEvent(BattleEventType.OnVisualRectUpdate)
	end
end

function BattleCheckerBoardMgr:_destroyActiveBaord()
	if self._activeCheckerBoard then
		goutil.destroy(self._activeCheckerBoard.gameObject)

		self._activeCheckerBoard = false

		local heightMapProxy = SpaceX.HeightMapProxy

		heightMapProxy.SetActiveHeightMapProxy(nil)
		heightMapProxy.SetActiveCheckerBoard(nil)
	end
end

function BattleCheckerBoardMgr:_destroyCheckerBoardOpenEffect()
	if self._checkerBoardStentil then
		goutil.destroy(self._checkerBoardStentil.gameObject)

		self._checkerBoardStentil = false
		self._goBoardOpenEffect = false
	end
end

function BattleCheckerBoardMgr:_createCheckerBoard(boardMO)
	local resMgr = self._resMgr
	local boardInst = resMgr:getInst(BattleResourceName.CheckerBoard)

	BattleGameObjectRootUtil.addToSignsRoot(boardInst)

	local initPosition = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(boardInst.transform, initPosition.x, BattleConst.YOffsetBoard, initPosition.z)

	local checkerBoard = SpaceX.CheckerBoard.Get(boardInst)

	checkerBoard:ParseLuaConfig(boardMO:getOriginalConfig())

	local scene = SceneMgr.instance:getScene(SceneType.Battle)
	local heightMapProxy = SpaceX.HeightMapProxy
	local battleType = self.flow.model:getBattleType()

	if not AirWorkShopDefSceneUtil.isInAirBattle(battleType) then
		heightMapProxy.SetActiveHeightMapProxy(scene.stage:getBaseHeightMapGameObject())
	end

	heightMapProxy.SetActiveCheckerBoard(checkerBoard)
	checkerBoard:BuildCollider()
	checkerBoard:SetDrawCallBackFunc(self._onCellSpread, self)

	return checkerBoard
end

function BattleCheckerBoardMgr:_createCheckerBoardOpenEffect(boardMO)
	local resMgr = self._resMgr
	local boardOpenEffectInst = resMgr:getInst(BattleResourceName.CheckerBoardOpenEffect)

	BattleGameObjectRootUtil.addToSignsRoot(boardOpenEffectInst)

	local position = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(boardOpenEffectInst.transform, position.x, BattleConst.YOffsetBoard, position.z)

	self._goBoardOpenEffect = goutil.findChild(boardOpenEffectInst, "open_effect")

	goutil.setActive(self._goBoardOpenEffect, false)

	return SpaceX.BorderCell.Get(boardOpenEffectInst)
end

function BattleCheckerBoardMgr:_onCellSpread(x, z)
	self.flow.pathArrow:onCellSpread(x, z)
end

return BattleCheckerBoardMgr
