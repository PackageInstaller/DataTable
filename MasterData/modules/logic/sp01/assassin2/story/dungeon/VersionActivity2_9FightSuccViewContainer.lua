-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9FightSuccViewContainer.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9FightSuccViewContainer", package.seeall)

local VersionActivity2_9FightSuccViewContainer = class("VersionActivity2_9FightSuccViewContainer", FightSuccViewContainer)

function VersionActivity2_9FightSuccViewContainer:buildViews()
	self.fightSuccActView = FightSuccActView.New()

	local views = {
		VersionActivity2_9FightSuccView.New(),
		self.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(views, FightGMRecordView.New())
	end

	return views
end

return VersionActivity2_9FightSuccViewContainer
