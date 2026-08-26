-- chunkname: @modules/logic/versionactivity1_4/act130/model/Activity130ElementMo.lua

module("modules.logic.versionactivity1_4.act130.model.Activity130ElementMo", package.seeall)

local Activity130ElementMo = pureTable("Activity130ElementMo")

function Activity130ElementMo:ctor()
	self.elementId = 0
	self.isFinish = false
	self.index = 0
	self.historylist = {}
	self.visible = false
	self.config = {}
	self.typeList = {}
	self.paramList = {}
end

function Activity130ElementMo:init(info)
	self.elementId = info.elementId
	self.isFinish = info.isFinish
	self.index = info.index
	self.historylist = {}

	for _, v in ipairs(info.historylist) do
		table.insert(self.historylist, v)
	end

	self.visible = info.visible

	local actId = VersionActivity1_4Enum.ActivityId.Role37

	self.config = Activity130Config.instance:getActivity130ElementCo(actId, self.elementId)

	if not self.config then
		logError(string.format("Activity130ElementMo no config id:%s", self.elementId))

		return
	end

	self.typeList = string.splitToNumber(self.config.type, "#")
	self.paramList = string.split(self.config.param, "#")
end

function Activity130ElementMo:isAvailable()
	return not self.isFinish and self.visible
end

function Activity130ElementMo:updateHistoryList(list)
	self.historylist = list
end

function Activity130ElementMo:getType()
	return self.typeList[self.index + 1]
end

function Activity130ElementMo:getNextType()
	return self.typeList[self.index + 2]
end

function Activity130ElementMo:getParam()
	return self.paramList[self.index + 1]
end

function Activity130ElementMo:getPrevParam()
	return self.paramList[self.index]
end

return Activity130ElementMo
