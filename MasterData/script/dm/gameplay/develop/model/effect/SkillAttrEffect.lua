-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/SkillAttrEffect.lua

SkillAttrEffect = class("SkillAttrEffect", objectlua.Object, _M)

SkillAttrEffect:has("_effect", {
	is = "r"
})
SkillAttrEffect:has("_effectConfigs", {
	is = "r"
})
SkillAttrEffect:has("_level", {
	is = "r"
})
SkillAttrEffect:has("_effectFromName", {
	is = "rw"
})

function SkillAttrEffect:initialize(effectFromName)
	super.initialize(self)

	self._owner = nil
	self._effectFromName = effectFromName
end

function SkillAttrEffect:refreshEffects(effects, level)
	effects = effects or {}
	self._effectConfigs = effects
	level = level or 0
	self._level = level
end

function SkillAttrEffect:setOwner(owner, player)
	self._owner = owner
	self._player = player
end

function SkillAttrEffect:addEffect()
	self._owner:getEffectList():addEffect(self._effect)
end

function SkillAttrEffect:_createEffect()
	local effects = {}
	local targetMap = {}

	for _, effectConfigId in pairs(self._effectConfigs) do
		local attrConfig = ConfigReader:getRecordById("SkillAttrEffect", effectConfigId)
		local targetType = attrConfig.Target

		targetMap[targetType] = true

		local list = SkillAttribute:createAttEffect(self._player, {
			id = effectConfigId,
			level = self._level
		})

		for i = 1, #list do
			effects[#effects + 1] = list[i]
		end
	end

	if #effects > 0 then
		self._effect = CompositeEffect:new(effects)
		self._effect._effectFromName = self._effectFromName
	end

	self:checkFlagToTarget(targetMap)
end

function SkillAttrEffect:checkFlagToTarget(targetMap)
	for target, v in pairs(targetMap) do
		if target ~= "SELF" then
			self._player:rSetHerosAttrFlag()

			return
		end
	end
end

function SkillAttrEffect:removeEffect()
	self._owner:getEffectList():removeEffect(self._effect)
end

function SkillAttrEffect:clearHerosAttrFlag()
	self._player:rSetHerosAttrFlag()
end

function SkillAttrEffect:rCreateEffect()
	self:removeEffect()
	self:_createEffect()
	self:addEffect()
end
