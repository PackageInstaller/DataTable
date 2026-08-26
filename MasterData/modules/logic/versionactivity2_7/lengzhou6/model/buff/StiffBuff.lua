-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/buff/StiffBuff.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.buff.StiffBuff", package.seeall)

local StiffBuff = class("StiffBuff", BuffBase)

function StiffBuff:init(id, configId)
	StiffBuff.super.init(self, id, configId)
end

function StiffBuff:execute(use)
	if use == nil then
		return false
	end

	if self._layerCount == 0 then
		return false
	end

	self:addCount(-1)

	return true
end

return StiffBuff
