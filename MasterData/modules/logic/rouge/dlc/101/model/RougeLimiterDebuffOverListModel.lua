-- chunkname: @modules/logic/rouge/dlc/101/model/RougeLimiterDebuffOverListModel.lua

module("modules.logic.rouge.dlc.101.model.RougeLimiterDebuffOverListModel", package.seeall)

local RougeLimiterDebuffOverListModel = class("RougeLimiterDebuffOverListModel", ListScrollModel)

function RougeLimiterDebuffOverListModel:onInit(limiterIds)
	self:initLimiterGroupList(limiterIds)
end

function RougeLimiterDebuffOverListModel:initLimiterGroupList(limiterIds)
	local list = {}

	for _, limiterId in ipairs(limiterIds or {}) do
		local limiterCo = RougeDLCConfig101.instance:getLimiterCo(limiterId)

		table.insert(list, limiterCo)
	end

	table.sort(list, self._debuffSortFunc)
	self:setList(list)
end

function RougeLimiterDebuffOverListModel._debuffSortFunc(aLimiterCo, bLimiterCo)
	return aLimiterCo.id < bLimiterCo.id
end

RougeLimiterDebuffOverListModel.instance = RougeLimiterDebuffOverListModel.New()

return RougeLimiterDebuffOverListModel
