-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroStarReward.lua

HeroStarReward = class("HeroStarReward", objectlua.Object, _M)

HeroStarReward:has("_star", {
	is = "r"
})
HeroStarReward:has("_itemIds", {
	is = "r"
})
HeroStarReward:has("_itemCount", {
	is = "r"
})
HeroStarReward:has("_selectId", {
	is = "r"
})

function HeroStarReward:initialize(star)
	super.initialize(self)

	self._star = star
	self._itemIds = {}
	self._itemCount = 0
	self._selectId = nil
end

function HeroStarReward:synchronize(data)
	if data.itemIds then
		for i, v in pairs(data.itemIds) do
			self._itemIds[tonumber(i) + 1] = v
		end
	end

	if data.itemCount then
		self._itemCount = data.itemCount
	end

	if data.selectId and data.selectId ~= "" then
		self._selectId = data.selectId
	end
end

function HeroStarReward:isGotReward()
	return not not self._selectId
end
