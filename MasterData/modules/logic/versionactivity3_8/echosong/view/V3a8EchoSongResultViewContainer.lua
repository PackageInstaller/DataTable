-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongResultViewContainer.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongResultViewContainer", package.seeall)

local V3a8EchoSongResultViewContainer = class("V3a8EchoSongResultViewContainer", BaseViewContainer)

function V3a8EchoSongResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a8EchoSongResultView.New())

	return views
end

return V3a8EchoSongResultViewContainer
