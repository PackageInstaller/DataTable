-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186EffectViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186EffectViewContainer", package.seeall)

local Activity186EffectViewContainer = class("Activity186EffectViewContainer", BaseViewContainer)

function Activity186EffectViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity186EffectView.New())

	return views
end

return Activity186EffectViewContainer
