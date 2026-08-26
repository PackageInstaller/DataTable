-- chunkname: @modules/logic/room/view/RoomCharacterPlaceViewContainer.lua

module("modules.logic.room.view.RoomCharacterPlaceViewContainer", package.seeall)

local RoomCharacterPlaceViewContainer = class("RoomCharacterPlaceViewContainer", BaseViewContainer)

function RoomCharacterPlaceViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCharacterPlaceView.New())
	table.insert(views, RoomViewTopRight.New("#go_topright", self._viewSetting.otherRes[2], {
		{
			classDefine = RoomViewTopRightCharacterItem
		}
	}))
	self:_buildCharacterPlaceListView1(views)
	self:_buildCharacterPlaceListView2(views)

	return views
end

function RoomCharacterPlaceViewContainer:_buildCharacterPlaceListView1(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_roleview1/rolescroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RoomCharacterPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellWidth = 200

	local screenWidth = self:_getUIScreenWidth()
	local scrollWidth = screenWidth - 44.22 - 39.48 - 20

	scrollParam.lineCount = 1
	scrollParam.cellHeight = 225
	scrollParam.cellSpaceH = self:_getCellSpace(scrollWidth, scrollParam.lineCount, scrollParam.cellWidth)
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 10
	self._characterPlaceScrollView1 = LuaListScrollView.New(RoomCharacterPlaceListModel.instance, scrollParam)

	table.insert(views, self._characterPlaceScrollView1)
end

function RoomCharacterPlaceViewContainer:_buildCharacterPlaceListView2(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_roleview2/rolescroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RoomCharacterPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 200

	local screenWidth = self:_getUIScreenWidth()
	local scrollWidth = screenWidth - 44.22 - 39.48 - 20

	scrollParam.lineCount = self:_getLineCount(scrollWidth, scrollParam.cellWidth)
	scrollParam.cellHeight = 205
	scrollParam.cellSpaceH = self:_getCellSpace(scrollWidth, scrollParam.lineCount, scrollParam.cellWidth)
	scrollParam.cellSpaceV = 4.6
	scrollParam.startSpace = 10
	self._characterPlaceScrollView2 = LuaListScrollView.New(RoomCharacterPlaceListModel.instance, scrollParam)

	table.insert(views, self._characterPlaceScrollView2)
end

function RoomCharacterPlaceViewContainer:_getLineCount(scrollWidth, cellWidth)
	local lineCount = math.floor(scrollWidth / cellWidth)

	lineCount = math.max(lineCount, 1)

	return lineCount
end

function RoomCharacterPlaceViewContainer:_getCellSpace(scrollWidth, lineCount, cellWidth)
	local cellSpaceH = 7

	if lineCount > 1 then
		cellSpaceH = (scrollWidth - cellWidth * lineCount + 48) / lineCount
		cellSpaceH = math.max(0, (scrollWidth - cellWidth * lineCount + 48) / lineCount)
	end

	return cellSpaceH
end

function RoomCharacterPlaceViewContainer:_getUIScreenWidth()
	local go = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if go then
		return recthelper.getWidth(go.transform)
	end

	local scale = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * scale + 0.5))
end

return RoomCharacterPlaceViewContainer
