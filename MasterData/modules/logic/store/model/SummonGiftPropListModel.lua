-- chunkname: @modules/logic/store/model/SummonGiftPropListModel.lua

module("modules.logic.store.model.SummonGiftPropListModel", package.seeall)

local SummonGiftPropListModel = class("SummonGiftPropListModel", ListScrollModel)

function SummonGiftPropListModel:refreshList(goodsMoList)
	local moList = {}
	local count = 0

	if not goodsMoList or next(goodsMoList) == nil then
		logError("找不到对应卡池的礼包数据")
	else
		for _, goodsMo in ipairs(goodsMoList) do
			local mo = {}

			mo.goodsMo = goodsMo
			count = count + 1

			table.insert(moList, mo)
		end
	end

	if count < StoreEnum.SummonPoolPackageMinCount then
		for i = count + 1, StoreEnum.SummonPoolPackageMinCount do
			local mo = {}

			table.insert(moList, mo)
		end
	end

	self:setList(moList)
end

SummonGiftPropListModel.instance = SummonGiftPropListModel.New()

return SummonGiftPropListModel
