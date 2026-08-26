-- chunkname: @modules/logic/fight/system/work/FightWork3_7BossQte.lua

module("modules.logic.fight.system.work.FightWork3_7BossQte", package.seeall)

local FightWork3_7BossQte = class("FightWork3_7BossQte", FightWorkItem)

function FightWork3_7BossQte:onStart()
	local myVertin = FightDataHelper.entityMgr:getMyVertin()

	if not myVertin then
		return self:onDone(true)
	end

	for _, buffData in pairs(myVertin.buffDic) do
		local actInfo = buffData.actInfo

		for i = 1, #actInfo do
			local actInfo = actInfo[i]
			local actId = actInfo.actId
			local config = lua_buff_act.configDict[actId]

			if config and config.type == "BattleSelection" and actInfo.param[#actInfo.param] == 0 and #actInfo.param >= 2 and actInfo.param[1] == 3303016 then
				self:cancelFightWorkSafeTimer()
				self:com_registFightEvent(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail)

				local flow = self:com_registFlowSequence()
				local entity

				for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
					local skin = entityData.skin

					if lua_fight_monster_3d.configDict[skin] then
						entity = FightGameMgr.entityMgr:getById(entityData.id)

						break
					end
				end

				if entity then
					local entityId = entity.id
					local var_1_0 = {
						actId = 0,
						actEffect = {
							{
								targetId = entityId
							}
						},
						fromId = entityId,
						toId = entityId,
						actType = FightEnum.ActType.SKILL
					}

					var_1_0.stepUid = FightTLEventEntityVisible.latestStepUid or 0
					self.timelineData = var_1_0

					flow:addWork(entity.skill:registTimelineWork("610416_guodu1", self.timelineData))
				end

				flow:registFinishCallback(self.onFlowFinish, self)

				self.viewData = {
					buffData = buffData,
					actInfo = actInfo
				}

				flow:start()

				return
			end
		end
	end

	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local entityData = entity.entityData
		local skin = entityData and entityData.skin

		if lua_fight_monster_3d.configDict[skin] then
			entity.spine.lockAct = false
		end
	end

	self:onDone(true)
end

function FightWork3_7BossQte:onFlowFinish()
	ViewMgr.instance:openView(ViewName.Fight3_7QteView, self.viewData, true)
end

function FightWork3_7BossQte:_onRespUseClothSkillFail()
	self:onDone(true)
end

return FightWork3_7BossQte
