-- chunkname: @modules/logic/matchgame/fight/view/MatchGameMemberInfoViewContainer.lua

module("modules.logic.matchgame.fight.view.MatchGameMemberInfoViewContainer", package.seeall)

local MatchGameMemberInfoViewContainer = class("MatchGameMemberInfoViewContainer", BaseViewContainer)

function MatchGameMemberInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, MatchGameMemberInfoView.New())

	return views
end

return MatchGameMemberInfoViewContainer
