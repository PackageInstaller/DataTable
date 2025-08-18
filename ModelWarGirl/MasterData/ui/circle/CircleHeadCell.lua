-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleHeadCell.lua

local ResClanHead = require("ClientData/ResClanHead")
local strClassName = "CircleHeadCell"
local CircleHeadCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CircleHeadCell:ctor()
	self:initUI()
end

function CircleHeadCell:initUI()
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)

	self.imgHead = UIControls.Image(self, "Mask/IconPlayerHead")
	self.imgSelect = UIControls.Image(self, "ImgSel")
	self.imgState = UIControls.Image(self, "ImgState")
	self.txtState = UIControls.Label(self, "ImgState/Text")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.imgMask = UIControls.Image(self, "ImgState/ImgMask")
	self.imgRed = UIControls.Image(self, "ImgState/ImgRed")
end

function CircleHeadCell:setCircleHeadData(circleHeadData)
	self.circleHeadData = circleHeadData

	self.imgHead:setImage(self.circleHeadData.resData.icon_path, self.circleHeadData.resData.icon_name)

	self.isUsing = CurAvatar.myCircle.headId == self.circleHeadData.resData.id

	self.imgState:setVisible(self.isUsing)
	self.imgNew:setVisible(CurAvatar.hintCircleHeadDic[self.circleHeadData.resData.id] ~= nil)
	self:refreshSelect()
end

function CircleHeadCell:refreshSelect()
	self.selected = self.circleHeadData.resData.id == self.mWindow.selectHeadId

	self.imgSelect:setVisible(self.selected)
	self.sensor:setEnable(not self.selected)
	self.txtState:setText(Lang.get(901))

	if self.mWindow.inited and self.selected and CurAvatar.hintCircleHeadDic[self.circleHeadData.resData.id] then
		CurAvatar.hintCircleHeadDic[self.circleHeadData.resData.id] = nil

		self.imgNew:setVisible(false)
		CurAvatar:hintCircleEditHead()
		self.mWindow:refreshTabHint()
	end
end

function CircleHeadCell:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function CircleHeadCell:onSensorClick(sender)
	if self.circleHeadData and self.selectCallback then
		self.selectCallback(self)
	end
end

return CircleHeadCell
