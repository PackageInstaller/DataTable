-- chunkname: @modules/logic/gm/view/GM_TaskDailyViewContainer.lua

module("modules.logic.gm.view.GM_TaskDailyViewContainer", package.seeall)

local GM_TaskDailyViewContainer = class("GM_TaskDailyViewContainer", GM_TaskListCommonItemContainer)
local s_viewObj

function GM_TaskDailyViewContainer:buildViews()
	return {
		GM_TaskDailyView.New()
	}
end

function GM_TaskDailyViewContainer:_gm_showAllTabIdUpdate(isOn)
	assert(s_viewObj)
	s_viewObj:_gm_showAllTabIdUpdate(isOn)
end

function GM_TaskDailyViewContainer:_gm_enableFinishOnSelect(isOn)
	assert(s_viewObj)
	s_viewObj:_gm_enableFinishOnSelect(isOn)
end

function GM_TaskDailyViewContainer:_gm_onClickFinishAll()
	assert(s_viewObj)
	s_viewObj:_gm_onClickFinishAll()
end

function GM_TaskDailyViewContainer.addEvents(viewObj)
	s_viewObj = assert(viewObj)
end

function GM_TaskDailyViewContainer.removeEvents(viewObj)
	s_viewObj = nil
end

return GM_TaskDailyViewContainer
