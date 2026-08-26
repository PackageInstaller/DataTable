-- chunkname: @modules/logic/gift/view/GiftMultipleInspirationHeroItem.lua

module("modules.logic.gift.view.GiftMultipleInspirationHeroItem", package.seeall)

local GiftMultipleInspirationHeroItem = class("GiftMultipleInspirationHeroItem", LuaCompBase)
local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function GiftMultipleInspirationHeroItem:init(go)
	self._go = go
	self._goclick = gohelper.findChild(self._go, "go_click")
	self._btnClick = gohelper.getClickWithAudio(self._goclick, AudioEnum.UI.UI_vertical_first_tabs_click)
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goclick)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	self._goSelected = gohelper.findChild(self._go, "select")
	self._imagerare = gohelper.findChildImage(self._go, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(self._go, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(self._go, "role/career")
	self._txtname = gohelper.findChildText(self._go, "role/name")
	self._goexskill = gohelper.findChild(go, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(go, "role/#go_exskill/#image_exskill")
	self._goRankBg = gohelper.findChild(go, "role/Rank")
	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChild(go, "role/Rank/rank" .. i)
	end

	self:addEvents()
end

function GiftMultipleInspirationHeroItem:addEvents()
	self._btnClick:AddClickListener(self.onClickSelf, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function GiftMultipleInspirationHeroItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function GiftMultipleInspirationHeroItem:onClickSelf()
	logNormal("GiftMultipleInspirationHeroItem onClickChoice id = " .. tostring(self._heroId))

	if not self._heroId then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self._heroId
	})
end

function GiftMultipleInspirationHeroItem:_onLongClickItem()
	if not self._heroId then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self._heroId
	})
end

function GiftMultipleInspirationHeroItem:onUpdateMO(heroId)
	self._heroId = heroId
	self._heroMo = HeroModel.instance:getByHeroId(heroId)

	self:refreshUI()
	self:refreshSelect()
end

function GiftMultipleInspirationHeroItem:refreshUI()
	local heroCo = HeroConfig.instance:getHeroCO(self._heroId)

	if not heroCo then
		logError("GiftMultipleInspirationHeroItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(self._heroId))

		return
	end

	self:refreshBaseInfo(heroCo)
	self:refreshExSkill()
end

function GiftMultipleInspirationHeroItem:refreshBaseInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("GiftMultipleInspirationHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name

	gohelper.setActive(self._goRankBg, self._heroMo ~= nil)

	if not self._heroMo then
		return
	end

	local rank = self._heroMo.rank
	local rankIconIndex = rank - 1
	local isShowRanIcon = false

	for i = 1, 3 do
		local isCurRanIcon = i == rankIconIndex

		gohelper.setActive(self._goranks[i], isCurRanIcon)

		isShowRanIcon = isShowRanIcon or isCurRanIcon
	end

	gohelper.setActive(self._goRankBg, isShowRanIcon)
end

function GiftMultipleInspirationHeroItem:refreshExSkill()
	if not self._heroMo or self._heroMo.exSkillLevel <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = exSkillFillAmount[self._heroMo.exSkillLevel] or 1
end

function GiftMultipleInspirationHeroItem:refreshSelect(heroId)
	local isSelect = heroId == self._heroId

	gohelper.setActive(self._goSelected, isSelect)
end

function GiftMultipleInspirationHeroItem:onDestroy()
	if not self._isDisposed then
		self._simageicon:UnLoadImage()
		self:removeEvents()

		self._isDisposed = true
	end
end

return GiftMultipleInspirationHeroItem
