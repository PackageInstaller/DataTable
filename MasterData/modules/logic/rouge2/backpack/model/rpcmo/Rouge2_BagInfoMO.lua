-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_BagInfoMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_BagInfoMO", package.seeall)

local Rouge2_BagInfoMO = pureTable("Rouge2_BagInfoMO")

function Rouge2_BagInfoMO:init(info)
	self:_initBagMap(info)
end

function Rouge2_BagInfoMO:_initBagMap(info)
	self._bagMap = {}

	if info then
		for _, bagInfo in ipairs(info.bags) do
			local bagType = bagInfo.bagType

			if not Rouge2_Enum.BagType2MoCls[bagType] then
				local bagCls = Rouge2_BagMO
				local bagMo = bagCls.New()

				bagMo:init(bagInfo)

				self._bagMap[bagType] = bagMo
			end
		end
	end
end

function Rouge2_BagInfoMO:getBag(bagType)
	return self._bagMap and self._bagMap[bagType]
end

function Rouge2_BagInfoMO:removeItems(itemInfoList)
	for _, itemInfo in ipairs(itemInfoList) do
		local uid = itemInfo.uid
		local bagType = Rouge2_BackpackHelper.uid2BagType(uid)
		local bagMo = self:getBag(bagType)

		if bagMo then
			bagMo:removeItem(itemInfo)
		end
	end
end

function Rouge2_BagInfoMO:updateItems(itemInfoList)
	for _, itemInfo in ipairs(itemInfoList) do
		local uid = itemInfo.uid
		local bagType = Rouge2_BackpackHelper.uid2BagType(uid)
		local bagMo = self:getBag(bagType)

		if not bagMo then
			bagMo = Rouge2_BagMO.New()

			bagMo:init({
				bagType = bagType
			})

			self._bagMap[bagType] = bagMo
		end

		if bagMo then
			bagMo:updateItem(itemInfo)
		end
	end
end

return Rouge2_BagInfoMO
