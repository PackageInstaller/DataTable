-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surface/controller/SurfaceSystem.lua

require("dm.gameplay.surface.model.SurfaceList")

SurfaceSystem = class("SurfaceSystem", Facade, _M)

SurfaceSystem:has("_service", {
	is = "r"
}):injectWith("SurfaceService")
SurfaceSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
SurfaceSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
SurfaceSystem:has("_surfaceList", {
	is = "r"
})
SurfaceSystem:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")
SurfaceSystem:has("_shopSystem", {
	is = "rw"
}):injectWith("ShopSystem")

SurfaceViewType = {
	kHero = "hero",
	kShop = "shop",
	kMaster = "master"
}

local SurfaceNodeRed = ConfigReader:getDataByNameIdAndKey("ConfigValue", "surface_notred", "content")

function SurfaceSystem:initialize()
	super.initialize(self)

	self._surfaceList = SurfaceList:new()

	self._surfaceList:initSurface()
end

function SurfaceSystem:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function SurfaceSystem:checkEnabled(data)
	local unlock, tips = self._systemKeeper:isUnlock("Unlock_Shop_Surface")

	return unlock, tips
end

function SurfaceSystem:tryEnter(data)
	local unlock, tips = self:checkEnabled(data)

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return
	end

	local function callback()
		local view = self:getInjector():getInstance("SurfaceView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end

	self._shopSystem:requestGetSurfaceShop(function()
		callback()
	end)
end

function SurfaceSystem:synchronize(data)
	if data then
		self._surfaceList:synchronize(data)
	end
end

function SurfaceSystem:getSurfaceById(id)
	return self:getSurfaces()[id]
end

function SurfaceSystem:hasHeroSkin(id)
	local surface = self:getSurfaceById(id)

	if surface then
		return surface:getUnlock()
	end

	return false
end

function SurfaceSystem:getSurfaces()
	return self._surfaceList:getSurfaces()
end

function SurfaceSystem:getSurfaceByTargetRole(roleId, viewType)
	viewType = viewType or SurfaceViewType.kHero

	local surfaces = self:getSurfaces()
	local showSurfaces = {}
	local surfaceList = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "SurfaceList")

	surfaceList = surfaceList or ConfigReader:getDataByNameIdAndKey("MasterBase", roleId, "SurfaceList")

	if viewType == SurfaceViewType.kShop then
		if surfaceList then
			for i = 1, #surfaceList do
				local surfaceId = surfaceList[i]
				local surface = surfaces[surfaceId]

				if surface and surface:getIsVisible() and surface:getType() ~= SurfaceType.kDefault then
					showSurfaces[#showSurfaces + 1] = surface
				end
			end
		end
	elseif viewType == SurfaceViewType.kMaster or viewType == SurfaceViewType.kHero then
		for i = 1, #surfaceList do
			local surfaceId = surfaceList[i]
			local surface = surfaces[surfaceId]

			if surface and surface:getUnlock() and surface:getIsVisible() or not surface:getUnlock() and surface:getNotGetIsVisible() then
				showSurfaces[#showSurfaces + 1] = surface
			end
		end
	end

	table.sort(showSurfaces, function(a, b)
		return a:getSort() < b:getSort()
	end)

	return showSurfaces
end

function SurfaceSystem:requestBuySurface(data, callback)
	local params = {
		surfaceId = data.surfaceId
	}

	self:getService():requestBuySurface(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:setSurfaceCustomDataByKey(data.surfaceId, true)
			self:dispatch(Event:new(EVT_SURFACE_BUY_SUCC, params))
		end
	end)
end

function SurfaceSystem:requestSelectSurface(data, callback)
	local params = {
		surfaceId = data.surfaceId
	}

	self:getService():requestSelectSurface(params, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:setSurfaceCustomDataByKey(data.surfaceId, true)
			self:dispatch(Event:new(EVT_SURFACE_SELECT_SUCC, response))
		end
	end)
end

function SurfaceSystem:getHeroShowRedPoint(s)
	if s and s:getUnlock() and s:getIsVisible() then
		local t = s:getType() or 0

		if not table.indexof(SurfaceNodeRed, t) then
			return true
		end
	end

	return false
end

function SurfaceSystem:checkIsShowRedPoint()
	local unlock, tips = self:checkEnabled()

	if not unlock then
		return false
	end

	local heroes = self._heroSystem:getOwnHeroIds()

	for i = 1, #heroes do
		local heroId = heroes[i].id

		if self:getRedPointByHeroId(heroId) then
			return true
		end
	end

	return false
end

function SurfaceSystem:getRedPointByHeroId(heroId)
	local unlock, tips = self:checkEnabled()

	if not unlock then
		return false
	end

	local heroId = heroId
	local heroSurfaces = self:getSurfaceByTargetRole(heroId)

	for i, s in ipairs(heroSurfaces) do
		if self:getRedPointByHeroIdAndSur(heroId, s:getId()) then
			return true
		end
	end

	return false
end

function SurfaceSystem:getRedPointByHeroIdAndSur(heroId, surfaceId)
	local unlock, tips = self:checkEnabled()

	if not unlock then
		return false
	end

	local allSurfaces = self:getSurfaces()
	local s = allSurfaces[surfaceId]

	if self:getHeroShowRedPoint(s) then
		local state = self:getSurfaceCustomDataByKey(surfaceId)

		if state == 0 then
			return true
		end
	end

	return false
end

function SurfaceSystem:initSurfaceCustomData()
	local state = self._customDataSystem:getValue(PrefixType.kGlobal, "surface_is_first")

	if state and tonumber(state) == 1 then
		return
	end

	self._customDataSystem:setValue(PrefixType.kGlobal, "surface_is_first", 1)

	local haveIds = {}
	local heroes = self._heroSystem:getOwnHeroIds()

	for i = 1, #heroes do
		local heroId = heroes[i].id
		local heroSurfaces = self:getSurfaceByTargetRole(heroId)

		for i, s in ipairs(heroSurfaces) do
			if self:getHeroShowRedPoint(s) then
				table.insert(haveIds, s:getId())
			end
		end
	end

	if next(haveIds) then
		self:setSurfaceCustomDataByKeys(haveIds)
	end
end

function SurfaceSystem:getSurfaceCustomDataByKey(surfaceId)
	local cjson = require("cjson.safe")
	local data = cjson.decode(self._customDataSystem:getValue(PrefixType.kGlobal, "SurfaceCustom", "{}"))

	if not data[surfaceId] then
		return 0
	end

	return tonumber(data[surfaceId])
end

function SurfaceSystem:setSurfaceCustomDataByKey(surFaceId, isRefresh)
	local allSurfaces = self:getSurfaces()
	local s = allSurfaces[surFaceId]

	if not self:getHeroShowRedPoint(s) then
		return
	end

	local cjson = require("cjson.safe")
	local data = cjson.decode(self._customDataSystem:getValue(PrefixType.kGlobal, "SurfaceCustom", "{}"))

	if data[surFaceId] and tonumber(data[surFaceId]) == 1 then
		return
	end

	local calback

	if isRefresh then
		function calback()
			self:dispatch(Event:new(EVT_SURFACE_REFRESH_REDPOINT, {}))
		end
	end

	data[surFaceId] = 1

	local dataStr = cjson.encode(data)

	self._customDataSystem:setValue(PrefixType.kGlobal, "SurfaceCustom", dataStr, calback)
end

function SurfaceSystem:setSurfaceCustomDataByKeys(surFaceIds)
	local cjson = require("cjson.safe")
	local data = cjson.decode(self._customDataSystem:getValue(PrefixType.kGlobal, "SurfaceCustom", "{}"))

	for i, v in ipairs(surFaceIds) do
		data[v] = 1
	end

	local dataStr = cjson.encode(data)

	self._customDataSystem:setValue(PrefixType.kGlobal, "SurfaceCustom", dataStr)
end
