-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkUnitMOBase.lua

module("logic.extensions.airworkshop.model.def.AirWorkUnitMOBase", package.seeall)

local M = class("AirWorkUnitMOBase")

function M:ctor(unitNO)
	self:onInit()

	if unitNO then
		self:_initByAgent(unitNO)
	end
end

function M:onInit()
	return
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:getEntityId()
	return self._entityId
end

function M:_init(unitNO)
	return
end

function M:trans2AgentForm()
	return
end

function M:getMsgMO()
	return
end

return M
