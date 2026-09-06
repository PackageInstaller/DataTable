-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/model/PanTaoFeastModel.lua

module("logic.extensions.pantaofeast.model.PanTaoFeastModel", package.seeall)

local PanTaoFeastModel = class("PanTaoFeastModel", BaseModel)

function PanTaoFeastModel:onInit()
	self:onReset()
end

function PanTaoFeastModel:onReset()
	self._infoMap = {}
	self._rankInfoMap = {}
end

function PanTaoFeastModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId
	local boardGridMap = {}

	if data.boardGridElements then
		for _, grid in ipairs(data.boardGridElements) do
			boardGridMap[grid.gridId] = grid
		end
	end

	local storeElementMap = {}

	if data.storeElements then
		for _, store in ipairs(data.storeElements) do
			storeElementMap[store.stashId] = store
		end
	end

	local orderIdMap = {}

	if data.orderIds then
		for _, orderId in ipairs(data.orderIds) do
			orderIdMap[orderId] = true
		end
	end

	local gainedRoundPrizeIdMap = {}

	if data.gainedRoundPrizeIds then
		for _, prizeId in ipairs(data.gainedRoundPrizeIds) do
			gainedRoundPrizeIdMap[prizeId] = true
		end
	end

	local unlockedBookIdMap = {}

	if data.unlockedBookIds then
		for _, bookId in ipairs(data.unlockedBookIds) do
			unlockedBookIdMap[bookId] = true
		end
	end

	local gainedBookPrizeIdMap = {}

	if data.gainedBookPrizeIds then
		for _, bookId in ipairs(data.gainedBookPrizeIds) do
			gainedBookPrizeIdMap[bookId] = true
		end
	end

	data.boardGridMap = boardGridMap
	data.storeElementMap = storeElementMap
	data.orderIdMap = orderIdMap
	data.gainedRoundPrizeIdMap = gainedRoundPrizeIdMap
	data.unlockedBookIdMap = unlockedBookIdMap
	data.gainedBookPrizeIdMap = gainedBookPrizeIdMap
	self._infoMap[activityId] = data
end

function PanTaoFeastModel:onNotifyChange(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if not info then
		return
	end

	if not info.boardGridMap then
		local boardGridMap = {}

		if data.changedGridElements then
			for _, grid in ipairs(data.changedGridElements) do
				boardGridMap[grid.gridId] = grid
			end

			info.boardGridMap = boardGridMap
		end

		if data.score ~= nil then
			info.score = (info.score or 0) + data.score
		end

		if data.unlockedBookIds then
			if not info.unlockedBookIdMap then
				local unlockedBookIdMap = {}

				for _, bookId in ipairs(data.unlockedBookIds) do
					unlockedBookIdMap[bookId] = true
				end

				info.unlockedBookIdMap = unlockedBookIdMap
			end
		end
	end
end

function PanTaoFeastModel:onMoveToStore(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info and data.storeElement then
		if not info.storeElementMap then
			info.storeElementMap[data.storeElement.stashId] = data.storeElement
			info.storeElementMap = info.storeElementMap
		end
	end
end

function PanTaoFeastModel:onCookDish(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info and data.dishElement then
		if not info.storeElementMap then
			info.storeElementMap[data.dishElement.stashId] = data.dishElement
			info.storeElementMap = info.storeElementMap
		end
	end
end

function PanTaoFeastModel:onStashToGrid(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info and data.storeElement then
		if not info.storeElementMap then
			info.storeElementMap[data.storeElement.stashId] = data.storeElement
			info.storeElementMap = info.storeElementMap
		end
	end
end

function PanTaoFeastModel:onDeleteGridElement(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		-- block empty
	end
end

function PanTaoFeastModel:onSubmitOrder(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.orderIdMap then
			info.orderIdMap[data.orderId] = true
			info.orderIdMap = info.orderIdMap
		end
	end
end

function PanTaoFeastModel:onGainRoundPrize(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.roundId then
			info.roundId = data.roundId
			info.orderIdMap = info.orderIdMap or {}
			info.gainedRoundPrizeIdMap = info.gainedRoundPrizeIdMap or {}
			info.gainedRoundPrizeIdMap[data.roundId - 1] = true

			if info.roundId > 0 and data.roundId == info.roundId then
				info.gainedRoundPrizeIdMap[data.roundId] = true
			end
		end
	end
end

function PanTaoFeastModel:onRepairBuilding(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.repairedBuildingCount = data.repairedBuildingCount
	end
end

function PanTaoFeastModel:onGainBookPrize(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.gainedBookPrizeIdMap then
			if data.bookIds then
				for _, bookId in ipairs(data.bookIds) do
					info.gainedBookPrizeIdMap[bookId] = true
				end
			end

			info.gainedBookPrizeIdMap = info.gainedBookPrizeIdMap
		end
	end
end

function PanTaoFeastModel:onGainDailyGift(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.dailyGiftId = data.nextGiftId
		info.dailyGiftGainCount = data.dailyGiftGainCount
	end
end

function PanTaoFeastModel:onGetRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._rankInfoMap = self._rankInfoMap or {}
	self._rankInfoMap[data.activityId] = data
end

function PanTaoFeastModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function PanTaoFeastModel:getRankInfo(activityId)
	if self._rankInfoMap then
		return self._rankInfoMap[activityId]
	end
end

function PanTaoFeastModel:hasUnlockedBook(activityId, elementId)
	local info = self._infoMap[activityId]

	if info then
		if not info.unlockedBookIdMap then
			local unlockedBookIdMap = {}

			return unlockedBookIdMap[elementId] == true
		end
	end

	return false
end

function PanTaoFeastModel:hasGainBookPrize(activityId, elementId)
	local info = self._infoMap[activityId]

	if info then
		if not info.gainedBookPrizeIdMap then
			local gainedBookPrizeIdMap = {}

			return gainedBookPrizeIdMap[elementId] == true
		end
	end

	return false
end

function PanTaoFeastModel:getStoreElementInfo(activityId, stashId)
	local info = self._infoMap[activityId]

	if info then
		if not info.storeElementMap then
			return info.storeElementMap[stashId]
		end
	end

	return nil
end

function PanTaoFeastModel:getCurRoundId(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.roundId or 0
	end

	return 0
end

function PanTaoFeastModel:hasGainOrder(activityId, orderId)
	local info = self._infoMap[activityId]

	if info then
		if not info.orderIdMap then
			local orderIdMap = {}

			return orderIdMap[orderId] == true
		end
	end

	return false
end

function PanTaoFeastModel:hasGainRoundPrize(activityId, roundPrizeId)
	local info = self._infoMap[activityId]

	if info then
		if not info.gainedRoundPrizeIdMap then
			local gainedRoundPrizeIdMap = {}

			return gainedRoundPrizeIdMap[roundPrizeId] == true
		end
	end

	return false
end

function PanTaoFeastModel:syncTempGridDataToModel(activityId)
	local gridDataList = PanTaoFeastGameController.instance:getCurGridDataList(activityId)
	local info = self._infoMap[activityId]

	if gridDataList and #gridDataList > 0 and info then
		local boardGridMap = {}

		for _, griddata in ipairs(gridDataList) do
			local gridId = griddata:getGridId()
			local isLocked = griddata:isLock()
			local elementId = griddata:getElementId()

			boardGridMap[gridId] = {
				gridId = gridId,
				state = isLocked and 1 or 0,
				elementId = elementId
			}
			info.boardGridMap = boardGridMap
		end
	end
end

PanTaoFeastModel.instance = PanTaoFeastModel.New()

return PanTaoFeastModel
