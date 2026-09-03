-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/AdvanceList.lua

require("dm.gameplay.develop.model.hero.Advance")

AdvanceList = class("AdvanceList", objectlua.Object, _M)

AdvanceList:has("_map", {
	is = "rw"
})
AdvanceList:has("_owner", {
	is = "rw"
})
AdvanceList:has("_max", {
	is = "rw"
})

function AdvanceList:initialize(owner)
	super.initialize(self)

	self._owner = owner
	self._map = {}
	self._max = false
end

function AdvanceList:synchronize(innerLevel, innerJigsawIndex, baseInnerList)
	self._showMapId = baseInnerList[innerLevel + 1] or baseInnerList[1]

	for i = 1, #baseInnerList do
		local innerId = baseInnerList[i]

		if not self._map[innerId] then
			self._map[innerId] = Advance:new(innerId, i, self._owner)

			if self._owner then
				self._map[innerId]:createAttrEffect(self._owner, self._owner:getPlayer())
			end
		end

		self._map[innerId]:synchronize(innerJigsawIndex, innerLevel, baseInnerList)
	end

	if innerLevel == #baseInnerList then
		self._max = true
	end
end

function AdvanceList:getShowInnerList()
	return self._map[self._showMapId]
end

function AdvanceList:getCost()
	return self._map[self._showMapId]:getCost()
end

function AdvanceList:getShowList()
	return self:getShowInnerList():getShowList()
end

function AdvanceList:getShowAttrList()
	return self:getShowInnerList():getShowAttrList()
end
