-- chunkname: @modules/logic/fight/entity/comp/FightBuffComp.lua

module("modules.logic.fight.entity.comp.FightBuffComp", package.seeall)

local FightBuffComp = class("FightBuffComp", FightBaseClass)
local BuffTypeHandlerCls = {
	[FightEnum.BuffType_Petrified] = FightBuffFrozen,
	[FightEnum.BuffType_Frozen] = FightBuffFrozen,
	[FightEnum.BuffType_ExPointOverflowBank] = FightBuffStoredExPoint,
	[FightEnum.BuffType_ContractBuff] = FightBuffContractBuff,
	[FightEnum.BuffType_BeContractedBuff] = FightBuffBeContractedBuff,
	[FightEnum.BuffType_CardAreaRedOrBlue] = FightBuffCardAreaRedOrBlueBuff,
	[FightEnum.BuffType_RedOrBlueCount] = FightBuffRedOrBlueCountBuff,
	[FightEnum.BuffType_RedOrBlueChangeTrigger] = FightBuffRedOrBlueChangeTriggerBuff,
	[FightEnum.BuffType_SaveFightRecord] = FightBuffSaveFightRecord,
	[FightEnum.BuffType_SubBuff] = FightBuffSubBuff,
	[FightEnum.BuffType_AddCardRecordByRound] = FightBuffRecordByRound,
	[FightEnum.BuffType_AddCardCastChannel] = FightBuffAddCardContinueChannel,
	[FightEnum.BuffType_LockHpMax] = FightBuffLockHpComp
}
local BuffIdHandlerCls = {
	[31080132] = FightBuffAddBKLESpBuff,
	[31080134] = FightBuffAddBKLESpBuff,
	[106315001] = FightBuffAddScaleOffset
}
local buffTypeIdHandCls = {
	[FightEnum.BuffTypeId_CoverPerson] = FightBuffCoverPerson,
	[31070111] = FightBuffSpecialCountCastBuff,
	[31070121] = FightBuffSpecialCountCastBuff,
	[900045418] = FightBuffWELXStarComp
}

function FightBuffComp:onConstructor(entity)
	self._entity = entity
	self._animPriorityQueue = PriorityQueue.New(FightBuffComp.buffCompareFuncAni)
	self._matPriorityQueue = PriorityQueue.New(FightBuffComp.buffCompareFuncMat)
	self._buffEffectDict = {}
	self._loopBuffEffectWrapDict = {}
	self._buffHandlerDict = {}
	self._buff_loop_effect_name = {}
	self._curBuffIdDic = {}
	self._addBuffEffectPathDic = {}
	self._curBuffTypeIdDic = {}
	self._buffDic = {}
	self.skinBuffEffectMgr = self:newClass(FightEntitySkinBuffEffectMgr)
	self.buffMgr = self:newClass(FightEntityBuffMgr)

	self:registSkinBuffEffect()
	self:com_registFightEvent(FightEvent.CoverPerformanceEntityData, self._onCoverPerformanceEntityData)
	self:registClasses()
	self:com_registMsg(FightMsgId.Hide3_7BossBuffEffect, self.onHide3_7BossBuffEffect)
end

function FightBuffComp:dealStartBuff()
	local entityMO = self._entity:getMO()

	if entityMO then
		self.filter_start_buff_stacked = {}

		for _, buffMO in pairs(entityMO:getBuffDic()) do
			self:addBuff(buffMO, true)
		end

		self.filter_start_buff_stacked = nil
	end

	self._entity:resetAnimState()
end

