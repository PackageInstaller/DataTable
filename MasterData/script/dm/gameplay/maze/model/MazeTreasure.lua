-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeTreasure.lua

MazeTreasure = class("MazeTreasure", objectlua.Object, _M)

MazeTreasure:has("_id", {
	is = "rw"
})
MazeTreasure:has("_configId", {
	is = "rw"
})
MazeTreasure:has("_level", {
	is = "rw"
})

function MazeTreasure:initialize()
	super.initialize(self)
end

function MazeTreasure:syncData(data)
	if data.level then
		self._level = data.level
	end

	if data.id then
		self._id = data.id
	end

	if data.configId then
		self._configId = data.configId
	end

	self._config = ConfigReader:getRecordById("PansLabItem", self._configId)
end

function MazeTreasure:getName()
	return Strings:get(self._config.Name)
end

function MazeTreasure:getDesc()
	local effectId = self._config.SkillAttrEffect
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", self._config.SkillAttrEffect)
	local level = self._level

	if not effectConfig then
		local specialeff = ConfigReader:getRecordById("SkillSpecialEffect", self._config.SkillSpecialEffect)
		local descValue = Strings:get(self._config.SpecialDesc)
		local factorMap = ConfigReader:getRecordById("PansLabItem", self._config.Id)
		local t = TextTemplate:new(descValue)
		local funcMap = {
			linear = function(value)
				if type(value) ~= "table" then
					return nil
				end

				return value[1] + (level - 1) * value[2]
			end,
			fixed = function(value)
				if type(value) ~= "table" then
					return nil
				end

				return value[1]
			end,
			custom = function(value)
				if type(value) ~= "table" then
					return nil
				end

				return value[level]
			end,
			scale = function(value, rate, base)
				return value * rate / (base or 1)
			end
		}

		return (t:stringify(factorMap, funcMap))
	end

	local effectDesc = effectConfig.EffectDesc
	local descValue = Strings:get(effectDesc)
	local factorMap = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local t = TextTemplate:new(descValue)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return (t:stringify(factorMap, funcMap))
end

function MazeTreasure:getIsUse()
	return self._config.IsUse == 1
end

function MazeTreasure:getIconPath()
	return "asset/mazeicon/" .. self._config.Icon .. ".png"
end
