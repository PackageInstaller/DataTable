-- chunkname: @modules/logic/battlepass/model/BpBonusModel.lua

module("modules.logic.battlepass.model.BpBonusModel", package.seeall)

local BpBonusModel = class("BpBonusModel", ListScrollModel)

function BpBonusModel:onInit()
	self._getBonus = {}
	self.serverBonusModel = BaseModel.New()
end

function BpBonusModel:reInit()
	self._getBonus = {}

	self.serverBonusModel:clear()
end

function BpBonusModel:onGetInfo(bonusInfoList)
	local list = {}

	for _, info in ipairs(bonusInfoList) do
		local mo = BpBonusMO.New()

		mo:init(info)
		table.insert(list, mo)
	end

	self.serverBonusModel:setList(list)
end

function BpBonusModel:initGetSelectBonus(getBonus)
	self._getBonus = {}

	for i, v in ipairs(getBonus) do
		self._getBonus[v.level] = v.index + 1
	end
end

function BpBonusModel:markSelectBonus(level, index)
	self._getBonus[level] = index + 1
end

function BpBonusModel:isGetSelectBonus(level)
	return self._getBonus[level] or nil
end

function BpBonusModel:updateInfo(bonusInfoList)
	for _, info in ipairs(bonusInfoList) do
		local mo = self.serverBonusModel:getById(info.level)

		if mo then
			mo:updateServerInfo(info)
		else
			local mo = BpBonusMO.New()

			mo:init(info)
			self.serverBonusModel:addAtLast(mo)
		end
	end
end

function BpBonusModel:refreshListView()
	local list = {}
	local coList = BpConfig.instance:getBonusCOList(BpModel.instance.id)

	for _, co in ipairs(coList) do
		local serverMO = self.serverBonusModel:getById(co.level)

		if serverMO then
			table.insert(list, serverMO)
		else
			local bpBonusMO = self:getById(co.level)

			if not bpBonusMO then
				bpBonusMO = BpBonusMO.New()

				bpBonusMO:init({
					hasGetfreeBonus = false,
					hasGetPayBonus = false,
					hasGetSpPayBonus = false,
					hasGetSpfreeBonus = false,
					level = co.level
				})
			end

			table.insert(list, bpBonusMO)
		end
	end

	self:setList(list)
end

BpBonusModel.instance = BpBonusModel.New()

return BpBonusModel
