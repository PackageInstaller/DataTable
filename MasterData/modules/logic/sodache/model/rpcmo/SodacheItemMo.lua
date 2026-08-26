-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheItemMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheItemMo", package.seeall)

local SodacheItemMo = pureTable("SodacheItemMo")

function SodacheItemMo:init(data)
	if self.configId ~= data.configId then
		self._refrainDict = nil
	end

	self.uid = data.uid
	self.configId = data.configId
	self.count = data.count
	self.itemType = SodacheEnum.ItemType.Unknown

	if self.configId >= 10000000 and self.configId < 20000000 then
		self.itemType = SodacheEnum.ItemType.Item
	elseif self.configId >= 20000000 and self.configId < 30000000 then
		self.itemType = SodacheEnum.ItemType.Card
	end

	self.itemCo = SodacheConfig.instance:getItemCo(self.itemType, self.configId)

	if not self.itemCo then
		logError("道具配置不存在!cfgId:" .. self.configId)
	end
end

function SodacheItemMo:getRefrainDict()
	if not self.itemCo then
		return
	end

	if self._refrainDict then
		return self._refrainDict
	end

	local dict

	if self.itemCo.type == SodacheEnum.CardType.Ammo then
		dict = {}

		local arr = string.splitToNumber(self.itemCo.refrain, "#") or {}

		for i, v in ipairs(arr) do
			dict[v] = true
		end
	end

	self._refrainDict = dict

	return dict
end

function SodacheItemMo:isRecommend()
	if not SodacheUtil.isInside() then
		return
	end

	local dict = self:getRefrainDict()

	if not dict or not next(dict) then
		return false
	end

	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		return false
	end

	for i, v in ipairs(insideMo.prop.bossCareerIds) do
		if dict[v] then
			return true
		end
	end

	return false
end

function SodacheItemMo:toCardMo(source)
	local cardMo = SodacheCardMo.New()

	cardMo:init(self, source)

	return cardMo
end

return SodacheItemMo
