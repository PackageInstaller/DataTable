-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ShowRoomTeamItem.lua

local strClassName = "ShowRoomTeamItem"
local ShowRoomTeamItem = Class(strClassName, UIControls.Child)

function ShowRoomTeamItem:ctor()
	self:initUI()
end

function ShowRoomTeamItem:initUI()
	self.panelSelf = UIControls.Panel(self, "")
	self.txtTitle = UIControls.Label(self, "BgTitle/TextTitle")
end

function ShowRoomTeamItem:setGroupItemInfo(groupItemInfo)
	self.groupItemInfo = groupItemInfo

	self:setPosition(groupItemInfo.pos.x, groupItemInfo.pos.y)
	self.panelSelf:setRectSize(groupItemInfo.size.width, groupItemInfo.size.height)
	self.txtTitle:setText(groupItemInfo.title)
end

return ShowRoomTeamItem
