-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/model/StagePracticeHero.lua

StagePracticeHero = class("StagePracticeHero", objectlua.Object, _M)

StagePracticeHero:has("_id", {
	is = "r"
})
StagePracticeHero:has("_config", {
	is = "r"
})

function StagePracticeHero:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("StageEnemy", tostring(id))
end

function StagePracticeHero:sync(data)
	return
end
