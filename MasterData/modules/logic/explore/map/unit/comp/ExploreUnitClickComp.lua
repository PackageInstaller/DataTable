-- chunkname: @modules/logic/explore/map/unit/comp/ExploreUnitClickComp.lua

module("modules.logic.explore.map.unit.comp.ExploreUnitClickComp", package.seeall)

local ExploreUnitClickComp = class("ExploreUnitClickComp", LuaCompBase)

function ExploreUnitClickComp:ctor(unit)
	self.unit = unit
	self.enable = true
end

function ExploreUnitClickComp:setup(go)
	self.colliderList = go:GetComponentsInChildren(typeof(UnityEngine.Collider))

	if self.colliderList == nil or self.colliderList.Length == 0 then
		return
	end

	for i = 0, self.colliderList.Length - 1 do
		local collider = self.colliderList[i]

		tolua.setpeer(collider, self)

		collider.enabled = self.enable
	end
end

function ExploreUnitClickComp:click()
	if not self.enable then
		return false
	end

	if self.unit.mo.triggerByClick then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickUnit, self.unit.mo)
	end

	return self.unit.mo.triggerByClick
end

function ExploreUnitClickComp:setEnable(v)
	self.enable = v

	if self.colliderList then
		for i = 0, self.colliderList.Length - 1 do
			self.colliderList[i].enabled = v
		end
	end
end

function ExploreUnitClickComp:beforeDestroy()
	return
end

function ExploreUnitClickComp:clear()
	if self.colliderList then
		for i = 0, self.colliderList.Length - 1 do
			tolua.setpeer(self.colliderList[i], nil)
		end
	end

	self.colliderList = nil
end

function ExploreUnitClickComp:onDestroy()
	self:clear()
end

return ExploreUnitClickComp
