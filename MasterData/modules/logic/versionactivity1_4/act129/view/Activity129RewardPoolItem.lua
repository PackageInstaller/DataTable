-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129RewardPoolItem.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129RewardPoolItem", package.seeall)

local Activity129RewardPoolItem = class("Activity129RewardPoolItem", LuaCompBase)

function Activity129RewardPoolItem:ctor(param)
	self.goItem = param.goItem
	self.itemList = param.itemList
	self.rare = param.rare
end

function Activity129RewardPoolItem:init(go)
	self.go = go
	self.goGrid = gohelper.findChild(self.go, "Grid")
end

function Activity129RewardPoolItem:setDict(dict, actId, poolId)
	if not dict then
		gohelper.setActive(self.go, false)

		return
	end

	self.actId = actId
	self.poolId = poolId
	self.isNull = true
	self.count = 0

	local index = 1

	for rare, list in pairs(dict) do
		for _, v in ipairs(list) do
			self:tryAddReward(v, rare, index)

			index = index + 1
		end
	end

	gohelper.setActive(self.go, not self.isNull)
	self:caleHeight()
end

function Activity129RewardPoolItem:caleHeight()
	local line = math.ceil(self.count / 4)
	local height = line * 200 + 75

	recthelper.setHeight(self.go.transform, height)
end

function Activity129RewardPoolItem:tryAddReward(reward, rare, index)
	if self.rare ~= rare then
		return
	end

	local item = self.itemList[index]

	item = item or self:createReward(index)

	gohelper.addChild(self.goGrid, item.go)
	item:setData(reward, self.actId, self.poolId, rare)

	self.isNull = false
	self.count = self.count + 1
end

function Activity129RewardPoolItem:createReward(index)
	local go = gohelper.clone(self.goItem, self.goGrid)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity129RewardItem)

	self.itemList[index] = item

	return item
end

function Activity129RewardPoolItem:onDestroy()
	return
end

return Activity129RewardPoolItem
