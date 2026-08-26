-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAtkFlyEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFlyEffect", package.seeall)

local FightTLEventAtkFlyEffect = class("FightTLEventAtkFlyEffect", FightTimelineTrackItem)
local FlyEffectActType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.COLDSATURDAYHURT] = true,
	[FightEnum.EffectType.NUODIKARANDOMATTACK] = true,
	[FightEnum.EffectType.NUODIKATEAMATTACK] = true,
	[FightEnum.EffectType.BUFFADD] = true
}

function FightTLEventAtkFlyEffect:onTrackStart(fightStepData, duration, paramsArr)
	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if self._attacker.skill:flyEffectNeedFilter(paramsArr[1], fightStepData) then
		return
	end

	self._paramsArr = paramsArr
	self.invokeBuff = paramsArr[28] == "1"
	self._effectName = paramsArr[1]
	self.fightStepData = fightStepData
	self._duration = duration
	self._releaseTime = tonumber(paramsArr[22])
	self._tokenRelease = not string.nilorempty(self._paramsArr[23])

	if string.nilorempty(self._effectName) then
		logError("atk effect name is nil")

		return
	end

	local flyType = string.nilorempty(paramsArr[2]) and 2 or tonumber(paramsArr[2])
	local atkOffsetX, atkAffsetY, atkAffsetZ = 0, 0, 0

	if paramsArr[4] then
		local arr = string.split(paramsArr[4], ",")

		atkOffsetX = arr[1] and tonumber(arr[1]) or atkOffsetX
		atkAffsetY = arr[2] and tonumber(arr[2]) or atkAffsetY
		atkAffsetZ = arr[3] and tonumber(arr[3]) or atkAffsetZ
	end

	if not string.nilorempty(paramsArr[21]) then
		local arr = GameUtil.splitString2(paramsArr[21], true, "#", ",")

		if #arr > 0 then
			local random = math.random(1, #arr)

			arr = arr[random]
			atkOffsetX = arr[1] or atkOffsetX
			atkAffsetY = arr[2] or atkAffsetY
			atkAffsetZ = arr[3] or atkAffsetZ
		end
	end

	local defOffsetX, defOffsetY, defOffsetZ = 0, 0, 0

	if paramsArr[5] then
		local arr = string.split(paramsArr[5], ",")

		defOffsetX = arr[1] and tonumber(arr[1]) or defOffsetX
		defOffsetY = arr[2] and tonumber(arr[2]) or defOffsetY
		defOffsetZ = arr[3] and tonumber(arr[3]) or defOffsetZ
	end

	self._easeFunc = paramsArr[6]
	self._parabolaHeight = tonumber(paramsArr[7])
	self._bezierParam = paramsArr[8]
	self._curveParam = paramsArr[9]
	self._previousFrame = paramsArr[10] and tonumber(paramsArr[10]) or 0
	self._afterFrame = paramsArr[11] and tonumber(paramsArr[11]) or 0
	self._withRotation = paramsArr[12] and tonumber(paramsArr[12]) or 1
	self._tCurveParam = paramsArr[13]
	self._alwayForceLookForward = paramsArr[14] and tonumber(paramsArr[14])
	self._act_on_index_entity = paramsArr[15] and tonumber(paramsArr[15])
	self._onlyActOnToId = paramsArr[19] == "1"
	self._actSide = nil

	if not string.nilorempty(paramsArr[20]) then
		local sideParam = paramsArr[20]

		if sideParam == "1" then
			self._actSide = FightEnum.EntitySide.EnemySide
		elseif sideParam == "2" then
			self._actSide = FightEnum.EntitySide.MySide
		end
	end

	self._actEffect_list = self._act_on_index_entity and FightHelper.dealDirectActEffectData(self.fightStepData.actEffect, self._act_on_index_entity, FlyEffectActType) or self.fightStepData.actEffect

	if string.nilorempty(paramsArr[16]) then
		self._act_entity_finished = nil
	else
		self._act_entity_finished = {}
	end

	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not self._attacker:isMySide() then
		atkOffsetX = -atkOffsetX
	end

	local atkPosX, atkPosY, atkPosZ = transformhelper.getPos(self._attacker.go.transform)

	if paramsArr[17] == "1" then
		do
			local defEntity = FightHelper.getEntity(fightStepData.toId)

			atkPosX, atkPosY, atkPosZ = transformhelper.getPos(defEntity.go.transform)
		end
	elseif paramsArr[17] == "2" then
		atkPosX, atkPosY, atkPosZ = FightHelper.getProcessEntityStancePos(self._attacker:getMO())
	elseif paramsArr[17] == "3" then
		do
			local defEntity = FightHelper.getEntity(fightStepData.toId)

			if defEntity then
				atkPosX, atkPosY, atkPosZ = FightHelper.getEntityWorldCenterPos(defEntity)
			end
		end
	elseif paramsArr[17] == "4" then
		do
			local atkEntity = FightHelper.getEntity(fightStepData.fromId)

			if atkEntity then
				atkPosX, atkPosY, atkPosZ = FightHelper.getEntityWorldCenterPos(atkEntity)
			end
		end
	elseif paramsArr[17] == "5" or paramsArr[17] == "6" then
		if paramsArr[17] == "5" then
			if not self._attacker:getSide() then
				if self._attacker:getSide() == FightEnum.EntitySide.MySide then
					local var_1_0 = FightEnum.EntitySide.EnemySide

					if not FightEnum.EntitySide.EnemySide then
						var_1_0 = FightEnum.EntitySide.MySide

						do
							local side = FightEnum.EntitySide.MySide
							local entityList = {}

							for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
								if entity:getSide() == side and entity:getTag() ~= SceneTag.UnitNpc then
									local isSub = FightDataHelper.entityMgr:isSub(entity.id)

									if not isSub then
										table.insert(entityList, entity)
									end
								end
							end

							table.sort(entityList, FightTLEventAtkFullEffect.sortByEntityX)

							local listCount = #entityList

							if listCount > 0 then
								local pos1x, pos1y, pos1z = transformhelper.getLocalPos(entityList[1].go.transform)
								local pos2x, pos2y, pos2z = transformhelper.getLocalPos(entityList[#entityList].go.transform)

								atkPosX = (pos1x + pos2x) / 2
								atkPosY = (pos1y + pos2y) / 2
								atkPosZ = (pos1z + pos2z) / 2
							else
								atkPosX = 0
								atkPosY = 0
								atkPosZ = 0
							end
						end

						local startX = atkPosX + atkOffsetX
						local startY = atkPosY + atkAffsetY
						local startZ = atkPosZ + atkAffsetZ

						if paramsArr[3] == "1" then
							local arr = string.split(paramsArr[4], ",")

							startX = arr[1] and tonumber(arr[1]) or 0

							if not self._attacker:isMySide() then
								startX = -startX
							end

							startY = arr[2] and tonumber(arr[2]) or 0
							startZ = arr[3] and tonumber(arr[3]) or 0
						end

						if flyType == 1 then
							self:_flyEffectSingle(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ)
						elseif flyType == 2 then
							self:_flyEffectTarget(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ, FightHelper.getEntityWorldCenterPos)
						elseif flyType == 3 then
							self:_flyEffectTarget(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ, false)
						elseif flyType == 4 then
							self:_flyEffectSingle(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ, true)
						elseif flyType == 5 then
							local selfPosX, selfPosY, selfPosZ = FightHelper.getProcessEntitySpinePos(self._attacker)

							defOffsetX = defOffsetX + selfPosX

							if not self._attacker:isMySide() then
								defOffsetX = -defOffsetX
							end

							defOffsetY = defOffsetY + selfPosY
							defOffsetZ = defOffsetZ + selfPosZ

							self:_flyEffectSingle(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ)
						elseif flyType == 6 then
							self:_flyEffectAbsolutely(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ)
						elseif flyType == 7 or flyType == 8 then
							if flyType == 7 then
								if not self._attacker:getSide() then
									if self._attacker:getSide() == FightEnum.EntitySide.MySide then
										local var_1_1 = FightEnum.EntitySide.EnemySide

										if not FightEnum.EntitySide.EnemySide then
											var_1_1 = FightEnum.EntitySide.MySide

											local side = FightEnum.EntitySide.MySide
											local entityList = {}

											for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
												if entity:getSide() == side and entity:getTag() ~= SceneTag.UnitNpc then
													local isSub = FightDataHelper.entityMgr:isSub(entity.id)

													if not isSub then
														table.insert(entityList, entity)
													end
												end
											end

											table.sort(entityList, FightTLEventAtkFullEffect.sortByEntityX)

											local listCount = #entityList
											local endX, endY, endZ = 0, 0, 0

											if listCount > 0 then
												local pos1x, pos1y, pos1z = transformhelper.getLocalPos(entityList[1].go.transform)
												local pos2x, pos2y, pos2z = transformhelper.getLocalPos(entityList[#entityList].go.transform)

												endX = (pos1x + pos2x) / 2
												endY = (pos1y + pos2y) / 2
												endZ = (pos1z + pos2z) / 2
											else
												endX = 0
												endY = 0
												endZ = 0
											end

											self:_flyEffectAbsolutely(startX, startY, startZ, endX + defOffsetX, endY + defOffsetY, endZ + defOffsetZ)
										end
									end
								end
							end
						else
							self:_flyEffectTarget(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ, FightHelper.getEntityHangPointPos, paramsArr[2])
						end

						local duration1 = self._duration * FightModel.instance:getSpeed()

						self._totalFrame = self.binder:GetFrameFloatByTime(duration1) - self._previousFrame - self._afterFrame
						self._startFrame = self.binder.CurFrameFloat + 1

						self:_startFly()
					end
				end
			end
		end
	end
end

function FightTLEventAtkFlyEffect:onTrackEnd()
	if self._paramsArr and self._paramsArr[18] ~= "1" then
		self:_removeEffect()
		self:_removeMover()
	end
end

function FightTLEventAtkFlyEffect:_flyEffectAbsolutely(startX, startY, startZ, endX, endY, endZ, onlyCheckEnemy)
	if self._attacker:isEnemySide() then
		endX = -endX
	end

	self:_addFlyEffect(startX, startY, startZ, endX, endY, endZ)
end

function FightTLEventAtkFlyEffect:_flyEffectSingle(startX, startY, startZ, endX, endY, endZ, onlyCheckEnemy)
	for _, actEffectData in ipairs(self._actEffect_list) do
		local can_play = FlyEffectActType[actEffectData.effectType]

		if actEffectData.effectType == FightEnum.EffectType.BUFFADD and not self.invokeBuff then
			can_play = false
		end

		if not can_play and actEffectData.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and actEffectData.effectType ~= FightEnum.EffectType.FIGHTSTEP and self._act_entity_finished and not self._act_entity_finished[actEffectData.targetId] then
			can_play = true
		end

		local oneDefender = FightHelper.getEntity(actEffectData.targetId)

		if onlyCheckEnemy then
			local fromEntity = FightHelper.getEntity(self.fightStepData.fromId)

			if fromEntity and oneDefender and fromEntity:getSide() == oneDefender:getSide() then
				can_play = false
			end
		end

		if self._onlyActOnToId and actEffectData.targetId ~= self.fightStepData.toId then
			can_play = false
		end

		if self._actSide and oneDefender and self._actSide ~= oneDefender:getSide() then
			can_play = false
		end

		if can_play and oneDefender then
			endX = oneDefender:isMySide() and -endX or endX

			self:_addFlyEffect(startX, startY, startZ, endX, endY, endZ)

			if self._act_entity_finished then
				self._act_entity_finished[oneDefender.id] = true
			end

			break
		end
	end
end

function FightTLEventAtkFlyEffect:_flyEffectTarget(startX, startY, startZ, defOffsetX, defOffsetY, defOffsetZ, endPosFunc, params)
	local invoke_list = self._actEffect_list

	for _, actEffectData in ipairs(invoke_list) do
		local can_play = FlyEffectActType[actEffectData.effectType]

		if actEffectData.effectType == FightEnum.EffectType.BUFFADD and not self.invokeBuff then
			can_play = false
		end

		if not can_play and self._act_entity_finished and not self._act_entity_finished[actEffectData.targetId] then
			can_play = true
		end

		if self._onlyActOnToId and actEffectData.targetId ~= self.fightStepData.toId then
			can_play = false
		end

		local oneDefender = FightHelper.getEntity(actEffectData.targetId)

		if self._actSide and oneDefender and self._actSide ~= oneDefender:getSide() then
			can_play = false
		end

		if can_play then
			if oneDefender then
				local getPosFunc = endPosFunc or FightHelper.getEntityWorldBottomPos
				local defPosX, defPosY, defPosZ = getPosFunc(oneDefender, params)

				if oneDefender:isMySide() then
					if not -defOffsetX then
						local offsetX = defOffsetX
						local endX = defPosX + offsetX
						local endY = defPosY + defOffsetY
						local endZ = defPosZ + defOffsetZ

						self:_addFlyEffect(startX, startY, startZ, endX, endY, endZ)

						if self._act_entity_finished then
							self._act_entity_finished[oneDefender.id] = true
						end
					end
				end
			else
				logNormal("fly effect to defender fail, entity not exist: " .. actEffectData.targetId)
			end
		end
	end
end

function FightTLEventAtkFlyEffect:_addFlyEffect(startX, startY, startZ, endX, endY, endZ)
	local effectWrap = self._attacker.effect:addGlobalEffect(self._effectName, nil, self._releaseTime)

	if self._tokenRelease then
		self._attacker.effect:addTokenRelease(self._paramsArr[23], effectWrap)
	end

	effectWrap:setWorldPos(startX, startY, startZ)

	self._flyParamDict = self._flyParamDict or {}

	local flyParam = {}

	flyParam.startX = startX
	flyParam.startY = startY
	flyParam.startZ = startZ
	flyParam.endX = endX
	flyParam.endY = endY
	flyParam.endZ = endZ
	self._flyParamDict[effectWrap.uniqueId] = flyParam
	self._attackEffectWrapList = self._attackEffectWrapList or {}

	table.insert(self._attackEffectWrapList, effectWrap)
	FightRenderOrderMgr.instance:onAddEffectWrap(self._attacker.id, effectWrap)
end

function FightTLEventAtkFlyEffect:_startFly()
	if not self._attackEffectWrapList then
		return
	end

	for i, effectWrap in ipairs(self._attackEffectWrapList) do
		local p = self._flyParamDict[effectWrap.uniqueId]

		if p then
			local startX, startY, startZ, endX, endY, endZ = p.startX, p.startY, p.startZ, p.endX, p.endY, p.endZ

			effectWrap:setWorldPos(startX, startY, startZ)

			if self._parabolaHeight then
				self:_setParabolaMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
			elseif not string.nilorempty(self._bezierParam) then
				self:_setBezierMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
			elseif not string.nilorempty(self._curveParam) then
				self:_setCurveMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
			elseif self._paramsArr[27] == "1" then
				self:moveByPosScale(effectWrap, startX, startY, startZ, endX, endY, endZ)
			else
				self:_setEaseMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
			end
		end
	end
end

function FightTLEventAtkFlyEffect:moveByPosScale(effectWrap, startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ)
	local target_obj = effectWrap.containerGO
	local paramsArr = self._paramsArr
	local x_move_cruve = paramsArr[24]
	local y_move_cruve = paramsArr[25]
	local z_move_cruve = paramsArr[26]
	local mover = MonoHelper.addLuaComOnceToGo(target_obj, UnitMoverCurve)
	local mover_handler = MonoHelper.addLuaComOnceToGo(target_obj, UnitMoverHandler)

	mover_handler:init(target_obj)
	mover_handler:addEventListeners()
	mover:setXMoveCruve(x_move_cruve)
	mover:setYMoveCruve(y_move_cruve)
	mover:setZMoveCruve(z_move_cruve)

	if not string.nilorempty(self._easeFunc) then
		mover:setEaseType(EaseType.Str2Type(self._easeFunc))
	else
		mover:setEaseType(nil)
	end

	mover:simpleMove(startPosX, startPosY, startPosZ, endPosX, endPosY, endPosZ, self._duration)
end

function FightTLEventAtkFlyEffect:_setEaseMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
	if self._withRotation == 1 then
		self:_calcRotation(effectWrap, startX, startY, startZ, endX, endY, endZ)
	end

	local mover = MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverEase)

	MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverHandler)
	mover:setEaseType(EaseType.Str2Type(self._easeFunc))
	mover:simpleMove(startX, startY, startZ, endX, endY, endZ, self._duration)

	if self._previousFrame > 0 or self._afterFrame > 0 then
		mover:setGetTimeFunction(self.getTimeFunction, self)
	end

	self._mover = mover
end

function FightTLEventAtkFlyEffect:_setParabolaMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
	local mover = MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverParabola)

	MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverHandler)
	mover:simpleMove(startX, startY, startZ, endX, endY, endZ, self._duration, self._parabolaHeight)

	if self._withRotation == 1 then
		mover:registerCallback(UnitMoveEvent.PosChanged, self._onPosChange, self)

		self._moverParamDict = self._moverParamDict or {}
		self._moverParamDict[mover] = {
			mover = mover,
			effectWrap = effectWrap,
			startX = startX,
			startY = startY,
			startZ = startZ
		}
	end

	if self._previousFrame > 0 or self._afterFrame > 0 then
		mover:setGetFrameFunction(self.getFrameFunction, self)
	end

	self._mover = mover
end

function FightTLEventAtkFlyEffect:_setBezierMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
	if self._withRotation == 1 then
		self:_calcRotation(effectWrap, startX, startY, startZ, endX, endY, endZ)
	end

	local mover = MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverBezier)

	MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverHandler)
	mover:setBezierParam(self._bezierParam)

	if not string.nilorempty(self._easeFunc) then
		mover:setEaseType(EaseType.Str2Type(self._easeFunc))
	else
		mover:setEaseType(nil)
	end

	mover:simpleMove(startX, startY, startZ, endX, endY, endZ, self._duration)

	if self._withRotation == 1 then
		-- block empty
	end

	if self._alwayForceLookForward then
		mover:registerCallback(UnitMoveEvent.PosChanged, self._onAlwayForceLookForward, self)

		self._moverParamDict = self._moverParamDict or {}
		self._moverParamDict[mover] = {
			mover = mover,
			effectWrap = effectWrap,
			startX = startX,
			startY = startY,
			startZ = startZ
		}
	end

	if self._previousFrame > 0 or self._afterFrame > 0 then
		mover:setGetTimeFunction(self.getTimeFunction, self)
	end

	self._mover = mover
