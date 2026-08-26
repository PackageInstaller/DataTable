-- chunkname: @modules/logic/versionactivity1_4/dailyallowance/DailyAllowanceViewContainer.lua

module("modules.logic.versionactivity1_4.dailyallowance.DailyAllowanceViewContainer", package.seeall)

local DailyAllowanceViewContainer = class("DailyAllowanceViewContainer", BaseViewContainer)

function DailyAllowanceViewContainer:buildViews()
	return {
		DailyAllowanceView.New()
	}
end

return DailyAllowanceViewContainer
