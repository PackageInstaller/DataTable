-- chunkname: @modules/logic/resonance/config/HeroResonanceConfig.lua

module("modules.logic.resonance.config.HeroResonanceConfig", package.seeall)

local HeroResonanceConfig = class("HeroResonanceConfig", BaseConfig)

function HeroResonanceConfig:ctor()
	self.resonance_config = nil
	self.resonance_cost_config = nil
	self.resonance_cube_shape = nil
	self.resonance_model_config = nil
	self.resonance_style_config = nil
	self.resonance_style_cost_config = nil
	self.cube_rightful = {}
	self.matrix_data = {}
	self.cube_lastrowful = {}
end

function HeroResonanceConfig:reqConfigNames()
	return {
		"talent_cube_attr",
		"character_talent",
		"talent_cube_shape",
		"talent_mould",
		"talent_style",
		"talent_style_cost"
	}
end

function HeroResonanceConfig:onConfigLoaded(configName, configTable)
	if configName == "talent_cube_attr" then
		self.resonance_config = configTable
	elseif configName == "character_talent" then
		self.resonance_cost_config = configTable

		self:_initCharacterTalent()
	elseif configName == "talent_cube_shape" then
		self.resonance_cube_shape = configTable
	elseif configName == "talent_mould" then
		self.resonance_model_config = configTable
	elseif configName == "talent_style" then
		self.resonance_style_config = configTable

		self:initParseTalentStyle()
	elseif configName == "talent_style_cost" then
		self.resonance_style_cost_config = configTable
	end
end

function HeroResonanceConfig:_initCharacterTalent()
	self._talentMaxLvMap = {}

	for i, v in ipairs(lua_character_talent.configList) do
		if not self._talentMaxLvMap[v.heroId] then
			local id = 0

			id = math.max(v.talentId, self._talentMaxLvMap[v.heroId])
			self._talentMaxLvMap[v.heroId] = self._talentMaxLvMap[v.heroId]
		end
	end
end

function HeroResonanceConfig:getHeroMaxTalentLv(heroId)
	return self._talentMaxLvMap[heroId] or 1
end

function HeroResonanceConfig:getCubeConfig(id)
	return self.resonance_cube_shape.configDict[id] or logError("共鸣形状表找不到id：", id)
end

function HeroResonanceConfig:getCubeConfigNotError(id)
	return self.resonance_cube_shape.configDict[id]
end

function HeroResonanceConfig:getCubeRightful(id)
	if not self.cube_rightful[id] then
		local config = self:getCubeConfig(id)
		local count = 0
		local tab = string.split(config.shape, "#")

		for i, v in ipairs(tab) do
			local arr = string.splitToNumber(v, ",")

			for index, value in ipairs(arr) do
				if value == 1 then
					count = count + 1
				end
			end
		end

		self.cube_rightful[id] = count
	end

	return self.cube_rightful[id]
end

