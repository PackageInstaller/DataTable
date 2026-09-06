-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/DirectoryView.lua

module("logiccommon.common.viewlib.usualviews.DirectoryView", package.seeall)

local DirectoryView = class("DirectoryView", TableViewComponent)

function DirectoryView:ctor()
	DirectoryView.super.ctor(self)
end

function DirectoryView:onEnter()
	DirectoryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ClickDirectoryItem, self._onClickCell, self)
end

function DirectoryView:onEnterFinished()
	return
end

function DirectoryView:onExit()
	DirectoryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ClickDirectoryItem, self._onClickCell, self)
end

function DirectoryView:onExitFinished()
	return
end

function DirectoryView:_numInView()
	local num = 0

	for _, v in ipairs(self._curViewDatas) do
		num = num + 1

		if v > 0 then
			num = num + v
		end
	end

	return num
end

function DirectoryView:_cellSize(view, index)
	local root, leaf = self:getRootAndLeaf(index)

	if root > #self._curViewDatas then
		return 0, 0
	else
		return 212, 80
	end
end

function DirectoryView:getRootAndLeaf(index)
	local root = 1

	while root <= #self._curViewDatas do
		local leafNums = math.max(0, self._curViewDatas[root])

		if leafNums < index then
			index = index - leafNums - 1
			root = root + 1
		else
			return root, index
		end
	end

	return root, 0
end

function DirectoryView:getIndexByRootAndLeaf(root, leaf)
	if root <= 0 or leaf < 0 then
		return -1
	end

	local index = 0
	local i = 1

	while i < root do
		index = index + 1 + math.max(0, self._curViewDatas[i])
		i = i + 1
	end

	return index + leaf
end

function DirectoryView:_updateCell(view, cell, data)
	local idx = cell.index
	local root, leaf = self:getRootAndLeaf(idx)
	local selected = false
	local isRoot = leaf == 0

	selected = isRoot and self._selectedRoot == root or self._selectedRoot == root and self._selectedLeaf == leaf

	local component = DirectoryItem.AddOnce(cell.gameObject)

	component:onSetMo(self:_getDirectoryName(root, leaf), selected, root, leaf)
end

function DirectoryView:_getDirectoryName(root, leaf)
	return "xxx"
end

function DirectoryView:_onClickCell(root, leaf)
	self._selectedRoot = root
	self._selectedLeaf = leaf

	if leaf == 0 and self._curViewDatas[root] ~= nil then
		self._curViewDatas[root] = -checknumber(self._curViewDatas[root])

		for k, _ in pairs(self._curViewDatas) do
			if k ~= root then
				self._curViewDatas[k] = -math.abs(self._curViewDatas[k])
			end
		end
	end

	self:reloadData()
	self:_refreshPage(root, leaf)
end

function DirectoryView:_refreshPage(root, leaf)
	return
end

function DirectoryView:_updateCellByRootAndLeaf(root, leaf)
	if not root or root <= 0 or not leaf or leaf < 0 then
		return
	end

	if self._curViewDatas[root] < 0 then
		return
	else
		local index = self:getIndexByRootAndLeaf(root, leaf)

		self._tableview:UpdateCellAtIndex(index)
	end
end

return DirectoryView
