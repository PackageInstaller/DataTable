-- chunkname: @modules/logic/fight/view/FightPlayerOperateMgr.lua

module("modules.logic.fight.view.FightPlayerOperateMgr", package.seeall)

local FightPlayerOperateMgr = class("FightPlayerOperateMgr", FightBaseView)

function FightPlayerOperateMgr:onInitView()
	return
end

function FightPlayerOperateMgr:addEvents()
	return
end

function FightPlayerOperateMgr:removeEvents()
	return
end

function FightPlayerOperateMgr:_onRoundSequenceFinish()
	self:checkNeedPlayerOperate()
end

function FightPlayerOperateMgr:_onClothSkillRoundSequenceFinish()
	self:checkNeedPlayerOperate()
end

function FightPlayerOperateMgr:_onStartSequenceFinish()
	self:checkNeedPlayerOperate()

	if self.aiJiAoToId then
		FightDataHelper.tempMgr.aiJiAoFakeHpOffset = {}

		FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(self.aiJiAoToId, self.aiJiAoTotalDamage)
		FightController.instance:dispatchEvent(FightEvent.AiJiAoFakeDecreaseHp, self.aiJiAoToId)

		self.aiJiAoToId = nil
		self.aiJiAoTotalDamage = nil
	end
end

function FightPlayerOperateMgr:checkNeedPlayerOperate()
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if self:checkAiJiAoQte() then
		return
	else
		FightDataHelper.tempMgr.aiJiAoFakeHpOffset = {}
		FightDataHelper.tempMgr.aiJiAoQteCount = 0
		FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = 0

		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	end

	if self:_checkChangeHeroNeedUseSkill() then
		return
	end

	if self:_checkBindContract() then
		return
	end

	self:_checkHeroUpgrade()

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkGuideAfterPlay)
	flow:registWork(FightWorkFunction, self.showUIPart, self)
	flow:start()
end

function FightPlayerOperateMgr:showUIPart()
	if not FightModel.instance:isFinish() then
		FightViewPartVisible.set(true, true, true, false, false)
	end
end

function FightPlayerOperateMgr.sortEntity(item1, item2)
	local entityMO1 = item1:getMO()
	local entityMO2 = item2:getMO()

	if entityMO1 and entityMO2 then
		return entityMO1.position < entityMO2.position
	end

	return false
end

function FightPlayerOperateMgr:_checkHeroUpgrade()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	local upgradeDataList = FightPlayerOperateMgr.detectUpgrade()

	if #upgradeDataList > 0 then
		for i = #upgradeDataList, 1, -1 do
			local data = upgradeDataList[i]
			local config = lua_hero_upgrade.configDict[data.id]

			if config.type == 1 then
				FightRpc.instance:sendUseClothSkillRequest(data.id, data.entityId, data.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
				table.remove(upgradeDataList, i)
			end
		end

		if #upgradeDataList > 0 then
			self._upgradeDataList = upgradeDataList

			ViewMgr.instance:openView(ViewName.FightSkillStrengthenView, upgradeDataList)
		end
	end
end

function FightPlayerOperateMgr.detectUpgrade()
	if FightModel.instance:isFinish() then
		return {}
	end

	local upgradeDataList = {}
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

	table.sort(entityList, FightPlayerOperateMgr.sortEntity)

	for i, v in ipairs(entityList) do
		local entityMO = v:getMO()

		if entityMO and entityMO.canUpgradeIds and tabletool.len(entityMO.canUpgradeIds) > 0 then
			for index, id in pairs(entityMO.canUpgradeIds) do
				local config = lua_hero_upgrade.configDict[id]

				if config then
					local optionIds = {}
					local options = string.splitToNumber(config.options, "#")

					for k, optionId in ipairs(options) do
						if not entityMO.upgradedOptions[optionId] then
							table.insert(optionIds, optionId)
						end
					end

					if #optionIds > 0 then
						local data = {}

						data.id = id
						data.entityId = entityMO.id
						data.optionIds = optionIds

						table.insert(upgradeDataList, data)
					end
				end
			end
		end
	end

	return upgradeDataList
end

function FightPlayerOperateMgr:_checkChangeHeroNeedUseSkill()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Season2AutoChangeHero) then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	local roundData = FightDataHelper.roundMgr:getRoundData()

	if not roundData then
		return
	end

	local tarEntityMO = FightDataHelper.entityMgr:getById(roundData.lastChangeHeroUid)

	if not tarEntityMO then
		return
	end

	local skillConfig = lua_skill.configDict[tarEntityMO.exSkill]

	if not skillConfig then
		return
	end

	if FightEnum.ShowLogicTargetView[skillConfig.logicTarget] and skillConfig.targetLimit == FightEnum.TargetLimit.MySide then
		local mySideList = FightDataHelper.entityMgr:getMyNormalList()
		local mySideSpList = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
		local mySideEntityCount = #mySideList + #mySideSpList

		if mySideEntityCount == 0 then
			return
		end
	end

	ViewMgr.instance:openView(ViewName.FightChangeHeroSelectSkillTargetView, {
		skillConfig = skillConfig,
		fromId = tarEntityMO.id
	})

	return true
end

function FightPlayerOperateMgr:_checkBindContract()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		logNormal("打开娜娜锲约界面，但是还在指引ing")

		return
	end

	local notifyEntityId = FightModel.instance.notifyEntityId

	if string.nilorempty(notifyEntityId) then
		return
	end

	local entity = FightHelper.getEntity(notifyEntityId)

	if not entity then
		return
	end

	local canContractList = FightModel.instance.canContractList

	if not canContractList or #canContractList < 1 then
		return
	end

	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.BindContract)
	ViewMgr.instance:openView(ViewName.FightNaNaTargetView)

	return true
