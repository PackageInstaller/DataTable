-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/EffectList.lua

require("dm.gameplay.develop.model.effect.CompositeEffect")
require("dm.gameplay.develop.model.effect.AttrFactor")
require("dm.gameplay.develop.model.effect.Effect")
require("dm.gameplay.develop.model.effect.SkillAttrEffect")

EffectList = class("EffectList", objectlua.Object, _M)

EffectList:has("_effectList", {
	is = "r"
})

function EffectList:initialize()
	self._effectList = {}

	super.initialize(self)
end

function EffectList:addEffect(e)
	if e == nil then
		return
	end

	if self._effectList[e] ~= nil then
		return
	end

	e:takeEffect(self)

	self._effectList[e] = true
end

function EffectList:removeEffect(e)
	if e == nil then
		return
	end

	local exist = self._effectList[e]

	if not exist then
		return
	end

	e:cancelEffect(self)

	self._effectList[e] = nil
end
