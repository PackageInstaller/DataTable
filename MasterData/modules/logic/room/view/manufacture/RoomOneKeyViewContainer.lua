-- chunkname: @modules/logic/room/view/manufacture/RoomOneKeyViewContainer.lua

module("modules.logic.room.view.manufacture.RoomOneKeyViewContainer", package.seeall)

local RoomOneKeyViewContainer = class("RoomOneKeyViewContainer", BaseViewContainer)

function RoomOneKeyViewContainer:buildViews()
	local views = {}
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_addPop/#scroll_production"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "right/#go_addPop/#scroll_production/viewport/content/#go_productionItem"
	scrollParam.cellClass = RoomOneKeyAddPopItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(OneKeyAddPopListModel.instance, scrollParam))

	self.roomOneKeyAddPopView = RoomOneKeyAddPopView.New()

	table.insert(views, self.roomOneKeyAddPopView)

	self.oneKeyView = RoomOneKeyView.New()

	table.insert(views, self.oneKeyView)

	return views
end

function RoomOneKeyViewContainer:playOpenTransition()
	local defaultOneKeyType = ManufactureModel.instance:getRecordOneKeyType()

	RoomOneKeyViewContainer.super.playOpenTransition(self, {
		anim = (defaultOneKeyType == RoomManufactureEnum.OneKeyType.Customize or nil) and "open2"
	})
end

function RoomOneKeyViewContainer:oneKeyViewSetAddPopActive(isShow)
	self.oneKeyView:setAddPopActive(isShow)
end

return RoomOneKeyViewContainer
