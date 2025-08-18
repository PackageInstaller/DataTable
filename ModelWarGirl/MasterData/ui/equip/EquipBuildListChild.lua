-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipBuildListChild.lua

local strClassName = "EquipBuildListChild"
local EquipBuildListChild = Class(strClassName, UIControls.Child)

function EquipBuildListChild:ctor()
	self:initUI()
end

function EquipBuildListChild:initUI()
	self.view = UIControls.ScrollViewLoopV(self, "", 0, self._initItem)
	self.panelContentNone = UIControls.Panel(self, "NoContent")
	self.cells = {}
end

function EquipBuildListChild:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or self.tableName(sender, self.prefabName, 0, 0, newIdx)

	if not self.data or #self.data == 0 then
		return
	end

	if self.data[newIdx] ~= nil then
		targetCell:setObj(self.data[newIdx])

		targetCell.mEnableTips = false
		targetCell.mEventClick = Slot(self.selectItem, self)

		local gid

		if self.mWindow.listType == Const.BUILD_PANEL_TYPE_EQUIP then
			gid = self.data[newIdx].gid
		else
			gid = self.data[newIdx].id
		end

		targetCell.imgSelect:setVisible(self.selectGid and self.selectGid == gid)
	end

	self.cells[newIdx] = targetCell
end

function EquipBuildListChild:selectItem(sender)
	local gid

	if self.mWindow.listType == Const.BUILD_PANEL_TYPE_EQUIP then
		gid = sender.object.gid
	else
		gid = sender.object.id
	end

	if self.selectGid and self.selectGid == gid then
		self.selectGid = nil
	else
		self.selectGid = gid
	end

	self.mWindow:setSelectItem(sender.object)
	self.view:setTotalCount(#self.data)
end

function EquipBuildListChild:sortConfigRefresh(data)
	self.data = data
	self.cells = {}

	if self.mWindow.listType == Const.BUILD_PANEL_TYPE_EQUIP then
		if self.mWindow.targetEquip then
			self.selectGid = self.mWindow.targetEquip.gid
		end

		self.tableName = UIControls.EquipGridLoop
		self.prefabName = "System/Common/Grid/GridEquipItem"
	else
		if self.mWindow.targetStone then
			self.selectGid = self.mWindow.targetStone.id
		end

		self.tableName = UIControls.ItemGridLoop
		self.prefabName = "System/Common/Grid/GridMaterialItem"
	end

	self.view:setTotalCount(#self.data)
end

function EquipBuildListChild:setData(data)
	self.data = data

	self.view:setTotalCount(#self.data)
end

function EquipBuildListChild:clearSelectGrid()
	self.selectGid = nil

	self.view:setTotalCount(#self.data)
end

return EquipBuildListChild
