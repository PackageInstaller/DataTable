-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\CardPoolHeroMixin.lua

local CardPoolHeroMixin = {}
local GameSettings = require("Helper/GameSettings")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local IMG_HERO_POOL_CARD_STAR_BG_ATLAS = "Atlas/HeroAtlas/HeroCardGridAtlas"
local IMG_HERO_POOL_CARD_BG_ATLAS = "Atlas/HeroAtlas/HeroCardCommonAtlas02"
local CARD_HEIGHT = {
	rare = 830,
	normal = 766
}
local COMMON_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardGreen"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardGold"
	},
	[Const.ITEM_QUALITY_PINK] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardPink"
	},
	[Const.ITEM_QUALITY_RED] = {
		IMG_HERO_POOL_CARD_BG_ATLAS,
		"BgCardPink"
	}
}
local HERO_CARD_SPRITE_BY_STEP = {
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardGreen01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardGreen"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardBlue01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardBlue"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPurple01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPurple"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPurple01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPurple"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardGold01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardGold"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPink01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPink"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPink01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPink"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPink01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPink"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPink01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPink"
		}
	},
	{
		IMG_HERO_POOL_CARD_STAR_BG = {
			IMG_HERO_POOL_CARD_STAR_BG_ATLAS,
			"BgCardPink01"
		},
		IMG_HERO_POOL_CARD_BG = {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardPink"
		}
	}
}

function CardPoolHeroMixin:ctorMixin()
	self.isPlayEffect = true
	self.showSelect = false

	self:initUI()
end

function CardPoolHeroMixin:initUI()
	self.rectPanel = UIControls.Panel(self, "")
	self.itemInfoPanel = UIControls.Panel(self, "InfoPanel2")
	self.heroInfoMainPanel = UIControls.Panel(self, "InfoPanel1")
	self.rolePortrait = UIControls.Role(self, "InfoPanel1/IconHeroPanel", 0, 0)
	self.imgHeroIcon = UIControls.Image(self, "InfoPanel1/IconHeroPanel/IconHero")
	self.imgCareerIcon = UIControls.Image(self, "InfoPanel1/IconCareer")
	self.imgGroupIcon = UIControls.Image(self, "InfoPanel1/IconGroup")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelect)

	self.imgStar = UIControls.Image(self, "InfoPanel1/IconStar")
	self.efxBgBlack = UIControls.Panel(self, "EfxBgBlack")
	self.efxBgLight = UIControls.Panel(self, "EfxBgLight")
	self.imgBg1 = UIControls.Image(self, "Bg1")
end

function CardPoolHeroMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function CardPoolHeroMixin:clearSelectCallback(...)
	self.selectCallback = nil
end

function CardPoolHeroMixin:onBtnSelect(sender)
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function CardPoolHeroMixin:setSelected(isSelected)
	self.beSelected = isSelected

	if self.showSelect then
		self.imgSelect:setVisible(isSelected)
	end
end

function CardPoolHeroMixin:setItem(item)
	self.heroInfoMainPanel:setVisible(false)
	self.itemInfoPanel:setVisible(true)

	local bgImgPath = COMMON_QUALITY_CONFIG[item.quality]

	if bgImgPath then
		self.imgBg1:setImage(bgImgPath[1], bgImgPath[2])
	end
end

function CardPoolHeroMixin:setHero(hero, isProlong)
	self.isHero = true
	self.hero = hero
	self.object = self.hero
	self.isPrpLong = isProlong ~= nil and isProlong == true

	local isLightDark = hero.camp == Const.CAMP_TYPE.NINE_NIGHT or hero.camp == Const.CAMP_TYPE.SLIM_SNOW

	isLightDark = isLightDark and not GameSettings.isLowQuality()

	self:setInfoMainPanel(isLightDark)

	local bgImgPath = self:_getHeroBgPath(hero)

	if bgImgPath then
		self.imgBg1:setImage(bgImgPath[1], bgImgPath[2])
	end

	local starBgPath = self:_getHeroStarBgPath(hero)

	if starBgPath then
		self.imgStar:setImage(starBgPath[1], starBgPath[2])
	end

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgGroupIcon:setImage(groupPath[1], groupPath[2])
	end

	local careerPath = hero:getCareerPath()

	if careerPath then
		self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	end

	self.imgHeroIcon:setVisible(false)
	self.rolePortrait:showRole(hero.id, UIConst.ROLEIMAGE_SHOWTYPE_HERO_DROP)
	self.heroInfoMainPanel:setVisible(true)
	self.itemInfoPanel:setVisible(false)

	if self.isPrpLong then
		local orgSize = self.rectPanel:getRectSize()

		self.rectPanel:setRectSize(orgSize.width, CARD_HEIGHT.rare)
	end

	self.corYieldPlayEffect = coroutine.start(self.yieldPlayEffect, self)
