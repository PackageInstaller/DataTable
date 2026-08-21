-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/map/RogueUnitCompPlateObj.lua

module("logic.extensions.roguelike.unit.comp.map.RogueUnitCompPlateObj", package.seeall)

local M = class("RogueUnitCompPlateObj")

function M:ctor(container)
	self._go = container.gameObject
end

function M:reset()
	self:onReset()
end

function M:onReset()
	self._resLoader:clear()
end

function M:onDestroy()
	self:onReset()
end

function M:loadAsset(objName, index)
	self._resLoader = SingleResLoader.New()

	local plateMgr = RogueMgr.instance:getPlateMgr()

	if not plateMgr then
		return
	end

	local url = plateMgr:getObjPath(objName, index)

	if url == "" then
		print("找不到摆件", objName)

		return
	end

	self._resLoader:load(url, self._onResLoaded, self)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self._go)

	self._light = goutil.findChild(self._goInst, "Point Light")
end

function M:setLightActive(isActive)
	if self._light then
		goutil.setActive(self._light, isActive)
	end
end

return M