end

function FightTLEventAtkFlyEffect:_setCurveMove(effectWrap, startX, startY, startZ, endX, endY, endZ)
	if self._withRotation == 1 then
		self:_calcRotation(effectWrap, startX, startY, startZ, endX, endY, endZ)
	end

	local mover = MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverCurve)

	MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverHandler)
	mover:setCurveParam(self._curveParam)
	mover:setTCurveParam(self._tCurveParam)

	if not string.nilorempty(self._easeFunc) then
		mover:setEaseType(EaseType.Str2Type(self._easeFunc))
	else
		mover:setEaseType(nil)
	end

	mover:simpleMove(startX, startY, startZ, endX, endY, endZ, self._duration)

	if self._withRotation == 1 then
		-- block empty
	end

	if self._alwayForceLookForward then
		mover:registerCallback(UnitMoveEvent.PosChanged, self._onAlwayForceLookForward, self)

		self._moverParamDict = self._moverParamDict or {}
		self._moverParamDict[mover] = {
			mover = mover,
			effectWrap = effectWrap,
			startX = startX,
			startY = startY,
			startZ = startZ
		}
	end

	if self._previousFrame > 0 or self._afterFrame > 0 then
		mover:setGetTimeFunction(self.getTimeFunction, self)
	end

	self._mover = mover