function FightBuffComp.buffCompareFuncAni(buffMO1, buffMO2)
	local buffCO1 = lua_skill_buff.configDict[buffMO1.buffId]
	local buffCO2 = lua_skill_buff.configDict[buffMO2.buffId]

	if not buffCO1 then
		logError("buff表找不到id:" .. buffMO1.buffId)
	end

	if not buffCO2 then
		logError("buff表找不到id:" .. buffMO2.buffId)
	end

	local buffTypeConfig1 = lua_skill_bufftype.configDict[buffCO1.typeId]
	local buffTypeConfig2 = lua_skill_bufftype.configDict[buffCO2.typeId]

	if not buffTypeConfig1 then
		logError("buff类表找不到id:" .. buffCO1.typeId)
	end

	if not buffTypeConfig2 then
		logError("buff类表找不到id:" .. buffCO2.typeId)
	end

	local priority1 = lua_skill_bufftype.configDict[buffCO1.typeId].aniSort
	local priority2 = lua_skill_bufftype.configDict[buffCO2.typeId].aniSort

	if priority1 ~= priority2 then
		return priority2 < priority1
	end

	if priority1 == 0 and priority2 == 0 then
		local has_act1 = not string.nilorempty(buffCO1.animationName) and buffCO1.animationName ~= "0"
		local has_act2 = not string.nilorempty(buffCO2.animationName) and buffCO2.animationName ~= "0"

		if has_act1 and not has_act2 then
			return true
		elseif not has_act1 and has_act2 then
			return false
		end
	end

	if buffMO1.time ~= buffMO2.time then
		return buffMO1.time > buffMO2.time
	end

	return buffMO1.id > buffMO2.id
end

function FightBuffComp.buffCompareFuncMat(buffMO1, buffMO2)
	local buffCO1 = lua_skill_buff.configDict[buffMO1.buffId]
	local buffCO2 = lua_skill_buff.configDict[buffMO2.buffId]
	local priority1 = lua_skill_bufftype.configDict[buffCO1.typeId].matSort
	local priority2 = lua_skill_bufftype.configDict[buffCO2.typeId].matSort

	if priority1 ~= priority2 then
		return priority2 < priority1
	end

	if priority1 == 0 and priority2 == 0 then
		local has_mat1 = not FightBuffComp.isEmptyMat(buffCO1.mat)
		local has_mat2 = not FightBuffComp.isEmptyMat(buffCO2.mat)

		if has_mat1 and not has_mat2 then
			return true
		elseif not has_mat1 and has_mat2 then
			return false
		end
	end

	if buffMO1.time ~= buffMO2.time then
		return buffMO1.time > buffMO2.time
	end

	return buffMO1.id > buffMO2.id
end

function FightBuffComp:haveBuffId(buffId)
	return self._curBuffIdDic[buffId] and self._curBuffIdDic[buffId] > 0
end

function FightBuffComp:haveBuffTypeId(buffId)
	return self._curBuffTypeIdDic[buffId] and self._curBuffTypeIdDic[buffId] > 0
end

