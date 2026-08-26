-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookListModel.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookListModel", package.seeall)

local ArcadeHandBookListModel = class("ArcadeHandBookListModel", ListScrollModel)

function ArcadeHandBookListModel:setMoList(type)
	self.moList = self.moList or {}

	if not self.moList[type] then
		local moList = ArcadeHandBookModel.instance:getMoListByType(type)

		self.moList[type] = {}

		if moList then
			for i, mo in pairs(moList) do
				table.insert(self.moList[type], mo)
			end

			self:_setItemAnchor(type)
		end
	end

	self:setList(self.moList[type])
end

function ArcadeHandBookListModel:_setItemAnchor(type)
	local moList = self.moList[type]

	if not moList then
		return
	end

	table.sort(moList, self.sort)

	local itemParams = ArcadeEnum.HandBookItemParams
	local lineMoList = {}
	local minSize = itemParams.MinSize

	for i, mo in pairs(moList) do
		if not mo then
			return
		end

		local lineMoCount = #lineMoList
		local sizeX, sizeY = mo:getIconSize()
		local anchorY = itemParams.StartY
		local preMo = moList[i - 1]

		if preMo then
			local _, preSizeY = preMo:getIconSize()
			local _, preAnchorY = preMo:getAnchor()

			if sizeX >= itemParams.RowCount * minSize then
				anchorY = preSizeY + preAnchorY + itemParams.SpaceY
				lineMoList = {}
			elseif lineMoCount > itemParams.RowCount - sizeX / minSize then
				anchorY = preSizeY + preAnchorY + itemParams.SpaceY
				lineMoList = {}
			elseif preSizeY < sizeY then
				local _preMo = moList[i - lineMoCount - 1]

				if _preMo then
					local _, _preSizeY = _preMo:getIconSize()
					local _, _preAnchorY = _preMo:getAnchor()

					anchorY = _preSizeY + _preAnchorY + itemParams.SpaceY
				else
					anchorY = itemParams.StartY
				end

				for _, __preMo in ipairs(lineMoList) do
					local _, __preSizeY = __preMo:getIconSize()
					local __anchorY = anchorY + sizeY - __preSizeY

					__preMo:setAnchorY(__anchorY)
				end
			else
				anchorY = preAnchorY
			end
		end

		table.insert(lineMoList, mo)
		self:_calculateAnchorX(lineMoList)
		mo:setAnchorY(anchorY)
	end
end

function ArcadeHandBookListModel:_calculateAnchorX(lineMoList)
	local itemParams = ArcadeEnum.HandBookItemParams
	local lineMoCount = #lineMoList

	for i, mo in ipairs(lineMoList) do
		local sizeX, _ = mo:getIconSize()
		local anchorX = 0
		local isMinSizeX = sizeX == itemParams.MinSize
		local preMo = lineMoList[i - 1]

		if preMo then
			local preSizeX, _ = preMo:getIconSize()
			local preAnchorX, _ = preMo:getAnchor()

			if lineMoCount == 2 then
				if isMinSizeX then
					local itemSizeX = itemParams.MinSize
					local remain = itemParams.MaxWidth - itemParams.StartX - itemSizeX * itemParams.RowCount
					local offset = math.max(remain / 2, 0)

					anchorX = preAnchorX + preSizeX + offset
				else
					anchorX = itemParams.MaxWidth - sizeX
				end
			else
				local remain = itemParams.MaxWidth - itemParams.StartX

				for _, _mo in ipairs(lineMoList) do
					local _sizex, _ = _mo:getIconSize()

					remain = remain - _sizex
				end

				local offset = math.max(remain / (lineMoCount - 1), 0)

				anchorX = preAnchorX + preSizeX + offset
			end
		else
			anchorX = lineMoCount == 1 and (isMinSizeX and itemParams.StartX or itemParams.MaxWidth * 0.5 - sizeX * 0.5) or itemParams.StartX
		end

		mo:setAnchorX(anchorX)
		mo:setRowInfo(lineMoCount, i)
	end
end

function ArcadeHandBookListModel:getMoByTypeIndex(type, index)
	return self.moList and self.moList[type] and self.moList[type][index]
end

function ArcadeHandBookListModel.sort(a, b)
	local a_sizeX, a_sizeY = a:getIconSize()
	local b_sizeX, b_sizeY = b:getIconSize()

	if a_sizeX ~= b_sizeX then
		return a_sizeX < b_sizeX
	end

	if a_sizeY ~= b_sizeY then
		return a_sizeY < b_sizeY
	end

	return a:getId() < b:getId()
end

ArcadeHandBookListModel.instance = ArcadeHandBookListModel.New()

return ArcadeHandBookListModel
