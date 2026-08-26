-- chunkname: @modules/common/others/UISimpleScrollViewItem.lua

module("modules.common.others.UISimpleScrollViewItem", package.seeall)

local UISimpleScrollViewItem = class("UISimpleScrollViewItem", UserDataDispose)

function UISimpleScrollViewItem:ctor(parentClass)
	self._parentClass = parentClass
end

function UISimpleScrollViewItem:startLogic(obj_root, scroll_param)
	self._obj_root = obj_root
	self._csListScroll = SLFramework.UGUI.ListScrollView.Get(obj_root)
	self._scroll_param = scroll_param or ListScrollParam.New()
end

function UISimpleScrollViewItem:useDefaultParam(scrollDir, lineCount, grid)
	self._scroll_param.scrollDir = scrollDir
	self._scroll_param.lineCount = lineCount
	grid = grid or self._obj_root:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	self._scroll_param.cellWidth = grid.cellSize.x
	self._scroll_param.cellHeight = grid.cellSize.y
	self._scroll_param.cellSpaceH = grid.spacing.x
	self._scroll_param.cellSpaceV = grid.spacing.y

	self:setSpace(0, 0)
end

function UISimpleScrollViewItem:setCreateParam(frameUpdateMs, minUpdateCountInFrame)
	self._scroll_param.frameUpdateMs = frameUpdateMs
	self._scroll_param.minUpdateCountInFrame = minUpdateCountInFrame
end

function UISimpleScrollViewItem:setSpace(startSpace, endSpace)
	self._scroll_param.startSpace = startSpace
	self._scroll_param.endSpace = endSpace
end

function UISimpleScrollViewItem:setClass(tar_class)
	self._tar_class = tar_class
end

function UISimpleScrollViewItem:setData(data)
	self._data = data

	if not self._init_finish then
		self._init_finish = true

		self:useScrollParam()
	end

	self._csListScroll:UpdateTotalCount(#self._data)
end

function UISimpleScrollViewItem:useScrollParam()
	self._csListScroll:Init(self._scroll_param.scrollDir, self._scroll_param.lineCount, self._scroll_param.cellWidth, self._scroll_param.cellHeight, self._scroll_param.cellSpaceH, self._scroll_param.cellSpaceV, self._scroll_param.startSpace, self._scroll_param.endSpace, self._scroll_param.sortMode, self._scroll_param.frameUpdateMs, self._scroll_param.minUpdateCountInFrame, self._onUpdateCell, self.onUpdateFinish, nil, self)
end

function UISimpleScrollViewItem:setObjItem(obj_item)
	self._obj_item = obj_item
end

function UISimpleScrollViewItem:setItemViewGOPath(viewGO_path)
	self._viewGO_path = viewGO_path
end

function UISimpleScrollViewItem:setUpdateFinishCallback(finish_callback)
	self._finish_callback = finish_callback
end

function UISimpleScrollViewItem:_onUpdateCell(cellGO, index)
	self._item_list = self._item_list or {}

	local lua_index = index + 1
	local item_class = self._item_list[lua_index]

	if not item_class then
		if self._obj_item then
			local tar_obj = gohelper.clone(self._obj_item, cellGO, LuaListScrollView.PrefabInstName)

			if self._viewGO_path then
				tar_obj = gohelper.findChild(tar_obj, self._viewGO_path)
			end

			item_class = self._parentClass:openSubView(self._tar_class, tar_obj)
		else
			item_class = self._parentClass:openSubView(self._tar_class, cellGO)
		end

		self._item_list[lua_index] = item_class
	end

	item_class._index = lua_index

	item_class:onScrollItemRefreshData(self._data[lua_index])
end

function UISimpleScrollViewItem:onUpdateFinish()
	if self._finish_callback then
		self._finish_callback(self._parentClass)
	end
end

function UISimpleScrollViewItem:releaseSelf()
	self._item_list = nil
	self.tar_class = nil
	self._parentClass = nil
	self._finish_callback = nil
	self._data = nil
	self._tar_class = nil
	self._scroll_param = nil

	self._csListScroll:Clear()
end

return UISimpleScrollViewItem
