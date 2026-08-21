-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionLabelViewPresentor.lua

module("logic.extensions.controlaction.view.ControlActionLabelViewPresentor", package.seeall)

local M = class("ControlActionLabelViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Regulatory_label_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ControlActionLabelView.New())

	return views
end

return M