function FightBuffComp:addBuff(buff, dontPlayOnceEffect, stepUid)
	local isLayerSalveHalo = buff.type == FightEnum.BuffType.LayerSalveHalo

	if isLayerSalveHalo then
		return
	end

	self._buffDic[buff.uid] = buff

	self:_showBuffFloat(buff)

	local buffCO = lua_skill_buff.configDict[buff.buffId]

	if not buffCO then
		return
	end

	self._curBuffIdDic[buffCO.id] = (self._curBuffIdDic[buffCO.id] or 0) + 1
	self._curBuffTypeIdDic[buffCO.typeId] = (self._curBuffTypeIdDic[buffCO.typeId] or 0) + 1

	self._animPriorityQueue:add(buff)
	self._matPriorityQueue:add(buff)
	self:_addBuffHandler(buff)

	local hasPlayBuffEffect = FightSkillBuffMgr.instance:hasPlayBuffEffect(self._entity.id, buff, stepUid)
	local needPlayOnceEffect = buffCO.effectloop ~= 0 or not dontPlayOnceEffect
	local buffEffectNamePath
	local buffEffectPath, audioId, changedHangPoint, effectDuration = FightHelper.processBuffEffectPath(buffCO.effect, self._entity, buff.buffId, "effectPath", buffCO.audio, buff)

	buffEffectPath, audioId = FightHelper.filterBuffEffectBySkin(buff.buffId, self._entity, buffEffectPath, audioId)

	if audioId > 0 and not AudioEffectMgr.instance:isPlaying(audioId) then
		AudioEffectMgr.instance:playAudio(audioId)
	end

	local hasBuffEffect = buffEffectPath ~= "0" and not string.nilorempty(buffEffectPath)

	if hasBuffEffect then
		local isPath = string.find(buffEffectPath, "/")

		buffEffectNamePath = isPath and buffEffectPath or "buff/" .. buffEffectPath
	end

	local effectFullPath = FightHelper.getEffectUrlWithLod(buffEffectNamePath)
	local isPlayingEffect = self._entity.effect:getEffectWrap(buffEffectNamePath) and self._addBuffEffectPathDic[effectFullPath]

	if not hasPlayBuffEffect and hasBuffEffect and needPlayOnceEffect then
		if not isPlayingEffect then
			self._addBuffEffectPathDic[effectFullPath] = true

			local effectWrap
			local hangPoint = buffCO.effectHangPoint

			if not string.nilorempty(changedHangPoint) then
				hangPoint = changedHangPoint
			end

			if not string.nilorempty(hangPoint) then
				effectWrap = self._entity.effect:addHangEffect(buffEffectNamePath, hangPoint)

				effectWrap:setLocalPos(0, 0, 0)

				if hangPoint == ModuleEnum.SpineHangPointRoot then
					effectWrap:setLocalPos(FightHelper.getAssembledEffectPosOfSpineHangPointRoot(self._entity, buffEffectNamePath))
				end
			else
				effectWrap = self._entity.effect:addGlobalEffect(buffEffectNamePath)

				local posX, posY, posZ = transformhelper.getPos(self._entity.go.transform)

				effectWrap:setWorldPos(posX, posY, posZ)
			end

			FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

			self._buffEffectDict[buff.uid] = effectWrap

			if buffCO.effectloop == 0 then
				local param = {
					uid = buff.uid,
					effectWrap = effectWrap
				}

				self:com_registTimer(self.removeOnceEffect, effectDuration or 2, param)
			end
		elseif buffCO.effectloop ~= 0 then
			for i, v in pairs(self._buffEffectDict) do
				if v.path == effectFullPath then
					self._buffEffectDict[buff.uid] = v

					break
				end
			end
		end

		if buffCO.effectloop ~= 0 then
			self._buff_loop_effect_name[effectFullPath] = (self._buff_loop_effect_name[effectFullPath] or 0) + 1
		end
	end

	local isAnimationNil = string.nilorempty(buffCO.animationName) or buffCO.animationName == "0"
	local isMatNil = FightBuffComp.isEmptyMat(buffCO.mat)
	local isBloomMatNil = string.nilorempty(buffCO.bloommat) or buffCO.bloommat == "0"

	if not isAnimationNil or not isMatNil or not isBloomMatNil then
		if not isAnimationNil then
			self._entity:resetAnimState()
		end

		self._entity:resetSpineMat()
		FightGameMgr.bloomMgr:setSingleEntityPass(buffCO.bloommat, true, self._entity, "buff_bloom")
		self:_udpateBuffVariant()
	end

	FightGameMgr.specialSceneEffectMgr:addBuff(self._entity, buff)
	FightController.instance:dispatchEvent(FightEvent.AddEntityBuff, self._entity.id, buff)
	self.buffMgr:addBuff(buff)
end

function FightBuffComp:addLoopBuff(effectWrap)
	if not effectWrap then
		return
	end

	if self._loopBuffEffectWrapDict then
		self._loopBuffEffectWrapDict[effectWrap.uniqueId] = effectWrap
	end
end

function FightBuffComp:removeLoopBuff(effectWrap)
	if not effectWrap then
		return
	end

	if self._loopBuffEffectWrapDict then
		self._loopBuffEffectWrapDict[effectWrap.uniqueId] = nil
	end
end

function FightBuffComp:_addBuffHandler(buff)
	local buffCO = lua_skill_buff.configDict[buff.buffId]

	if not buffCO then
		return
	end

	local buffHandlerKey
	local buffFeatures = FightConfig.instance:getBuffFeatures(buffCO.id)

	for k, v in pairs(buffFeatures) do
		if BuffTypeHandlerCls[k] then
			buffHandlerKey = k

			local typeCls = BuffTypeHandlerCls[k]
			local buffHandler = FightBuffHandlerPool.getHandlerInst(buffHandlerKey, typeCls)

			if buffHandler then
				self._buffHandlerDict[buff.uid] = buffHandler

				buffHandler:onBuffStart(self._entity, buff)
			end

			break
		end
	end

	if BuffIdHandlerCls[buff.buffId] then
		local typeCls = BuffIdHandlerCls[buff.buffId]
		local buffHandler = FightBuffHandlerPool.getHandlerInst(buff.buffId, typeCls)

		if buffHandler then
			self._buffHandlerDict[buff.uid] = buffHandler

			buffHandler:onBuffStart(self._entity, buff)
		end
	end

	local buffTypeCO = lua_skill_bufftype.configDict[buffCO.typeId]
	local buffTypeId = buffTypeCO and buffTypeCO.id

	if buffTypeId and buffTypeIdHandCls[buffTypeId] then
		local typeCls = buffTypeIdHandCls[buffTypeId]
		local buffHandler = FightBuffHandlerPool.getHandlerInst(buffTypeId, typeCls)

		if buffHandler then
			self._buffHandlerDict[buff.uid] = buffHandler

			buffHandler:onBuffStart(self._entity, buff)
		end
	end
