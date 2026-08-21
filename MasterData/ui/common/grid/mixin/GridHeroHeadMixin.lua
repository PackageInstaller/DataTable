-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridHeroHeadMixin.lua

local GridHeroHeadMixin = {}

function GridHeroHeadMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEventClick = nil
end

function GridHeroHeadMixin:initUI()
	self.basePath = ""

	if self.mPath then
		self.basePath = self.mPath .. "/"
	end

	self.btnHeroHead = UIControls.Button(self, self.basePath .. "")

	self.btnHeroHead:addEventClick(self.onGridClick)

	self.imgHeroIcon = UIControls.Image(self, self.basePath .. "IconHead")
	self.imgQuality = UIControls.Image(self, self.basePath .. "ImgQuality")
	self.imgCareer = UIControls.Image(self, self.basePath .. "IconCareer")
	self.imgHeroStar = UIControls.Image(self, self.basePath .. "ImgStar")

	if UIControls.checkControlFunc(self, self.basePath .. "CoatingImg") then
		self.imgPaint = UIControls.Image(self, self.basePath .. "CoatingImg")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "CoatingImg/EfxCoating") then
		self.efxPainting = UIControls.Panel(self, self.basePath .. "CoatingImg/EfxCoating")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "IconCoating02") then
		self.panelPaintPlus = UIControls.Panel(self, self.basePath .. "IconCoating02")
		self.txtPaintPlusLevel = UIControls.Label(self, self.basePath .. "IconCoating02/Text")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "IconUR") then
		self.iconUR = UIControls.Panel(self, self.basePath .. "IconUR")
	end
end

function GridHeroHeadMixin:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function GridHeroHeadMixin:_setObj(object)
	self.object = object

	local iconPath = object:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
		self.imgHeroIcon:setVisible(true)
	end

	local stepImgInfo = self.object:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	local careerPath = object:getCareerPath()

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end

	local starPath = object:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
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

	if Const.PAINT_PLUS_OPEN and self.panelPaintPlus then
		local nowLevel = self.object:getPaintPlusShowLevel()

		if nowLevel and nowLevel ~= 0 then
			self.panelPaintPlus:setVisible(true)
			self.txtPaintPlusLevel:setText(nowLevel)
		else
			self.panelPaintPlus:setVisible(false)
		end
	end

	if self.iconUR then
		self.iconUR:setVisible(self.object.isURHero and self.object:isURHero() or false)
	end
end

function GridHeroHeadMixin:clear()
	self.object = nil

	self.imgHeroIcon:setVisible(false)
end

function GridHeroHeadMixin:isEmpty()
	return self.object == nil
end

function GridHeroHeadMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	if self:isEmpty() then
		return
	end

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

return GridHeroHeadMixin
