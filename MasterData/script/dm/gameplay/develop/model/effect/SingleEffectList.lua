-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/SingleEffectList.lua

require("dm.gameplay.develop.model.effect.EffectList")
require("dm.gameplay.develop.model.effect.SingleAttrAddEffect")

SingleEffectList = class("SingleEffectList", EffectList, _M)

SingleEffectList:has("_attrUnits", {
	is = "r"
})

function SingleEffectList:initialize(id)
	self._id = id

	self:rCeateAttrUnits()
	super.initialize(self)
end

function SingleEffectList:rCeateAttrUnits()
	self._attrUnits = {}

	for _, env in pairs(GameEnvType) do
		self._attrUnits[env] = AttrFactor:new()
		self._attrUnits[env].env = env
		self._attrUnits[env].id = self._id
	end
end

function SingleEffectList:getAttrUnitByEvn(env)
	return self._attrUnits[env]
end

function SingleEffectList:attachAttrToTarget(attrFactor, env)
	local mainAttrFactor = self:getAttrUnitByEvn(GameEnvType.kAll)

	attrFactor:copyAttrFactor(mainAttrFactor)

	local sceneAttrFactor = self:getAttrUnitByEvn(GameEnvType.KSceneAll)

	attrFactor:copyAttrFactor(sceneAttrFactor)

	if env and env ~= GameEnvType.kAll then
		local evnAttrFactor = self:getAttrUnitByEvn(env)

		attrFactor:copyAttrFactor(evnAttrFactor)
	end
end
