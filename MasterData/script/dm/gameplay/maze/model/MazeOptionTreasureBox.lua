-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionTreasureBox.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionTreasureBox = class("MazeOptionTreasureBox", MazeBaseOption)

MazeOptionTreasureBox:has("_itemList", {
	is = "rw"
})

function MazeOptionTreasureBox:initialize()
	super.initialize(self)

	self._canrefesh = false
	self._viewName = "MazeTreasureBoxView"
end

function MazeOptionTreasureBox:syncData(data)
	if data.optionId then
		self._optionId = data.optionId
	end

	if data.itemList then
		self._itemList = data.itemList
	end

	self._canrefesh = not not self:isTypeItemBox_2Time()

	if table.nums(self._itemList) < 2 then
		self._canrefesh = false
	end
end

function MazeOptionTreasureBox:setItemList(data)
	if data then
		self._itemList = data.itemList

		if GameConfigs.mazeDebugMode then
			dump(self._itemList, "可刷新宝物宝箱---")
		end
	end
end

function MazeOptionTreasureBox:getFirstTreasure()
	local list = {}

	for k, v in pairs(self._itemList) do
		if k == "0" then
			list[k] = v

			break
		end
	end

	return list
end

function MazeOptionTreasureBox:getSecondTreasure()
	local list = {}

	for k, v in pairs(self._itemList) do
		if k == "1" then
			list[k] = v

			break
		end
	end

	return list
end

function MazeOptionTreasureBox:isRefeshType()
	return self._type == "ItemBox_2Time"
end

function MazeOptionTreasureBox:isCanRefesh()
	return self._canrefesh
end

function MazeOptionTreasureBox:setCanRefesh(can)
	self._canrefesh = can
end

function MazeOptionTreasureBox:getNameByBoxId(id)
	local config = ConfigReader:getRecordById("PansLabItem", id)

	return Strings:get(config.Name)
end

function MazeOptionTreasureBox:getIconPathByBoxId(id)
	local config = ConfigReader:getRecordById("PansLabItem", id)

	return "asset/mazeicon/" .. config.Icon .. ".png"
end

function MazeOptionTreasureBox:getDescByBoxId(id, lv)
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

return MazeOptionTreasureBox
