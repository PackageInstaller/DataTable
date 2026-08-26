-- chunkname: @modules/logic/rouge2/common/model/Rouge2_GameMapRecordInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_GameMapRecordInfoMO", package.seeall)

local Rouge2_GameMapRecordInfoMO = pureTable("Rouge2_GameMapRecordInfoMO")

function Rouge2_GameMapRecordInfoMO:init(info)
	self:initFinishEntrust(info.finishEntrust)
	self:initChoiceSelectInfo(info.choiceSelect)
	self:initFinishEventInfo(info.finishEvent)
end

function Rouge2_GameMapRecordInfoMO:initFinishEntrust(finishEntrust)
	self._finishEntrustMap = {}
	self._finishEntrustList = {}

	if finishEntrust then
		for _, entrustId in ipairs(finishEntrust) do
			table.insert(self._finishEntrustList, entrustId)

			self._finishEntrustMap[entrustId] = true
		end
	end
end

function Rouge2_GameMapRecordInfoMO:initChoiceSelectInfo(choiceSelect)
	self._choiceSelectMap = {}
	self._choiceSelectList = {}

	if choiceSelect then
		for _, choiceId in ipairs(choiceSelect) do
			table.insert(self._choiceSelectList, choiceId)

			self._choiceSelectMap[choiceId] = true
		end
	end
end

function Rouge2_GameMapRecordInfoMO:initFinishEventInfo(finishEvent)
	self._finishEventMap = {}
	self._finishEventList = {}

	if finishEvent then
		for _, eventId in ipairs(finishEvent) do
			table.insert(self._finishEventList, eventId)

			self._finishEventMap[eventId] = true
		end
	end
end

function Rouge2_GameMapRecordInfoMO:isChoiceSelect(choiceId)
	return self._choiceSelectMap and self._choiceSelectMap[choiceId] == true
end

function Rouge2_GameMapRecordInfoMO:isFinishEvent(eventId)
	return self._finishEventMap and self._finishEventMap[eventId] == true
end

function Rouge2_GameMapRecordInfoMO:isFinishEntrust(entrustId)
	return self._finishEntrustMap and self._finishEntrustMap[entrustId] == true
end

function Rouge2_GameMapRecordInfoMO:getFinishEntrustNum()
	return (self._finishEntrustList or nil) and (#self._finishEntrustList or 0)
end

function Rouge2_GameMapRecordInfoMO:getFinishEntrustIdList()
	return self._finishEntrustList
end

return Rouge2_GameMapRecordInfoMO
