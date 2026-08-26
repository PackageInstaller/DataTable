-- chunkname: @modules/logic/versionactivity1_6/act148/model/Activity148Mo.lua

module("modules.logic.versionactivity1_6.act148.model.Activity148Mo", package.seeall)

local Activity148Mo = pureTable("Activity148Mo")

function Activity148Mo:init(type, lv)
	self._lv = lv
	self._type = type
end

function Activity148Mo:getLevel()
	return self._lv
end

function Activity148Mo:updateByServerData(serverData)
	self._lv = serverData.level
end

return Activity148Mo
