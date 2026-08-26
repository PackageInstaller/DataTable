-- chunkname: @modules/logic/fight/view/FightSuccViewContainer.lua

module("modules.logic.fight.view.FightSuccViewContainer", package.seeall)

local FightSuccViewContainer = class("FightSuccViewContainer", BaseViewContainer)

function FightSuccViewContainer:buildViews()
	self.fightSuccActView = FightSuccActView.New()

	local views = {
		FightSuccView.New(),
		self.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(views, FightGMRecordView.New())
	end

	return views
end

return FightSuccViewContainer
