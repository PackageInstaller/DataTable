-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\GridHeroStarUp.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "GridHeroStarUp"
local GridHeroStarUp = Class(strClassName, UIControls.Child)

function GridHeroStarUp:ctor()
	self:initUI()
end

function GridHeroStarUp:initUI()
	self.btnHeroHead = UIControls.Button(self, "")

	self.btnHeroHead:addEventClick(self.onBtnClick)

	self.txtHeroLv = UIControls.Label(self, "OtherInfo/TextLv")
	self.txtHeroLvTitle = UIControls.Label(self, "OtherInfo/TextLv/Text")
	self.imgHeroGroup = UIControls.Image(self, "OtherInfo/IconGroup")
	self.imgHeroCareer = UIControls.Image(self, "OtherInfo/IconCareer")

	self.imgHeroCareer:setVisible(false)

	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgIconNew = UIControls.Image(self, "IconNew")
	self.imgHeroStar = UIControls.Image(self, "ImgStar")
	self.bgStage = UIControls.Panel(self, "BgStageLv")
	self.txtStage = UIControls.Label(self, "BgStageLv/Text")
	self.panelOtherInfo = UIControls.Panel(self, "OtherInfo")
	self.panelStar = UIControls.Panel(self, "BgStar")
	self.imgPaint = UIControls.Image(self, "OtherInfo/CoatingImg")
	self.efxPainting = UIControls.Panel(self, "OtherInfo/CoatingImg/EfxCoating")

	if UIControls.checkControlFunc(self, "OtherInfo/ImgCrystalLv") then
		self.panelCrystalLv = UIControls.Panel(self, "OtherInfo/ImgCrystalLv")
		self.textCrystalLv = UIControls.Label(self, "OtherInfo/ImgCrystalLv/TextCrystalLv")
		self.textCrystalOldLv = UIControls.Label(self, "OtherInfo/ImgCrystalLv/TextOldLv")
		self.textCrystalOldLvTitle = UIControls.Label(self, "OtherInfo/ImgCrystalLv/TextOldLv/Text")
	end

	if UIControls.checkControlFunc(self, "OtherInfo/IconCoating02") then
		self.txtPaintPlusLevel = UIControls.Label(self, "OtherInfo/IconCoating02/Text")
		self.panelPaintPlus = UIControls.Panel(self, "OtherInfo/IconCoating02")
	end

	if UIControls.checkControlFunc(self, "OtherInfo/NotUnlock") then
		self.notUnlock = UIControls.Image(self, "OtherInfo/NotUnlock")
	end

	if UIControls.checkControlFunc(self, "OtherInfo/IconUR") then
		self.iconUR = UIControls.Panel(self, "OtherInfo/IconUR")
	end
end

function GridHeroStarUp:setOnlyShowHead()
	self.imgHeroStar:setVisible(false)
	self.panelStar:setVisible(false)
	self.bgStage:setVisible(false)
	self.panelOtherInfo:setVisible(false)
	self.imgIconNew:setVisible(false)

	self.clickCallback = nil
end

function GridHeroStarUp:setHero(hero)
	self.hero = hero

	local lvColor = self.hero:getLvColor()

	if self.panelCrystalLv and self.hero.crystalSecondLevel and self.hero.crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.txtHeroLv:setVisible(false)
		self.textCrystalOldLv:setText(self.hero:getShowLv())
		self.textCrystalOldLv:setFontColor(lvColor)
		self.textCrystalLv:setText(math.floor(self.hero.crystalSecondLevel / 10))
		self.textCrystalOldLvTitle:setFontColor(lvColor)
	else
		if self.panelCrystalLv then
			self.panelCrystalLv:setVisible(false)
		end

		self.txtHeroLv:setText(self.hero:getShowLv())
		self.txtHeroLv:setVisible(true)
		self.txtHeroLv:setFontColor(lvColor)
		self.txtHeroLvTitle:setFontColor(lvColor)
	end

	local iconPath = hero:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	local stepImgInfo = self.hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	if self.imgPaint then
		local paintPath = self.hero:getPaintPath(Const.PAINT_HERO_GRID)

		if paintPath then
			self.imgPaint:setVisible(true)
			self.imgPaint:setImage(paintPath[1], paintPath[2])
		else
			self.imgPaint:setVisible(false)
		end
	end

	if self.efxPainting then
		local paintEfxPath = self.hero:getPaintEfxPath(Const.PAINT_HERO_GRID)

		if paintEfxPath then
			self.efxPainting:playEffect(paintEfxPath)
			self.efxPainting:setVisible(true)
		else
			self.efxPainting:setVisible(false)
		end
	end

	self.imgHeroGroup:setVisible(true)

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgHeroGroup:setImage(groupPath[1], groupPath[2])
	end

	local starPath = hero:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end

	if Const.PAINT_PLUS_OPEN and self.txtPaintPlusLevel then
		local paintPlusLevel = self.hero:getPaintPlusShowLevel()

		if paintPlusLevel and paintPlusLevel ~= 0 then
			self.panelPaintPlus:setVisible(true)
			self.txtPaintPlusLevel:setText(paintPlusLevel)
		else
			self.panelPaintPlus:setVisible(false)
		end
	end

	if self.iconUR then
		self.iconUR:setVisible(self.hero:isURHero())
	end
