-- chunkname: @modules/logic/explore/map/unit/comp/ExploreUnitUIComp.lua

module("modules.logic.explore.map.unit.comp.ExploreUnitUIComp", package.seeall)

local ExploreUnitUIComp = class("ExploreUnitUIComp", LuaCompBase)

function ExploreUnitUIComp:ctor(unit)
	self.unit = unit
	self.uiDict = {}
end

function ExploreUnitUIComp:init(go)
	self.go = go
end

function ExploreUnitUIComp:setup(go)
	for _, ui in pairs(self.uiDict) do
		ui:setTarget(go)
	end
end

function ExploreUnitUIComp:addUI(cls)
	self.uiDict[cls.__cname] = self.uiDict[cls.__cname] or cls.New(self.unit)

	return self.uiDict[cls.__cname]
end

function ExploreUnitUIComp:removeUI(cls)
	if self.uiDict[cls.__cname] then
		self.uiDict[cls.__cname]:tryDispose()

		self.uiDict[cls.__cname] = nil
	end
end

function ExploreUnitUIComp:clear()
	if self.uiDict then
		for _, ui in pairs(self.uiDict) do
			ui:setTarget(self.go)
		end
	end
end

function ExploreUnitUIComp:onDestroy()
	for _, ui in pairs(self.uiDict) do
		ui:tryDispose()
	end

	self.uiDict = nil
	self.unit = nil
	self.go = nil
end

return ExploreUnitUIComp
