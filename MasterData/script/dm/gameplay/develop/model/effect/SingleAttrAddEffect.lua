-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/SingleAttrAddEffect.lua

require("dm.gameplay.develop.model.effect.AttrAddEffect")

SingleAttrAddEffect = class("SingleAttrAddEffect", AttrAddEffect, _M)

function SingleAttrAddEffect:_realCalculateEffect(target, multiFactor)
	local effectEvn = self._config.effectEvn

	target = target:getAttrUnitByEvn(effectEvn)

	super._realCalculateEffect(self, target, multiFactor)
end