end

function FightBuffComp:_removeBuffHandler(uid)
	local buffHandler = self._buffHandlerDict[uid]

	if buffHandler then
		self._buffHandlerDict[uid] = nil

		buffHandler:onBuffEnd()
		FightBuffHandlerPool.putHandlerInst(buffHandler)
	end
end

function FightBuffComp:updateBuff(buff, oldMO, actEffectData)
	local buffHandler = self._buffHandlerDict[buff.uid]

	if buffHandler and buffHandler.onBuffUpdate then
		buffHandler:onBuffUpdate(buff)
	end

	local isLayerSalveHalo = buff.type == FightEnum.BuffType.LayerSalveHalo

	if isLayerSalveHalo then
		return
	end

	local hasPlayBuff = FightSkillBuffMgr.instance:hasPlayBuff(actEffectData)

	if not hasPlayBuff and (buff.duration > oldMO.duration or buff.count > oldMO.count or buff.layer > oldMO.layer) then
		self:_showBuffFloat(buff)
	end

	self.buffMgr:updateBuff(buff)
end

FightBuffComp.InVisibleColorDict = {
	["1"] = {
		Color.New(0.55, 0.69, 0.71, 0),
		Color.New(2.7, 6, 14.25, 0)
	},
	["2"] = {
		Color.New(0.71, 0.59, 0.55, 0),
		Color.New(13.5, 9, 9, 0)
	},
	["3"] = {
		Color.New(0.7, 0.7, 0.7, 0),
		Color.New(4.5, 4.5, 4.5, 0)
	},
	["4"] = {
		Color.New(0.68, 0.68, 0.68, 0),
		Color.New(0, 0, 0, 1)
	}
}

