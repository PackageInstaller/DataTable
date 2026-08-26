-- chunkname: @modules/logic/gm/view/GM_TaskWeeklyViewContainer.lua

module("modules.logic.gm.view.GM_TaskWeeklyViewContainer", package.seeall)

local GM_TaskWeeklyViewContainer = class("GM_TaskWeeklyViewContainer", GM_TaskListCommonItemContainer)
local s_viewObj

function GM_TaskWeeklyViewContainer:buildViews()
	return {
		GM_TaskWeeklyView.New()
	}
end

function GM_TaskWeeklyViewContainer:_gm_showAllTabIdUpdate(isOn)
	assert(s_viewObj)
	s_viewObj:_gm_showAllTabIdUpdate(isOn)
end

function GM_TaskWeeklyViewContainer:_gm_enableFinishOnSelect(isOn)
	assert(s_viewObj)
	s_viewObj:_gm_enableFinishOnSelect(isOn)
end

function GM_TaskWeeklyViewContainer:_gm_onClickFinishAll()
	assert(s_viewObj)
	s_viewObj:_gm_onClickFinishAll()
end

function GM_TaskWeeklyViewContainer.addEvents(viewObj)
	s_viewObj = assert(viewObj)
end

function GM_TaskWeeklyViewContainer.removeEvents(viewObj)
	s_viewObj = nil
end

return GM_TaskWeeklyViewContainer
