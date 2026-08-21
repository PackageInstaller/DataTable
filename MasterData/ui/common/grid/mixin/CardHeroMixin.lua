-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\CardHeroMixin.lua

local CardHeroMixin = {}
local GameSettings = require("Helper/GameSettings")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ResColor = require("ClientData/ResColor")
local HERO_COMMON_ATLAS_PATH = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local HeroEquipInfoPanel = require("UI/MainState/HeroEquipInfoPanel")

function CardHeroMixin:ctorMixin()
	self.checkHeroEnhance = false
	self.isPlayEffect = true
	self.showSelect = false

	self:initUI()
end

function CardHeroMixin:initUI()
	self.infoMainPanel = UIControls.Panel(self, "InfoPanel")
	self.imgHeroIcon = UIControls.Image(self, "InfoPanel/IconHero")
	self.imgCareerIcon = UIControls.Image(self, "InfoPanel/IconCareer")
	self.imgStateIcon = UIControls.Image(self, "InfoPanel/IconState")
	self.imgStateIcon2 = UIControls.Image(self, "InfoPanel/IconState2")
	self.imgGroupIcon = UIControls.Image(self, "InfoPanel/IconGroup")
	self.txtHeroLv = UIControls.Label(self, "InfoPanel/BgLv/TextLv")
	self.txtHeroLvTitle = UIControls.Label(self, "InfoPanel/BgLv/TextLv/TextTitle")
	self.imgBgLv = UIControls.Panel(self, "InfoPanel/BgLv")
	self.imgPaint = UIControls.Image(self, "InfoPanel/BgLv/CoatingImg")
	self.imgCanUpgrade = UIControls.Image(self, "InfoPanel/IconNew2")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelect)

	self.imgBgStar = UIControls.Image(self, "InfoPanel/BgStar")
	self.imgStar = UIControls.Image(self, "InfoPanel/IconStar")
	self.efxMaxStar = UIControls.Panel(self, "InfoPanel/ImgBar1/EfxStarMax")
	self.efxBgBlack = UIControls.Panel(self, "EfxBgBlack")
	self.efxBgLight = UIControls.Panel(self, "EfxBgLight")
	self.txtGroupBlack = UIControls.Panel(self, "InfoPanel/TextGroupBlack")
	self.txtGroupLight = UIControls.Panel(self, "InfoPanel/TextGroupLight")
	self.txtStage = UIControls.Label(self, "InfoPanel/BgStageLv/Text")
	self.bgStage = UIControls.Panel(self, "InfoPanel/BgStageLv")
	self.imgBar1 = UIControls.Image(self, "InfoPanel/ImgBar1")
	self.imgBg1 = UIControls.Image(self, "Bg1")
	self.imgSel = UIControls.Image(self, "InfoPanel/ImgSel")
	self.imgCardMask = UIControls.Image(self, "InfoPanel/ImgCardMask")
	self.panelHeroEnhance = UIControls.Panel(self, "InfoPanel/IconRec")
	self.imgSelect = UIControls.Image(self, "InfoPanel/ImgSel")
	self.imgLock = UIControls.Image(self, "InfoPanel/ImgLock")
	self.efxPainting = UIControls.Panel(self, "InfoPanel/BgLv/CoatingImg/EfxCoating")

	if UIControls.checkControlFunc(self, "InfoPanel/ImgSelBPTeam") then
		self.imgSelBPTeam = UIControls.Image(self, "InfoPanel/ImgSelBPTeam")
		self.txtSelBPTeam = UIControls.Label(self, "InfoPanel/ImgSelBPTeam/Text")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconVanity") then
		self.panelUniqueHero = UIControls.Panel(self, "InfoPanel/IconVanity")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/BgLv/ImgCrystalLv") then
		self.panelCrystalLv = UIControls.Panel(self, "InfoPanel/BgLv/ImgCrystalLv")
		self.textCrystalLv = UIControls.Label(self, "InfoPanel/BgLv/ImgCrystalLv/TextCrystalLv")
		self.textCrystalOldLv = UIControls.Label(self, "InfoPanel/BgLv/ImgCrystalLv/TextOldLv")
		self.textCrystalOldLvTitle = UIControls.Label(self, "InfoPanel/BgLv/ImgCrystalLv/TextOldLv/TextTitle")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconBattleSpecial") then
		self.battleSpecialPanel = UIControls.Panel(self, "InfoPanel/IconBattleSpecial")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconDispatchSpecial") then
		self.dispatchSpecialPanel = UIControls.Image(self, "InfoPanel/IconDispatchSpecial")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconStateBattle") then
		self.stateBattleSpecialPanel = UIControls.Panel(self, "InfoPanel/IconStateBattle")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconStateDispatch") then
		self.stateDispatchSpecialPanel = UIControls.Panel(self, "InfoPanel/IconStateDispatch")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/ImgSelRune") then
		self.imgSelRune = UIControls.Panel(self, "InfoPanel/ImgSelRune")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconCoating02") then
		self.txtPaintPlusLv = UIControls.Label(self, "InfoPanel/IconCoating02/Text")
		self.panelPaintPlus = UIControls.Panel(self, "InfoPanel/IconCoating02")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconUR") then
		self.iconUR = UIControls.Panel(self, "InfoPanel/IconUR")
	end
