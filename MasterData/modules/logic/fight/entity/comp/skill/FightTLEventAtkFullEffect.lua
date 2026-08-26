-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAtkFullEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFullEffect", package.seeall)

local FightTLEventAtkFullEffect = class("FightTLEventAtkFullEffect", FightTimelineTrackItem)

function FightTLEventAtkFullEffect:onTrackStart(fightStepData, duration, paramsArr)
	if not FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[4]) then
		return
	end

	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not self._attacker then
		return
	end

	local token = paramsArr[10]

	if not string.nilorempty(token) then
		local entityDic = FightGameMgr.entityMgr.entityDic

		for k, v in pairs(entityDic) do
			if v.effect then
				v.effect:_onInvokeTokenRelease(token)
			end
		end

		return
	end

	local effectName = paramsArr[1]
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if paramsArr[2] then
		local arr = string.split(paramsArr[2], ",")

		offsetX = arr[1] and tonumber(arr[1]) or offsetX

		if not self._attacker:isMySide() and paramsArr[5] ~= "1" then
			offsetX = -offsetX
		end

		offsetY = arr[2] and tonumber(arr[2]) or offsetY
		offsetZ = arr[3] and tonumber(arr[3]) or offsetZ
	end

	if not string.nilorempty(paramsArr[6]) then
		local arr = GameUtil.splitString2(paramsArr[6], true)
		local fightScene = GameSceneMgr.instance:getCurScene()
		local levelId = fightScene:getCurLevelId()
		local stanceId = FightHelper.getEntityStanceId(self._attacker:getMO())

		for i, v in ipairs(arr) do
			if levelId == v[1] and stanceId == v[2] then
				offsetX = offsetX + v[3] or 0
				offsetY = offsetY + v[4] or 0
				offsetZ = offsetZ + v[5] or 0
			end
		end
	end

	if not string.nilorempty(paramsArr[7]) then
		if self._attacker:getSide() == FightEnum.EntitySide.MySide then
			if not FightEnum.EntitySide.EnemySide then
				do
					local tempSide = FightEnum.EntitySide.MySide
					local entityMO = FightDataHelper.entityMgr:getNormalList(tempSide)[1]

					if entityMO then
						local arr = GameUtil.splitString2(paramsArr[7], true)
						local fightScene = GameSceneMgr.instance:getCurScene()
						local levelId = fightScene:getCurLevelId()
						local stanceId = FightHelper.getEntityStanceId(entityMO)

						for i, v in ipairs(arr) do
							if levelId == v[1] and stanceId == v[2] then
								offsetX = offsetX + v[3] or 0
								offsetY = offsetY + v[4] or 0
								offsetZ = offsetZ + v[5] or 0
							end
						end
					end
				end

				if not string.nilorempty(paramsArr[15]) then
					if paramsArr[15] == "1" then
						if not self._attacker:getSide() then
							if self._attacker:getSide() == FightEnum.EntitySide.MySide then
								local var_1_1 = FightEnum.EntitySide.EnemySide

								if not FightEnum.EntitySide.EnemySide then
									var_1_1 = FightEnum.EntitySide.MySide

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

										table.sort(entityList, self.sortByEntityX)

										local listCount = #entityList

										if listCount > 0 then
											local pos1x, pos1y, pos1z = transformhelper.getLocalPos(entityList[1].go.transform)
											local pos2x, pos2y, pos2z = transformhelper.getLocalPos(entityList[#entityList].go.transform)
											local posX = (pos1x + pos2x) / 2
											local posY = (pos1y + pos2y) / 2
											local posZ = (pos1z + pos2z) / 2

											offsetX = posX + (side == FightEnum.EntitySide.MySide and offsetX or -offsetX)
											offsetY = posY + offsetY
											offsetZ = posZ + offsetZ
										else
											offsetX = 0 + offsetX
											offsetY = 0 + offsetY
											offsetZ = 0 + offsetZ
										end
									end

									if string.nilorempty(effectName) then
										logError("atk effect name is nil")

										goto label_1_0
									end
								end
							end
						end
					end
				end
			end
		end
	end

	self._releaseTime = nil

	if not string.nilorempty(paramsArr[11]) and paramsArr[11] ~= "0" then
		self._releaseTime = tonumber(paramsArr[11]) / FightModel.instance:getSpeed()
	end

	self._effectWrap = self._attacker.effect:addGlobalEffect(effectName, nil, self._releaseTime)

	do
		local useWorldPos = true

		if paramsArr[13] == "1" then
			local mainCamera = CameraMgr.instance:getMainCameraGO()

			gohelper.addChild(mainCamera, self._effectWrap.containerGO)

			useWorldPos = false
		end

		local order = tonumber(paramsArr[3]) or -1

		if order == -1 then
			FightRenderOrderMgr.instance:onAddEffectWrap(self._attacker.id, self._effectWrap)
		else
			FightRenderOrderMgr.instance:setEffectOrder(self._effectWrap, order)
		end

		if useWorldPos then
			self._effectWrap:setWorldPos(offsetX, offsetY, offsetZ)
		else
			self._effectWrap:setLocalPos(offsetX, offsetY, offsetZ)
		end

		self._releaseByServer = tonumber(paramsArr[8])

		if self._releaseByServer then
			self._attacker.effect:addServerRelease(self._releaseByServer, self._effectWrap)
		end

		self._tokenRelease = not string.nilorempty(paramsArr[9])

		if self._tokenRelease then
			self._attacker.effect:addTokenRelease(paramsArr[9], self._effectWrap)
		end

		self._roundRelease = not string.nilorempty(paramsArr[12])

		if self._roundRelease then
			self._attacker.effect:addRoundRelease(tonumber(paramsArr[12]), self._effectWrap)
		end
	end

	::label_1_0::

	local audioId = tonumber(paramsArr[14])

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightTLEventAtkFullEffect:onTrackEnd()
	self:_removeEffect()
end

function FightTLEventAtkFullEffect:onDestructor()
	self:_removeEffect()
end

function FightTLEventAtkFullEffect:_removeEffect()
	local canRelease = not self._releaseByServer

	if self._tokenRelease then
		canRelease = false
	end

	if self._releaseTime then
		canRelease = false
	end

	if (self._roundRelease or nil) and false and self._effectWrap then
		self._attacker.effect:removeEffect(self._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._attacker.id, self._effectWrap)
	end

	self._effectWrap = nil
	self._attacker = nil
end

function FightTLEventAtkFullEffect.sortByEntityX(a, b)
	local x1 = transformhelper.getLocalPos(a.go.transform)
	local x2 = transformhelper.getLocalPos(b.go.transform)

	return x1 < x2
end

return FightTLEventAtkFullEffect
