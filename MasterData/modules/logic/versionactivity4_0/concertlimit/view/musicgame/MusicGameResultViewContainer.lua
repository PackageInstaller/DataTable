-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameResultViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameResultViewContainer", package.seeall)

local MusicGameResultViewContainer = class("MusicGameResultViewContainer", BaseViewContainer)

function MusicGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, MusicGameResultView.New())

	return views
end

return MusicGameResultViewContainer
