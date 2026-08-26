-- chunkname: @modules/logic/equip/view/decompose/EquipDecomposeViewContainer.lua

module("modules.logic.equip.view.decompose.EquipDecomposeViewContainer", package.seeall)

local EquipDecomposeViewContainer = class("EquipDecomposeViewContainer", BaseViewContainer)

function EquipDecomposeViewContainer:buildViews()
	local equipScrollParam = ListScrollParam.New()

	equipScrollParam.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_equip"
	equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	equipScrollParam.cellClass = EquipDecomposeScrollItem
	equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipScrollParam.lineCount = self:getLineCount()
	equipScrollParam.cellWidth = 200
	equipScrollParam.cellHeight = 200
	equipScrollParam.cellSpaceH = 0
	equipScrollParam.cellSpaceV = 0
	equipScrollParam.frameUpdateMs = 0
	equipScrollParam.minUpdateCountInFrame = equipScrollParam.lineCount

	return {
		EquipDecomposeView.New(),
		LuaListScrollViewWithAnimator.New(EquipDecomposeListModel.instance, equipScrollParam, self.getDelayTimeArray(equipScrollParam.lineCount)),
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function EquipDecomposeViewContainer.getDelayTimeArray(lineCount)
	local timeArray = {}

	setmetatable(timeArray, timeArray)

	function timeArray.__index(t, index)
		local line = math.floor((index - 1) / lineCount)

		if line > 4 then
			return nil
		end

		return line * 0.03
	end

	return timeArray
end

function EquipDecomposeViewContainer:getLineCount()
	local contentTr = gohelper.findChildComponent(self.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)
	local contentWidth = recthelper.getWidth(contentTr)

	return math.floor(contentWidth / 200)
end

function EquipDecomposeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function EquipDecomposeViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

function EquipDecomposeViewContainer:onContainerCloseFinish()
	EquipDecomposeListModel.instance:clear()
end

return EquipDecomposeViewContainer
