-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/RangeAttrAddEffect.lua

require("dm.gameplay.develop.model.effect.AttrAddEffect")

RangeAttrAddEffect = class("RangeAttrAddEffect", AttrAddEffect, _M)

function RangeAttrAddEffect:_realCalculateEffect(target, multiFactor)
	local effectList = self._config.player:getEffectList()
	local effectEvn = self._config.effectEvn

	super._realCalculateEffect(self, effectList:getAttrUnitByEvn(self._config.target, effectEvn), multiFactor)
end
