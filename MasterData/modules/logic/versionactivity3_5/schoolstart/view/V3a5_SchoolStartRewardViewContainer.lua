-- chunkname: @modules/logic/versionactivity3_5/schoolstart/view/V3a5_SchoolStartRewardViewContainer.lua

module("modules.logic.versionactivity3_5.schoolstart.view.V3a5_SchoolStartRewardViewContainer", package.seeall)

local V3a5_SchoolStartRewardViewContainer = class("V3a5_SchoolStartRewardViewContainer", BaseViewContainer)

function V3a5_SchoolStartRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a5_SchoolStartRewardView.New())

	return views
end

return V3a5_SchoolStartRewardViewContainer
