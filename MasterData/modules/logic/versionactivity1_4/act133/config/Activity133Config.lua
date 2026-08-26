-- chunkname: @modules/logic/versionactivity1_4/act133/config/Activity133Config.lua

module("modules.logic.versionactivity1_4.act133.config.Activity133Config", package.seeall)

local Activity133Config = class("Activity133Config", BaseConfig)

function Activity133Config:ctor()
	self._act133taskList = {}
	self._act133bonusList = {}
	self._finalBonus = nil
end

function Activity133Config:reqConfigNames()
	return {
		"activity133_bonus",
		"activity133_task"
	}
end

function Activity133Config:onConfigLoaded(configName, configTable)
	if configName == "activity133_task" then
		for _, taskCo in ipairs(configTable.configList) do
			table.insert(self._act133taskList, taskCo)
		end
	elseif configName == "activity133_bonus" then
		for _, bonusCo in ipairs(configTable.configList) do
			local id = bonusCo.id

			if bonusCo.finalBonus == 1 then
				self._finalBonus = bonusCo.bonus
			else
				self._act133bonusList[id] = self._act133bonusList[id] or {}

				table.insert(self._act133bonusList[id], bonusCo)
			end
		end
	end
end

function Activity133Config:getFinalBonus()
	return self._finalBonus
end

function Activity133Config:getBonusCoList()
	return self._act133bonusList
end

function Activity133Config:getNeedFixNum()
	return #self._act133bonusList
end

function Activity133Config:getTaskCoList()
	return self._act133taskList
end

function Activity133Config:getTaskCo(id)
	for i, v in ipairs(self._act133taskList) do
		if v.id == id then
			return v
		end
	end

	return self._act133taskList[id]
end

function Activity133Config:getBonusCo(id)
	return self._act133bonusList[id]
end

function Activity133Config:IsActivityTask(id)
	if self._act133taskList[id].orActivity == "1" then
		return true
	end

	return false
end

Activity133Config.instance = Activity133Config.New()

return Activity133Config
