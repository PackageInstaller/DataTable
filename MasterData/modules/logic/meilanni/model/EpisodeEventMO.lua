-- chunkname: @modules/logic/meilanni/model/EpisodeEventMO.lua

module("modules.logic.meilanni.model.EpisodeEventMO", package.seeall)

local EpisodeEventMO = pureTable("EpisodeEventMO")

function EpisodeEventMO:init(info)
	self.eventId = info.eventId
	self.isFinish = info.isFinish
	self.option = info.option
	self.index = info.index

	self:_initHistorySelect(info)
	self:_initHistorylist(info)

	self.config = MeilanniConfig.instance:getElementConfig(self.eventId)

	if not self.config then
		logError(string.format("EpisodeEventMO no config id:%s", self.eventId))

		return
	end

	self.interactParam = GameUtil.splitString2(self.config.interactParam, true, "|", "#")
end

function EpisodeEventMO:_initHistorySelect(info)
	self.historySelect = {}

	for i, v in ipairs(info.historySelect) do
		self.historySelect[v] = v
	end
end

function EpisodeEventMO:optionIsSelected(value)
	return self.historySelect[value]
end

function EpisodeEventMO:_initHistorylist(info)
	self.historylist = {}

	for i, v in ipairs(info.historylist) do
		local data = EventHistoryMO.New()

		data:init(v)

		self.historylist[data.index] = data
	end
end

function EpisodeEventMO:getSkipDialog()
	for _, params in ipairs(self.interactParam) do
		if params[1] == MeilanniEnum.ElementType.Dialog then
			local dialogId = params[2]
			local dialogList = lua_activity108_dialog.configDict[dialogId]
			local dialogConfig = dialogList and dialogList[-1]

			if dialogConfig then
				return dialogConfig
			end
		end
	end
end

function EpisodeEventMO:getType()
	local param = self.interactParam[self.index + 1]

	return param and param[1]
end

function EpisodeEventMO:getNextType()
	local param = self.interactParam[self.index + 2]

	return param and param[1]
end

function EpisodeEventMO:getParam()
	local param = self.interactParam[self.index + 1]

	return param and param[2]
end

function EpisodeEventMO:getPrevParam()
	local param = self.interactParam[self.index]

	return param and param[2]
end

function EpisodeEventMO:getBattleId()
	local param = self:getParam()

	return tonumber(param)
end

function EpisodeEventMO:getConfigBattleId()
	for i, v in ipairs(self.interactParam) do
		if v[1] == MeilanniEnum.ElementType.Battle then
			local param = v[2]

			return tonumber(param)
		end
	end
end

return EpisodeEventMO
