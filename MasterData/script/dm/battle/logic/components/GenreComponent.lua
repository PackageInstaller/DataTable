-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/GenreComponent.lua

Genres = {
	kTank = "tank",
	kGank = "gank",
	kDPS = "dps"
}
GenreComponent = class("GenreComponent", BaseComponent, _M)

GenreComponent:has("_genre", {
	is = "rw"
})

function GenreComponent:initialize()
	super.initialize(self)

	self._attackImpacts = {}
	self._defenseImpacts = {}
end

function GenreComponent:initWithRawData(data)
	super.initWithRawData(self, data)
	self:setGenre(data.genre)
end

function GenreComponent:getAttackImpact(defenderGenres, propName)
	local factors = self._attackImpacts[defenderGenres]

	return factors and factors[propName]
end

function GenreComponent:newAttackImpact(defenderGenres, propName, baseValue)
	local attr = AttributeNumber:new()

	attr:setBase(baseValue or 0)

	local factors = self._attackImpacts[defenderGenres]

	factors[propName] = attr

	return attr
end

function GenreComponent:getDefenseImpact(attackerGenres, propName)
	local factors = self._defenseImpacts[attackerGenres]

	return factors and factors[propName]
end

function GenreComponent:newDefenseImpact(defenderGenres, propName, baseValue)
	local attr = AttributeNumber:new()

	attr:setBase(baseValue or 0)

	local factors = self._defenseImpacts[defenderGenres]

	factors[propName] = attr

	return attr
end

function GenreComponent:copyComponent(srcComp, ratio)
	self:setGenre(srcComp:getGenre())
end