function HeroResonanceConfig:getLastRowfulPos(id)
	if not self.cube_lastrowful[id] then
		local config = self:getCubeConfig(id)
		local count = 0
		local tab = string.split(config.shape, "#")
		local fulTab = string.splitToNumber(tab[#tab], ",")

		for i = #fulTab, 1, -1 do
			if fulTab[i] ~= 1 then
				count = count + 1
			else
				self.cube_lastrowful[id] = count

				return self.cube_lastrowful[id]
			end
		end

		self.cube_lastrowful[id] = count
	end

	return self.cube_lastrowful[id]
end

function HeroResonanceConfig:getCubeMatrix(id)
	if self.matrix_data[id] then
		return self.matrix_data[id]
	end

	local config = self:getCubeConfig(id)
	local mat_list = {}
	local list_y = string.split(config.shape, "#")

	for i = 0, #list_y - 1 do
		mat_list[i] = {}

		for index, value in ipairs(string.split(list_y[i + 1], ",")) do
			mat_list[i][index - 1] = tonumber(value)
		end
	end

	self.matrix_data[id] = mat_list

	return self.matrix_data[id]
end

function HeroResonanceConfig:getTalentConfig(hero_id, talent_level)
	local heroCO = self.resonance_cost_config.configDict[hero_id]

	if not heroCO then
		logError("共鸣表找不到,英雄id：", hero_id, "共鸣等级：", talent_level)
	end

	return heroCO and heroCO[talent_level]
end

function HeroResonanceConfig:getTalentAllShape(hero_id, talent_level)
	local config = self:getTalentModelConfig(hero_id, talent_level)

	if not config then
		logError("共鸣表找不到,英雄id：", hero_id, "共鸣等级：", talent_level)

		return
	end

	return config.allShape
end

function HeroResonanceConfig:getTalentModelConfig(hero_id, talent_level)
	local var_13_0 = self.resonance_model_config.configDict[talent_level]

	if self.resonance_model_config.configDict[talent_level] then
		var_13_0 = self:getTalentConfig(hero_id, talent_level)
		var_13_0 = var_13_0 and self.resonance_model_config.configDict[talent_level][self:getTalentConfig(hero_id, talent_level).talentMould]
	end

	return var_13_0
end

function HeroResonanceConfig:getTalentModelShapeMaxLevel(hero_id)
	self.max_talent_model_shape_level = self.max_talent_model_shape_level or {}

	if self.max_talent_model_shape_level[hero_id] then
		return self.max_talent_model_shape_level[hero_id]
	end

	local level = 0
	local talentMould = self:getTalentConfig(hero_id, 1).talentMould
	local temp_shape
	local cur_shape_level = {}

	for k, v in pairs(self.resonance_model_config.configDict) do
		for index, value in pairs(v) do
			if value.talentMould == talentMould then
				table.insert(cur_shape_level, {
					talentId = value.talentId,
					allShape = value.allShape
				})

				if value.allShape ~= temp_shape then
					temp_shape = value.allShape
					level = level + 1
				end
			end
		end
	end

	table.sort(cur_shape_level, function(item1, item2)
		return item1.talentId < item2.talentId
	end)

	self.cur_talent_model_shape_level = self.cur_talent_model_shape_level or {}
	self.cur_talent_model_shape_level[talentMould] = cur_shape_level
	self.max_talent_model_shape_level[hero_id] = level

	return level
end

function HeroResonanceConfig:getCurTalentModelShapeLevel(hero_id, talent_level)
	local talentMould = self:getTalentConfig(hero_id, 1).talentMould
	local level = 0
	local temp_shape

	for i, v in ipairs(self.cur_talent_model_shape_level[talentMould]) do
		if v.allShape ~= temp_shape then
			level = level + 1
			temp_shape = v.allShape
		end

		if talent_level <= v.talentId then
			break
		end
	end

	return level
end

function HeroResonanceConfig:initParseTalentStyle()
	self.talent_style_replace_cube_list = {}

	if self.resonance_style_config then
		for _, co in pairs(self.resonance_style_config.configList) do
			if co and not string.nilorempty(co.replaceCube) then
				local orginIds = GameUtil.splitString2(co.replaceCube)

				for _, ids in pairs(orginIds) do
					local styleMo = TalentStyleMo.New()
					local orginId = tonumber(ids[1])
					local replaceId = tonumber(ids[2])

					if orginId and replaceId then
						styleMo:setMo(co, orginId, replaceId)

						if not self.talent_style_replace_cube_list[orginId] then
							self.talent_style_replace_cube_list[orginId][co.styleId] = styleMo
							self.talent_style_replace_cube_list[orginId] = self.talent_style_replace_cube_list[orginId]
						end
					end
				end
			end
		end

		for k, v in pairs(self.talent_style_replace_cube_list) do
			local styleMo = TalentStyleMo.New()
			local key, value = next(v)
			local co = self.resonance_style_config.configDict[value._styleCo.talentMould][0]

			styleMo:setMo(co, k, k)

			v[0] = styleMo
		end
	end
end

function HeroResonanceConfig:getTalentStyle(orginCubeId)
	if self.talent_style_replace_cube_list then
		return self.talent_style_replace_cube_list
	end
end

function HeroResonanceConfig:getTalentStyleUnlockConsume(heroId, styleId)
	local config = self:getTalentStyleCostConfig(heroId, styleId)

	return config and config.consume
end

function HeroResonanceConfig:getTalentStyleCostConfig(heroId, styleId)
	if self.resonance_style_cost_config then
		if self.resonance_style_cost_config then
			return self.resonance_style_cost_config[styleId]
		end
	end
end

HeroResonanceConfig.instance = HeroResonanceConfig.New()

return HeroResonanceConfig
