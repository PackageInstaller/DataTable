-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroSound.lua

HeroSound = class("HeroSound", objectlua.Object, _M)

HeroSound:has("_id", {
	is = "rw"
})
HeroSound:has("_unlock", {
	is = "rw"
})

function HeroSound:initialize(id)
	super.initialize(self)

	self._id = id
	self._unlock = false
	self._config = ConfigReader:getRecordById("Sound", self._id)
end

function HeroSound:getSound()
	if self._config.IncludeMusic then
		self._id = self._config.IncludeMusic[math.random(1, #self._config.IncludeMusic)]

		return self._id
	end

	return self._config.Id
end

function HeroSound:getSoundDesc()
	return Strings:get(self._config.SoundDesc)
end

function HeroSound:getText()
	return Strings:get(self._config.Text)
end

function HeroSound:getUnlockCondition()
	return self._config.Unlock or {}
end

function HeroSound:getUnlockDesc()
	return self._config.UnlockDesc
end

function HeroSound:getIsShow()
	return self._config.Show ~= 0
end
