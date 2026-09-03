-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surface/model/Surface.lua

Surface = class("Surface", objectlua.Object, _M)

Surface:has("_id", {
	is = "rw"
})
Surface:has("_unlock", {
	is = "rw"
})

function Surface:initialize(id)
	super.initialize(self)

	self._id = id
	self._unlock = false
	self._config = ConfigReader:getRecordById("Surface", self._id)
end

function Surface:getTargetHero()
	return self._config.Hero
end

function Surface:getName()
	return Strings:get(self._config.Name)
end

function Surface:getDesc()
	return Strings:get(self._config.Desc)
end

function Surface:getType()
	return self._config.Type
end

function Surface:getUnlockShortDesc()
	return Strings:get(self._config.GainShortDesc)
end

function Surface:getUnlockDesc()
	return Strings:get(self._config.GainDesc)
end

function Surface:getGoodsId()
	return self._config.GoodsId
end

function Surface:getActivityId()
	return self._config.ActivityId
end

function Surface:getLink()
	return self._config.Link
end

function Surface:getQuality()
	return self._config.Quality
end

function Surface:getModel()
	return self._config.Model
end

function Surface:getRedVisible()
	return false
end

function Surface:getIsVisible()
	return self._config.Unlook == 1
end

function Surface:getNotGetIsVisible()
	return self._config.NotGetUnlook ~= 1
end

function Surface:getSort()
	return self._config.Sort
end

function Surface:getUnlock()
	if self:getType() == SurfaceType.kDefault then
		self._unlock = true
	end

	return self._unlock
end
