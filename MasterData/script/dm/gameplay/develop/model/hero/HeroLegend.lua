-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroLegend.lua

HeroLegend = class("HeroLegend", objectlua.Object, _M)

HeroLegend:has("_owner", {
	is = "rw"
})

function HeroLegend:initialize(owner)
	super.initialize(self)

	self._owner = owner
	self._id = self._owner._config.StarId
	self._curStarId = ""

	if self._owner then
		self:createAttrEffect(self._owner, self._owner:getPlayer())
	end
end

function HeroLegend:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kHeroBLegend)

	self._effect:setOwner(owner, player)
end

function HeroLegend:refreshEffect()
	self._effect:removeEffect()
	self:rCreateEffect()
end

function HeroLegend:rCreateEffect()
	local effects = self:getAttrEffects()

	self._effect:refreshEffects(effects, 0)
	self._effect:rCreateEffect()
end

function HeroLegend:synchronize(effects)
	self._effects = effects

	self:refreshEffect()
end

function HeroLegend:getAttrEffects()
	local effects = {}

	for id, v in pairs(self._effects) do
		local attrConfig = ConfigReader:getRecordById("SkillAttrEffect", id)

		if attrConfig and v == 1 then
			table.insert(effects, id)
		end
	end

	return effects
end