end

function CardHeroMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function CardHeroMixin:clearSelectCallback(...)
	self.selectCallback = nil
end

function CardHeroMixin:onBtnSelect(sender)
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function CardHeroMixin:setSelected(isSelected)
	self.beSelected = isSelected

	if self.showSelect then
		self.imgSelect:setVisible(isSelected)
	end
end

function CardHeroMixin:setHero(hero)
	self.hero = hero
	self.object = self.hero

	local isLightDark = hero.camp == Const.CAMP_TYPE.NINE_NIGHT or hero.camp == Const.CAMP_TYPE.SLIM_SNOW

	isLightDark = isLightDark and not GameSettings.isLowQuality()

	self:setInfoMainPanel(isLightDark)

	local bgImgPath = self.hero:getBgSpritePath()

	self.imgBg1:setImage(bgImgPath[1], bgImgPath[2])

	local lvColor = self.hero:getLvColor()

	if self.panelCrystalLv and self.hero.crystalSecondLevel and self.hero.crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.txtHeroLv:setVisible(false)
		self.textCrystalOldLv:setText(self.hero:getShowLv())
		self.textCrystalOldLv:setFontColor(lvColor)
		self.textCrystalOldLvTitle:setFontColor(lvColor)
		self.textCrystalLv:setText(math.floor(self.hero.crystalSecondLevel / 10))
	else
		if self.panelCrystalLv then
			self.panelCrystalLv:setVisible(false)
			self.txtHeroLv:setVisible(true)
		end

		self.txtHeroLv:setText(self.hero:getShowLv())
		self.txtHeroLv:setFontColor(lvColor)
		self.txtHeroLvTitle:setFontColor(lvColor)
	end

	self.imgLock:setVisible(self.hero.lock == 1)

	local iconPath = hero:getIconPath()

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgGroupIcon:setImage(groupPath[1], groupPath[2])
	end

	local careerPath = hero:getCareerPath()

	if careerPath then
		self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	end

	local starPath = hero:getStarPath()

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end

	local paintPath = hero:getPaintPath(Const.PAINT_HERO_CARD)

	if paintPath then
		self.imgPaint:setVisible(true)
		self.imgPaint:setImage(paintPath[1], paintPath[2])
	else
		self.imgPaint:setVisible(false)
	end

	self.hero:setHeroStepUI(self.bgStage, self.txtStage)
	self.txtGroupBlack:setVisible(self.hero.camp == Const.CAMP_TYPE.NINE_NIGHT)
	self.txtGroupLight:setVisible(self.hero.camp == Const.CAMP_TYPE.SLIM_SNOW)

	self.corYieldPlayEffect = coroutine.start(self.yieldPlayEffect, self)

	local stepImgIdx = ResStarUpCondition[self.hero.star].step_img_idx or 1
	local stepImgInfo = UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]

	self.imgBar1:setImage(stepImgInfo.IMG_BAR1[1], stepImgInfo.IMG_BAR1[2])
	self.imgBgStar:setImage(stepImgInfo.BG_STAR[1], stepImgInfo.BG_STAR[2])

	if self.checkHeroEnhance then
		self:refreshHeroEnhance()
	end

	if self.mWindow.isOpenWearInfo then
		self:addEquipInfo()
	end

	if hero.hideLv then
		self.txtHeroLv:setVisible(false)
	end

	if self.panelUniqueHero then
		self.panelUniqueHero:setVisible(self.hero:isUniqueHero())
	end

	if Const.PAINT_PLUS_OPEN and self.panelPaintPlus then
		local level = self.hero:getPaintPlusShowLevel()

		if level and level ~= 0 then
			self.panelPaintPlus:setVisible(true)
			self.txtPaintPlusLv:setText(level)
		else
			self.panelPaintPlus:setVisible(false)
		end
	end

	if self.iconUR then
		self.iconUR:setVisible(self.hero:isURHero())
	end
end

local ComponentOrderType = typeof(Framework.UI.UIComponentOrder)
local CanvasType = typeof(UnityEngine.Canvas)

function CardHeroMixin:setInfoMainPanel(needSortCanvas)
	local go = self.infoMainPanel:getGameObject()
	local uiOrder = go:GetComponent(ComponentOrderType)

	if uiOrder then
		if not needSortCanvas then
			local canvs = go:GetComponent(CanvasType)

			self.deleteOrderCom = uiOrder
			self.deleteCanvasCom = canvs
		end
	elseif needSortCanvas then
		uiOrder = go:AddComponent(ComponentOrderType)
		uiOrder.Order = 3
	end
end

