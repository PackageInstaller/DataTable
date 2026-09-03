-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/model/ShopSurface.lua

ShopSurface = class("ShopSurface", objectlua.Object)

ShopSurface:has("_id", {
	is = "rw"
})
ShopSurface:has("_stock", {
	is = "rw"
})
ShopSurface:has("_index", {
	is = "rw"
})

function ShopSurface:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("ShopSurface", self._id)

	self:initSurfaceConfig()

	self._stock = 0
end

function ShopSurface:initSurfaceConfig()
	self._baseConfig = ConfigReader:requireRecordById("Surface", self:getSurfaceId())
end

function ShopSurface:getSurfaceId()
	return self._config.Surface
end

function ShopSurface:getSort()
	return self._config.Sort
end

function ShopSurface:getBackGroundImg()
	return self._config.BackGroundImg .. ".jpg"
end

function ShopSurface:getPrice()
	return self._config.Cost[1].amount
end

function ShopSurface:getCostType()
	return self._config.Cost[1].code
end

function ShopSurface:isShow()
	return self._config.Hide == 1
end

function ShopSurface:getTimeType()
	return self._config.TimeType
end

function ShopSurface:getIsLimit()
	return self:getTimeType().type == "limit"
end

function ShopSurface:getStartMills()
	local start = self:getTimeType().start
	local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	return (TimeUtil:timeByRemoteDate({
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}))
end

function ShopSurface:getEndMills()
	local start = self:getTimeType()["end"]
	local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local table = {
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}

	return (TimeUtil:timeByRemoteDate(table))
end

function ShopSurface:getName()
	return Strings:get(self._baseConfig.Name)
end

function ShopSurface:getDesc()
	return Strings:get(self._baseConfig.Desc)
end

function ShopSurface:getModel()
	return self._baseConfig.Model
end

function ShopSurface:getTargetHeroId()
	return self._baseConfig.Hero
end
