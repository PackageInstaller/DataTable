-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureAddPopViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureAddPopViewContainer", package.seeall)

local RoomManufactureAddPopViewContainer = class("RoomManufactureAddPopViewContainer", BaseViewContainer)

function RoomManufactureAddPopViewContainer:buildViews()
	local views = {}
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "root/#go_addPop/#scroll_production"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#go_addPop/#scroll_production/viewport/content/#go_productionItem"
	scrollParam.cellClass = RoomManufactureFormulaItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(ManufactureFormulaListModel.instance, scrollParam))

	self._popView = RoomManufactureAddPopView.New()

	table.insert(views, self._popView)

	return views
end

function RoomManufactureAddPopViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animatorPlayer = self._popView.animatorPlayer

	animatorPlayer:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
end

return RoomManufactureAddPopViewContainer
