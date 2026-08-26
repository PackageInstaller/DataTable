-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/MaLiAnNaSoldierEntityMo.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaSoldierEntityMo", package.seeall)

local MaLiAnNaSoldierEntityMo = class("MaLiAnNaSoldierEntityMo")

function MaLiAnNaSoldierEntityMo.create()
	return (MaLiAnNaSoldierEntityMo.New())
end

function MaLiAnNaSoldierEntityMo:ctor()
	self._id = 0
	self._soliderId = -1
	self._localPosX = 0
	self._localPosY = 0
	self._state = Activity201MaLiAnNaEnum.SoliderState.InSlot
	self._config = nil
	self._targetSlotId = nil
	self._moveSlotPathPoint = {}
	self._hp = 0
	self._stateMachine = StateMachine.Create()

	self._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.Moving, self._moveEnter, self._moveUpdate, nil, self)
	self._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.InSlot, self._inSlotEnter, self._inSlotUpdate, nil, self)
	self._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.Attack, self._attackEnter, self._attackUpdate, nil, self)
	self._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.Dead, self._deadEnter, nil, nil, self)
	self._stateMachine:addState(Activity201MaLiAnNaEnum.SoliderState.AttackSlot, self._attackSlotEnter, self._attackSlotUpdate, nil, self)
end

function MaLiAnNaSoldierEntityMo:init(id, configId)
	self._soliderId = configId
	self._id = id
	self._config = Activity201MaLiAnNaConfig.instance:getSoldierById(configId)
	self._hp = self._config.hP
	self._speed = self._config.speed
	self._moveDirX = 0
	self._moveDirY = 0
	self._camp = Activity201MaLiAnNaEnum.CampType.Player
	self._dispatchGroupId = nil
	self._attackTime = nil
	self._soliderSkill = {}

	self._stateMachine:setInitialState(Activity201MaLiAnNaEnum.SoliderState.InSlot)
	self:initSkill()
end

function MaLiAnNaSoldierEntityMo:getId()
	return self._id
end

function MaLiAnNaSoldierEntityMo:getConfigId()
	return self._soliderId
end

function MaLiAnNaSoldierEntityMo:getConfig()
	return self._config
end

function MaLiAnNaSoldierEntityMo:getTargetSlotId()
	return self._targetSlotId
end

function MaLiAnNaSoldierEntityMo:setCamp(camp)
	self._camp = camp
end

function MaLiAnNaSoldierEntityMo:getCamp()
	return self._camp
end

function MaLiAnNaSoldierEntityMo:getHp()
	return self._hp
end

function MaLiAnNaSoldierEntityMo:getMoveDir()
	return self._moveDirX, self._moveDirY
end

function MaLiAnNaSoldierEntityMo:isHero()
	return self._config.type == Activity201MaLiAnNaEnum.SoldierType.hero
end

function MaLiAnNaSoldierEntityMo:getLocalPos()
	return self._localPosX, self._localPosY
end

function MaLiAnNaSoldierEntityMo:setLocalPos(x, y)
	self._localPosX, self._localPosY = x, y
end

function MaLiAnNaSoldierEntityMo:setDispatchGroupId(dispatchGroupId)
	self._dispatchGroupId = dispatchGroupId
end

function MaLiAnNaSoldierEntityMo:getDispatchGroupId()
	return self._dispatchGroupId
end

function MaLiAnNaSoldierEntityMo:getMoveSlotPathPoint()
	return self._moveSlotPathPoint
end

function MaLiAnNaSoldierEntityMo:getCurMoveIndex()
	return self._targetIndex
end

function MaLiAnNaSoldierEntityMo:getDisPatchList()
	return
end

function MaLiAnNaSoldierEntityMo:setMovePointPath(moveSlotPath)
	if moveSlotPath == nil then
		return
	end

	if self._moveSlotPathPoint ~= nil then
		tabletool.clear(self._moveSlotPathPoint)
		tabletool.addValues(self._moveSlotPathPoint, moveSlotPath)
	end

	self._targetSlotId = moveSlotPath[#moveSlotPath]

	local firstSlotId = moveSlotPath[1]
	local firstSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(firstSlotId)

	if firstSlot then
		local x, y = firstSlot:getBasePosXY()

		self:setLocalPos(x, y)
	end

	self:_setDisPatchDir()
end

function MaLiAnNaSoldierEntityMo:_setDisPatchDir()
	self._targetIndex = 2

	self:updateDir(self._targetIndex)
end

function MaLiAnNaSoldierEntityMo:changeState(state)
	self._state = state

	self._stateMachine:transitionTo(state)
end

function MaLiAnNaSoldierEntityMo:getCurState()
	return self._state
end

function MaLiAnNaSoldierEntityMo:isDead()
	return self._state == Activity201MaLiAnNaEnum.SoliderState.Dead or self._hp <= 0
end

function MaLiAnNaSoldierEntityMo:update(deltaTime)
	if self._isReset then
		return
	end

	if self._stateMachine then
		self._stateMachine:update(deltaTime)
	end
end

function MaLiAnNaSoldierEntityMo:updateHp(diff, fastChange)
	self._hp = math.max(0, self._hp + diff)

	if self:isHero() and diff ~= 0 then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.SoliderHpChange, self:getId(), diff)
	end

	if self._hp <= 0 and fastChange then
		self:changeState(Activity201MaLiAnNaEnum.SoliderState.Dead)
	end
