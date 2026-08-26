-- chunkname: @modules/logic/sodache/model/SodacheShopSelectMo.lua

module("modules.logic.sodache.model.SodacheShopSelectMo", package.seeall)

local SodacheShopSelectMo = pureTable("SodacheShopSelectMo")
local MAX_BUY_COUNT = 99

function SodacheShopSelectMo:ctor()
	self.curSelectGoods = {}
	self.isMultSelect = false
end

function SodacheShopSelectMo:getGoodSelectCount(goodId)
	if not self.curSelectGoods[1] then
		return 0
	end

	goodId = goodId or self.curSelectGoods[1].shopMo.id

	for i, v in ipairs(self.curSelectGoods) do
		if v.shopMo.id == goodId then
			return v.selectCount
		end
	end

	return 0
end

function SodacheShopSelectMo:addGoodCount(shopMo, count)
	if shopMo.count == 0 then
		GameFacade.showToast(ToastEnum.SodacheToastId373007)

		return
	end

	if self.isMultSelect then
		local isFind = false

		for i, v in ipairs(self.curSelectGoods) do
			if v.shopMo.id == shopMo.id then
				isFind = true

				if shopMo.count ~= -1 and v.selectCount + count > shopMo.count then
					GameFacade.showToast(ToastEnum.SodacheToastId373007)

					return
				end

				v.selectCount = v.selectCount + count

				if v.selectCount <= 0 then
					table.remove(self.curSelectGoods, i)
				end

				break
			end
		end

		if not isFind and count >= 0 then
			local goodMo = SodacheShopGoodsMo.New()

			goodMo:init(shopMo)

			goodMo.selectCount = math.max(count, 1)

			table.insert(self.curSelectGoods, goodMo)
		end
	else
		self.curSelectGoods[1] = self.curSelectGoods[1] or SodacheShopGoodsMo.New()

		if self.curSelectGoods[1].shopMo ~= shopMo then
			self.curSelectGoods[1]:init(shopMo)
		end

		self.curSelectGoods[1].selectCount = math.max(1, self.curSelectGoods[1].selectCount + count)
		self.curSelectGoods[1].selectCount = shopMo.count ~= -1 and math.min(shopMo.count, self.curSelectGoods[1].selectCount, MAX_BUY_COUNT) or math.min(MAX_BUY_COUNT, self.curSelectGoods[1].selectCount)
	end
end

function SodacheShopSelectMo:addCurGoodCount(count)
	if self.isMultSelect or not self.curSelectGoods[1] then
		return
	end

	local shopMo = self.curSelectGoods[1].shopMo

	self:addGoodCount(shopMo, count)
end

function SodacheShopSelectMo:setCurGoodMax()
	if self.isMultSelect or not self.curSelectGoods[1] then
		return
	end

	local shopMo = self.curSelectGoods[1].shopMo

	self.curSelectGoods[1].selectCount = shopMo.count ~= -1 and math.max(shopMo.count, self.curSelectGoods[1].selectCount) or MAX_BUY_COUNT
end

function SodacheShopSelectMo:setCurGoodMin()
	if self.isMultSelect or not self.curSelectGoods[1] then
		return
	end

	self.curSelectGoods[1].selectCount = 1
end

function SodacheShopSelectMo:clearAllGoodSelect()
	self.curSelectGoods = {}
end

return SodacheShopSelectMo