end

function FightPlayerOperateMgr:checkAiJiAoQte()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local entityDataDic = FightDataHelper.entityMgr.entityDataDic
	local buffFeature = FightEnum.BuffFeature.EzioBigSkill
	local isAuto = FightDataHelper.stateMgr:getIsAuto()

	for entityId, entityData in pairs(entityDataDic) do
		if entityData.side == FightEnum.EntitySide.MySide then
			local hasFeature, buffMO = entityData:hasBuffFeature(buffFeature)

			if hasFeature then
				local actCommonParams = buffMO.actCommonParams
				local arr = string.split(actCommonParams, "|")

				for _, v in ipairs(arr) do
					local paramArray = string.split(v, "#")
					local featureId = tonumber(paramArray[1])
					local buffActConfig = lua_buff_act.configDict[featureId]

					if buffActConfig and buffActConfig.type == buffFeature then
						local splitList = string.split(paramArray[2], ",")
						local count = tonumber(splitList[1]) or 0
						local totalDamage = tonumber(splitList[2])
						local toId = splitList[3]

						if count and count > 0 then
							if count == FightDataHelper.tempMgr.aiJiAoQteCount then
								if not FightDataHelper.tempMgr.aiJiAoQteEndlessLoop then
									local loopCount = 0

									loopCount = loopCount + 1
									FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = loopCount

									if loopCount > 2 then
										local playEntity = FightHelper.getEntity(entityId)

										if playEntity then
											local fightStepData = FightStepData.New(FightDef_pb.FightStep())

											fightStepData.isFakeStep = true
											fightStepData.fromId = playEntity.id

											if playEntity:isMySide() then
												fightStepData.toId = FightEntityScene.EnemySideId or FightEntityScene.MySideId
											end

											fightStepData.actType = FightEnum.ActType.SKILL

											local work = playEntity.skill:registTimelineWork("aijiao_312301_unique_direct_exit", fightStepData)

											work:start()
										end

										return false
									end
								end
							end

							FightDataHelper.tempMgr.aiJiAoQteCount = count

							if toId == "0" then
								self.playAiJiAoPreTimeline = true

								local targetLimit = FightAiJiAoQteSelectView.getTargetLimit(229002, entityId)

								if #targetLimit == 0 then
									return false
								end

								local tab = {
									mustSelect = true,
									skillId = 229002,
									fromId = entityId,
									callback = self.afterAiJiAoSelectToId,
									handle = self,
									targetLimit = targetLimit
								}

								self.aiJiAoFromId = entityId

								local workFlow = self:com_registFlowSequence()

								if isAuto then
									local playEntity = FightHelper.getEntity(entityId)
									local curSelectEntityId = FightDataHelper.operationDataMgr.curSelectEntityId

									curSelectEntityId = curSelectEntityId and curSelectEntityId ~= 0 and curSelectEntityId

									if not FightHelper.getEntity(curSelectEntityId) then
										curSelectEntityId = nil
									end

									if not curSelectEntityId then
										local bossId = FightHelper.getCurBossId()

										for i, targetId in ipairs(targetLimit) do
											local targetEntityData = FightDataHelper.entityMgr:getById(targetId)

											if targetEntityData and FightHelper.isBossId(bossId, targetEntityData.modelId) then
												curSelectEntityId = targetId

												break
											end
										end

										curSelectEntityId = curSelectEntityId or targetLimit[1]
									end

									if not curSelectEntityId or not FightHelper.getEntity(curSelectEntityId) then
										return false
									end

									workFlow:registWork(FightWorkPlayTimeline, playEntity, "aijiao_312301_unique_pre", curSelectEntityId)
									workFlow:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, entityId, curSelectEntityId)
									workFlow:start()

									return true
								end

								local exPointObj = FightMsgMgr.sendMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, entityId)

								if exPointObj then
									AudioMgr.instance:trigger(20305032)
									workFlow:registWork(FightWorkPlayAnimator, exPointObj, "dazhao")
								end

								workFlow:registWork(FightWorkFunction, self.openFightAiJiAoQteSelectView, self, tab)
								workFlow:start()
							else
								self.aiJiAoToId = toId
								self.aiJiAoTotalDamage = totalDamage

								local viewParam = {
									fromId = entityId,
									toId = toId
								}
								local workFlow = self:com_registFlowSequence()

								if not self.playAiJiAoPreTimeline then
									self.playAiJiAoPreTimeline = true

									local playEntity = FightHelper.getEntity(entityId)

									workFlow:registWork(FightWorkPlayTimeline, playEntity, "aijiao_312301_unique_pre", toId)
								end

								if isAuto then
									workFlow:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, entityId, toId)
									workFlow:start()

									return true
								end

								workFlow:registWork(FightWorkFunction, self.openAiJiAoQteView, self, viewParam)
								workFlow:start()
							end

							return true
						end
					end
				end
			end
		end
	end
end

function FightPlayerOperateMgr:openFightAiJiAoQteSelectView(tab)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteSelectView, tab)
end

function FightPlayerOperateMgr:afterAiJiAoSelectToId(toId)
	local viewParam = {
		fromId = self.aiJiAoFromId,
		toId = toId
	}
	local workFlow = self:com_registFlowSequence()
	local playEntity = FightHelper.getEntity(self.aiJiAoFromId)

	workFlow:registWork(FightWorkPlayTimeline, playEntity, "aijiao_312301_unique_pre", toId)
	workFlow:registWork(FightWorkFunction, self.openAiJiAoQteView, self, viewParam)
	workFlow:start()
end

function FightPlayerOperateMgr:openAiJiAoQteView(viewParam)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteView, viewParam)
end

return FightPlayerOperateMgr
