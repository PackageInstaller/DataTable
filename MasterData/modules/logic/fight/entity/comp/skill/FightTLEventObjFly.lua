-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventObjFly.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventObjFly", package.seeall)

local FightTLEventObjFly = class("FightTLEventObjFly", FightTimelineTrackItem)

function FightTLEventObjFly:onTrackStart(fightStepData, duration, paramsArr)
	self.fly_obj = nil
	self.from_entity = FightGameMgr.entityMgr:getEntity(fightStepData.fromId)
	self.to_entity = FightGameMgr.entityMgr:getEntity(fightStepData.toId)
	self.params_arr = paramsArr
	self._duration = duration

	local _type = tonumber(paramsArr[1])

	if _type == 1 then
		-- block empty
	elseif _type == 2 and self.from_entity and self.from_entity:isMySide() then
		self.fly_obj = FightGameMgr.entityMgr:getEntity(fightStepData.fromId).spine:getSpineGO()
		self._attacker = FightHelper.getEntity(FightEntityScene.MySideId)

		self.timelineItem.workTimelineItem:_cancelSideRenderOrder()
	end

	if not self.fly_obj then
		return
	end

	self:calFly(fightStepData, paramsArr)
end

function FightTLEventObjFly:calFly(fightStepData, paramsArr)
	self.fightStepData = fightStepData

	local startOffsetX, startOffsetY, startOffsetZ = 0, 0, 0

	if paramsArr[3] then
		local arr = string.split(paramsArr[3], ",")

		startOffsetX = arr[1] and tonumber(arr[1]) or startOffsetX
		startOffsetY = arr[2] and tonumber(arr[2]) or startOffsetY
		startOffsetZ = arr[3] and tonumber(arr[3]) or startOffsetZ
	end

	local endOffsetX, endOffsetY, endOffsetZ = 0, 0, 0

	if paramsArr[4] then
		local arr = string.split(paramsArr[4], ",")

		endOffsetX = arr[1] and tonumber(arr[1]) or endOffsetX
		endOffsetY = arr[2] and tonumber(arr[2]) or endOffsetY
		endOffsetZ = arr[3] and tonumber(arr[3]) or endOffsetZ
	end

	self._easeFunc = paramsArr[5]
	self._y_offset_cruve = paramsArr[6]
	self._x_move_cruve = paramsArr[7]
	self._y_move_cruve = paramsArr[8]
	self._z_move_cruve = paramsArr[9]
	self._withRotation = paramsArr[10] and tonumber(paramsArr[10]) or 0

	if self.from_entity and not self.from_entity:isMySide() then
		startOffsetX = -startOffsetX
	end

	local startPosX, startPosY, startPosZ = transformhelper.getPos(self.fly_obj.transform)
	local startPosX = startPosX + startOffsetX
	local startPosY = startPosY + startOffsetY
	local startPosZ = startPosZ + startOffsetZ
	local flyType = string.nilorempty(paramsArr[2]) and 2 or tonumber(paramsArr[2])
	local endPosX, endPosY, endPosZ

	if fightStepData.forcePosX then
		endPosZ = fightStepData.forcePosZ
		endPosY = fightStepData.forcePosY
		endPosX = fightStepData.forcePosX
	else
		endPosX, endPosY, endPosZ = self:calEndPos(flyType, endOffsetX, endOffsetY, endOffsetZ)
	end

	local duration1 = self._duration * FightModel.instance:getSpeed()

	self._totalFrame = self.binder:GetFrameFloatByTime(duration1)
	self._startFrame = self.binder.CurFrameFloat + 1

	self:_startFly(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
end

function FightTLEventObjFly:_startFly(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
	self:_setCurveMove(self.fly_obj, startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
end

function FightTLEventObjFly:_setCurveMove(target_obj, startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
	if self._withRotation == 1 then
		self:_calcRotation(target_obj, startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
	end

	self.UnitMoverCurve_comp = MonoHelper.getLuaComFromGo(target_obj, UnitMoverCurve)
	self.UnitMoverHandler_comp = MonoHelper.getLuaComFromGo(target_obj, UnitMoverHandler)

	local mover = MonoHelper.addLuaComOnceToGo(target_obj, UnitMoverCurve)
	local mover_handler = MonoHelper.addLuaComOnceToGo(target_obj, UnitMoverHandler)

	mover_handler:init(target_obj)
	mover_handler:addEventListeners()
	mover:setXMoveCruve(self._x_move_cruve)
	mover:setYMoveCruve(self._y_move_cruve)
	mover:setZMoveCruve(self._z_move_cruve)
	mover:setCurveParam(self._y_offset_cruve)

	if not string.nilorempty(self._easeFunc) then
		mover:setEaseType(EaseType.Str2Type(self._easeFunc))
	else
		mover:setEaseType(nil)
	end

	mover:simpleMove(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, self._duration)
end

function FightTLEventObjFly:_onPosChange(mover)
	if self._moverParamDict then
		local moverParam = self._moverParamDict[mover]

		if moverParam then
			local posX, posY, posZ = mover:getPos()
			local target_obj = moverParam.target_obj
			local startPosX = moverParam.startPosX
			local startPosY = moverParam.startPosY
			local startPosZ = moverParam.startPosZ

			self:_calcRotation(target_obj, startPosX, startPosY, startPosZ, posX, posY, posZ)

			moverParam.startPosX = posX
			moverParam.startPosY = posY
			moverParam.startPosZ = posZ
		end
	end
end

function FightTLEventObjFly:_calcRotation(target_obj, startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
	local lookDir = FightHelper.getEffectLookDir(self.from_entity:getSide())
	local lookTargetRotation = Quaternion.LookRotation(Vector3.New(endPosX - startPosX, endPosY - startPosY, endPosZ - startPosZ), Vector3.up)
	local lookDirRotation = Quaternion.AngleAxis(lookDir, Vector3.up)
	local originRotation = Quaternion.AngleAxis(90, Vector3.up)

	target_obj.transform.rotation = lookTargetRotation * lookDirRotation * originRotation
end

function FightTLEventObjFly:calEndPos(flyType, endOffsetX, endOffsetY, endOffsetZ)
	if flyType == 1 then
		return endOffsetX, endOffsetY, endOffsetZ
	elseif flyType == 2 then
		return self:_flyEffectTarget(endOffsetX, endOffsetY, endOffsetZ, FightHelper.getEntityWorldCenterPos)
	elseif flyType == 3 then
		return self:_flyEffectTarget(endOffsetX, endOffsetY, endOffsetZ, false)
	else
		return self:_flyEffectTarget(endOffsetX, endOffsetY, endOffsetZ, FightHelper.getEntityHangPointPos, self.params_arr[2])
	end
end

function FightTLEventObjFly:_flyEffectTarget(endOffsetX, endOffsetY, endOffsetZ, endPosFunc, params)
	if self.to_entity then
		local getPosFunc = endPosFunc or FightHelper.getEntityWorldBottomPos
		local defPosX, defPosY, defPosZ = getPosFunc(self.to_entity, params)

		if self.to_entity:isMySide() then
			if not -endOffsetX then
				local offsetX = endOffsetX
				local endPosX = defPosX + offsetX
				local endPosY = defPosY + endOffsetY
				local endPosZ = defPosZ + endOffsetZ

				return endPosX, endPosY, endPosZ
			end
		end
	end

	return endOffsetX, endOffsetY, endOffsetZ
end

function FightTLEventObjFly:onDestructor()
	if not gohelper.isNil(self.fly_obj) then
		if not self.UnitMoverHandler_comp then
			MonoHelper.removeLuaComFromGo(self.fly_obj, UnitMoverHandler)

			self.UnitMoverHandler_comp = nil
		end

		if not self.UnitMoverCurve_comp then
			MonoHelper.removeLuaComFromGo(self.fly_obj, UnitMoverCurve)

			self.UnitMoverCurve_comp = nil
		end
	end
end

return FightTLEventObjFly
