-- chunkname: @modules/logic/versionactivity2_2/act101/view/VersionActivity2_2RoomSignViewContainer.lua

module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignViewContainer", package.seeall)

local VersionActivity2_2RoomSignViewContainer = class("VersionActivity2_2RoomSignViewContainer", Activity101SignViewBaseContainer)

function VersionActivity2_2RoomSignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = VersionActivity2_2RoomSignItem
	refListScrollParam.scrollGOPath = "#scroll_ItemList"
	refListScrollParam.cellWidth = 476
	refListScrollParam.cellHeight = 576
	refListScrollParam.cellSpaceH = 30
end

function VersionActivity2_2RoomSignViewContainer:onGetMainViewClassType()
	return VersionActivity2_2RoomSignView
end

function VersionActivity2_2RoomSignViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return VersionActivity2_2RoomSignViewContainer
