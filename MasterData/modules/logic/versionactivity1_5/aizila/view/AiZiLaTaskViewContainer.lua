-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaTaskViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskViewContainer", package.seeall)

local AiZiLaTaskViewContainer = class("AiZiLaTaskViewContainer", BaseViewContainer)

function AiZiLaTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AiZiLaTaskItem.prefabPath
	scrollParam.cellClass = AiZiLaTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(AiZiLaTaskListModel.instance, scrollParam))
	table.insert(views, AiZiLaTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AiZiLaTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return AiZiLaTaskViewContainer