end

function FightTLEventAtkFlyEffect:_onPosChange(mover, origin_roration)
	if self._moverParamDict then
		local moverParam = self._moverParamDict[mover]

		if moverParam then
			local posX, posY, posZ = mover:getPos()
			local effectWrap = moverParam.effectWrap
			local startX = moverParam.startX
			local startY = moverParam.startY
			local startZ = moverParam.startZ

			self:_calcRotation(effectWrap, startX, startY, startZ, posX, posY, posZ, origin_roration)

			moverParam.startX = posX
			moverParam.startY = posY
			moverParam.startZ = posZ
		end
	end
end

function FightTLEventAtkFlyEffect:_onAlwayForceLookForward(mover)
	self:_onPosChange(mover, self._alwayForceLookForward)
end

function FightTLEventAtkFlyEffect:_calcRotation(effectWrap, startX, startY, startZ, endX, endY, endZ, origin_roration)
	if not self._attacker then
		return
	end

	local lookDir = FightHelper.getEffectLookDir(self._attacker:getSide())
	local lookTargetRotation = Quaternion.LookRotation(Vector3.New(endX - startX, endY - startY, endZ - startZ), Vector3.up)
	local lookDirRotation = Quaternion.AngleAxis(lookDir, Vector3.up)
	local originRotation = Quaternion.AngleAxis(origin_roration or 90, Vector3.up)

	effectWrap.containerTr.rotation = lookTargetRotation * lookDirRotation * originRotation
