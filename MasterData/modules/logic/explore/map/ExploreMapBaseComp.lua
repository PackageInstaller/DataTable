-- chunkname: @modules/logic/explore/map/ExploreMapBaseComp.lua

module("modules.logic.explore.map.ExploreMapBaseComp", package.seeall)

local ExploreMapBaseComp = class("ExploreMapBaseComp", LuaCompBase)

function ExploreMapBaseComp:init(go)
	self._mapGo = go
	self._mapStatus = ExploreEnum.MapStatus.Normal

	self:onInit()
end

function ExploreMapBaseComp:onInit()
	return
end

function ExploreMapBaseComp:addEventListeners()
	return
end

function ExploreMapBaseComp:removeEventListeners()
	return
end

function ExploreMapBaseComp:setMap(map)
	self._map = map
end

function ExploreMapBaseComp:setMapStatus(status)
	self._mapStatus = status
end

function ExploreMapBaseComp:beginStatus(data)
	return self._map:setMapStatus(self._mapStatus, data)
end

function ExploreMapBaseComp:onStatusStart()
	return
end

function ExploreMapBaseComp:onStatusEnd()
	return
end

function ExploreMapBaseComp:onMapClick(mousePosition)
	self._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function ExploreMapBaseComp:canSwitchStatus(toStatus)
	return true
end

function ExploreMapBaseComp:onDestroy()
	self._mapGo = nil
end

return ExploreMapBaseComp
