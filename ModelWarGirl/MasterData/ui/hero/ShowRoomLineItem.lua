-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ShowRoomLineItem.lua

local strClassName = "ShowRoomLineItem"
local ShowRoomLineItem = Class(strClassName, UIControls.Child)

function ShowRoomLineItem:ctor()
	self:initUI()
end

function ShowRoomLineItem:initUI()
	self.panelHeroLine = UIControls.Panel(self, "HeroLinePanel")
	self.panelGroupLine = UIControls.Panel(self, "TeamLinePanel")
	self.imgHeroLine = UIControls.Panel(self, "HeroLinePanel/ImgLine")
	self.txtHeroDesc = UIControls.Label(self, "HeroLinePanel/Bg/Text")
	self.bgHeroDesc = UIControls.Panel(self, "HeroLinePanel/Bg")
	self.imgHeroArrow1 = UIControls.Panel(self, "HeroLinePanel/ImgLine/LineL/ImgArrow1")
	self.imgHeroArrow2 = UIControls.Panel(self, "HeroLinePanel/ImgLine/LineR/ImgArrow2")
	self.imgGroupLine = UIControls.Panel(self, "TeamLinePanel/ImgLine")
	self.txtGroupDesc = UIControls.Label(self, "TeamLinePanel/Bg/Text")
	self.bgGroupDesc = UIControls.Panel(self, "TeamLinePanel/Bg")
	self.imgGroupArrow1 = UIControls.Panel(self, "TeamLinePanel/ImgLine/ImgArrow1")
	self.imgGroupArrow2 = UIControls.Panel(self, "TeamLinePanel/ImgLine/ImgArrow2")
end

function ShowRoomLineItem:setLineItemInfo(lineItemInfo, isGroupLine)
	self.panelHeroLine:setVisible(not isGroupLine)
	self.panelGroupLine:setVisible(isGroupLine)

	if isGroupLine then
		self.txtGroupDesc:setText(lineItemInfo.desc)

		local curSize = self.imgGroupLine:getRectSize()

		self.imgGroupLine:setRectSize(lineItemInfo.dis, curSize.height)
		self:setPosition(lineItemInfo.pos[1], lineItemInfo.pos[2])
		self.imgGroupLine:setRotateByXYZ(nil, nil, lineItemInfo.rotate)

		if lineItemInfo.twoWay and lineItemInfo.twoWay == 1 then
			self.imgGroupArrow1:setScaleXYZ(1, 1, 1)
			self.imgGroupArrow2:setScaleXYZ(-1, 1, 1)
		else
			self.imgGroupArrow1:setScaleXYZ(1, 1, 1)
			self.imgGroupArrow2:setScaleXYZ(1, 1, 1)
		end
	else
		self.txtHeroDesc:setText(lineItemInfo.desc)

		local curSize = self.imgHeroLine:getRectSize()

		self.imgHeroLine:setRectSize(lineItemInfo.dis, curSize.height)
		self:setPosition(lineItemInfo.pos[1], lineItemInfo.pos[2])
		self.imgHeroLine:setRotateByXYZ(nil, nil, lineItemInfo.rotate)
		self.bgHeroDesc:setVisible(lineItemInfo.txtVisible)
		self.panelHeroLine:setVisible(lineItemInfo.txtVisible)

		if lineItemInfo.twoWay and lineItemInfo.twoWay == 1 then
			self.imgHeroArrow1:setScaleXYZ(1, 1, 1)
			self.imgHeroArrow2:setScaleXYZ(-1, 1, 1)
		else
			self.imgHeroArrow1:setScaleXYZ(1, 1, 1)
			self.imgHeroArrow2:setScaleXYZ(1, 1, 1)
		end
	end
end

return ShowRoomLineItem
