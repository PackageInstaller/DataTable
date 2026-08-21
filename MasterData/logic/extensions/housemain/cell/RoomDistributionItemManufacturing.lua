-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomDistributionItemManufacturing.lua

module("logic.extensions.housemain.cell.RoomDistributionItemManufacturing", package.seeall)

local M = class("RoomDistributionItemManufacturing", RoomDistributionItemCell)

function M:onCellBindUI()
	return
end

function M:onCellDestroyUI()
	return
end

function M:onCellBindEvents()
	return
end

function M:onCellUnBindEvents()
	return
end

function M:onCellEnter()
	return
end

function M:onCellExit()
	return
end

function M:onCellClick()
	return
end

function M:onCellSetData()
	self:updateWorkingStateHint(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateProcess(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateSign(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
end

function M:updateWorkingStateHint(roomId, roomType, roomOpenState)
	local hint

	if self:_storeFull() then
		hint = string.format("<color=#fc7171>%s</color>", lang("tip_stop"))
	else
		local activeCount = 0
		local hasSchemeCount = 0

		for i = 1, 3 do
			local mMo = ManufactureModel.instance:getPlantById(i)

			if not mMo:isLock() then
				activeCount = activeCount + 1

				if mMo:getSchemeId() > 0 then
					hasSchemeCount = hasSchemeCount + 1
				end
			end
		end

		if activeCount > 0 then
			if hasSchemeCount > 0 then
				hint = lang("tip_production")
			else
				hint = lang("tip_in_the_free")
			end
		else
			hint = string.format("<color=#fc7171>%s</color>", lang("tip_stop"))
		end
	end

	self._txtHint.text = hint
end

function M:updateSign(roomId, roomType, roomOpenState)
	local rootType = 1
	local storeFull = self:_storeFull()
	local signMark = HouseMainEnum.SignMark.TradeStorageFull

	self:hideSign()

	if storeFull then
		self:createSign(signMark, rootType)
	end
end

function M:updateProcess(roomId, roomType, roomOpenState)
	local count = 0
	local totalStore = 0
	local limit = ManufactureModel.instance:getPlantLimitStore()

	for i = 1, 3 do
		local mMo = ManufactureModel.instance:getPlantById(i)

		if not mMo:isLock() and mMo:getSchemeId() > 0 then
			count = count + 1
			totalStore = totalStore + mMo:getCurrStore()
		end
	end

	local process = totalStore / (limit * count)

	print(string.format("制造厂 有方案车间数[%d] 库存总数[%d] 单个车间上限[%d],process [%s]", count, totalStore, limit, process))

	process = math.floor(process * 100)

	self:setProgress(true, process)
end

function M:_storeFull()
	local count = 0
	local totalStore = 0
	local limit = ManufactureModel.instance:getPlantLimitStore()

	for i = 1, 3 do
		local mMo = ManufactureModel.instance:getPlantById(i)

		if not mMo:isLock() then
			count = count + 1
			totalStore = totalStore + mMo:getCurrStore()
		end
	end

	if totalStore >= count * limit then
		return true
	else
		return false
	end
end

return M
