-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionHeroBox.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionHeroBox = class("MazeOptionHeroBox", MazeBaseOption)

MazeOptionHeroBox:has("_type", {
	is = "rw"
})
MazeOptionHeroBox:has("_optionId", {
	is = "rw"
})
MazeOptionHeroBox:has("_level", {
	is = "rw"
})
MazeOptionHeroBox:has("_rewardId", {
	is = "rw"
})
MazeOptionHeroBox:has("_heroList", {
	is = "rw"
})

function MazeOptionHeroBox:initialize()
	super.initialize(self)

	self._type = ""
	self._canrefesh = false
	self._viewName = "MazeHeroBoxView"
end

function MazeOptionHeroBox:syncData(data)
	if data.type then
		self._type = data.type
	end

	if data.optionId then
		self._optionId = data.optionId
	end

	if data.rewardId then
		self._rewardId = data.rewardId
	end

	if data.heroList then
		self._heroList = data.heroList
	end

	self._canrefesh = self._type == "HeroBox_2Time"

	if table.nums(self._heroList) < 2 then
		self._canrefesh = false
	end

	if GameConfigs.mazeDebugMode then
		print("HeroBoxType:", self._type)
	end
end

function MazeOptionHeroBox:setHeroList(data)
	self._heroList = data.heroList
end

function MazeOptionHeroBox:isRefeshType()
	return self._type == "HeroBox_2Time"
end

function MazeOptionHeroBox:getFirstHero()
	local list = {}

	for k, v in pairs(self._heroList) do
		if k == "0" then
			list[k] = v

			break
		end
	end

	return list
end

function MazeOptionHeroBox:getSecondTreasure()
	local list = {}

	for k, v in pairs(self._heroList) do
		if k == "1" then
			list[k] = v

			break
		end
	end

	return list
end

function MazeOptionHeroBox:isCanRefesh()
	return self._canrefesh
end

function MazeOptionHeroBox:setCanRefesh(can)
	self._canrefesh = can
end

function MazeOptionHeroBox:getNameByHeroId(id)
	return (Strings:find(ConfigReader:getDataByNameIdAndKey("HeroBase", id, "Name")))
end

function MazeOptionHeroBox:getLvByHeroId(id)
	local level = ConfigReader:getDataByNameIdAndKey("PansLabAttr", id, "Level")

	return "Lv." .. level
end

function MazeOptionHeroBox:getIconPathByBoxId(id)
	local config = ConfigReader:getRecordById("PansLabItem", id)

	return "asset/mazeicon/" .. config.Icon .. ".png"
end

function MazeOptionHeroBox:getDescByBoxId(id, lv)
	local config = ConfigReader:getRecordById("PansLabItem", id)
	local effectId = config.SkillAttrEffect
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", config.SkillAttrEffect)
	local level = lv

	if not effectConfig then
		return "no desc config"
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

return MazeOptionHeroBox
