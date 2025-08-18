-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpPlayerHeadCell.lua

local TopPvpPlayerDetailsDlg = "UI/PVPMode/TopPVP/TopPvpPlayerDetailsDlg"
local strClassName = "TopPvpPlayerHeadCell"
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local TopPvpPlayerHeadCell = Class(strClassName, UIControls.Child)

function TopPvpPlayerHeadCell:ctor(...)
	self:initUI()
end

function TopPvpPlayerHeadCell:initUI()
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onEventClick)

	self.imgIcon = UIControls.Image(self, "IconPlayer")
	self.imgHeadFrame = UIControls.Image(self, "IconPlayerHeadFrame")
	self.txtLv = UIControls.Label(self, "TextLv")

	self:setVisible(true)
end

function TopPvpPlayerHeadCell:setPlayerHead(level, head, uid, needUidCheck, headFrameId, headFrameEndTime)
	self.uid = uid

	if level and level == 0 then
		level = 1
	end

	self.txtLv:setText(utils.format(Lang.get(90278), level or 1))
	HeadHelper.setHeadIcon(self.imgIcon, head, uid, needUidCheck)
	HeadHelper.setHeadFrame(self.imgHeadFrame, headFrameId, headFrameEndTime)
end

function TopPvpPlayerHeadCell:setCommInfo(comms, needUidCheck, orderCell)
	self.data = comms

	local comm = comms.comm

	self.orderCell = orderCell

	self:setPlayerHead(comm.level, comm.head, comm.uid, needUidCheck, comm.head_frame_id or comm.headFrameId or 0, comm.head_frame_end_time or 0)
end

function TopPvpPlayerHeadCell:setPlayer(otherPlayer, needUidCheck, orderCell)
	self.orderCell = orderCell

	self:setPlayerHead(otherPlayer.level, otherPlayer.head, otherPlayer.uid, needUidCheck, otherPlayer.headFrameId, otherPlayer.head_frame_end_time or 0)
end

function TopPvpPlayerHeadCell:setEnable(v)
	self.sensor:setEnable(v)
end

function TopPvpPlayerHeadCell:onEventClick(sensor)
	UIManager.getUI("topPvpPlayerDetailsDlg", true):show(self.data)
end

return TopPvpPlayerHeadCell
