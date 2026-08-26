-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/component/skill/TravelGoSkillInfo.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.component.skill.TravelGoSkillInfo", package.seeall)

local TravelGoSkillInfo = class("TravelGoSkillInfo", TravelGoBase)

function TravelGoSkillInfo:ctor(entity, uid, cfgId)
	TravelGoSkillInfo.super.ctor(self)

	self.entity = entity
	self.uid = uid
	self.cfgId = cfgId
	self.cfg = lua_activity220_skill.configDict[cfgId]
	self.behaviorInfo = {}

	for i = 1, 3 do
		self:parseBehavior(i)
	end
end

function TravelGoSkillInfo:onEnable()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnRoundEnd, self.onRoundEnd, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
end

function TravelGoSkillInfo:onDispose()
	return
end

function TravelGoSkillInfo:onRoundEnd(entity)
	if self.entity.uid ~= entity.uid then
		return
	end

	for i, v in ipairs(self.behaviorInfo) do
		if v.cd >= 1 then
			v.cd = v.cd - 1
		end
	end
end

function TravelGoSkillInfo:onBattleEventFinish()
	for i, v in ipairs(self.behaviorInfo) do
		v.cd = 0
	end
end

function TravelGoSkillInfo:parseBehavior(i)
	local eventName = "timing" .. i
	local eventStr = self.cfg[eventName]

	if not string.nilorempty(eventStr) then
		local events = string.splitToNumber(eventStr, "#")
		local conditions
		local conditionName = "condition" .. i
		local conditionStr = self.cfg[conditionName]
		local comboCountName = "count1"
		local comboCount = self.cfg[comboCountName]

		if comboCount == 0 then
			comboCount = 1
		end

		local probabilityName = "percent" .. i
		local probability = self.cfg[probabilityName]

		if probability == nil or probability == 0 then
			probability = 1
		end

		if TravelGoController.instance.isFullProbability then
			probability = 1
		end

		local actionIds
		local actionsName = "param" .. i
		local actionsStr = self.cfg[actionsName]
		local cdName = "cooldown" .. i
		local cooldown = self.cfg[cdName]

		self.behaviorInfo[i] = {
			cd = 0,
			events = events,
			conditions = (not string.nilorempty(conditionStr) or nil) and string.splitToNumber(conditionStr, "#"),
			comboCount = comboCount,
			probability = probability,
			target = self.cfg["target" .. i],
			actionIds = (not string.nilorempty(actionsStr) or nil) and string.splitToNumber(actionsStr, "#"),
			cooldown = cooldown
		}
	end
end

function TravelGoSkillInfo:isCd(index)
	local info = self.behaviorInfo[index]

	if info then
		return info.cd > 0
	end
end

function TravelGoSkillInfo:startCd(index)
	local info = self.behaviorInfo[index]

	if info then
		info.cd = info.cooldown
	end
end

function TravelGoSkillInfo:isCondition(index, effectCheckType, effectId)
	local info = self.behaviorInfo[index]

	if info then
		local event = info.events[1]

		if self:checkEffectEvent(event, effectCheckType, info.events, effectId) then
			if info.conditions then
				for _, condition in ipairs(info.conditions) do
					if self:checkCondition(condition) then
						return true
					end
				end
			else
				return true
			end
		end
	end
end

function TravelGoSkillInfo:getComboCount(index)
	return self.behaviorInfo[index].comboCount
end

function TravelGoSkillInfo:getProbability(index)
	return self.behaviorInfo[index].probability
end

function TravelGoSkillInfo:getActions(index, data)
	local actionIds = self.behaviorInfo[index].actionIds

	if actionIds then
		local actions = {}

		for _, effectCfgId in ipairs(actionIds) do
			local node = TravelGoSkillEffectNode.New()

			if self.behaviorInfo[index].target == 0 then
				if not data.own then
					local target = data.target

					if not target.attributes:isDie() then
						node:setData({
							own = data.own,
							target = target,
							skillId = self.cfgId,
							effectCfgId = effectCfgId
						})
						table.insert(actions, node)
					end
				end
			end
		end

		return actions
	end
end

function TravelGoSkillInfo:checkEffectEvent(event, checkType, events, effectId)
	if event ~= checkType then
		return false
	end

	if checkType == TravelGoBattleEnum.EffectCheckType.RoundStartEffect then
		return self.entity.tag.round == events[2]
	elseif checkType == TravelGoBattleEnum.EffectCheckType.TriggerEffect then
		return events[2] == effectId
	end

	return true
end

function TravelGoSkillInfo:checkCondition(condition)
	if condition == 0 then
		return true
	elseif condition == 1 then
		local per = self.entity.attributes:getHpPercent()

		return per < 0.3
	elseif condition == 2 then
		local per = self.entity.attributes:getRagePercent()

		return per >= 1
	end

	return false
end

return TravelGoSkillInfo
