-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/model/TripleMacthesGameConfigureMO.lua

module("logic.extensions.triplemacthesgame.model.TripleMacthesGameConfigureMO", package.seeall)

local TripleMacthesGameConfigureMO = class("TripleMacthesGameConfigureMO")

function TripleMacthesGameConfigureMO:ctor(cfg)
	self.colorCount = 4
	self._addCellList = {}
	self._itemList = {}
	self.isRamdonColor = true
	self._supplyWeight = {}
	self._addCellList = {}
	self._supplyAddRate = {}
	self.useRandomSpecial = true
	self.isRamdonItem = false
	self.blockIconCfg = TripleMachesGameConfig.instance:getBlockIconReplace(cfg.blockIconPlanId)

	local addWeight = 0

	if cfg then
		self.colorCount = cfg.supplyCount
		self.isRamdonColor = cfg.isRamdonColor
		self.isRamdonItem = cfg.isRamdonItem
		self.defaultIce = cfg.iceCount
		self.defalutBox = cfg.boxCount

		for i, v in ipairs(cfg.supplyAddType) do
			if v == 2 then
				table.insert(self._addCellList, self.defaultIce)

				self._supplyAddRate[self.defaultIce] = cfg.supplyAddRate[i]
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
		self.supplyLimit = {}

		if checknumber(cfg.itemPlanId) > 0 then
			local itemCfg = TripleMachesGameConfig.instance:getItemSupplyCfg(cfg.itemPlanId)

			for i, v in pairs(itemCfg) do
				self.supplyLimit[i] = v.number
			end
		end

		self.useFixSupply = checknumber(cfg.itemCount)
		self.flyClearCellCount = cfg.flyCount
	end

	self._totalWeight = 1000 * self.colorCount + addWeight
end

function TripleMacthesGameConfigureMO:getTotalWeight()
	return checknumber(self._totalWeight)
end

function TripleMacthesGameConfigureMO:getTypeWeight(type)
	return checknumber(self._supplyWeight[type])
end

function TripleMacthesGameConfigureMO:getAddTypeRate(type)
	return checknumber(self._supplyAddRate[type])
end

return TripleMacthesGameConfigureMO