end

local ComponentOrderType = typeof(Framework.UI.UIComponentOrder)
local CanvasType = typeof(UnityEngine.Canvas)

function CardPoolHeroMixin:setInfoMainPanel(needSortCanvas)
	local go = self.heroInfoMainPanel:getGameObject()
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

function CardPoolHeroMixin:yieldPlayEffect()
	coroutine.step()

	if self.deleteCanvasCom and self.deleteOrderCom then
		UnityEngine.Object.DestroyImmediate(self.deleteOrderCom)
		UnityEngine.Object.DestroyImmediate(self.deleteCanvasCom)

		self.deleteCanvasCom = nil
		self.deleteOrderCom = nil
	end

	local notLowQuality = not GameSettings.isLowQuality()

	self.efxBgBlack:setVisible(false)
	self.efxBgLight:setVisible(false)

	if self.efxBgBlack and self.hero.camp == Const.CAMP_TYPE.NINE_NIGHT and self.isPlayEffect and notLowQuality then
		local obj = self.efxBgBlack:getComObj()

		if obj ~= nil then
			local scale = obj.transform.localScale
			local effPath = "Effects/UI/efx_ui_BgBlack_02.prefab"

			if self.isPrpLong then
				effPath = "Effects/UI/efx_ui_BgBlack_01.prefab"
			end

			self.efxBgBlack:playEffect(effPath)
			self.efxBgBlack:setScaleXYZ(scale.x, scale.y, scale.z)
			self.efxBgBlack:setVisible(true)
		else
			self.efxBgBlack:setVisible(true)
			self.efxBgBlack:playEffect()
		end
	end

	if self.efxBgLight and self.hero.camp == Const.CAMP_TYPE.SLIM_SNOW and self.isPlayEffect and notLowQuality then
		self.efxBgLight:setVisible(true)
		self.efxBgLight:playEffect()
	end
end

function CardPoolHeroMixin:stopUIEffect(...)
	self.isPlayEffect = false

	if self.efxBgBlack then
		self.efxBgBlack:setVisible(false)
	end

	if self.efxBgLight then
		self.efxBgLight:setVisible(false)
	end

	self:clearCoroutine()
end

function CardPoolHeroMixin:clearCoroutine()
	if self.corYieldPlayEffect then
		coroutine.stop(self.corYieldPlayEffect)

		self.corYieldPlayEffect = nil
	end
end

function CardPoolHeroMixin:_getHeroBgPath(hero)
	if hero.camp == Const.CAMP_TYPE.SLIM_SNOW then
		return {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardLight"
		}
	elseif hero.camp == Const.CAMP_TYPE.NINE_NIGHT then
		return {
			IMG_HERO_POOL_CARD_BG_ATLAS,
			"BgCardBlack"
		}
	else
		local stepImgIdx = ResStarUpCondition[hero.star].step_img_idx or 1

		return HERO_CARD_SPRITE_BY_STEP[stepImgIdx].IMG_HERO_POOL_CARD_BG
	end
end

function CardPoolHeroMixin:_getHeroStarBgPath(hero)
	local stepImgIdx = ResStarUpCondition[hero.star].step_img_idx or 1

	return HERO_CARD_SPRITE_BY_STEP[stepImgIdx].IMG_HERO_POOL_CARD_STAR_BG
end

return CardPoolHeroMixin
