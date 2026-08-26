-- chunkname: @modules/logic/room/model/record/RoomLogModel.lua

module("modules.logic.room.model.record.RoomLogModel", package.seeall)

local RoomLogModel = class("RoomLogModel", BaseModel)

function RoomLogModel:onInit()
	self._currentPage = 1
end

function RoomLogModel:reInit()
	self._currentPage = 1
end

function RoomLogModel:getInfos()
	return self._list
end

function RoomLogModel:setInfos(infos)
	self._currentTime = nil
	self._list = {}
	self._newLog = nil

	local function sortfunc(a, b)
		return a.time > b.time
	end

	table.sort(infos, sortfunc)

	for index, info in ipairs(infos) do
		local tab = {}

		tab.type = info.type
		tab.time = info.time
		tab.timestr = TimeUtil.timestampToString4(info.time)

		self:setConfigByType(info, tab)

		local isNewDay = self:checkIsNewDay(info.time)

		if isNewDay and #infos > 0 then
			local dt = os.date("*t", info.time - TimeUtil.OneDaySecond)
			local temp = {}

			temp.type = RoomRecordEnum.LogType.Time
			temp.day = dt.wday

			table.insert(self._list, temp)
		end

		table.insert(self._list, tab)
	end

	if self._newLog then
		RoomController.instance:dispatchEvent(RoomEvent.NewLog, self._newLog)
	end
end

function RoomLogModel:setConfigByType(info, tab)
	if info.type == RoomRecordEnum.LogType.Speical then
		local interactionId = info.id
		local interactionConfig = RoomConfig.instance:getCharacterInteractionConfig(interactionId)
		local heroname = HeroConfig.instance:getHeroCO(interactionConfig.heroId).name

		if heroname then
			tab.heroname = heroname
		end

		local stepId = 0

		tab.config = interactionConfig

		while true do
			tab.logConfigList = tab.logConfigList or {}
			stepId = stepId + 1

			local dialogConfig = RoomConfig.instance:getCharacterDialogConfig(interactionConfig.dialogId, stepId)

			if not dialogConfig then
				break
			end

			table.insert(tab.logConfigList, dialogConfig)
		end
	elseif info.type == RoomRecordEnum.LogType.Normal then
		local config = RoomLogConfig.instance:getLogConfigById(info.id)

		if config then
			tab.content = config.content
		end
	elseif info.type == RoomRecordEnum.LogType.Custom then
		local config = RoomTradeConfig.instance:getTaskCoById(info.id)

		if config then
			tab.config = config
			tab.name = HeroConfig.instance:getHeroCO(tonumber(config.speaker)).name

			local temp = {}

			if not string.nilorempty(config.logtext) then
				temp = string.splitToNumber(config.logtext, "#")
			end

			if #temp > 0 then
				tab.logConfigList = tab.logConfigList or {}

				local endId = temp[2]
				local id = temp[1]

				while id <= endId do
					local logconfig = RoomLogConfig.instance:getLogConfigById(id)

					table.insert(tab.logConfigList, logconfig)

					id = id + 1
				end
			end
		end

		if info.isNew and not self._newLog then
			self._newLog = tab
		end
	end
end

function RoomLogModel:checkIsNewDay(time)
	if not self._currentTime then
		self._currentTime = time

		return false
	elseif time < self._currentTime and not TimeUtil.isSameDay(time, self._currentTime) then
		self._currentTime = time

		return true
	end
end

function RoomLogModel:setPage(page)
	self._currentPage = page
end

function RoomLogModel:getPage()
	return self._currentPage or 1
end

RoomLogModel.instance = RoomLogModel.New()

return RoomLogModel
