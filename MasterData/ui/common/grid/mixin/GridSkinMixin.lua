-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridSkinMixin.lua

local ResColor = require("ClientData/ResColor")
local GridChangeCellChild = require("UI/Common/Grid/GridChangeCellChild")
local strClassName = "GridSkinMixin"
local GridSkinMixin = {}

function GridSkinMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
	self.isShowPreviewTips = false
	self.mDisableWays = nil
end

function GridSkinMixin:initUI()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onGridClick)

	self.imgQuality = UIControls.Image(self, "ImgQuality")
	self.iconStrBg = UIControls.Image(self, "BgIcon")
	self.iconSkin = UIControls.Image(self, "IconSkin")

	if UIControls.checkControlFunc(self, "MaskIcon") then
		self.imgMask = UIControls.Image(self, "MaskIcon")
	end

	if UIControls.checkControlFunc(self, "MaskIcon/Icon") then
		self.imgSkinIcon = UIControls.Image(self, "MaskIcon/Icon")
	elseif UIControls.checkControlFunc(self, "Icon") then
		self.imgSkinIcon = UIControls.Image(self, "Icon")
	end

	if UIControls.checkControlFunc(self, "IconChange") then
		self.panelIconChange = UIControls.Panel(self, "IconChange")
	end
end

function GridSkinMixin:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function GridSkinMixin:_setObj(object)
	self:RefreshConvertObject()

	local color = object:getQualityPath()

	self.imgQuality:setImage(color[1], color[2])

	local iconInfo = object:getIconPath()

	if iconInfo then
		self.imgSkinIcon:setImage(iconInfo[1], iconInfo[2])
		self.imgSkinIcon:setVisible(true)
	end
end

function GridSkinMixin:SetConvertObject(checkNeedConvertObject)
	self.checkNeedConvertObject = checkNeedConvertObject

	self:RefreshConvertObject()
end

function GridSkinMixin:RefreshConvertObject()
	if self.panelIconChange then
		if self.checkNeedConvertObject and BaseObject.checkConvertObject(self.object) then
			if not self.gridChangeCellChild then
				self.gridChangeCellChild = GridChangeCellChild(self, "", "System/Common/GridChangeCell")
			end

			self.gridChangeCellChild:setObj(self.object)
			self.gridChangeCellChild:setVisible(true)
			self.panelIconChange:setVisible(true)
		else
			if self.gridChangeCellChild then
				self.gridChangeCellChild:setVisible(false)
			end

			self.panelIconChange:setVisible(false)
		end
	end
end

function GridSkinMixin:clear()
	self.object = nil

	self.imgSkinIcon:setVisible(false)
end

function GridSkinMixin:isEmpty()
	return self.object == nil
end

function GridSkinMixin:refreshGet()
	if not self.panelHave then
		self.panelHave = UIControls.Panel(self, "ImgHave")
		self.panelNoHero = UIControls.Panel(self, "ImgNoHero")
	end

	if self.object:isGet() then
		self.panelHave:setVisible(true)
		self.panelNoHero:setVisible(false)
	else
		self.panelHave:setVisible(false)

		if self.object:isHeroGet() then
			self.panelNoHero:setVisible(false)
		else
			self.panelNoHero:setVisible(true)
		end
	end
end

function GridSkinMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	if self:isEmpty() then
		return
	end

	self:openTipsPanel()

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

function GridSkinMixin:openTipsPanel()
	if self.mEnableTips then
		if self.isShowPreviewTips == true then
			UIManager.getUI("skinPreviewTips"):setObjectByGrid(self)
		else
			UIManager.getUI("skinTips"):showObj(self, self.object, nil, nil, self.checkNeedConvertObject)
		end
	end
end

function GridSkinMixin:setIconGray(isGray)
	if self.imgSkinIcon and self.imgSkinIcon:getVisible() then
		self.imgSkinIcon:setImageGray(isGray)
	end

	if self.imgQuality and self.imgQuality:getVisible() then
		self.imgQuality:setImageGray(isGray)
	end
end

function GridSkinMixin:onConfigHideBg()
	if not self.bg then
		self.bg = UIControls.Panel(self, "Bg")
	end

	self.bg:setVisible(false)
end

function GridSkinMixin:onConfigHideQuality()
	self.imgQuality:setVisible(false)
end

function GridSkinMixin:onSpeIconHide()
	self.iconSkin:setVisible(false)
end

function GridSkinMixin:onBgStarHide()
	self.iconStrBg:setVisible(false)
end

return GridSkinMixin
