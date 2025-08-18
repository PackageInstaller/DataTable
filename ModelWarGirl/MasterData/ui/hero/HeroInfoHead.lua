-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroInfoHead.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResColor = require("ClientData/ResColor")
local HeroEquipInfoPanel = require("UI/MainState/HeroEquipInfoPanel")
local HeroInfoHead = {}

function HeroInfoHead:ctorMixin()
	self.mEnableTips = true
	self.clickNotice = nil
	self.mEvenClick = nil

	self:initUI()
end

function HeroInfoHead:initUI()
	self.btnHeroHead = UIControls.Button(self, "")

	self.btnHeroHead:addEventClick(self.onBtnHeroHeadClick)

	self.txtHeroLv = UIControls.Label(self, "OtherInfo/TextLv")
	self.imgHeroNameBg = UIControls.Image(self, "Back")
	self.txtHeroName = UIControls.Label(self, "OtherInfo/TextName")
	self.panelHeroHead = UIControls.Image(self, "BgHead")
	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgHeroStepBg = UIControls.Panel(self, "BgStageLv")
	self.txtHeroStep = UIControls.Label(self, "BgStageLv/Text")
	self.imgHeroCareer = UIControls.Image(self, "OtherInfo/IconCareer")
	self.imgHeroGroup = UIControls.Image(self, "OtherInfo/IconGroup")
	self.imgHeroStarBg = UIControls.Image(self, "BgStar")
	self.imgHeroStar = UIControls.Image(self, "ImgStar")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgPaint = UIControls.Image(self, "CoatingImg")
	self.efxPainting = UIControls.Panel(self, "CoatingImg/EfxCoating")

	if UIControls.checkControlFunc(self, "ImgCrystalLv") then
		self.panelCrystalLv = UIControls.Panel(self, "ImgCrystalLv")
		self.textCrystalLv = UIControls.Label(self, "ImgCrystalLv/TextCrystalLv")
	end

	if UIControls.checkControlFunc(self, "IconCoating02") then
		self.panelPaintPlus = UIControls.Panel(self, "IconCoating02")
		self.txtPaintPlusLevel = UIControls.Label(self, "IconCoating02/Text")
	end

	if UIControls.checkControlFunc(self, "IconUR") then
		self.iconUR = UIControls.Panel(self, "IconUR")
	end
end

function HeroInfoHead:setHero(hero, _paintType, isInBag)
	self.hero = hero

	if Const.REVIEW_VERSION then
		self.txtHeroLv:setText(Lang.get(1203) .. self.hero:getShowLv())
	else
		self.txtHeroLv:setText("LV." .. self.hero:getShowLv())
	end

	local lvColor = self.hero:getLvColor()

	self.txtHeroLv:setFontColor(lvColor)

	if self.panelCrystalLv and self.hero.crystalSecondLevel and self.hero.crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.textCrystalLv:setText(math.floor(self.hero.crystalSecondLevel / 10))
	end

	self.txtHeroName:setText(hero.name)

	local iconPath = hero:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	local stepImgInfo = self.hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	self.hero:setHeroStepUI(self.imgHeroStepBg, self.txtHeroStep, true)

	local careerPath = hero:getCareerPath()

	if careerPath then
		self.imgHeroCareer:setImage(careerPath[1], careerPath[2])
	end

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgHeroGroup:setImage(groupPath[1], groupPath[2])
	end

	local starPath = hero:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end

	local paintType = _paintType or Const.PAINT_HERO_HEAD

	if self.imgPaint then
		local paintPath = self.hero:getPaintPath(paintType)

		if paintPath then
			self.imgPaint:setVisible(true)
			self.imgPaint:setImage(paintPath[1], paintPath[2])
		else
			self.imgPaint:setVisible(false)
		end
	end

	if self.efxPainting then
		local paintEfxPath = self.hero:getPaintEfxPath(paintType)

		if paintEfxPath then
			self.efxPainting:playEffect(paintEfxPath)
			self.efxPainting:setVisible(true)
		else
			self.efxPainting:setVisible(false)
		end
	end

	local locked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_EQUIP_TOWER)

	if isInBag and not locked and not utils.tableIsContainsElement(BattleConst.HIDE_WEAR_TYPE, self.mParent.battleType) then
		self:addEquipInfo()
	end

	self:setVisible(true)

	if Const.PAINT_PLUS_OPEN and self.panelPaintPlus then
		local level = hero:getPaintPlusShowLevel()

		if level and level ~= 0 then
			self.panelPaintPlus:setVisible(true)
			self.txtPaintPlusLevel:setText(level)
		else
			self.panelPaintPlus:setVisible(false)
		end
	end

	if self.iconUR then
		self.iconUR:setVisible(self.hero:isURHero())
	end
end

function HeroInfoHead:onBtnHeroHeadClick()
	if self.clickNotice then
		MsgManager.clientNotice(self.clickNotice)

		return
	end

	if self.mEvenClick then
		self.mEvenClick(self)

		return
	end

	if self.mEnableTips then
		if self.tipsDynamicOrder then
			UIManager.getUI("roleInfoHeroDlg"):setData({
				self.hero
			}, 1, self)
		else
			local heroMainDlg = UIManager.getUI("heroMainDlg", true)

			if heroMainDlg then
				heroMainDlg:initForContentPanel(Const.HERO_CONTENT_PANEL.HERO_EQUIP, self.hero.gid)
			end
		end
	end
end

function HeroInfoHead:setHeroRealLv(level)
	self.hero.realLevel = level ~= nil and level or self.hero.realLevel

	if Const.REVIEW_VERSION then
		self.txtHeroLv:setText(Lang.get(1203) .. self.hero.realLevel)
	else
		self.txtHeroLv:setText("LV." .. self.hero.realLevel)
	end

	self.txtHeroLv:setFontColor(ResColor.WHITE)

	if self.panelCrystalLv then
		self.panelCrystalLv:setVisible(false)
	end
end

function HeroInfoHead:hideHeroLv()
	self.txtHeroLv:setVisible(false)

	if self.panelCrystalLv then
		self.panelCrystalLv:setVisible(false)
	end
end

function HeroInfoHead:hideHeroGroup()
	self.imgHeroGroup:setVisible(false)
end

function HeroInfoHead:hideHeroCareer()
	self.imgHeroCareer:setVisible(false)
end

function HeroInfoHead:hideHeroName()
	self.imgHeroNameBg:setVisible(false)
	self.txtHeroName:setVisible(false)

	local pos = self.panelHeroHead:getPosition()

	self.panelHeroHead:setPosition(pos.x, -110)
end

function HeroInfoHead:hideHeroStar()
	self.imgHeroStarBg:setVisible(false)
	self.imgHeroStar:setVisible(false)
end

function HeroInfoHead:addEquipInfo()
	if self.heroEquipInfoPanel == nil then
		self.heroEquipInfoPanel = HeroEquipInfoPanel(self, "HeroEquipInfoPanel", "System/Bag/HeroEquipInfoPanel")
	end

	self.heroEquipInfoPanel:setData(self.hero)
	self.heroEquipInfoPanel:setVisible(true)
end

return HeroInfoHead
