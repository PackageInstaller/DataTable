-- chunkname: @modules/ugui/icon/common/CommonHeroIconNew.lua

module("modules.ugui.icon.common.CommonHeroIconNew", package.seeall)

local CommonHeroIconNew = class("CommonHeroIconNew", LuaCompBase)

function CommonHeroIconNew:init(go)
	self.go = go
	self.trans = go.transform
	self._goEmpty = gohelper.findChild(self.go, "#go_empty")
	self._goHero = gohelper.findChild(self.go, "#go_hero")
	self._goBgFrame = gohelper.findChild(self.go, "#go_hero/bgframe")
	self._heroIcon = gohelper.findChildSingleImage(self.go, "#go_hero/heroicon")
	self._careerIcon = gohelper.findChildImage(self.go, "#go_hero/career")
	self._goLevel = gohelper.findChild(self.go, "#go_hero/#go_level")
	self._rankIcon = gohelper.findChildImage(self.go, "#go_hero/#go_level/layout/#image_insight")
	self._txtLvHead = gohelper.findChildText(self.go, "#go_hero/#go_level/layout/#txt_lvHead")
	self._txtLevel = gohelper.findChildText(self.go, "#go_hero/#go_level/layout/#txt_level")
	self._rareIcon = gohelper.findChildImage(self.go, "#go_hero/rare")
	self._clickCb = nil
	self._clickCbObj = nil
	self._btnClick = nil

	self:isShowEmptyWhenNoneHero(true)
	self:updateIsEmpty()
end

function CommonHeroIconNew:addClickListener(clickCb, clickCbObj)
	self._clickCb = clickCb
	self._clickCbObj = clickCbObj
	self._btnClick = self._btnClick or SLFramework.UGUI.UIClickListener.Get(self.go)

	self._btnClick:AddClickListener(self._onItemClick, self)
end

function CommonHeroIconNew:_onItemClick()
	if self._clickCb then
		if self._clickCbObj then
			self._clickCb(self._clickCbObj, self._mo)
		else
			self._clickCb(self._mo)
		end
	end
end

function CommonHeroIconNew:removeClickListener()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._clickCb = nil
	self._clickCbObj = nil
end

function CommonHeroIconNew:getIsHasHero()
	if self._mo then
		local heroCfg = self._mo.config
		local heroId = heroCfg and heroCfg.id

		return heroId and heroId ~= 0
	end
end

function CommonHeroIconNew:setScale(scale)
	transformhelper.setLocalScale(self.trans, scale, scale, scale)
end

function CommonHeroIconNew:setAnchor(anchorX, anchorY)
	recthelper.setAnchor(self.trans, anchorX, anchorY)
end

function CommonHeroIconNew:setIsBalance(isBalance)
	local color = isBalance and "#81abe5" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(self._rankIcon, color)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtLvHead, color)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtLevel, color)
end

function CommonHeroIconNew:isShowEmptyWhenNoneHero(flag)
	self._isShowEmptyWhenNoneHero = flag

	local isEmpty = not self:getIsHasHero()

	if isEmpty then
		gohelper.setActive(self._goEmpty, flag)
	else
		gohelper.setActive(self._goEmpty, false)
	end
end

function CommonHeroIconNew:isShowBgFrame(flag)
	gohelper.setActive(self._goBgFrame, flag)
end

function CommonHeroIconNew:isShowLevel(flag)
	gohelper.setActive(self._goLevel, flag)
end

function CommonHeroIconNew:isShowRare(flag)
	gohelper.setActive(self._rareIcon.gameObject, flag)
end

function CommonHeroIconNew:isShowCareer(flag)
	gohelper.setActive(self._careerIcon.gameObject, flag)
end

function CommonHeroIconNew:onUpdateHeroId(heroId, skinId)
	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if not heroCfg then
		return
	end

	local heroMo = HeroMo.New()
	local useSkinId = skinId or heroCfg.skinId

	heroMo:init({
		heroId = heroId,
		skin = useSkinId
	}, heroCfg)
	self:onUpdateMO(heroMo)
end

function CommonHeroIconNew:onUpdateMO(heroMO)
	local heroCfg = heroMO and heroMO.config

	if not heroCfg then
		self:updateIsEmpty()

		return
	end

	self._mo = heroMO

	local strCareer = tostring(heroCfg.career)

	UISpriteSetMgr.instance:setCommonSprite(self._careerIcon, "lssx_" .. strCareer)

	local skinId = self._mo.skin
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	if not skinConfig then
		logError(string.format("CommonHeroIconNew:onUpdateMO error, skinConfig is nil, skinId: %s", skinId))

		return
	end

	local heroIconPath = ResUrl.getRoomHeadIcon(skinConfig.headIcon)

	self._heroIcon:LoadImage(heroIconPath)

	local showLevel, rank = HeroConfig.instance:getShowLevel(self._mo.level)

	if rank and rank > 1 then
		local tmpRank = rank - 1

		UISpriteSetMgr.instance:setCommonSprite(self._rankIcon, "dongxi_xiao_" .. tmpRank)
	else
		gohelper.setActive(self._rankIcon.gameObject, false)
	end

	self._txtLevel.text = showLevel

	local rare = heroCfg.rare

	UISpriteSetMgr.instance:setCommonSprite(self._rareIcon, "equipbar" .. CharacterEnum.Color[rare])
	self:updateIsEmpty()
end

function CommonHeroIconNew:showLevel(level)
	local showLevel, rank = HeroConfig.instance:getShowLevel(level)

	if rank and rank > 1 then
		local tmpRank = rank - 1

		UISpriteSetMgr.instance:setCommonSprite(self._rankIcon, "dongxi_xiao_" .. tmpRank)
		gohelper.setActive(self._rankIcon.gameObject, true)
	else
		gohelper.setActive(self._rankIcon.gameObject, false)
	end

	self._txtLevel.text = showLevel
end

function CommonHeroIconNew:updateIsEmpty()
	local isHasHero = self:getIsHasHero()

	if isHasHero then
		gohelper.setActive(self._goHero, true)
		gohelper.setActive(self._goEmpty, false)
	else
		gohelper.setActive(self._goHero, false)
		gohelper.setActive(self._goEmpty, self._isShowEmptyWhenNoneHero)
	end
end

function CommonHeroIconNew:onDestroy()
	self._heroIcon:UnLoadImage()
	self:isShowEmptyWhenNoneHero(true)
end

return CommonHeroIconNew
