-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterLeadStage.lua

MasterLeadStage = class("MasterLeadStage", objectlua.Object, _M)

MasterLeadStage:has("_config", {
	is = "r"
})
MasterLeadStage:has("_leadStageId", {
	is = "rw"
})
MasterLeadStage:has("_leadStageLevel", {
	is = "rw"
})
MasterLeadStage:has("_leadStageActiveTime", {
	is = "rw"
})
MasterLeadStage:has("_skillLevel", {
	is = "rw"
})
MasterLeadStage:has("_maxLeadStageLevel", {
	is = "rw"
})
MasterLeadStage:has("_allSkill", {
	is = "rw"
})

MasterLeadStageSkillState = {
	KUP = "KUP",
	KLOCK = "KLOCK",
	KNORMAL = "KNORMAL",
	KNew = "KNew"
}

function MasterLeadStage:initialize(owner, player)
	super.initialize(self)

	self._owner = owner
	self._player = player
	self._masterId = owner:getId()
	self._leadStageId = ""
	self._leadStageLevel = 0
	self._leadStageActiveTime = {}
	self._skillLevel = {}
	self._maxLeadStageLevel = 0

	self:initConfig()

	self._config = {}
	self.sortCondition = {
		"StarHero",
		"RareityHero",
		"Awaken",
		"Equip",
		"LeadStage",
		"Suit",
		"EquipRareityLevel"
	}
	self._effects = {}

	self:createAttrEffect(self._owner, self._player)
end

