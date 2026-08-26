-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131ElementMo.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131ElementMo", package.seeall)

local Activity131ElementMo = pureTable("Activity131ElementMo")

function Activity131ElementMo:ctor()
	self.elementId = 0
	self.isFinish = false
	self.index = 0
	self.historylist = {}
	self.visible = false
	self.config = {}
	self.typeList = {}
	self.paramList = {}
end

function Activity131ElementMo:init(info)
	self.elementId = info.elementId
	self.isFinish = info.isFinish
	self.index = info.index
	self.historylist = {}

	for _, v in ipairs(info.historylist) do
		table.insert(self.historylist, v)
	end

	self.visible = info.visible

	local actId = VersionActivity1_4Enum.ActivityId.Role6

	self.config = Activity131Config.instance:getActivity131ElementCo(actId, self.elementId)

	if not self.config then
		logError(string.format("Activity131ElementMo no config id:%s", self.elementId))

		return
	end

	self.typeList = string.splitToNumber(self.config.type, "#")
	self.paramList = string.split(self.config.param, "#")
end

function Activity131ElementMo:isAvailable()
	return not self.isFinish and self.visible
end

function Activity131ElementMo:updateHistoryList(list)
	self.historylist = list
end

function Activity131ElementMo:getType()
	return self.typeList[self.index + 1]
end

function Activity131ElementMo:getNextType()
	return self.typeList[self.index + 2]
end

function Activity131ElementMo:getParam()
	return self.paramList[self.index + 1]
end

function Activity131ElementMo:getPrevParam()
	return self.paramList[self.index]
end

return Activity131ElementMo
