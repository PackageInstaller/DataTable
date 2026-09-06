-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/model/SupplymergeModel.lua

module("logic.extensions.strength.model.SupplymergeModel", package.seeall)

local SupplymergeModel = class("SupplymergeModel", BaseModel)

function SupplymergeModel:ctor()
	SupplymergeModel.super.ctor(self)
end

function SupplymergeModel:onInit()
	self:onReset()
end

function SupplymergeModel:onReset()
	self._strengthPrize = false
	self._info = {}
end

function SupplymergeModel:onBasicBenefitsGetInfoRes(msg)
	self._strengthPrize = msg.isGainStrengthPrize
	self._info = GameUtil.pbToTable(msg.infos) or {}
end

function SupplymergeModel:isStrengthPrize()
	return self._strengthPrize
end

function SupplymergeModel:onBasicBenefitsGainStrengthPrizeRes(msg)
	self._strengthPrize = true
end

function SupplymergeModel:onBasicBenefitsGainPrizeRes(indexList)
	for _, index in ipairs(indexList or {}) do
		for _, v in pairs(self._info) do
			if v and v.index == index then
				v.isGainPrize = true

				break
			end
		end
	end
end

function SupplymergeModel:getCellState(index)
	for _, v in pairs(self._info or {}) do
		if v and v.index == index then
			return v.isGainPrize
		end
	end

	return false
end

SupplymergeModel.instance = SupplymergeModel.New()

return SupplymergeModel