end

function GridHeroStarUp:hideLevel(...)
	self.txtHeroLv:setVisible(false)
	self.txtHeroLvTitle:setVisible(false)

	if self.panelCrystalLv then
		self.panelCrystalLv:setVisible(false)
	end
end

function GridHeroStarUp:setFakeCrystalLevel(isTrue)
	local fakeCrystalLevel = self.hero:getFakeCrystalLevel()
	local fakeSecondLevel = self.hero:getFakeCrystalSecondLevel()
	local level = isTrue and fakeCrystalLevel or self.hero.realLevel
	local lvColor = isTrue and self.hero:getFakeCrystalColor() or ResColor.WHITE

	if self.panelCrystalLv and isTrue and fakeSecondLevel and fakeSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.txtHeroLv:setVisible(false)
		self.textCrystalOldLv:setText(level)
		self.textCrystalOldLv:setFontColor(lvColor)
		self.textCrystalOldLvTitle:setFontColor(lvColor)
		self.textCrystalLv:setText(math.floor(fakeSecondLevel / 10))
	else
		if self.panelCrystalLv then
			self.panelCrystalLv:setVisible(false)
			self.txtHeroLv:setVisible(true)
		end

		self.txtHeroLv:setText(level)

		local lvColor = isTrue and self.hero:getFakeCrystalColor() or ResColor.WHITE

		self.txtHeroLv:setFontColor(lvColor)
		self.txtHeroLvTitle:setFontColor(lvColor)
	end
end

function GridHeroStarUp:setStarUpFakeHero(hero)
	self.hero = hero

	self.txtHeroLv:setVisible(false)

	if self.panelCrystalLv then
		self.panelCrystalLv:setVisible(false)
	end

	if self.hero.id then
		local iconPath = hero:getIconPath(true)

		if iconPath then
			self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
		end
	else
		self.imgHeroIcon:setImage("Atlas/CommonAtlas/GridAtlas/GridAtlas", "IconRandom")
	end

	if self.hero.camp then
		local groupPath = hero:getGroupPath()

		if groupPath then
			self.imgHeroGroup:setImage(groupPath[1], groupPath[2])
		end

		self.imgHeroGroup:setVisible(true)
	else
		self.imgHeroGroup:setVisible(false)
	end

	local stepImgInfo = self.hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	local starPath = hero:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end
end

function GridHeroStarUp:setDispatchInfo(level, iconPath, groupPath, starPath, stepImgInfo, stepStr)
	self.txtHeroLv:setText(level)
	self.txtHeroLv:setVisible(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	self.imgHeroGroup:setVisible(true)

	if groupPath then
		self.imgHeroGroup:setImage(groupPath[1], groupPath[2])
	end

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	self.bgStage:setVisible(true)
	self.imgHeroStar:setVisible(false)

	if stepStr ~= nil then
		self.txtStage:setText(stepStr)
	end
end

function GridHeroStarUp:showPaintPlus()
	if Const.PAINT_PLUS_OPEN then
		self.panelOtherInfo:setVisible(true)

		local starPath = self.hero:getStarPath()

		if starPath then
			self.panelStar:setVisible(true)
			self.imgHeroStar:setVisible(true)
			self.imgHeroStar:setImage(starPath[1], starPath[2])
		else
			self.panelStar:setVisible(false)
			self.imgHeroStar:setVisible(false)
		end
	end
end

function GridHeroStarUp:showPaintPlusSpeLevel0(...)
	if not Const.PAINT_PLUS_OPEN then
		return
	end

	if not self.hero then
		return
	end

	local paintPlusLevel = self.hero:getPaintPlusShowLevel()

	if paintPlusLevel and paintPlusLevel ~= 0 then
		self.panelPaintPlus:setVisible(true)
		self.txtPaintPlusLevel:setText(paintPlusLevel)
	else
		self.panelPaintPlus:setVisible(true)
		self.txtPaintPlusLevel:setText(0)
	end
end

function GridHeroStarUp:setDispatchState(...)
	self.imgHeroStar:setVisible(false)
	self:showStepInfo()
end

function GridHeroStarUp:showStepInfo()
	self.hero:setHeroStepUI(self.bgStage, self.txtStage, true)
end

function GridHeroStarUp:setClickCallback(clickCallback)
	self.clickCallback = clickCallback
end

function GridHeroStarUp:onBtnClick(sender)
	if self.hero and self.clickCallback then
		self.clickCallback(self)
	end
end

return GridHeroStarUp
