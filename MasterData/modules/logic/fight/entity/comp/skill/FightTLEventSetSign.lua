-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSetSign.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSetSign", package.seeall)

local FightTLEventSetSign = class("FightTLEventSetSign", FightTimelineTrackItem)

function FightTLEventSetSign:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self.duration = duration
	self.paramsArr = paramsArr

	if paramsArr[1] == "1" then
		self.workTimelineItem.skipAfterTimelineFunc = true
	end

	local param2 = paramsArr[2]

	if not string.nilorempty(param2) then
		local arr = string.split(param2, "#")
		local visible = table.remove(arr, 1)

		self:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, visible == "show", arr)
	end

	local param3 = paramsArr[3]

	if not string.nilorempty(param3) then
		local arr = string.split(param3, "#")
		local targetType = arr[1]
		local visible = arr[2]

		if targetType == "1" then
			local toId = fightStepData.toId
			local entityData = FightDataHelper.entityMgr:getById(toId)
			local isBoss = FightHelper.checkIsBossByMonsterId(entityData.modelId)

			if (lua_fight_assembled_monster.configDict[entityData.skin] or nil) and true then
				self:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, visible == "show")
			end
		end
	end

	local param4 = paramsArr[4]

	if not string.nilorempty(param4) then
		FightDataHelper.tempMgr.hideNameUIByTimeline = param4 == "hide"
	end

	if paramsArr[5] == "1" then
		fightStepData.forceShowDamageTotalFloat = true
	end

	local param6 = paramsArr[6]

	if param6 == "aiJiAoQteStart" then
		FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.AiJiAoQteIng)

		local entityList = FightHelper.getAllEntitys()

		for _, entity in ipairs(entityList) do
			if entity.nameUI then
				entity.nameUI:setActive(true)
			end
		end
	elseif param6 == "aiJiAoQteEnd" then
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	elseif param6 == "close3_7bossPlane" then
		FightMsgMgr.sendMsg(FightMsgId.Set3_7BossPlane, false)
	elseif param6 == "open3_7bossPlane" then
		FightMsgMgr.sendMsg(FightMsgId.Set3_7BossPlane, true)
	elseif param6 == "close3_7bossShieldEffect" then
		local entity

		for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
			local skin = entityData.skin

			if lua_fight_monster_3d.configDict[skin] then
				entity = FightGameMgr.entityMgr:getById(entityData.id)

				break
			end
		end

		if entity then
			local effectDic = entity.effect._playingEffectDict

			for k, effectWrap in pairs(effectDic) do
				if effectWrap.containerGO.name == "smxjdz1_c_hudun02.prefab" then
					entity.effect:removeEffect(effectWrap)
					effectWrap:setActive(false)

					local buffeffectDic = entity.buff._buffEffectDict

					for uid, buffEffect in pairs(buffeffectDic) do
						if buffEffect == effectWrap then
							buffeffectDic[uid] = nil
						end
					end

					break
				end
			end
		end
	elseif param6 == "lockMyturnCamera" then
		FightDataHelper.tempMgr.lockMyturnCamera = true
	elseif param6 == "unlockMyturnCamera" then
		FightDataHelper.tempMgr.lockMyturnCamera = false
	elseif param6 == "useFightCameraRorateWhenIdle" then
		FightMsgMgr.sendMsg(FightMsgId.SetFightCameraRorateWhenIdle, true)
	elseif param6 == "closeFightCameraRorateWhenIdle" then
		FightMsgMgr.sendMsg(FightMsgId.SetFightCameraRorateWhenIdle, false)
	elseif param6 == "Set3_7BossLayer2Unit" then
		FightMsgMgr.sendMsg(FightMsgId.Set3_7BossLayer2Unit)
	elseif param6 == "Set3_7BossLayer2Scene" then
		FightMsgMgr.sendMsg(FightMsgId.Set3_7BossLayer2Scene)
	elseif param6 == "hide3_7BossBuffEffect" then
		local entity

		for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
			local skin = entityData.skin

			if lua_fight_monster_3d.configDict[skin] then
				entity = FightGameMgr.entityMgr:getById(entityData.id)

				break
			end
		end

		if entity then
			FightMsgMgr.sendMsg(FightMsgId.Hide3_7BossBuffEffect, entity.id)
		end
	elseif param6 == "mySideHpShining" then
		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			if entity:isMySide() and entity.nameUI and entity.nameUI._hp_ani then
				entity.nameUI._hp_ani:Play("up", 0, 0)
			end
		end
	elseif param6 == "fight3_7bossqtehphit" then
		local animator = FightMsgMgr.sendMsg(FightMsgId.GetBossHpRootAnimator)

		if animator then
			animator:Play("bosshit", 0, 0)
		end

		local entity

		for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
			local skin = entityData.skin

			if lua_fight_monster_3d.configDict[skin] then
				entity = FightGameMgr.entityMgr:getById(entityData.id)

				break
			end
		end

		if entity then
			entity.nameUI:setActive(false, FightNameActiveKey.Fight3_7qteKey)
		end

		FightViewPartVisible.set()
	elseif param6 == "fight3_7bossqteend" then
		FightDataHelper.tempMgr.is3_7BossQteing = false

		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			if entity and entity.nameUI then
				entity.nameUI:setActive(true, FightNameActiveKey.Fight3_7qteKey)
			end
		end
	elseif param6 == "ndkqtestart" then
		FightDataHelper.tempMgr.isNdkQteing = true
	elseif param6 == "ndkqteend" then
		FightDataHelper.tempMgr.isNdkQteing = false
	end

	local param7 = paramsArr[7]

	if not string.nilorempty(param7) then
		FightDataHelper.tempMgr.myStanceId = tonumber(param7)

		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			if entity:isMySide() then
				entity:resetStandPos()
			end
		end
	end

	local param8 = paramsArr[8]

	if not string.nilorempty(param8) then
		local entity

		for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
			local skin = entityData.skin

			if lua_fight_monster_3d.configDict[skin] then
				entity = FightGameMgr.entityMgr:getById(entityData.id)

				break
			end
		end

		if entity and entity.spineRenderer.actorMaterialController then
			self.depthOffset = tonumber(param8)
			entity.spineRenderer.actorMaterialController.depthOffset = self.depthOffset
			self.depthEntity = entity
		end
	end
end

function FightTLEventSetSign:onTrackEnd()
	if self.workTimelineItem.skipAfterTimelineFunc then
		local skillMgr = FightSkillMgr.instance

		skillMgr._playingSkillCount = skillMgr._playingSkillCount - 1

		if skillMgr._playingSkillCount < 0 then
			skillMgr._playingSkillCount = 0
		end

		skillMgr._playingEntityId2StepData[self.fightStepData.fromId] = nil
	end

	if self.depthEntity then
		self.depthEntity.spineRenderer.actorMaterialController.depthOffset = self.depthEntity.spineRenderer.depthOffset
	end
end

function FightTLEventSetSign:onDestructor()
	return
end

return FightTLEventSetSign
