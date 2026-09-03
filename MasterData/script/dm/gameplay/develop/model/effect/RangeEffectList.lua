-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/RangeEffectList.lua

require("dm.gameplay.develop.model.effect.EffectList")
require("dm.gameplay.develop.model.effect.RangeAttrAddEffect")

RangeEffectList = class("RangeEffectList", EffectList, _M)

RangeEffectList:has("_attUnitGroup", {
	is = "r"
})

function RangeEffectList:initialize()
	self:rCeateAttrGroup()
	super.initialize(self)
end

function RangeEffectList:rCeateAttrGroup()
	self._attUnitGroup = {}

	for _, targetType in pairs(RangeTargetType) do
		self._attUnitGroup[targetType] = {}

		local group = self._attUnitGroup[targetType]

		for _, env in pairs(GameEnvType) do
			group[env] = AttrFactor:new()
		end
	end
end

function RangeEffectList:getAttrUnitByEvn(targetType, env)
	return self._attUnitGroup[targetType][env]
end

function RangeEffectList:_attachAttrToTarget(targetType, attrFactor, env)
	local mainAttrFactor = self:getAttrUnitByEvn(targetType, GameEnvType.kAll)

	attrFactor:copyAttrFactor(mainAttrFactor)

	if env and env ~= GameEnvType.kAll then
		local evnAttrFactor = self:getAttrUnitByEvn(targetType, env)

		attrFactor:copyAttrFactor(evnAttrFactor)
	end
end

function RangeEffectList:attachAttrToHero(hero, env)
	local attrFactor = hero:getAttrFactor()

	self:_attachAttrToTarget(RangeTargetType.kAll, attrFactor, env)
	self:_attachAttrToTarget(RangeTargetType.kHERO, attrFactor, env)
end

function RangeEffectList:attachAttrToMaster(master, env)
	local attrFactor = master:getAttrFactor()

	self:_attachAttrToTarget(RangeTargetType.kAll, attrFactor, env)
	self:_attachAttrToTarget(RangeTargetType.kMASTER, attrFactor, env)
end
