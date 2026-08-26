-- chunkname: @modules/logic/fight/model/data/FightDataClass.lua

module("modules.logic.fight.model.data.FightDataClass", package.seeall)

local FightDataClass = {}
local baseTab = {}
local cname2meta = {}
local cname2super = {}

function baseTab.ctor()
	return
end

function baseTab.onConstructor()
	return
end

local function initializationInternal(class, handle, ...)
	local super = cname2super[class.__cname]

	if super then
		initializationInternal(super, handle, ...)
	end

	local func = rawget(class, "onConstructor")

	if func then
		return func(handle, ...)
	end
end

local function baseOf(xxx, name, super)
	local class = {}

	class.__cname = name

	if super then
		setmetatable(class, {
			__index = super
		})
	else
		setmetatable(class, {
			__index = baseTab
		})
	end

	cname2meta[name] = {
		__index = class
	}
	cname2super[name] = super

	function class.New(...)
		local tab = {}

		tab.__cname = name

		setmetatable(tab, cname2meta[name])
		tab:ctor()
		initializationInternal(class, tab, ...)

		return tab
	end

	return class
end

setmetatable(FightDataClass, {
	__call = baseOf
})

return FightDataClass
