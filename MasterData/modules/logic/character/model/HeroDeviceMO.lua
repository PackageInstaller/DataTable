-- chunkname: @modules/logic/character/model/HeroDeviceMO.lua

module("modules.logic.character.model.HeroDeviceMO", package.seeall)

local HeroDeviceMO = class("HeroDeviceMO")

function HeroDeviceMO:ctor(heroId)
	self._heroId = heroId
end

function HeroDeviceMO:refreshDevice(deviceId)
	if self._deviceId == deviceId then
		return
	end

	self._deviceId = deviceId
	self._config = lua_fight_device.configDict[self._deviceId]

	if not self._config then
		logError("未找到装置配置 deviceId：" .. deviceId)

		return
	end

	self._powerSkill = self:_parsePowerSkillInfo(self._config.powerSkill)
	self._skills = {}
	self._skills[1] = self:_parseSkillInfo(self._config.skill1)
	self._skills[2] = self:_parseSkillInfo(self._config.skill2)
	self._skills[3] = self:_parseSkillInfo(self._config.uniqueSkill)

	if #self._skills[1] > 1 and #self._skills[2] > 1 then
		local temp = tabletool.copy(self._skills[1][2])

		self._skills[1][2] = tabletool.copy(self._skills[2][1])
		self._skills[2][1] = temp
	end

	self:_checkSpecialPowerSkills()
end

function HeroDeviceMO:_checkSpecialPowerSkills()
	local specialcardCos = HeroConfig.instance:getHeroSpecialcardCos(self._heroId)

	if specialcardCos then
		local heroMo = self:getHeroMo()
		local var_3_0 = self._exSkillLevel

		if not self._exSkillLevel then
			if heroMo then
				var_3_0 = heroMo.exSkillLevel

				if not heroMo.exSkillLevel then
					local exSkillLevel = 0

					if not self._tempExSkillLevel or self._tempExSkillLevel ~= exSkillLevel then
						self._tempExSkillLevel = exSkillLevel

						local co = specialcardCos[exSkillLevel]

						if co and not string.nilorempty(co.skillcard) then
							self._specialPowerSkill = {}

							local skillIds = string.splitToNumber(co.skillcard, "|")

							for _, skillId in ipairs(skillIds) do
								local skillInfo = self:_getPowerSkillInfo(skillId)

								if skillInfo then
									table.insert(self._specialPowerSkill, skillInfo)
								end
							end

							return
						end
					end
				end
			end
		end
	end

	self._specialPowerSkill = self._specialPowerSkill or self:_parsePowerSkillInfo(self._config.specialPowerSkill)
end

function HeroDeviceMO:_parsePowerSkillInfo(str)
	local powerSkills = {}

	if string.nilorempty(str) then
		return powerSkills
	end

	local infos = GameUtil.splitString2(str, true, "|", "#")

	for _, info in ipairs(infos) do
		local skillId = info[1]
		local skillInfo = self:_getPowerSkillInfo(skillId, info[2])

		if skillInfo then
			table.insert(powerSkills, skillInfo)
		end
	end

	return powerSkills
end

function HeroDeviceMO:_getPowerSkillInfo(skillId, count)
	local energyCo = lua_skill_energy.configDict[skillId]
	local skillInfo = {}

	skillInfo.skillId = skillId

	if energyCo then
		skillInfo.energyType = energyCo.energyType
		skillInfo.energyCount = energyCo.count or 0
		skillInfo.isSpecialCard = energyCo.isSpecialCard == 1
		skillInfo.count = count or 0
		skillInfo.energyCo = energyCo
	end

	return skillInfo
end

function HeroDeviceMO:_parseSkillInfo(str)
	local tb = {}

	if string.nilorempty(str) then
		return tb
	end

	local split = GameUtil.splitString2(str, true)

	for _, v in ipairs(split) do
		local info = {}

		info.skillId = v[1]
		info.costType = v[2]
		info.costValue = v[3]

		table.insert(tb, info)
	end

	return tb
end

function HeroDeviceMO:setHeroMo(heroMo)
	self._heroMo = heroMo
end

function HeroDeviceMO:getSkillIdsStr(index)
	index = index or self._selectCardGroupIndex or 1

	local str = string.format("1#%s|2#%s", self:getSkillId(1, index), self:getSkillId(2, index))

	return str, self:getSkillId(3, index)
end

function HeroDeviceMO:getSkillId(skillIndex, index)
	index = index or self._selectCardGroupIndex or 1

	local info = self:getSkillInfo(skillIndex, index)

	return info and info.skillId
end

function HeroDeviceMO:getSkillInfo(skillIndex, index)
	index = index or 1

	local tb = self._skills[skillIndex]
	local info = tb and tb[index]

	info = info or tb and tb[1]

	return info
end

function HeroDeviceMO:getSkillInfoById(skillId)
	for _, v in ipairs(self._skills) do
		for _, info in ipairs(v) do
			if skillId == info.skillId then
				return info
			end
		end
	end
end

function HeroDeviceMO:getPowerSkillInfoById(skillId)
	for _, v in ipairs(self._powerSkill) do
		if skillId == v.skillId then
			return v
		end
	end
end

function HeroDeviceMO:getSpecialPowerSkillInfoById(skillId)
	for _, v in ipairs(self._specialPowerSkill) do
		if skillId == v.skillId then
			return v
		end
	end
end

function HeroDeviceMO:getSelectCardGroupIndex()
	return self._selectCardGroupIndex
end

function HeroDeviceMO:setSelectCardGroupIndex(index)
	self._selectCardGroupIndex = index
end

function HeroDeviceMO:getSkills()
	return self._skills
end

function HeroDeviceMO:getPowerSkills()
	return self._powerSkill
end

function HeroDeviceMO:getSpecialPowerSkills()
	self:_checkSpecialPowerSkills()

	return self._specialPowerSkill
end

function HeroDeviceMO:getUniqueSkillPoint()
	local heroMo = self:getHeroMo()

	if heroMo then
		local destinyStoneMo = heroMo:getHeroDestinyStoneMo()

		if destinyStoneMo then
			local stoenCo = destinyStoneMo:getCurUseStoneCo()

			if stoenCo and not string.nilorempty(stoenCo.uniqueSkill_point) then
				local uniqueSkill_point = string.splitToNumber(stoenCo.uniqueSkill_point, "#")

				return uniqueSkill_point[2] or 0
			end
		end
	end

	if not self._heroId then
		return 0
	end

	local heroCo = HeroConfig.instance:getHeroCO(self._heroId)

	if heroCo and not string.nilorempty(heroCo.uniqueSkill_point) then
		local uniqueSkill_point = string.splitToNumber(heroCo.uniqueSkill_point, "#")

		return uniqueSkill_point[2] or 0
	end

	return 0
end

function HeroDeviceMO:getHeroMo()
	return self._heroMo
end

function HeroDeviceMO:setExSkillLevel(exSkillLevel)
	self._exSkillLevel = exSkillLevel
end

return HeroDeviceMO