function MasterLeadStage:initConfig()
	local info = {}
	local config = ConfigReader:getDataTable("MasterLeadStage")

	for i, v in pairs(config) do
		if v.MasterOwn == self._masterId then
			table.insert(info, v)
		end
	end

	if not next(info) then
		return
	end

	table.sort(info, function(a, b)
		return a.StageNum < b.StageNum
	end)

	self._maxLeadStageLevel = #info
	self._allSkill = {}

	if info[#info].Skill.Attr and next(info[#info].Skill.Attr) then
		for i, v in ipairs(info[#info].Skill.Attr) do
			table.insert(self._allSkill, v)
		end
	end

	if info[#info].Skill.Skill and next(info[#info].Skill.Skill) then
		for i, v in ipairs(info[#info].Skill.Skill) do
			table.insert(self._allSkill, v)
		end
	end

	for i = 1, #info do
		info[i].skills = table.copy(self._allSkill, {})

		if i == 1 then
			for _, sk in ipairs(info[i].skills) do
				if not table.indexof(info[i].Skill.Attr or {}, sk) then
					if table.indexof(info[i].Skill.Skill or {}, sk) then
						info[i].skills[sk] = {
							level = 1,
							state = MasterLeadStageSkillState.KNew
						}

						goto label_2_0
					end
				end

				info[i].skills[sk] = {
					level = 0,
					state = MasterLeadStageSkillState.KLOCK
				}

				::label_2_0::
			end
		elseif i <= self._maxLeadStageLevel then
			local pre = i - 1

			for _, sk in ipairs(info[i].skills) do
				if not table.indexof(info[i].Skill.Attr or {}, sk) then
					if table.indexof(info[i].Skill.Skill or {}, sk) then
						if info[pre].skills[sk].state ~= MasterLeadStageSkillState.KLOCK then
							local preLevel = info[pre].skills[sk].level

							if table.indexof(info[i].Skill.Attr or {}, sk) then
								local skillInfo = ConfigReader:getRecordById("Skill", sk)
								local buffInfo = ConfigReader:getRecordById("SkillAttrEffect", skillInfo.AttrEffects[1]).Value
								local var_2_5 = {}

								if (buffInfo[1][preLevel] or 0) < (buffInfo[1][preLevel + 1] or 0) then
									var_2_5.state = MasterLeadStageSkillState.KUP or MasterLeadStageSkillState.KNORMAL
								end

								var_2_5.level = preLevel + 1
								info[i].skills[sk] = var_2_5
							elseif table.indexof(info[i].Skill.Skill or {}, sk) then
								local buffInfo = ConfigReader:getRecordById("Skill", sk).Args
								local var_2_7 = {}

								if buffInfo[1].value[preLevel] < buffInfo[1].value[preLevel + 1] then
									var_2_7.state = MasterLeadStageSkillState.KUP or MasterLeadStageSkillState.KNORMAL
								end

								var_2_7.level = preLevel + 1
								info[i].skills[sk] = var_2_7
							end
						else
							info[i].skills[sk] = {
								level = 1,
								state = MasterLeadStageSkillState.KNew
							}
						end

						goto label_2_1
					end
				end

				info[i].skills[sk] = {
					level = 0,
					state = MasterLeadStageSkillState.KLOCK
				}

				::label_2_1::
			end
		end
	end

	self._detailConfig = info
end

function MasterLeadStage:syncData(data)
	if not self._detailConfig then
		return
	end

	if data.leadStageId then
		self._leadStageId = data.leadStageId
	end

	if data.level then
		self._leadStageLevel = data.level

		if self._leadStageLevel == 0 then
			local id = ConfigReader:getDataByNameIdAndKey("MasterBase", self._masterId, "LeadStage")

			self._config = ConfigReader:getRecordById("MasterLeadStage", id)
		else
			local c = ConfigReader:getRecordById("MasterLeadStage", self._leadStageId)

			self._config = ConfigReader:getRecordById("MasterLeadStage", c.NextStage)
		end
	end

	if data.skillLevel then
		self._skillLevel = data.skillLevel
	end

	if data.activateTime then
		for k, v in pairs(data.activateTime or {}) do
			self._leadStageActiveTime[k] = v
		end
	end

	self:refreshEffect()
end

function MasterLeadStage:isMaxLevel()
	return self._leadStageLevel >= self._maxLeadStageLevel
end

function MasterLeadStage:getConfigInfo()
	return self._detailConfig
end

function MasterLeadStage:getConfigSkillInfo()
	return self._detailConfig.skills
end

function MasterLeadStage:getLastStage()
	return self._config.LastStage
end

function MasterLeadStage:getNextStage()
	return self._config.NextStage
end

function MasterLeadStage:getCost(lv)
	local costInfo = lv and self._detailConfig[lv].UpNeedItem or self._config.UpNeedItem
	local cost = {}

	for k, v in pairs(costInfo) do
		table.insert(cost, {
			id = k,
			n = v
		})
	end

	return cost
end

function MasterLeadStage:getIsOpen()
	return self._config and self._config.LeadStageControl == 1
end

function MasterLeadStage:getSkillKind(skillId)
	return table.indexof(self._detailConfig[#self._detailConfig].Skill.Attr or {}, skillId) and "Attr" or "Skill"
end

function MasterLeadStage:getActiveTime(id)
	return self._leadStageActiveTime[id]
end

function MasterLeadStage:getShowCondition()
	local ret = {}

	for i, v in ipairs(self.sortCondition) do
		if self._config.UpCondition[v] then
			table.insert(ret, {
				key = v,
				value = self._config.UpCondition[v]
			})
		end
	end

	return ret
end

function MasterLeadStage:getShowConditionByStageLv(stagelv)
	local ret = {}

	for i, v in ipairs(self.sortCondition) do
		if self._detailConfig[stagelv].UpCondition[v] then
			table.insert(ret, {
				key = v,
				value = self._detailConfig[stagelv].UpCondition[v]
			})
		end
	end

	return ret
end

function MasterLeadStage:getLeadStageModel()
	if self._leadStageLevel > 0 then
		local info = ConfigReader:getRecordById("MasterLeadStage", self._leadStageId)

		return info.ModelId
	end

	return nil
end

function MasterLeadStage:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kMasterLeadStage)

	self._effect:setOwner(owner, player)
end

function MasterLeadStage:refreshEffect()
	self._effect:removeEffect()
	self:rCreateEffect()
end

function MasterLeadStage:rCreateEffect()
	local effects = self:getAttrEffects()

	self._effect:refreshEffects(effects, self._leadStageLevel)
	self._effect:rCreateEffect()
end

function MasterLeadStage:synchronize(effects)
	self._effects = effects

	self:refreshEffect()
end

function MasterLeadStage:getAttrEffects()
	local effects = {}

	for id, v in pairs(self._effects) do
		local attrConfig = ConfigReader:getRecordById("SkillAttrEffect", id)

		if attrConfig then
			table.insert(effects, id)
		end
	end

	return effects
end
