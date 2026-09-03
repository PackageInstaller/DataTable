-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/team/Team.lua

Team = class("Team", objectlua.Object, _M)

Team:has("_masterId", {
	is = "rw"
})
Team:has("_heroes", {
	is = "rw"
})
Team:has("_combat", {
	is = "rw"
})
Team:has("_id", {
	is = "rw"
})
Team:has("_name", {
	is = "rw"
})
Team:has("_islock", {
	is = "rw"
})
Team:has("_hp", {
	is = "rw"
})

function Team:initialize(data)
	super.initialize(self)

	self._id = data.teamId or 0
	self._masterId = 0
	self._heroes = {}
	self._combat = 0
	self._name = ""
	self._islock = false
	self._hp = 0
end

function Team:synchronize(data)
	if data.masterId then
		self._masterId = data.masterId
	end

	if data.heroes then
		self:trimHeroData(data.heroes)
	end

	if data.combat then
		self._combat = data.combat
	end

	if data.name then
		if Strings:get(data.name) == "" then
			if not data.name then
				do
					self._name = Strings:get(data.name)
				end

				if data.hp then
					self._hp = data.hp
				end
			end
		end
	end
end

function Team:trimHeroData(data)
	self._heroes = {}

	for k, v in pairs(data) do
		local index = tonumber(k + 1)

		self._heroes[index] = v
	end
end

function Team:getName()
	return self._name
end
