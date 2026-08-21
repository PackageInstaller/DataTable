-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleDangerArea.lua

module("logic.battle.battleflow.component.BattleDangerArea", package.seeall)

local BattleDangerArea = class("BattleDangerArea", IBattleFlowComp)

function BattleDangerArea:onInit()
	self._goBoundingBox = false
	self._filledBoundingBox = false
	self._goBoundingFence = false
	self._boundingFence = false
	self._dangerMarks = {}
	self._visibleSignAmount = SignalAmount.New()
end

function BattleDangerArea:onStart()
	self:_setEvent(true)

	self._settingModel = self.flow.settingModel or false
	self._resMgr = self.flow.resMgr or false
	self._unitMgr = self.flow.unitMgr or false
	self._boardMgr = self.flow.boardMgr or false
	self._pathFinder = self.flow.sharedPathFinder or false
	self._boardModel = self.flow.boardModel or false

	self._visibleSignAmount:clear()
end

function BattleDangerArea:onResourceLoaded()
	local go = self._resMgr:getInst(BattleResourceName.DangerAreaSign)

	self._goBoundingBox = go
	self._filledBoundingBox = SpaceX.FilledBoundingBox.Get(go)

	BattleGameObjectRootUtil.addToSignsRoot(go)

	go = self._resMgr:getInst(BattleResourceName.DangerAreaFenceSign)
	self._goBoundingFence = go
	self._boundingFence = SpaceX.BoundingFence.Get(go)

	BattleGameObjectRootUtil.addToSignsRoot(go)
end

function BattleDangerArea:onEnterDone()
	local boardMO = self._boardModel:getActiveBoardMO()
	local position = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(self._goBoundingBox.transform, position.x, BattleConst.YOffsetDangerArea, position.z)
	Astral.TransformUtil.SetPos(self._goBoundingFence.transform, position.x, BattleConst.YOffsetDangerArea, position.z)
	self:_updateBoundingBox()
end

function BattleDangerArea:onClear()
	self:_setEvent(false)

	self._settingModel = false
	self._resMgr = false
	self._unitMgr = false
	self._boardMgr = false
	self._pathFinder = false
	self._boardModel = false

	if self._filledBoundingBox then
		self._filledBoundingBox:Clear()

		self._filledBoundingBox = false
	end

	if self._goBoundingBox then
		goutil.destroy(self._goBoundingBox)

		self._goBoundingBox = false
	end

	if self._boundingFence then
		self._boundingFence:Clear()

		self._boundingFence = false
	end

	if self._goBoundingFence then
		goutil.destroy(self._goBoundingFence)

		self._goBoundingFence = false
	end

	BattleTableUtil.clearTable(self._dangerMarks)
end

function BattleDangerArea:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_SWITCH_DANGER_AREA, self._onSwitchDangerArea, self)
		BattleDispatcher:addEventListener(BattleEventType.OnPlayerStarted, self._updateBoundingBox, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntitySteppedFinish, self._updateBoundingBox, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntitiesAdded, self._updateBoundingBox, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntityRemoved, self._updateBoundingBox, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntitySwapped, self._updateBoundingBox, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_SWITCH_DANGER_AREA, self._onSwitchDangerArea, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnPlayerStarted, self._updateBoundingBox, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntitySteppedFinish, self._updateBoundingBox, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntitiesAdded, self._updateBoundingBox, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityRemoved, self._updateBoundingBox, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntitySwapped, self._updateBoundingBox, self)
	end
end

function BattleDangerArea:setVisibleByKey(visible, key)
	if visible then
		self._visibleSignAmount:remove(key)
	else
		self._visibleSignAmount:addUnique(key)
	end

	self:_updateBoundingBoxVisible()
end

function BattleDangerArea:_updateBoundingBoxVisible()
	if self._goBoundingBox then
		local isVisible = self._visibleSignAmount:isUnactive()
		local isEnableDangerArea = self._settingModel:isEnableDangerArea()

		goutil.setActive(self._goBoundingBox, isEnableDangerArea and isVisible)
		goutil.setActive(self._goBoundingFence, isEnableDangerArea and isVisible)
	end
end

function BattleDangerArea:_onSwitchDangerArea(eventId, isEnable)
	self:_updateBoundingBoxVisible()
	self:_updateBoundingBox()
end

function BattleDangerArea:_updateBoundingBox()
	if not self._settingModel:isEnableDangerArea() then
		return
	end

	self:_markAllAttackArea()
	self:_buildDangerArea()
end

function BattleDangerArea:_markAllAttackArea()
	local unitMgr = self._unitMgr
	local units = unitMgr:getAllUnits()

	table.clear(self._dangerMarks)

	for _, unit in pairs(units) do
		if not BattleCampRelationUtil.isSameOrFriendOfOperateCamp(unit) and BattleUnitUtil.isAlive(unit) and unit.property:isFlagEnable(BattleUnitFlagMask.FlagOperatable) then
			self:_markUnitAttackArea(unit)
		end
	end
end

function BattleDangerArea:_buildDangerArea()
	local boardModel = self._boardModel
	local filledBoundingBox = self._filledBoundingBox
	local boundingFence = self._boundingFence

	filledBoundingBox:Clear()
	boundingFence:Clear()

	for unionIndex, mark in pairs(self._dangerMarks) do
		if mark then
			local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

			filledBoundingBox:AddVertex(x, z)
			boundingFence:AddVertex(x, z)
		end
	end

	filledBoundingBox:Rebuild()
	boundingFence:Rebuild()
end

function BattleDangerArea:_markUnitAttackArea(unit)
	local pathFinder = self._pathFinder
	local skillMO = unit.skill:findEnableDamageSkill()

	if not self:_checkSkillDamage(skillMO) then
		return
	end

	local isSkillEnable = unit.skill:isSkillEnable(skillMO:getSkillId())
	local resultNodeArray = pathFinder:signStopableAndAttackableArea(unit, skillMO:getSkillId())

	for _, resultNode in resultNodeArray:ipairs() do
		if resultNode.isEnable and resultNode.isAttackable then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())

			self._dangerMarks[unionIndex] = true
		end
	end
end

function BattleDangerArea:_checkSkillDamage(skillMO)
	if not skillMO:isValid() then
		return false
	end

	return skillMO:getPurpose() == BattleEnum.SkillPurpose.DAMAGE
end

return BattleDangerArea
