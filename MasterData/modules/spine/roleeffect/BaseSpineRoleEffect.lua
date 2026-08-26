-- chunkname: @modules/spine/roleeffect/BaseSpineRoleEffect.lua

module("modules.spine.roleeffect.BaseSpineRoleEffect", package.seeall)

local BaseSpineRoleEffect = class("BaseSpineRoleEffect")

function BaseSpineRoleEffect:setSpine(spine)
	self._spine = spine
end

function BaseSpineRoleEffect:init(roleEffectConfig)
	return
end

function BaseSpineRoleEffect:showBodyEffect(bodyName, callback, callbackTarget)
	return
end

function BaseSpineRoleEffect:playBodyEffect(showEffect, child, bodyName)
	return
end

function BaseSpineRoleEffect:onDestroy()
	return
end

return BaseSpineRoleEffect
