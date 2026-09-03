-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/Player.lua

require("dm.gameplay.develop.model.effect.EffectCenter")
require("dm.gameplay.develop.model.effect.RangeEffectList")
require("dm.gameplay.develop.model.effect.AttributeCategory")
require("dm.gameplay.develop.model.RemoteObjectRegistry")
require("dm.gameplay.develop.model.bag.Bag")
require("dm.gameplay.develop.model.BasePlayer")
require("dm.gameplay.develop.model.hero.HeroList")
require("dm.gameplay.develop.model.hero.equip.EquipList")
require("dm.gameplay.develop.model.master.MasterList")
require("dm.gameplay.maze.model.MazeTeam")
require("dm.gameplay.develop.model.master.MasterEmblemList")
require("dm.gameplay.develop.model.master.MasterGeneral")
require("dm.gameplay.develop.model.master.MasterAura")
require("dm.gameplay.develop.model.team.TeamList")
require("dm.gameplay.club.model.Club")
require("dm.gameplay.explore.model.Explore")
require("dm.gameplay.develop.model.hero.HeroBuilding")
require("dm.gameplay.develop.model.master.MasterBuilding")
require("dm.gameplay.tsoul.model.TSoulList")

Player = class("Player", BasePlayer, _M)

Player:has("_heroList", {
	is = "r"
})
Player:has("_equipList", {
	is = "r"
})
Player:has("_masterList", {
	is = "r"
})
Player:has("_masterEmblemList", {
	is = "r"
})
Player:has("_bag", {
	is = "r"
})
Player:has("_masterAura", {
	is = "r"
})
Player:has("_effectList", {
	is = "rw"
})
Player:has("_teamList", {
	is = "r"
})
Player:has("_club", {
	is = "r"
})
Player:has("_effectCenter", {
	is = "r"
})
Player:has("_explore", {
	is = "r"
}):injectWith("Explore")
Player:has("_storyPointList", {
	is = "r"
})
Player:has("_stagePractice", {
	is = "r"
})
Player:has("_todayOnlineTime", {
	is = "rw"
})
Player:has("_heroBuildingModule", {
	is = "rw"
})
Player:has("_masterBuildingModule", {
	is = "rw"
})
Player:has("_tSoulList", {
	is = "r"
})

function Player:initialize(player)
	super.initialize(self)

	self._effectList = RangeEffectList:new()
	self._storyPointList = {}
	self._stagePractice = {}
	self._todayOnlineTime = 0

	self:initSys()
end

function Player:userInject(injector)
	injector:injectInto(self._explore)
end

function Player:initSys()
	self._bag = Bag:new(self)
	self._equipList = EquipList:new(self)
	self._heroList = HeroList:new(self)
	self._mazeHeroList = HeroList:new(self)
	self._masterList = MasterList:new(self)
	self._mazeTeam = MazeTeam:new(self)
	self._masterEmblemList = MasterEmblemList:new(self)
	self._masterAura = MasterAura:new(self)
	self._teamList = TeamList:new()
	self._club = Club:new()
	self._effectCenter = EffectCenter:new(self)
	self._explore = Explore:new()
	self._tSoulList = TSoulList:new(self)
	self._heroBuildingModule = HeroBuilding:new(self)
	self._masterBuildingModule = MasterBuilding:new(self)
end

function Player:synchronize(diffData)
	super.synchronize(self, diffData)
end

function Player:rSetMastersAttrFlag()
	self._masterList:clearAttrsFlag()
end

function Player:rSetHerosAttrFlag()
	self._heroList:clearAttrsFlag()
end

function Player:rCreateEffects()
	self._masterList:rCreateEffects()
end

function Player:syncStoryPoint(data)
	if not data then
		return
	end

	for k, value in pairs(data) do
		self._storyPointList[k] = value
	end
end

function Player:syncStagePractice(data)
	if data.points then
		if not self._stagePractice.points then
			self._stagePractice.points = data.points
		else
			for k, v in pairs(data.points) do
				self._stagePractice.points[k] = v
			end
		end
	end

	if data.teams then
		if not self._stagePractice.teams then
			self._stagePractice.teams = data.teams
		else
			for k, v in pairs(data.teams) do
				self._stagePractice.teams[k] = v
			end
		end
	end
end

function Player:syncAttrEffect()
	self._heroBuildingModule:refreshEffect()
	self._masterBuildingModule:refreshEffect()
	self._heroList:syncAttrEffect()
	self._masterList:syncAttrEffect()
end
