-- chunkname: @modules/ugui/icon/common/CommonHeroIcon.lua

module("modules.ugui.icon.common.CommonHeroIcon", package.seeall)

local CommonHeroIcon = class("CommonHeroIcon", LuaCompBase)

function CommonHeroIcon:init(go)
	self.go = go
	self.tr = go.transform
	self._callback = nil
	self._callbackObj = nil
	self._btnClick = nil
	self._lvTxt = gohelper.findChildText(go, "lvltxt")
	self._starObj = gohelper.findChild(go, "starobj")
	self._maskObj = gohelper.findChild(go, "mask")
	self._breakObj = gohelper.findChild(go, "breakobj")
	self._rareObj = gohelper.findChild(go, "rareobj")
	self._cardIcon = gohelper.findChildSingleImage(go, "charactericon")
	self._careerIcon = gohelper.findChildImage(go, "career")
	self._careerFrame = gohelper.findChildImage(go, "frame")
	self._rareIcon = gohelper.findChildImage(go, "cardrare")
	self._isShowStar = true
	self._isShowBreak = true
	self._isShowRate = true

	self:_initObj()
end

function CommonHeroIcon:setLvVisible(value)
	gohelper.setActive(self._lvTxt.gameObject, value)
end

function CommonHeroIcon:setMaskVisible(value)
	gohelper.setActive(self._maskObj, value)
end

function CommonHeroIcon:isShowStar(flag)
	self._isShowStar = flag

	gohelper.setActive(self._starObj, flag)
end

function CommonHeroIcon:isShowBreak(flag)
	self._isShowBreak = flag

	gohelper.setActive(self._breakObj, flag)
end

function CommonHeroIcon:isShowRare(flag)
	self._isShowRare = flag

	gohelper.setActive(self._rareObj, flag)
end

function CommonHeroIcon:isShowRareIcon(flag)
	self._isShowRareIcon = flag

	gohelper.setActive(self._rareIcon.gameObject, flag)
end

function CommonHeroIcon:isShowCareerIcon(flag)
	self._isShowCareer = flag

	gohelper.setActive(self._careerIcon.gameObject, flag)
end

function CommonHeroIcon:setScale(scale)
	transformhelper.setLocalScale(self.tr, scale, scale, scale)
end

function CommonHeroIcon:setAnchor(anchorX, anchorY)
	recthelper.setAnchor(self.tr, anchorX, anchorY)
end

function CommonHeroIcon:_initObj()
	self._rareGos = self:getUserDataTb_()

	for i = 1, 6 do
		self._rareGos[i] = gohelper.findChild(self._rareObj, "rare" .. tostring(i))
	end

	self._starImgs = self:getUserDataTb_()

	for i = 1, 5 do
		self._starImgs[i] = gohelper.findChildImage(self._starObj, "star" .. tostring(i))
	end

	self._breakImgs = self:getUserDataTb_()

	for i = 1, 6 do
		self._breakImgs[i] = gohelper.findChildImage(self._breakObj, "break" .. tostring(i))
	end
end

function CommonHeroIcon:addClickListener(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
	self._btnClick = self._btnClick or SLFramework.UGUI.UIClickListener.Get(self.go)

	self._btnClick:AddClickListener(self._onItemClick, self)
end

function CommonHeroIcon:removeClickListener()
	self._callback = nil
	self._callbackObj = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function CommonHeroIcon:removeEventListeners()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function CommonHeroIcon:onUpdateHeroId(heroId)
	local heroCo = HeroConfig.instance:getHeroCO(heroId)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	self._cardIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._careerIcon, "lssx_" .. tostring(heroCo.career))
	self:_fillRareContent(CharacterEnum.Star[heroCo.rare])
end

function CommonHeroIcon:onUpdateMO(mo)
	self._mo = mo
	self._lvTxt.text = HeroConfig.instance:getShowLevel(mo.level)

	self:_fillRareContent(CharacterEnum.Star[mo.config.rare])
	self:_fillBreakContent(mo.exSkillLevel)
	self:_fillStarContent(mo.rank)

	local heroSkin = HeroModel.instance:getByHeroId(mo.heroId)
	local skinConfig = SkinConfig.instance:getSkinCo(heroSkin.skin)

	self._cardIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._careerIcon, "lssx_" .. tostring(mo.config.career))
end

function CommonHeroIcon:updateMonster(monsterConfig)
	self._monsterConfig = monsterConfig
	self._lvTxt.text = HeroConfig.instance:getShowLevel(monsterConfig.level)

	self:_fillRareContent(1)
	gohelper.setActive(self._breakObj, false)
	gohelper.setActive(self._starObj, false)

	local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

	self._cardIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._careerIcon, "lssx_" .. tostring(monsterConfig.career))
end

function CommonHeroIcon:_fillRareContent(value)
	value = value and math.max(value, 1) or 1

	if self._rareObj then
		UISpriteSetMgr.instance:setCommonSprite(self._rareIcon, "bp_quality_0" .. tostring(value))

		if self._isShowRare then
			for i = 1, 6 do
				gohelper.setActive(self._rareGos[i], i <= value)
			end
		end

		gohelper.setActive(self._rareObj, self._isShowRare)
	end
end

function CommonHeroIcon:_fillBreakContent(value)
	value = value and math.max(value, 1) or 1

	if self._breakObj then
		if self._isShowBreak then
			for i = 1, 6 do
				if i <= value then
					SLFramework.UGUI.GuiHelper.SetColor(self._breakImgs[i], "#d7a93d")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._breakImgs[i], "#626467")
				end
			end
		end

		gohelper.setActive(self._breakObj, self._isShowBreak)
	end
end

function CommonHeroIcon:_fillStarContent(value)
	value = value and math.max(value, 1) or 1

	if self._starObj then
		if self._isShowStar then
			for i = 1, 5 do
				if i <= value then
					SLFramework.UGUI.GuiHelper.SetColor(self._starImgs[i], "#d7a93d")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._starImgs[i], "#626467")
				end
			end
		end

		gohelper.setActive(self._starObj, self._isShowStar)
	end
end

function CommonHeroIcon:_onItemClick()
	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, self._mo)
		else
			self._callback(self._mo)
		end
	end
end

function CommonHeroIcon:onDestroy()
	self._cardIcon:UnLoadImage()
end

return CommonHeroIcon
