-- chunkname: @modules/logic/survival/model/store/SurvivalStoreModel.lua

module("modules.logic.survival.model.store.SurvivalStoreModel", package.seeall)

local SurvivalStoreModel = class("SurvivalStoreModel", BaseModel)

function SurvivalStoreModel:onInit()
	return
end

function SurvivalStoreModel:reInit()
	return
end

function SurvivalStoreModel:clear()
	SurvivalStoreModel.super.clear(self)
end

function SurvivalStoreModel:onReceiveSurvivalOutsideShopBuyReply(msg)
	local mo = self.goodsMODic[msg.id]

	if mo then
		mo:onReceiveSurvivalOutsideShopBuyReply(msg.count)
	end
end

function SurvivalStoreModel:setData(data)
	self.data = data
	self.goodsMOs = {}
	self.goodsMODic = {}

	for i, v in ipairs(self.data.items) do
		local mo = SurvivalGoodsMO.New()

		mo:setData(v)
		table.insert(self.goodsMOs, mo)

		self.goodsMODic[v.id] = mo
	end
end

function SurvivalStoreModel:getGoodsMos()
	local mos = {}

	for _, mo in ipairs(self.goodsMOs) do
		table.insert(mos, mo)
	end

	return mos
end

function SurvivalStoreModel:getGoodsMosByTabId(id)
	local mos = {}

	for _, mo in ipairs(self.goodsMOs) do
		if mo:getTagId() == id then
			table.insert(mos, mo)
		end
	end

	return mos
end

SurvivalStoreModel.instance = SurvivalStoreModel.New()

return SurvivalStoreModel
