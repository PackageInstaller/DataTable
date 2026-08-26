-- chunkname: @modules/logic/versionactivity3_3/arcade/view/quit/ArcadeQuitTipViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.quit.ArcadeQuitTipViewContainer", package.seeall)

local ArcadeQuitTipViewContainer = class("ArcadeQuitTipViewContainer", BaseViewContainer)

function ArcadeQuitTipViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeQuitTipView.New())

	return views
end

return ArcadeQuitTipViewContainer
