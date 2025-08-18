-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\GridCircleCommonMixin.lua

local ResClanHead = require("ClientData/ResClanHead")
local ResClanHeadFrame = require("ClientData/ResClanHeadFrame")
local GridCircleCommonMixin = {}

function GridCircleCommonMixin:ctorMixin()
	self.mEnableTips = false

	self:initUI()
end

function GridCircleCommonMixin:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgIcon = UIControls.Image(self, "Mask/IconCircle")
	self.imgIconFrame = UIControls.Image(self, "IconCircleFrame")
end

function GridCircleCommonMixin:setCircle(circle)
	self.circle = circle

	local spriteInfo = self.circle:getCircleHeadPath()

	if spriteInfo then
		self.imgIcon:setImage(spriteInfo[1], spriteInfo[2])
	end

	local endTime = self.circle:getHeadFrameEndTimeTick()

	utils.setCircleHeadFrame(self.imgIconFrame, self.circle.headFrameId, endTime)
end

function GridCircleCommonMixin:setByCommInfo(commInfo)
	self.commInfo = commInfo

	local spriteInfo = ResClanHead[self.commInfo.head]

	if spriteInfo then
		self.imgIcon:setImage(spriteInfo.icon_path, spriteInfo.icon_name)
	end

	utils.setCircleHeadFrame(self.imgIconFrame, self.commInfo.head_frame_id, self.commInfo.head_frame_end_time)
end

function GridCircleCommonMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function GridCircleCommonMixin:onBtnSelfClick()
	if (self.circle or self.commInfo) and self.selectCallback then
		self.selectCallback(self)
	end

	if self.mEnableTips then
		self:openShowCircle()
	end
end

function GridCircleCommonMixin:openShowCircle()
	local circle = CurAvatar:tryGetCircleDetailInfo(self.circle.gid)

	if circle or self.circle.gid == CurAvatar.circleRoleData.clangid then
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		if circle then
			showCircleDlg:setCircle(circle)
		end
	end
end

return GridCircleCommonMixin