function FightBuffComp:_udpateBuffVariant()
	local hasInvisibleEffect
	local spineMat = self._entity.spineRenderer:getReplaceMat()

	if not spineMat then
		return
	end

	local buffDic = self._entity:getMO():getBuffDic()

	for _, oneMO in pairs(buffDic) do
		local buffCO = lua_skill_buff.configDict[oneMO.buffId]

		if buffCO then
			local bloomMatParam = buffCO.bloommat
			local bloommat = string.sub(bloomMatParam, 1, #bloomMatParam - 1)

			if bloommat == FightBloomMgr.Bloom_invisible then
				hasInvisibleEffect = string.sub(bloomMatParam, #bloomMatParam)
			end
		end
	end

	if hasInvisibleEffect then
		local color0, color1
		local side = self._entity:isMySide() and -1 or 1
		local colorList = FightBuffComp.InVisibleColorDict[hasInvisibleEffect]

		if colorList then
			color0 = colorList[1]
			color1 = colorList[2]
			color0.a = side
		end

		if color0 then
			FightGameMgr.bloomMgr:setSingleEntityPass(FightBloomMgr.Bloom_invisible, true, self._entity, "buff_bloom")
			spineMat:SetColor(UnityEngine.Shader.PropertyToID("_InvisibleColor"), color0)
			spineMat:SetColor(UnityEngine.Shader.PropertyToID("_InvisibleColor1"), color1)
		end
	else
		FightGameMgr.bloomMgr:setSingleEntityPass(FightBloomMgr.Bloom_invisible, false, self._entity, "buff_bloom")
	end
end

function FightBuffComp:removeOnceEffect(param)
	local uid = param.uid
	local effectWrap = param.effectWrap

	self._entity.effect:removeEffect(effectWrap)

	self._buffEffectDict[uid] = nil
	self._addBuffEffectPathDic[effectWrap.path] = nil
end

function FightBuffComp:showBuffEffects(nonActiveKey)
	for _, effectWrap in pairs(self._buffEffectDict) do
		effectWrap:setActive(true, nonActiveKey)
	end

	for _, effectWrap in pairs(self._loopBuffEffectWrapDict) do
		effectWrap:setActive(true, nonActiveKey)
	end

	FightGameMgr.specialSceneEffectMgr:setBuffEffectVisible(self._entity, true)
	FightController.instance:dispatchEvent(FightEvent.SetBuffEffectVisible, self._entity.id, true)
end

function FightBuffComp:hideBuffEffects(nonActiveKey)
	for _, effectWrap in pairs(self._buffEffectDict) do
		effectWrap:setActive(false, nonActiveKey)
	end

	for _, effectWrap in pairs(self._loopBuffEffectWrapDict) do
		effectWrap:setActive(false, nonActiveKey)
	end

	FightGameMgr.specialSceneEffectMgr:setBuffEffectVisible(self._entity, false)
	FightController.instance:dispatchEvent(FightEvent.SetBuffEffectVisible, self._entity.id, false)
end

function FightBuffComp:onHide3_7BossBuffEffect(entityId)
	if entityId ~= self._entity.id then
		return
	end

	for _, effectWrap in pairs(self._buffEffectDict) do
		effectWrap:setActive(false)
	end

	for _, effectWrap in pairs(self._loopBuffEffectWrapDict) do
		effectWrap:setActive(false)
	end
end

function FightBuffComp:hideLoopEffects(nonActiveKey)
	local entityMO = self._entity:getMO()

	if not entityMO then
		return
	end

	for buffUid, effectWrap in pairs(self._buffEffectDict) do
		local buffMO = entityMO:getBuffMO(buffUid)
		local buffCO = buffMO and lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			local buffTypeConfig = lua_skill_bufftype.configDict[buffCO.typeId]

			if buffMO and buffCO.effectloop == 1 and buffTypeConfig.playEffect == 0 then
				effectWrap:setActive(false, nonActiveKey)
			end
		elseif buffMO then
			logError("buff表找不到id:" .. buffMO.buffId)
		end
	end

	for _, effectWrap in pairs(self._loopBuffEffectWrapDict) do
		effectWrap:setActive(false, nonActiveKey)
	end
end

function FightBuffComp:_showBuffFloat(buff)
	if self.lockFloat then
		return
	end

	if buff.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	local buffCO = lua_skill_buff.configDict[buff.buffId]

	if buffCO then
		if self.filter_start_buff_stacked and FightSkillBuffMgr.instance:buffIsStackerBuff(buffCO) then
			if self.filter_start_buff_stacked[buff.buffId] then
				return
			else
				self.filter_start_buff_stacked[buff.buffId] = true
			end
		end

		local buffTypeCO = lua_skill_bufftype.configDict[buffCO.typeId]

		if buffTypeCO and buffTypeCO.dontShowFloat ~= 0 then
			local show_content = buffCO.name

			if FightSkillBuffMgr.instance:buffIsStackerBuff(buffCO) and buffTypeCO.takeStage == -1 then
				local stacked_count = FightSkillBuffMgr.instance:getStackedCount(self._entity.id, buff)

				show_content = show_content .. luaLang("multiple") .. stacked_count
			end

			FightFloatMgr.instance:float(buff.entityId, FightEnum.FloatType.buff, show_content, buffTypeCO.dontShowFloat, false)
		end
	end
end

function FightBuffComp:_onCoverPerformanceEntityData(entityId)
	if self._entity and self._entity.id == entityId and self._buffDic then
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if entityMO then
			for buffUid, v in pairs(self._buffDic) do
				if not entityMO.buffDic[buffUid] then
					self:delBuff(buffUid)
				end
			end

			for k, v in pairs(entityMO.buffDic) do
				if not self._buffDic[k] then
					self:addBuff(v, true)
				end
			end
		end
	end
end

local filterRemoveEffectWhenDead = {
	[4150003] = true
}

function FightBuffComp:delBuff(buffUid, isDead)
	if not self._buffDic then
		return
	end

	local buffMO = self._buffDic[buffUid]

	if not buffMO then
		return
	end

	self._buffDic[buffUid] = nil

	local isLayerSalveHalo = buffMO.type == FightEnum.BuffType.LayerSalveHalo

	if isLayerSalveHalo then
		return
	end

	local uid = buffMO.uid
	local buffCO = lua_skill_buff.configDict[buffMO.buffId]

	if buffCO then
		if self._curBuffIdDic[buffCO.id] then
			self._curBuffIdDic[buffCO.id] = self._curBuffIdDic[buffCO.id] - 1
		end

		if self._curBuffTypeIdDic[buffCO.typeId] then
			self._curBuffTypeIdDic[buffCO.typeId] = self._curBuffTypeIdDic[buffCO.typeId] - 1
		end

		local function markRemvoeFunc(data)
			return data.id == buffMO.id
		end

		local oldCount = self._animPriorityQueue:getSize()

		self._animPriorityQueue:markRemove(markRemvoeFunc)
		self._matPriorityQueue:markRemove(markRemvoeFunc)

		if buffCO.effect ~= "0" and not string.nilorempty(buffCO.effect) then
			local effectWrap = self._buffEffectDict[uid]

			if effectWrap then
				self._buffEffectDict[uid] = nil

				if self._buff_loop_effect_name[effectWrap.path] then
					self._buff_loop_effect_name[effectWrap.path] = self._buff_loop_effect_name[effectWrap.path] - 1
				end

				if not self._buff_loop_effect_name[effectWrap.path] then
					local reference_count = 0

					if reference_count == 0 then
						self._addBuffEffectPathDic[effectWrap.path] = nil

						local hasDelAnimator = false

						if not string.nilorempty(buffCO.delAnimator) and not self.IS_DISPOSED then
							hasDelAnimator = true

							local arr = string.split(buffCO.delAnimator, "#")
							local delEffectFlow = self:com_registFlowSequence()

							if not gohelper.isNil(effectWrap.effectGO) then
								local obj = gohelper.findChild(effectWrap.effectGO, arr[1])

								if obj then
									delEffectFlow:registWork(FightWorkPlayAnimator, obj, arr[2])
									delEffectFlow:registFinishCallback(self.removeEffectAfterDelAnimator, self, effectWrap)
									delEffectFlow:start()
								end
							end
						end

						if not hasDelAnimator then
							self._entity.effect:removeEffect(effectWrap)
							FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
						end
					end
				end
			end
		end

		local cur_scene = GameSceneMgr.instance:getCurScene()
		local tar_entity = FightGameMgr.entityMgr:getEntity(self._entity.id)
		local buffId = buffCO.id
		local effectPath, audioId, changedHangPoint, effectDuration = FightHelper.processBuffEffectPath(buffCO.delEffect, self._entity, buffId, "delEffect", buffCO.delAudio, buffMO)

		effectPath, audioId = FightHelper.filterBuffEffectBySkin(buffId, self._entity, effectPath, audioId)

		if audioId > 0 then
			FightAudioMgr.instance:playAudio(audioId)
		end

		if tar_entity and effectPath ~= "0" and not string.nilorempty(effectPath) and tar_entity == self._entity then
			if (not tar_entity:__isActive() or nil) and false then
				local effectWrap
				local isPath = string.find(effectPath, "/")

				if isPath then
					-- block empty
				else
					effectPath = "buff/" .. effectPath
				end

				local hangPoint = changedHangPoint

				if not string.nilorempty(hangPoint) then
					hangPoint = buffCO.delEffectHangPoint
				end

				if not string.nilorempty(hangPoint) then
					effectWrap = self._entity.effect:addHangEffect(effectPath, hangPoint)

					effectWrap:setLocalPos(0, 0, 0)

					if hangPoint == ModuleEnum.SpineHangPointRoot then
						effectWrap:setLocalPos(FightHelper.getAssembledEffectPosOfSpineHangPointRoot(self._entity, effectPath))
					end
				else
					effectWrap = self._entity.effect:addGlobalEffect(effectPath)

					local posX, posY, posZ = transformhelper.getPos(self._entity.go.transform)

					effectWrap:setWorldPos(posX, posY, posZ)
				end

				FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
				self:com_registTimer(self.removeOnceEffect, effectDuration or 2, {
					uid = uid,
					effectWrap = effectWrap
				})
			end
		end

		self:_removeBuffHandler(uid)

		local isAnimationNil = string.nilorempty(buffCO.animationName) or buffCO.animationName == "0"
		local isMatNil = FightBuffComp.isEmptyMat(buffCO.mat)
		local isBloomMatNil = string.nilorempty(buffCO.bloommat) or buffCO.bloommat == "0"

		if not isAnimationNil or not isMatNil or not isBloomMatNil then
			self._entity:resetAnimState()
			self._entity:resetSpineMat()
			FightGameMgr.bloomMgr:setSingleEntityPass(buffCO.bloommat, false, self._entity, "buff_bloom")
			self:_udpateBuffVariant()
		end
	end

	FightGameMgr.specialSceneEffectMgr:delBuff(self._entity, buffMO)
	FightController.instance:dispatchEvent(FightEvent.RemoveEntityBuff, self._entity.id, buffMO)
	self.buffMgr:removeBuff(buffMO.uid)
end

function FightBuffComp:removeEffectAfterDelAnimator(effectWrap)
	self._entity.effect:removeEffect(effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
end

function FightBuffComp:getBuffAnim()
	local buffMO = self._animPriorityQueue:getFirst()

	if buffMO then
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			local isAnimationNil = string.nilorempty(buffCO.animationName) or buffCO.animationName == "0"

			if not isAnimationNil then
				return buffCO.animationName, buffMO
			end
		end
	end
end

function FightBuffComp:getBuffMatName()
	local buffMO = self._matPriorityQueue:getFirst()

	if buffMO then
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO and not FightBuffComp.isEmptyMat(buffCO.mat) then
			return buffCO.mat, buffMO
		end
	end
end

function FightBuffComp.isEmptyMat(matName)
	return matName == nil or matName == "" or matName == "0" or matName == "buff_immune"
end

function FightBuffComp:releaseAllBuff()
	if self._buffDic then
		for k, v in pairs(self._buffDic) do
			self:delBuff(v.uid)
		end
	end
end

function FightBuffComp:onDestructor()
	for _, handler in pairs(self._buffHandlerDict) do
		FightBuffHandlerPool.putHandlerInst(handler)
	end

	local entityMO = self._entity:getMO()

	if entityMO then
		for _, buffMO in pairs(entityMO:getBuffDic()) do
			self:delBuff(buffMO.uid)
		end
	end

	FightGameMgr.specialSceneEffectMgr:clearEffect(self._entity)
end

function FightBuffComp:registSkinBuffEffect()
	local entityData = FightDataHelper.entityMgr:getById(self._entity.id)

	if not entityData then
		return
	end

	local skinBuffEffectMgr = self.skinBuffEffectMgr
	local skinId = entityData.skin
	local skinConfig = lua_skin.configDict[skinId]

	if skinConfig then
		local dianJiShiConfig = lua_fight_dian_ji_shi_buff_effect.configDict[skinId]

		if not dianJiShiConfig and skinConfig.characterId == 3140 then
			dianJiShiConfig = lua_fight_dian_ji_shi_buff_effect.configDict[0]
		end

		if dianJiShiConfig then
			self:newClass(FightBuffDianJiShiEffect, self._entity, entityData, dianJiShiConfig)
		end
	end

	local luxiUpgradeEffectConfig = lua_fight_luxi_upgrade_effect.configDict[skinId]

	if luxiUpgradeEffectConfig then
		skinBuffEffectMgr:newClass(FightBuffLuXiUpgradeEffect, self._entity, entityData, luxiUpgradeEffectConfig)
	end

	local zongMaoBossStageBuffIdEffectConfig = lua_zongmao_boss_stage_buffid_effect.configDict[skinId]

	if zongMaoBossStageBuffIdEffectConfig then
		self.buffMgr:newClass(FightZongMaoBossStageBuffIdEffect, self._entity, entityData, zongMaoBossStageBuffIdEffectConfig)
	end
end

function FightBuffComp:registClasses()
	local entityData = FightDataHelper.entityMgr:getById(self._entity.id)

	if not entityData then
		return
	end

	if entityData.modelId == 3023 then
		self:newClass(FightBuffShiXiHangShiPenEffect, self._entity)
	end

	local skin = entityData.skin

	if lua_fight_ya_mi_hu_ti_effect.configDict[skin] then
		self:newClass(FightBuffYaMiHuTiEffect, self._entity)
	end

	self:newClass(FightNarcissusImmunityEffect, self._entity)
end

return FightBuffComp