end

function MaLiAnNaSoldierEntityMo:getMovePointIndex()
	if self._moveSlotPathPoint then
		local targetSlotId = self._moveSlotPathPoint[self._targetIndex]

		if targetSlotId then
			local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(targetSlotId)
			local x, y = slot:getBasePosXY()
			local _, slotHideRange, _, _ = slot:getSlotConstValue()
			local targetIndex

			if MathUtil.isPointInCircleRange(self._localPosX, self._localPosY, slotHideRange, x, y) then
				targetIndex = self._targetIndex
			end

			if MathUtil.hasPassedPoint(self._localPosX, self._localPosY, x, y, self._moveDirX, self._moveDirY) then
				targetIndex = self._targetIndex

				self:setLocalPos(x, y)
				self:updateDir(targetIndex + 1)
			end

			return targetIndex
		end
	end

	return nil
end

function MaLiAnNaSoldierEntityMo:updateDir(endIndex)
	if endIndex > #self._moveSlotPathPoint then
		return
	end

	local startX, startY = self:getLocalPos()

	if endIndex > 1 then
		local slotId = self._moveSlotPathPoint[endIndex - 1]
		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

		startX, startY = slot:getBasePosXY()
	end

	if self._moveSlotPathPoint and self._moveSlotPathPoint[endIndex] then
		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(self._moveSlotPathPoint[endIndex])
		local endX, endY = slot:getBasePosXY()

		self._moveDirX, self._moveDirY = MathUtil.vec2_normalize(endX - startX, endY - startY)
	end

	self._targetIndex = endIndex
end

function MaLiAnNaSoldierEntityMo:_isNeedEnterSlot()
	local index = self:getMovePointIndex()

	if index then
		local count = #self._moveSlotPathPoint
		local curSlotId = self._moveSlotPathPoint[index]
		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(curSlotId)

		return (curSlotId == self._targetSlotId or slot and slot:getSlotCamp() ~= self._camp or nil) and true, curSlotId, count ~= index
	end

	return false, nil, false
end

function MaLiAnNaSoldierEntityMo:_moveEnter()
	self:changeRecordSoliderState(false)
end

function MaLiAnNaSoldierEntityMo:isMoveEnd()
	local count = #self._moveSlotPathPoint

	return self._targetIndex == count
end

function MaLiAnNaSoldierEntityMo:_moveUpdate(deltaTime)
	self:skillUpdate(deltaTime)

	local needEnterSlot, slotId, needHide = self:_isNeedEnterSlot()

	if self:isHero() and needHide then
		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

		if slot and slot:getSlotCamp() ~= self._camp then
			needHide = false
		end
	end

	MaliAnNaSoliderEntityMgr.instance:setHideEntity(self, not needHide)

	if needEnterSlot then
		Activity201MaLiAnNaGameController.instance:soliderEnterSlot(self, slotId)

		return
	end

	local speed = self._speed * deltaTime

	self:setLocalPos(self._localPosX + self._moveDirX * speed, self._localPosY + self._moveDirY * speed)
end

function MaLiAnNaSoldierEntityMo:_inSlotEnter()
	if self._targetSlotId ~= nil then
		-- block empty
	end

	Activity201MaLiAnNaGameModel.instance:removeDisPatchSolider(self:getId())
	MaliAnNaSoliderEntityMgr.instance:recycleEntity(self)
end

function MaLiAnNaSoldierEntityMo:_inSlotUpdate(deltaTime)
	self:skillUpdate(deltaTime)
end

function MaLiAnNaSoldierEntityMo:_attackEnter()
	self._attackTime = Activity201MaLiAnNaEnum.attackTime
end

function MaLiAnNaSoldierEntityMo:_attackUpdate(deltaTime)
	self:skillUpdate(deltaTime)

	if self._attackTime == nil then
		return
	end

	self._attackTime = self._attackTime - deltaTime

	if self._attackTime <= 0 then
		self:updateHp(0, true)

		if self._hp and self._hp > 0 then
			self:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)
		end

		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_warring_loop)

		self._attackTime = nil
	end
end

function MaLiAnNaSoldierEntityMo:_deadEnter()
	Activity201MaLiAnNaGameController.instance:soliderDead(self)
end

function MaLiAnNaSoldierEntityMo:_attackSlotEnter()
	self._attackSlotTime = Activity201MaLiAnNaEnum.attackSlotTime
end

