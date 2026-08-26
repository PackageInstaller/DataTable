-- chunkname: @modules/logic/gm/view/GMPostProcessViewContainer.lua

module("modules.logic.gm.view.GMPostProcessViewContainer", package.seeall)

local GMPostProcessViewContainer = class("GMPostProcessViewContainer", BaseViewContainer)

function GMPostProcessViewContainer:buildViews()
	local views = {}
	local mixListParam = MixScrollParam.New()

	mixListParam.scrollGOPath = "scroll"
	mixListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	mixListParam.prefabUrl = "scroll/item"
	mixListParam.cellClass = GMPostProcessItem
	mixListParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(GMPostProcessModel.instance, mixListParam))
	table.insert(views, GMPostProcessView.New())

	return views
end

function GMPostProcessViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return GMPostProcessViewContainer