function CardHeroMixin:setHeroRealLv(level)
	self.hero.realLevel = level ~= nil and level or self.hero.realLevel

	self.txtHeroLv:setText(self.hero.realLevel)
	self.txtHeroLv:setFontColor(ResColor.WHITE)
	self.txtHeroLvTitle:setFontColor(ResColor.WHITE)

	if self.panelCrystalLv then
		self.panelCrystalLv:setVisible(false)
	end
end

function CardHeroMixin:yieldPlayEffect()
	coroutine.step()

	if self.deleteCanvasCom and self.deleteOrderCom then
		UnityEngine.Object.DestroyImmediate(self.deleteOrderCom)
		UnityEngine.Object.DestroyImmediate(self.deleteCanvasCom)

		self.deleteCanvasCom = nil
		self.deleteOrderCom = nil
	end

	local notLowQuality = not GameSettings.isLowQuality()

	if self.efxMaxStar and self.hero.star >= 10 and self.isPlayEffect and notLowQuality then
		local playEfx = self.efxMaxStar:getVisible()

		self.efxMaxStar:setVisible(true)

		if not playEfx then
			self.efxMaxStar:playEffect()
		end
	else
		self.efxMaxStar:setVisible(false)
	end

	local paintEfxPath = self.hero:getPaintEfxPath(Const.PAINT_HERO_CARD)

	if paintEfxPath and notLowQuality then
		self.efxPainting:playEffect(paintEfxPath)
		self.efxPainting:setVisible(true)
	else
		self.efxPainting:setVisible(false)
	end

	if self.efxBgBlack and self.hero.camp == Const.CAMP_TYPE.NINE_NIGHT and self.isPlayEffect and notLowQuality then
		self.efxBgBlack:setVisible(true)
		self.efxBgBlack:playEffect()
	else
		self.efxBgBlack:setVisible(false)
	end

	if self.efxBgLight and self.hero.camp == Const.CAMP_TYPE.SLIM_SNOW and self.isPlayEffect and notLowQuality then
		self.efxBgLight:setVisible(true)
		self.efxBgLight:playEffect()
	else
		self.efxBgLight:setVisible(false)
	end
end

function CardHeroMixin:stopUIEffect(...)
	self.isPlayEffect = false

	if self.efxMaxStar then
		self.efxMaxStar:setVisible(false)
	end

	if self.efxBgBlack then
		self.efxBgBlack:setVisible(false)
	end

	if self.efxBgLight then
		self.efxBgLight:setVisible(false)
	end

	self:clearCoroutine()
end

function CardHeroMixin:clearCoroutine()
	if self.corYieldPlayEffect then
		coroutine.stop(self.corYieldPlayEffect)

		self.corYieldPlayEffect = nil
	end
end

function CardHeroMixin:refreshHeroEnhance()
	local enhance = false

	if GameFsm.isInState(Const.STATE_BATTLE) then
		local state = GameFsm.getState(Const.STATE_BATTLE)

		if state.battleConfig and state.battleConfig.formation_condition then
			local condi = state.battleConfig.formation_condition

			if condi[1] and condi[2] and tostring(self.hero[condi[1]]) == condi[2] then
				enhance = true
			end
		end
	end

	self.panelHeroEnhance:setVisible(enhance)
end

function CardHeroMixin:setPaintShow(paintPath, paintEfxPath)
	if paintPath then
		self.imgPaint:setVisible(true)
		self.imgPaint:setImage(paintPath[1], paintPath[2])
	else
		self.imgPaint:setVisible(false)
	end

	if paintEfxPath then
		self.efxPainting:playEffect(paintEfxPath)
		self.efxPainting:setVisible(true)
	else
		self.efxPainting:setVisible(false)
	end
end

function CardHeroMixin:addEquipInfo()
	if self.heroEquipInfoPanel == nil then
		self.heroEquipInfoPanel = HeroEquipInfoPanel(self, "HeroEquipInfoPanel", "System/Bag/HeroEquipInfoPanel")
	end

	self.heroEquipInfoPanel:setData(self.hero)
	self.heroEquipInfoPanel:setVisible(true)
end

function CardHeroMixin:setHaveState(isHave)
	self.imgStateIcon2:setVisible(not isHave)
	self.imgHeroIcon:setImageGray(not isHave)
end

function CardHeroMixin:setBattleSpecial(value)
	if self.battleSpecialPanel then
		self.battleSpecialPanel:setVisible(value)
	end
end

function CardHeroMixin:setDispatchSpecial(value, path, icon)
	if self.dispatchSpecialPanel then
		self.dispatchSpecialPanel:setVisible(value)

		if value and path and icon then
			self.dispatchSpecialPanel:setImage(path, icon)
		end
	end
end

function CardHeroMixin:setStateBattleSpecial(value)
	if self.stateBattleSpecialPanel then
		self.stateBattleSpecialPanel:setVisible(value)
	end
end

function CardHeroMixin:setStateDispatchSpecial(value)
	if self.stateDispatchSpecialPanel then
		self.stateDispatchSpecialPanel:setVisible(value)
	end
end

return CardHeroMixin
