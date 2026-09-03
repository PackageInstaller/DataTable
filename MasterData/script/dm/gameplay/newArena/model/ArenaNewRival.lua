-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/model/ArenaNewRival.lua

ArenaNewRival = class("ArenaNewRival", objectlua.Object, _M)

ArenaNewRival:has("_status", {
	is = "r"
})
ArenaNewRival:has("_id", {
	is = "r"
})
ArenaNewRival:has("_level", {
	is = "rw"
})
ArenaNewRival:has("_nickName", {
	is = "rw"
})
ArenaNewRival:has("_headImg", {
	is = "rw"
})
ArenaNewRival:has("_combat", {
	is = "rw"
})
ArenaNewRival:has("_showHero", {
	is = "r"
})
ArenaNewRival:has("_master", {
	is = "r"
})
ArenaNewRival:has("_heroes", {
	is = "r"
})
ArenaNewRival:has("_leadStageId", {
	is = "r"
})
ArenaNewRival:has("_leadStageLevel", {
	is = "r"
})
ArenaNewRival:has("_rank", {
	is = "r"
})
ArenaNewRival:has("_bubble", {
	is = "r"
})
ArenaNewRival:has("_isRobot", {
	is = "r"
})
ArenaNewRival:has("_headFrame", {
	is = "r"
})
ArenaNewRival:has("_title", {
	is = "r"
})

function ArenaNewRival:initialize()
	super.initialize(self)

	self._status = 0
	self._id = ""
	self._level = 0
	self._nickName = ""
	self._headImg = ""
	self._combat = 0
	self._showHero = "ZTXCun"
	self._master = {}
	self._heroes = {}
	self._leadStageId = ""
	self._leadStageLevel = 0
	self._rank = 0
	self._isRobot = false
	self._bubble = ""
	self._title = ""
end

function ArenaNewRival:synchronize(data)
	if data.status then
		self._status = data.status
	end

	if data.id then
		self._id = data.id
	end

	if data.level then
		self._level = data.level
	end

	if data.headImg then
		self._headImg = data.headImg
	end

	if data.headFrame then
		self._headFrame = data.headFrame
	end

	if data.nickname then
		self._nickName = data.nickname
	end

	if data.combat then
		self._combat = data.combat
	end

	if data.showId then
		self._showHero = data.showId
	end

	if data.rank then
		self._rank = data.rank
	end

	if data.master then
		self:initMaster(data.master)
	end

	if data.heroes then
		self:initHeroes(data.heroes)
	end

	if data.leadStageId then
		self._leadStageId = data.leadStageId
	end

	if data.leadStageLevel then
		self._leadStageLevel = data.leadStageLevel
	end

	if data.signature then
		self._bubble = data.signature
	end

	if data.robot then
		self._isRobot = data.robot
	end

	if data.title then
		self._title = data.title
	end
end

function ArenaNewRival:initMaster(master)
	for i, v in pairs(master) do
		self._master[i] = v
	end
end

function ArenaNewRival:initHeroes(heroes)
	for i, v in ipairs(heroes) do
		self._heroes[i] = v
	end
end

function ArenaNewRival:getName()
	return ""
end

function ArenaNewRival:getMasterId()
	return self._master[1]
end
