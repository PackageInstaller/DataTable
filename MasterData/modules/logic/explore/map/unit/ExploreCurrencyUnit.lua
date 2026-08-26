-- chunkname: @modules/logic/explore/map/unit/ExploreCurrencyUnit.lua

module("modules.logic.explore.map.unit.ExploreCurrencyUnit", package.seeall)

local ExploreCurrencyUnit = class("ExploreCurrencyUnit", ExploreBaseDisplayUnit)

function ExploreCurrencyUnit:onRoleEnter(_, _, unit)
	if unit:isRole() then
		self:tryTrigger()
	end
end

function ExploreCurrencyUnit:processMapIcon(icon)
	local iconArr = string.split(icon, "#")

	icon = iconArr[tonumber(self.mo.specialDatas[1])]

	return icon
end

return ExploreCurrencyUnit