function MaLiAnNaSoldierEntityMo:_attackSlotUpdate(deltaTime)
	self:skillUpdate(deltaTime)

	if self._attackSlotTime == nil then
		return
	end

	self._attackSlotTime = self._attackSlotTime - deltaTime

	if self._attackSlotTime <= 0 then
		self:updateHp(0, true)

		if self._hp and self._hp > 0 then
			self:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)
		end

		self._attackSlotTime = nil
	end
end

function MaLiAnNaSoldierEntityMo:initSkill()
	if self._soliderSkill == nil then
		self._soliderSkill = {}
	end

	local passiveSkillConfigId = self._config.passiveSkill

	if passiveSkillConfigId ~= 0 then
		local passiveSkill = MaLiAnNaSkillUtils.instance.createSkill(passiveSkillConfigId)

		passiveSkill:setUseSoliderId(self:getId())
		table.insert(self._soliderSkill, passiveSkill)
	end
end

function MaLiAnNaSoldierEntityMo:skillUpdate(deltaTime)
	if self._soliderSkill == nil then
		return
	end

	for i = 1, #self._soliderSkill do
		local skill = self._soliderSkill[i]

		if skill then
			skill:update(deltaTime)
		end
	end
end

function MaLiAnNaSoldierEntityMo:getSkillSpeedUp()
	if self._soliderSkill == nil or #self._soliderSkill <= 0 then
		return 0
	end

	for i = 1, #self._soliderSkill do
		local skill = self._soliderSkill[i]

		if skill:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.upSlotGenerateSoliderSpeed then
			local effect = skill:getEffect()

			return tonumber(effect[2])
		end
	end

	return 0
end

function MaLiAnNaSoldierEntityMo:getEnterSlotSkillValue()
	if self._soliderSkill == nil or #self._soliderSkill <= 0 then
		return nil, nil
	end

	for i = 1, #self._soliderSkill do
		local skill = self._soliderSkill[i]

		if skill:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.enterSlotAddSolider then
			local effect = skill:getEffect()

			return self._camp, tonumber(effect[2])
		end
	end

	return nil, nil
end

function MaLiAnNaSoldierEntityMo:setCurViewPos(x, y)
	self._viewPosX = x
	self._viewPosY = y
end

function MaLiAnNaSoldierEntityMo:getCurViewPos()
	return self._viewPosX, self._viewPosY
end

function MaLiAnNaSoldierEntityMo:getBulletPos()
	if self._state == Activity201MaLiAnNaEnum.SoliderState.InSlot then
		return self:getCurViewPos()
	end

	local x, y = self:getLocalPos()

	return x, y + 40
end

function MaLiAnNaSoldierEntityMo:setRecordSolider(soliderMo)
	if self._exSoliderMoList == nil then
		self._exSoliderMoList = {}
	end

	table.insert(self._exSoliderMoList, soliderMo)
end

function MaLiAnNaSoldierEntityMo:changeRecordSoliderState(stop)
	if self._exSoliderMoList == nil then
		return
	end

	if stop then
		if not Activity201MaLiAnNaEnum.SoliderState.StopMove then
			local state = Activity201MaLiAnNaEnum.SoliderState.Moving

			for i = 1, #self._exSoliderMoList do
				local soliderMo = self._exSoliderMoList[i]

				if not soliderMo:isDead() then
					soliderMo:changeState(state)
				end
			end

			if not stop then
				tabletool.clear(self._exSoliderMoList)
			end
		end
	end
end

function MaLiAnNaSoldierEntityMo:reset()
	self._soliderId = nil
	self._id = nil
	self._config = nil
	self._hp = nil
	self._speed = nil
	self._moveDirX = nil
	self._moveDirY = nil
	self._camp = nil
	self._dispatchGroupId = nil
	self._attackTime = nil
	self._soliderSkill = nil
end

function MaLiAnNaSoldierEntityMo:clear()
	self:reset()

	if self._stateMachine ~= nil then
		self._stateMachine:onDestroy()

		self._stateMachine = nil
	end
end

function MaLiAnNaSoldierEntityMo:getSmallIcon()
	local res = ""
	local icon = self._config.icon

	if self:isHero() and icon == 312601 then
		res = ResUrl.getHeadIconSmall(icon)
	end

	return (ResUrl.monsterHeadIcon(icon))
end

function MaLiAnNaSoldierEntityMo:dump()
	local info = ""

	info = info .. "士兵ID:" .. tostring(self._id) .. "\n"
	info = info .. "士兵配置ID:" .. tostring(self._soliderId) .. "\n"
	info = info .. "士兵位置X:" .. tostring(self._localPosX) .. "\n"
	info = info .. "士兵位置Y:" .. tostring(self._localPosY) .. "\n"
	info = info .. "士兵状态:" .. tostring(self._state) .. "\n"

	logNormal("MaLiAnNaSoldierEntityMo->:", info)
end

return MaLiAnNaSoldierEntityMo