end

function FightTLEventAtkFlyEffect:getTimeFunction()
	if not self._attacker then
		return 1000
	end

	local binderFrame = self._attacker.skill:getCurFrameFloat()

	if not binderFrame then
		return 1000
	end

	local curFrame = binderFrame + 1 - self._startFrame

	if curFrame <= self._previousFrame then
		return 0
	end

	if self._totalFrame <= 0 then
		return self._duration
	end

	return (curFrame - self._previousFrame) / self._totalFrame * self._duration
end

function FightTLEventAtkFlyEffect:getFrameFunction()
	if not self._attacker then
		return 1000, 1, 1
	end

	local binderFrame = self._attacker.skill:getCurFrameFloat()

	if not binderFrame then
		return 1000, 1, 1
	end

	local curFrame = binderFrame + 1 - self._startFrame

	return curFrame, self._previousFrame, self._totalFrame
end

function FightTLEventAtkFlyEffect:onDestructor()
	if self._moverParamDict then
		for mover, _ in pairs(self._moverParamDict) do
			mover:unregisterCallback(UnitMoveEvent.PosChanged, self._onPosChange, self)
		end
	end

	self._moverParamDict = nil

	self:_removeEffect()
	self:_removeMover()
end

function FightTLEventAtkFlyEffect:_removeMover()
	if self._mover then
		if self._mover.setGetTimeFunction then
			self._mover:setGetTimeFunction(nil, nil)
		end

		if self._mover.setGetFrameFunction then
			self._mover:setGetFrameFunction(nil, nil)
		end

		self._mover = nil
	end

	if self._attackEffectWrapList then
		for _, effectWrap in ipairs(self._attackEffectWrapList) do
			MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverEase)
			MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverParabola)
			MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverBezier)
			MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverCurve)
			MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverHandler)
		end
	end
end

function FightTLEventAtkFlyEffect:_removeEffect()
	if self._attackEffectWrapList then
		for _, effectWrap in ipairs(self._attackEffectWrapList) do
			if (self._tokenRelease or nil) and false then
				FightRenderOrderMgr.instance:onRemoveEffectWrap(self._attacker.id, effectWrap)
				self._attacker.effect:removeEffect(effectWrap)
			end
		end

		self._attackEffectWrapList = nil
	end

	self._flyParamDict = nil
	self._attacker = nil
end

return FightTLEventAtkFlyEffect
