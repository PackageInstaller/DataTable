-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/model/SxGameCellMO.lua

module("logic.extensions.sxgame.model.SxGameCellMO", package.seeall)

local SxGameCellMO = class("SxGameCellMO")

function SxGameCellMO:ctor()
	self._type = 0
	self._x = 0
	self._y = 0
	self._cellRes = nil
	self._addType = {}
	self._isIce = false
	self._defualIceCount = SxGameCellAddType.Ice_1
	self._defualBoxCount = SxGameCellAddType.Ice_6
end

function SxGameCellMO:initCell()
	if self._type == SxGameCellType.Red then
		self._cellRes = "ui/views/sxgame/itemred.prefab"
	elseif self._type == SxGameCellType.Yellow then
		self._cellRes = "ui/views/sxgame/itemyellow.prefab"
	elseif self._type == SxGameCellType.Green then
		self._cellRes = "ui/views/sxgame/itemgreen.prefab"
	elseif self._type == SxGameCellType.Purple then
		self._cellRes = "ui/views/sxgame/itempurple.prefab"
	elseif self._type == SxGameCellType.Flash then
		self._cellRes = "ui/views/sxgame/itemflash.prefab"
	elseif self._type == SxGameCellType.Bloom then
		self._cellRes = "ui/views/sxgame/itembloom.prefab"
	elseif self._type == SxGameCellType.FlashShu then
		self._cellRes = "ui/views/sxgame/itemshuflash.prefab"
	elseif self._type == SxGameCellType.Blue then
		self._cellRes = "ui/views/sxgame/itemblue.prefab"
	elseif self._type == SxGameCellType.MoveForward then
		self._cellRes = "ui/views/sxgame/itemforward.prefab"
	elseif self._type == SxGameCellType.MoveBack then
		self._cellRes = "ui/views/sxgame/itemback.prefab"
	elseif self._type == SxGameCellType.Block then
		self._cellRes = "ui/views/sxgame/itemblock.prefab"
	end
end

function SxGameCellMO:getCellRes()
	return self._cellRes
end

function SxGameCellMO:typeToString()
	if #self._addType <= 0 then
		if self._type == SxGameCellType.FlashShu then
			return string.format("%d-%d", SxGameCellType.FlashShu, self._type)
		elseif self._type == SxGameCellType.Flash then
			return string.format("%d-%d", SxGameCellType.Flash, self._type)
		end

		return string.format("%d", self._type)
	else
		for i, v in pairs(self._addType) do
			if v == SxGameCellAddType.Ice_1 then
				return string.format("2-%d", self._type)
			end
		end

		if self._type == SxGameCellType.FlashShu then
			return string.format("%d-%d", SxGameCellType.FlashShu, self._type)
		elseif self._type == SxGameCellType.Flash then
			return string.format("%d-%d", SxGameCellType.Flash, self._type)
		elseif self._type == SxGameCellType.RambowBall or self._type == SxGameCellType.Fly then
			for i, v in ipairs(self._addType) do
				if v >= SxGameCellAddType.Red and v <= SxGameCellAddType.Purple then
					return string.format("%d-%d", v, self._type)
				end
			end
		end

		return string.format("%d", self._type)
	end
end

function SxGameCellMO:string2Type(str)
	self._isIce = false

	local params = string.split(str, "-")

	if #params == 1 then
		if checknumber(params[1]) == SxGameCellType.Box then
			self._type = SxGameCellType.EmptyShow

			table.insert(self._addType, self._defualBoxCount)

			self._isIce = true
		else
			self._type = checknumber(params[1])
		end
	elseif #params >= 2 then
		self._type = checknumber(params[#params])
		self._addType = {}

		local iceLevel = 0

		if self._type == SxGameCellType.Box then
			iceLevel = iceLevel + self._defualBoxCount
			self._type = SxGameCellType.EmptyShow
		end

		for i, v in pairs(params) do
			if checknumber(v) == 2 then
				table.insert(self._addType, self._defualIceCount + iceLevel)

				iceLevel = 0
				self._isIce = true
			elseif checknumber(v) == SxGameCellType.FlashShu then
				self._type = SxGameCellType.FlashShu
			elseif checknumber(v) == SxGameCellType.Flash then
				self._type = SxGameCellType.Flash
			elseif checknumber(v) >= SxGameCellAddType.Red and checknumber(v) <= SxGameCellAddType.Purple and (self._type < SxGameCellAddType.Red or self._type > SxGameCellAddType.Purple) then
				table.insert(self._addType, checknumber(v))
			end
		end

		if iceLevel > 0 then
			table.insert(self._addType, self._defualIceCount + iceLevel)

			self._isIce = true
		end
	end
end

return SxGameCellMO
