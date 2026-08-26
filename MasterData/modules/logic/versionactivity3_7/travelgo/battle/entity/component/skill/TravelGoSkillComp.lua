-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/component/skill/TravelGoSkillComp.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.component.skill.TravelGoSkillComp", package.seeall)

local TravelGoSkillComp = class("TravelGoSkillComp", TravelGoBase)

function TravelGoSkillComp:ctor()
	TravelGoSkillComp.super.ctor(self)

	self.uid = 0
	self.skills = {}
end

function TravelGoSkillComp:onDisable()
	if self.skillAddFlow then
		self.skillAddFlow:dispose()

		self.skillAddFlow = nil
	end
end

function TravelGoSkillComp:addSkill(cfgId)
	if cfgId <= 0 then
		return
	end

	self.uid = self.uid + 1

	local skill = TravelGoSkillInfo.New(self.parent, self.uid, cfgId)

	skill:awake(true)
	table.insert(self.skills, skill)
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnSkillChange, self.parent)

	local own = self.parent
	local actionsList = self:tiggerSkillBehavior(TravelGoBattleEnum.EffectCheckType.SkillCreate, {
		own = own,
		target = own
	}, nil, {
		skill
	})

	if actionsList then
		if self.skillAddFlow then
			self.skillAddFlow:dispose()

			self.skillAddFlow = nil
		end

		self.skillAddFlow = TravelGoFlowNode.New()

		for i, v in ipairs(actionsList) do
			self.skillAddFlow:add(v)
		end

		self.skillAddFlow:enable()
	end

	return skill
end

function TravelGoSkillComp:tiggerSkillBehavior(effectCheckType, data, effectId, argsSkills)
	self.sortSkills = {}

	tabletool.addValues(self.sortSkills, self.skills)
	table.sort(self.sortSkills, self.sortSkill)

	return self:triggerActions(effectCheckType, data, effectId, argsSkills)
end

function TravelGoSkillComp:triggerActions(effectCheckType, data, effectId, argsSkills)
	local actionsList
	local skillList = argsSkills or self.sortSkills

	for i, skill in ipairs(skillList) do
		for j = 1, 3 do
			if not skill:isCd(j) and skill:isCondition(j, effectCheckType, effectId) then
				local comboCount = skill:getComboCount(j)

				for k = 1, comboCount do
					local probability = skill:getProbability(j)
					local n = math.random()
					local isRelease = n <= probability

					if isRelease then
						skill:startCd(j)

						local actions = skill:getActions(j, data)

						if actions then
							for _, action in ipairs(actions) do
								if actionsList == nil then
									actionsList = {}
								end

								table.insert(actionsList, action)

								if j == 1 and action.skillId == TravelGoConst.UltimateSkillId then
									local actionsList3 = self:triggerActions(TravelGoBattleEnum.EffectCheckType.ReleaseUltimate, data)

									if actionsList3 then
										for _, action2 in ipairs(actionsList3) do
											table.insert(actionsList, action2)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return actionsList
end

function TravelGoSkillComp.sortSkill(a, b)
	return a.cfgId < b.cfgId
end

return TravelGoSkillComp
