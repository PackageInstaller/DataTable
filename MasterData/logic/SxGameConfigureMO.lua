-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/model/SxGameConfigureMO.lua

module("logic.extensions.sxgame.model.SxGameConfigureMO", package.seeall)

local SxGameConfigureMO = class("SxGameConfigureMO")

function SxGameConfigureMO:ctor(cfg)
	self.colorCount = 4
	self._addCellList = {}
	self._itemList = {}
	self.isRamdonColor = true
	self._supplyWeight = {}
	self._addCellList = {}
	self._supplyAddRate = {}
	self.useRandomSpecial = true

	local addWeight = 0

	if cfg then
		self.colorCount = cfg.supplyCount
		self.isRamdonColor = cfg.isRamdonColor

		for i, v in ipairs(cfg.supplyAddType) do
			if v == 2 then
				table.insert(self._addCellList, SxGameCellAddType.Ice_1)

				self._supplyAddRate[SxGameCellAddType.Ice_1] = cfg.supplyAddRate[i]
			else
				table.insert(self._addCellList, v)

				self._supplyAddRate[v] = cfg.supplyAddRate[i]
			end
		end

		self._itemList = cfg.supplyType

		for i, v in ipairs(self._itemList) do
			self._supplyWeight[v] = cfg.supplyWeight[i]
			addWeight = addWeight + cfg.supplyWeight[i]
		end

		self.useRandomSpecial = false
	end

	self._totalWeight = 1000 * self.colorCount + addWeight
end

function SxGameConfigureMO:getTotalWeight()
	return checknumber(self._totalWeight)
end

function SxGameConfigureMO:getTypeWeight(type)
	return checknumber(self._supplyWeight[type])
end

function SxGameConfigureMO:getAddTypeRate(type)
	return checknumber(self._supplyAddRate[type])
end

return SxGameConfigureMO
