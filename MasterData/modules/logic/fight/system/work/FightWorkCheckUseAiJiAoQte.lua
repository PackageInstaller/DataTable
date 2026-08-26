-- chunkname: @modules/logic/fight/system/work/FightWorkCheckUseAiJiAoQte.lua

module("modules.logic.fight.system.work.FightWorkCheckUseAiJiAoQte", package.seeall)

local FightWorkCheckUseAiJiAoQte = class("FightWorkCheckUseAiJiAoQte", FightWorkItem)

function FightWorkCheckUseAiJiAoQte:onStart()
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

										self:onDone(true)

										return false
									end
								end
							end

							FightDataHelper.tempMgr.aiJiAoQteCount = count

							if toId == "0" then
								FightDataHelper.tempMgr.playAiJiAoPreTimeline = true

								local targetLimit = FightAiJiAoQteSelectView.getTargetLimit(229002, entityId)

								if #targetLimit == 0 then
									self:onDone(true)

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

									workFlow:registWork(FightWorkPlayTimeline, playEntity, "aijiao_312301_unique_pre", curSelectEntityId)
									workFlow:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, entityId, curSelectEntityId)
									workFlow:start()
									self:cancelFightWorkSafeTimer()

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
								local viewParam = {
									fromId = entityId,
									toId = toId
								}
								local workFlow = self:com_registFlowSequence()

								if not FightDataHelper.tempMgr.playAiJiAoPreTimeline then
									FightDataHelper.tempMgr.playAiJiAoPreTimeline = true
									FightDataHelper.tempMgr.aiJiAoFakeHpDic = {}
									FightDataHelper.tempMgr.aiJiAoFakeShieldDic = {}

									FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(toId, totalDamage)
									FightController.instance:dispatchEvent(FightEvent.AiJiAoFakeDecreaseHp, toId)

									local playEntity = FightHelper.getEntity(entityId)

									workFlow:registWork(FightWorkPlayTimeline, playEntity, "aijiao_312301_unique_pre", toId)
								end

								if isAuto then
									workFlow:registWork(FightWorkFunction, FightAiJiAoQteView.autoQte, entityId, toId)
									workFlow:start()
									self:cancelFightWorkSafeTimer()

									return true
								end

								workFlow:registWork(FightWorkFunction, self.openAiJiAoQteView, self, viewParam)
								workFlow:start()
							end

							self:cancelFightWorkSafeTimer()

							return true
						end
					end
				end
			end
		end
	end

	self:onDone(true)
end

function FightWorkCheckUseAiJiAoQte:openFightAiJiAoQteSelectView(tab)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteSelectView, tab)
end

function FightWorkCheckUseAiJiAoQte:afterAiJiAoSelectToId(toId)
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

function FightWorkCheckUseAiJiAoQte:openAiJiAoQteView(viewParam)
	ViewMgr.instance:openView(ViewName.FightAiJiAoQteView, viewParam)
end

return FightWorkCheckUseAiJiAoQte
