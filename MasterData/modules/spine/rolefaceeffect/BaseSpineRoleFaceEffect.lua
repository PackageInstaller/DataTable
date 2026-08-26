-- chunkname: @modules/spine/rolefaceeffect/BaseSpineRoleFaceEffect.lua

module("modules.spine.rolefaceeffect.BaseSpineRoleFaceEffect", package.seeall)

local BaseSpineRoleFaceEffect = class("BaseSpineRoleFaceEffect")

function BaseSpineRoleFaceEffect:setSpine(spine)
	self._spine = spine
end

function BaseSpineRoleFaceEffect:init(config)
	return
end

function BaseSpineRoleFaceEffect:showFaceEffect(name)
	return
end

function BaseSpineRoleFaceEffect:onDestroy()
	return
end

return BaseSpineRoleFaceEffect
