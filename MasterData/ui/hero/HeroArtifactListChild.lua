-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroArtifactListChild.lua

local strClassName = "HeroArtifactListChild"
local HeroArtifactListChild = Class(strClassName, UIControls.Child)

function HeroArtifactListChild:ctor()
	self:initUI()
end

function HeroArtifactListChild:initUI()
	self.view = UIControls.ScrollViewLoopV(self, "", 0, self._initItem)
	self.cells = {}
end

function HeroArtifactListChild:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.ArtifactGridLoop(sender, "System/Common/Grid/GridBadgeItem", 0, 0, newIdx)

	if not self.data or #self.data == 0 then
		return
	end

	if self.data[newIdx] ~= nil then
		targetCell:setObj(self.data[newIdx])

		targetCell.mEnableTips = false
		targetCell.mEventClick = Slot(self.selectArtifact, self)

		targetCell.imgSelect:setVisible(self.selectGid and self.selectGid == self.data[newIdx].gid)
	end

	self.cells[newIdx] = targetCell
end

function HeroArtifactListChild:selectArtifact(sender)
	self.selectGid = sender.object.gid
	self.selectedGrid = sender

	self.mWindow:setSelectItem(sender.object)
	self.view:setTotalCount(#self.data)
end

function HeroArtifactListChild:setData(data)
	self.data = data

	self.view:setTotalCount(#self.data)
end

return HeroArtifactListChild
