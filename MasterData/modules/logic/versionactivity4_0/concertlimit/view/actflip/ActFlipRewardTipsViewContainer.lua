-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipRewardTipsViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipRewardTipsViewContainer", package.seeall)

local ActFlipRewardTipsViewContainer = class("ActFlipRewardTipsViewContainer", BaseViewContainer)

function ActFlipRewardTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, ActFlipRewardTipsView.New())

	return views
end

return ActFlipRewardTipsViewContainer
