-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/model/ExchangeTabInfoMo.lua

module("logic.extensions.exchange.model.ExchangeTabInfoMo", package.seeall)

local ExchangeTabInfoMo = class("ExchangeTabInfoMo")

function ExchangeTabInfoMo:ctor(tabId)
	self.tabId = tabId
end

function ExchangeTabInfoMo:setData(tabInfo)
	self.refreshTimes = tabInfo.refreshTimes
	self.infos = tabInfo.infos

	self:initItems()
end

function ExchangeTabInfoMo:addHasExchange(posId, num)
	for i, tem in ipairs(self.items) do
		if tem.info and tem.info.posId == posId then
			local isLimitBuy = ExchangeController.instance:isBuyLimit(tem.cfg.commodityProgramId)

			if isLimitBuy then
				tem.info.posLimitBuyNum = tem.info.posLimitBuyNum + num
			end

			tem.info.curBuyNum = checknumber(tem.info.curBuyNum) + num
			self.items[i] = tem

			break
		end
	end
end

function ExchangeTabInfoMo:initItems()
	self.items = {}

	for k, v in ipairs(self.infos) do
		local tb = GameUtil.pbToTable(v)
		local tem = {}

		tem.cfg = ExchangeConfig.instance:getItemById(v.commodityId)
		tem.info = v

		table.insert(self.items, tem)
	end
end

function ExchangeTabInfoMo:getItems()
	return self.items
end

return ExchangeTabInfoMo
