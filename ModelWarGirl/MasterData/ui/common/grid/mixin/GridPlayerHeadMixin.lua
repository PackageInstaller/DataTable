-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPlayerHeadMixin.lua

local HeadHelper = require("UI/RoleInfo/HeadHelper")
local GridPlayerHeadMixin = {}

function GridPlayerHeadMixin:ctorMixin()
	self:initUI()
	self:_overrideSetObjGray()
end

function GridPlayerHeadMixin:initUI()
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onEventClick)

	self.imgIcon = UIControls.Image(self, "IconPlayer")
	self.imgHeadFrame = UIControls.Image(self, "IconPlayerHeadFrame")
	self.txtLv = UIControls.Label(self, "TextLv")

	self:setVisible(true)
end

function GridPlayerHeadMixin:setPlayerHead(level, head, uid, needUidCheck, headFrameId, headFrameEndTime)
	self.uid = uid

	if level and level == 0 then
		level = 1
	end

	self.txtLv:setText(string.format(Lang.get(30171), level or 1))
	HeadHelper.setHeadIcon(self.imgIcon, head, uid, needUidCheck)
	HeadHelper.setHeadFrame(self.imgHeadFrame, headFrameId, headFrameEndTime)
end

function GridPlayerHeadMixin:setCommInfo(comm, needUidCheck, orderCell)
	self.orderCell = orderCell

	self:setPlayerHead(comm.level, comm.head, comm.uid, needUidCheck, comm.head_frame_id or comm.headFrameId or 0, comm.head_frame_end_time or 0)
end

function GridPlayerHeadMixin:setPlayer(otherPlayer, needUidCheck, orderCell)
	self.orderCell = orderCell

	self:setPlayerHead(otherPlayer.level, otherPlayer.head, otherPlayer.uid, needUidCheck, otherPlayer.headFrameId, otherPlayer.head_frame_end_time or 0)
end

function GridPlayerHeadMixin:hideLevel()
	self.txtLv:setVisible(false)
end

function GridPlayerHeadMixin:setEnable(v)
	self.sensor:setEnable(v)
end

function GridPlayerHeadMixin:checkRobotInfo(robotType)
	if utils.isRobot(self.uid) then
		self.robotType = robotType
	else
		self.robotType = nil
	end
end

function GridPlayerHeadMixin:onEventClick(sensor)
	CurAvatar:showPlayerTips(self.uid, self.orderCell, nil, self.robotType)
end

function GridPlayerHeadMixin:setGray(v)
	self.sensor:setObjGray(v)
end

function GridPlayerHeadMixin:_setObjGray(v)
	if self.imgHeadFrame.effectChild and self.imgHeadFrame.effectChild.aniCom then
		if v then
			self.imgHeadFrame.effectChild.aniCom:stopAni(self.imgHeadFrame.effectChild.aniName)
		else
			self.imgHeadFrame.effectChild.aniCom:startAniLoop(self.imgHeadFrame.effectChild.aniName)
		end
	end
end

function GridPlayerHeadMixin:_overrideSetObjGray(...)
	local func = self.setObjGray

	function self.setObjGray(...)
		func(...)
		self._setObjGray(...)
	end
end

return GridPlayerHeadMixin
