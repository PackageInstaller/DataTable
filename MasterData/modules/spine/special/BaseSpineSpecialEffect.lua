-- chunkname: @modules/spine/special/BaseSpineSpecialEffect.lua

module("modules.spine.special.BaseSpineSpecialEffect", package.seeall)

local BaseSpineSpecialEffect = class("BaseSpineSpecialEffect", BaseCommonSpecialEffect)

function BaseSpineSpecialEffect:ctor(spine)
	self:setSpine(spine)
end

function BaseSpineSpecialEffect:init(go)
	self._go = go

	self:_onInit()
end

function BaseSpineSpecialEffect:setSpine(spine)
	self._spine = spine
end

function BaseSpineSpecialEffect:onBodyChange(prevBodyName, curBodyName)
	self:_onBodyChange(prevBodyName, curBodyName)
end

function BaseSpineSpecialEffect:isFindAnim(curName, checkNames)
	if not checkNames then
		return false
	end

	for _, checkName in ipairs(checkNames) do
		if string.find(curName, checkName) ~= nil then
			return true
		end
	end

	return false
end

function BaseSpineSpecialEffect:_onInit()
	return
end

function BaseSpineSpecialEffect:_onBodyChange(prevBodyName, curBodyName)
	return
end

function BaseSpineSpecialEffect:onDestroy()
	return
end

return BaseSpineSpecialEffect
