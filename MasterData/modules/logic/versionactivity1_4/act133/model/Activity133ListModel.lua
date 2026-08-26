-- chunkname: @modules/logic/versionactivity1_4/act133/model/Activity133ListModel.lua

module("modules.logic.versionactivity1_4.act133.model.Activity133ListModel", package.seeall)

local Activity133ListModel = class("Activity133ListModel", ListScrollModel)

function Activity133ListModel:init(scrollgo)
	local list = {}

	self.scrollgo = scrollgo

	local bonusCoList = Activity133Config.instance:getBonusCoList()

	for _, bonusCo in ipairs(bonusCoList) do
		local mo = Activity133ListMO.New()

		mo:init(bonusCo[1])
		table.insert(list, mo)
	end

	table.sort(list, Activity133ListModel._sortFunction)

	for _, mo in ipairs(list) do
		if not Activity133Model.instance:checkBonusReceived(mo.id) then
			local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity
			local costs = string.splitToNumber(mo.config.needTokens, "#")
			local costNum = tonumber(costs[3])

			if costNum <= havenum then
				mo.showRed = true

				break
			end
		end
	end

	self:setList(list)
end

function Activity133ListModel._sortFunction(x, y)
	if x.id ~= y.id then
		return x.id < y.id
	end
end

function Activity133ListModel:reInit()
	return
end

Activity133ListModel.instance = Activity133ListModel.New()

return Activity133ListModel
