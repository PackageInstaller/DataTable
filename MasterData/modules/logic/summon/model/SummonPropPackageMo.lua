-- chunkname: @modules/logic/summon/model/SummonPropPackageMo.lua

module("modules.logic.summon.model.SummonPropPackageMo", package.seeall)

local SummonPropPackageMo = pureTable("SummonPropPackageMo")

function SummonPropPackageMo:ctor()
	self.propOrderDic = {}
end

function SummonPropPackageMo:update(infos)
	tabletool.clear(self.propOrderDic)

	if infos and next(infos) then
		for _, info in ipairs(infos) do
			if not self.propOrderDic[info.orderId] then
				self:addSinglePropInfo(info.orderId, info.recommendPopUpCount)
			end
		end
	end
end

function SummonPropPackageMo:addSinglePropInfo(orderId, recommendPopUpCount)
	self.propOrderDic[orderId] = recommendPopUpCount
end

function SummonPropPackageMo:getOrderPropTimes(orderId)
	return self.propOrderDic[orderId] or 0
end

function SummonPropPackageMo:isOrderProp(orderId)
	return self:getOrderPropTimes(orderId) > 0
end

return SummonPropPackageMo
