-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183FightSuccViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183FightSuccViewContainer", package.seeall)

local Act183FightSuccViewContainer = class("Act183FightSuccViewContainer", FightSuccViewContainer)

function Act183FightSuccViewContainer:buildViews()
	self.fightSuccActView = FightSuccActView.New()

	local views = {
		Act183FightSuccView.New(),
		self.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(views, FightGMRecordView.New())
	end

	return views
end

return Act183FightSuccViewContainer
