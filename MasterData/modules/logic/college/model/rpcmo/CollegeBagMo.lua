-- chunkname: @modules/logic/college/model/rpcmo/CollegeBagMo.lua

module("modules.logic.college.model.rpcmo.CollegeBagMo", package.seeall)

local CollegeBagMo = pureTable("CollegeBagMo")

function CollegeBagMo:init(data)
	self.items, self.itemsMap = GameUtil.rpcInfosToListAndMap(data.items, CollegeBagItemMo, "uid", self.itemsMap)
	self.dirty = true
end

function CollegeBagMo:getItemMo(uid)
	return self.itemsMap[uid]
end

function CollegeBagMo:getItemCount(id)
	self:makeCache()

	return self._itemCount[id] or 0
end

function CollegeBagMo:makeCache()
	if not self.dirty then
		return
	end

	self.dirty = false
	self._itemCount = {}

	for i, v in ipairs(self.items) do
		self._itemCount[v.id] = (self._itemCount[v.id] or 0) + v.count
	end
end

function CollegeBagMo:updateItems(items)
	for i, v in ipairs(items) do
		local itemMo = self.itemsMap[v.uid]

		if itemMo then
			itemMo.count = v.count
		else
			itemMo = CollegeBagItemMo.New()

			itemMo:init(v)

			self.items[#self.items + 1] = itemMo
			self.itemsMap[v.uid] = itemMo
		end
	end

	self.dirty = true
end

function CollegeBagMo:delItems(uids)
	for i = 2, #uids do
		local itemMo = self.itemsMap[uids[i]]

		if itemMo then
			tabletool.removeValue(self.items, itemMo)

			self.itemsMap[uids[i]] = nil
		end
	end

	self.dirty = true
end

function CollegeBagMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeBagMo" then
		return false
	end

	local isSame = true

	if #self.items ~= #otherMo.items then
		isSame = false

		logError(string.format("CollegeBagMo compareWith items count not same: %s >> %s", #self.items, #otherMo.items))
	else
		for i = 1, #self.items do
			local otherItemMo = otherMo.itemsMap[self.items[i].uid]

			if not otherItemMo or not self.items[i]:compareWith(otherItemMo) then
				isSame = false

				logError(string.format("CollegeBagMo compareWith items not same: uid=%s", self.items[i].uid))

				break
			end
		end
	end

	return isSame
end

return CollegeBagMo
