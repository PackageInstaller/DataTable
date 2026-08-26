-- chunkname: @modules/logic/gm/view/GM_TaskListCommonItemContainer.lua

module("modules.logic.gm.view.GM_TaskListCommonItemContainer", package.seeall)

local GM_TaskListCommonItemContainer = class("GM_TaskListCommonItemContainer", BaseViewContainer)

function GM_TaskListCommonItemContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_TaskListCommonItemContainer:buildViews()
	assert(false)
end

function GM_TaskListCommonItemContainer:_gm_showAllTabIdUpdate()
	assert(false, "please override this function")
end

function GM_TaskListCommonItemContainer:_gm_enableFinishOnSelect()
	assert(false, "please override this function")
end

function GM_TaskListCommonItemContainer:_gm_onClickFinishAll()
	assert(false, "please override this function")
end

return GM_TaskListCommonItemContainer
