-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridHeroMixin.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "GridHeroMixin"
local GridHeroMixin = {}

function GridHeroMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
	self.isShowPreviewTips = false
end

function GridHeroMixin:initUI()
	self.btnHeroHead = UIControls.Button(self, "")

	self.btnHeroHead:addEventClick(self.onGridClick)

	self.txtHeroLv = UIControls.Label(self, "OtherInfo/TextLv")
	self.txtHeroLvTitle = UIControls.Label(self, "OtherInfo/TextLv/Text")
	self.imgHeroGroup = UIControls.Image(self, "OtherInfo/IconGroup")
	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgIconNew = UIControls.Image(self, "IconNew")
	self.imgHeroStar = UIControls.Image(self, "ImgStar")
	self.imgCareer = UIControls.Image(self, "OtherInfo/IconCareer")
	self.imgPaint = UIControls.Image(self, "OtherInfo/CoatingImg")
	self.efxPainting = UIControls.Panel(self, "OtherInfo/CoatingImg/EfxCoating")

	if UIControls.checkControlFunc(self, "InfoPanel/IconVanity") then
		self.panelUniqueHero = UIControls.Panel(self, "InfoPanel/IconVanity")
	end

	self.panelOtherInfo = UIControls.Panel(self, "OtherInfo")

	if UIControls.checkControlFunc(self, "BgStar") then
		self.imgBgStar = UIControls.Image(self, "ImgStar")
	end

	if UIControls.checkControlFunc(self, "OtherInfo/ImgCrystalLv") then
		self.panelCrystalLv = UIControls.Panel(self, "OtherInfo/ImgCrystalLv")
		self.textCrystalLv = UIControls.Label(self, "OtherInfo/ImgCrystalLv/TextCrystalLv")
		self.textCrystalOldLv = UIControls.Label(self, "OtherInfo/ImgCrystalLv/TextOldLv")
		self.textCrystalOldLvTitle = UIControls.Label(self, "OtherInfo/ImgCrystalLv/TextOldLv/Text")
	end
end

function GridHeroMixin:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function GridHeroMixin:_setObj(object)
	self.object = object

	local lvColor = self.object:getLvColor()

	if self.panelCrystalLv and object.crystalSecondLevel and object.crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.txtHeroLv:setVisible(false)
		self.textCrystalOldLv:setText(object:getShowLv())
		self.textCrystalOldLv:setFontColor(lvColor)
		self.textCrystalLv:setText(math.floor(object.crystalSecondLevel / 10))
		self.textCrystalOldLvTitle:setFontColor(lvColor)
	else
		if self.panelCrystalLv then
			self.panelCrystalLv:setVisible(false)
		end

		self.txtHeroLv:setText(object:getShowLv())
		self.txtHeroLv:setVisible(true)
		self.txtHeroLv:setFontColor(lvColor)
		self.txtHeroLvTitle:setFontColor(lvColor)
	end

	local iconPath = object:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
		self.imgHeroIcon:setVisible(true)
	end

	local stepImgInfo = self.object:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	self.imgHeroGroup:setVisible(true)

	local groupPath = object:getGroupPath()

	if groupPath then
		self.imgHeroGroup:setImage(groupPath[1], groupPath[2])
	end

	local starPath = object:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end

	local careerPath = object:getCareerPath()

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end

	if self.imgPaint then
		local paintPath = object:getPaintPath(Const.PAINT_HERO_GRID)

		if paintPath then
			self.imgPaint:setVisible(true)
			self.imgPaint:setImage(paintPath[1], paintPath[2])
		else
			self.imgPaint:setVisible(false)
		end
	end

	if self.efxPainting then
		local paintEfxPath = object:getPaintEfxPath(Const.PAINT_HERO_GRID)

		if paintEfxPath then
			self.efxPainting:playEffect(paintEfxPath)
			self.efxPainting:setVisible(true)
		else
			self.efxPainting:setVisible(false)
		end
	end

	if self.panelUniqueHero then
		self.panelUniqueHero:setVisible(self.object:isUniqueHero())
	end
end

function GridHeroMixin:clear()
	self.object = nil

	self.imgHeroIcon:setVisible(false)
end

function GridHeroMixin:isEmpty()
	return self.object == nil
end

function GridHeroMixin:onGridClick(sender)
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

function GridHeroMixin:openTipsPanel()
	if self.mEnableTips then
		if self.isShowPreviewTips then
			UIManager.getUI("heroPreviewTips"):showObj(self, self.object)
		else
			UIManager.getUI("heroTips"):showObj(self, self.object)
		end
	end
end

function GridHeroMixin:setIconGray(isGray)
	if self.imgHeroIcon and self.imgHeroIcon:getVisible() then
		self.imgHeroIcon:setImageGray(isGray)
	end

	if self.imgQuality and self.imgQuality:getVisible() then
		self.imgQuality:setImageGray(isGray)
	end
end

function GridHeroMixin:setHeroRealLv(level)
	self.object.realLevel = level ~= nil and level or self.object.realLevel

	self.txtHeroLv:setText(self.object.realLevel)
	self.txtHeroLv:setFontColor(ResColor.WHITE)
	self.txtHeroLvTitle:setFontColor(ResColor.WHITE)

	if self.panelCrystalLv then
		self.panelCrystalLv:setVisible(false)
		self.txtHeroLv:setVisible(true)
	end
end

function GridHeroMixin:setSneakBattleShow(...)
	self.imgBgStar:setVisible(false)
	self.imgHeroStar:setVisible(false)
	self.txtHeroLv:setVisible(false)
	self.imgCareer:setVisible(true)
end

return GridHeroMixin
