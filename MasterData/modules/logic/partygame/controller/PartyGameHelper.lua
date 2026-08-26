-- chunkname: @modules/logic/partygame/controller/PartyGameHelper.lua

module("modules.logic.partygame.controller.PartyGameHelper", package.seeall)

local PartyGameHelper = class("PartyGameHelper")

function PartyGameHelper:ctor()
	self._init = false
end

function PartyGameHelper:init()
	if self._init then
		return
	end

	self._init = true
	self._wrapData = {}

	PartyGame.Runtime.GameLogic.GameInterfaceBase.InitWrapData(self._wrapData)
end

function PartyGameHelper:getComponentData(uid, type, fieldName)
	self:init()

	local info = self._wrapData[type]

	if not info then
		return -1
	end

	local fieldIndex = info.fields[fieldName]

	if not fieldIndex then
		return -1
	end

	return PartyGame.Runtime.GameLogic.GameInterfaceBase.GetComponentValue(uid, info.id, fieldIndex)
end

function PartyGameHelper:getSingleComponentData(type, fieldName)
	self:init()

	local info = self._wrapData[type]

	if not info then
		return -1
	end

	local fieldIndex = info.fields[fieldName]

	if not fieldIndex then
		return -1
	end

	return PartyGame.Runtime.GameLogic.GameInterfaceBase.GetSingleComponentValue(info.id, fieldIndex)
end

PartyGameHelper.instance = PartyGameHelper.New()

return PartyGameHelper
