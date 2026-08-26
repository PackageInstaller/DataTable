-- chunkname: @modules/logic/versionactivity2_4/pinball/controller/PinballEntityMgr.lua

module("modules.logic.versionactivity2_4.pinball.controller.PinballEntityMgr", package.seeall)

local PinballEntityMgr = class("PinballEntityMgr")

function PinballEntityMgr:ctor()
	self._entitys = {}
	self._item = nil
	self._topItem = nil
	self._numItem = nil
	self._layers = {}
	self.uniqueId = 0
	self._curMarblesNum = 0
	self._totalNum = 0
end

function PinballEntityMgr:addEntity(unitType, co)
	self.uniqueId = self.uniqueId + 1

	if not PinballEnum.UnitTypeToName[unitType] then
		local cls = _G[string.format("Pinball%sEntity", PinballEnum.UnitTypeToName[unitType])] or PinballColliderEntity
		local layer = PinballEnum.UnitTypeToLayer[unitType]
		local go = layer and self._layers[layer] and gohelper.clone(self._item, self._layers[layer], PinballEnum.UnitTypeToName[unitType]) or gohelper.cloneInPlace((PinballHelper.isMarblesType(unitType) or unitType == PinballEnum.UnitType.CommonEffect or nil) and (self._topItem or self._item), PinballEnum.UnitTypeToName[unitType])

		gohelper.setActive(go, true)

		local entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls)

		entity.id = self.uniqueId
		entity.unitType = unitType

		entity:initByCo(co)
		entity:loadRes()

		if entity:isMarblesType() then
			self._curMarblesNum = self._curMarblesNum + 1
		end

		entity:tick(0)

		self._entitys[self.uniqueId] = entity

		return entity
	end
end

function PinballEntityMgr:addNumShow(num, x, y)
	self._totalNum = self._totalNum + num

	local go = gohelper.cloneInPlace(self._numItem)

	gohelper.setActive(go, true)

	local entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballNumShowEntity)

	entity:setType(self._totalNum)
	entity:setPos(x, y)
end

function PinballEntityMgr:removeEntity(id)
	if self._entitys[id] then
		self._entitys[id]:markDead()
	end
end

function PinballEntityMgr:getEntity(id)
	return self._entitys[id]
end

function PinballEntityMgr:getAllEntity()
	return self._entitys
end

function PinballEntityMgr:beginTick()
	TaskDispatcher.runRepeat(self.frameTick, self, 0, -1)
end

function PinballEntityMgr:pauseTick()
	TaskDispatcher.cancelTask(self.frameTick, self)
end

function PinballEntityMgr:setRoot(normalItem, topItem, numItem, layers)
	self._item = normalItem
	self._topItem = topItem
	self._numItem = numItem
	self._layers = layers
end

function PinballEntityMgr:frameTick()
	if isDebugBuild and PinballModel.instance._gmkey then
		self:checkGMKey()
	end

	local count = 3
	local dt = Mathf.Clamp(UnityEngine.Time.deltaTime, 0.01, 0.1)

	dt = dt / count

	for i = 1, count do
		self:_tickDt(dt)
	end
end

function PinballEntityMgr:_tickDt(dt)
	for _, entity in pairs(self._entitys) do
		entity:tick(dt)
	end

	for _, entityA in pairs(self._entitys) do
		if entityA:isCheckHit() then
			for i = #entityA.curHitEntityIdList, 1, -1 do
				local hitId = entityA.curHitEntityIdList[i]
				local hitEntity = self._entitys[hitId]

				if not hitEntity or not PinballHelper.getHitInfo(entityA, hitEntity) then
					if hitEntity then
						hitEntity:onHitExit(entityA.id)
						tabletool.removeValue(hitEntity.curHitEntityIdList, entityA.id)
					end

					entityA:onHitExit(hitId)
					table.remove(entityA.curHitEntityIdList, i)
				end
			end

			for _, entityB in pairs(self._entitys) do
				if entityA ~= entityB and entityB:canHit() and not tabletool.indexOf(entityA.curHitEntityIdList, entityB.id) then
					local hitX, hitY, hitDir = PinballHelper.getHitInfo(entityA, entityB)

					if hitX then
						table.insert(entityA.curHitEntityIdList, entityB.id)
						table.insert(entityB.curHitEntityIdList, entityA.id)

						if entityA.unitType <= entityB.unitType then
							entityA:onHitEnter(entityB.id, hitX, hitY, hitDir)
							entityB:onHitEnter(entityA.id, hitX, hitY, -hitDir)

							break
						end

						entityB:onHitEnter(entityA.id, hitX, hitY, -hitDir)
						entityA:onHitEnter(entityB.id, hitX, hitY, hitDir)

						break
					end
				end
			end
		end
	end

	local isChange = false

	for id, entity in pairs(self._entitys) do
		if entity.isDead then
			if entity.curHitEntityIdList then
				for _, hitId in pairs(entity.curHitEntityIdList) do
					local hitEntity = self._entitys[hitId]

					if hitEntity then
						hitEntity:onHitExit(entity.id)
						tabletool.removeValue(hitEntity.curHitEntityIdList, entity.id)
						entity:onHitExit(hitEntity.id)
					end
				end

				entity.curHitEntityIdList = {}
			end

			if entity:isMarblesType() then
				self._curMarblesNum = self._curMarblesNum - 1
				isChange = true
			end

			self._entitys[id]:dispose()

			self._entitys[id] = nil
		end
	end

	if isChange and self._curMarblesNum == 0 then
		self._totalNum = 0

		PinballController.instance:dispatchEvent(PinballEvent.MarblesDead)
	end
end

function PinballEntityMgr:checkGMKey()
	local addBall

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha1) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad1) then
		addBall = 1
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha2) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad2) then
		addBall = 2
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha3) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad3) then
		addBall = 3
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha4) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad4) then
		addBall = 4
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha5) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad5) then
		addBall = 5
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha0) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad0) then
		for _, entity in pairs(self._entitys) do
			entity.vx = 0
			entity.vy = 0
		end
	end

	if addBall then
		local view = ViewMgr.instance:getContainer(ViewName.PinballGameView)._views[2]
		local dict = view._curBagDict

		dict[addBall] = dict[addBall] + 1

		view:_refreshBagAndSaveData()
	end
end

function PinballEntityMgr:clear()
	TaskDispatcher.cancelTask(self.frameTick, self)

	for _, entity in pairs(self._entitys) do
		entity:dispose()
	end

	self._entitys = {}
	self._item = nil
	self._topItem = nil
	self._numItem = nil
	self._layers = nil
	self._curMarblesNum = 0
end

PinballEntityMgr.instance = PinballEntityMgr.New()

return PinballEntityMgr
