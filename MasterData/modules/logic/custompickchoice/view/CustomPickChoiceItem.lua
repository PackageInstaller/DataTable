-- chunkname: @modules/logic/custompickchoice/view/CustomPickChoiceItem.lua

module("modules.logic.custompickchoice.view.CustomPickChoiceItem", package.seeall)

local CustomPickChoiceItem = class("CustomPickChoiceItem", LuaCompBase)
local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function CustomPickChoiceItem:init(go)
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

function CustomPickChoiceItem:addEvents()
	self._btnClick:AddClickListener(self.onClickSelf, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function CustomPickChoiceItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function CustomPickChoiceItem:onClickSelf()
	logNormal("CustomPickChoiceItem onClickChoice id = " .. tostring(self._mo.id))
	CustomPickChoiceController.instance:setSelect(self._mo.id)
end

function CustomPickChoiceItem:_onLongClickItem()
	if not self._mo then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self._mo.id
	})
end

function CustomPickChoiceItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
	self:refreshSelect()
end

function CustomPickChoiceItem:refreshUI()
	local heroCo = HeroConfig.instance:getHeroCO(self._mo.id)

	if not heroCo then
		logError("CustomPickChoiceItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(self._mo.id))

		return
	end

	self:refreshBaseInfo(heroCo)
	self:refreshExSkill()
end

function CustomPickChoiceItem:refreshBaseInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("CustomPickChoiceItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name

	local rank = self._mo.rank
	local rankIconIndex = rank - 1
	local isShowRanIcon = false

	for i = 1, 3 do
		local isCurRanIcon = i == rankIconIndex

		gohelper.setActive(self._goranks[i], isCurRanIcon)

		isShowRanIcon = isShowRanIcon or isCurRanIcon
	end

	gohelper.setActive(self._goRankBg, isShowRanIcon)
end

function CustomPickChoiceItem:refreshExSkill()
	if not self._mo:hasHero() or self._mo:getSkillLevel() <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = exSkillFillAmount[self._mo:getSkillLevel()] or 1
end

function CustomPickChoiceItem:refreshSelect()
	local isSelect = CustomPickChoiceListModel.instance:isHeroIdSelected(self._mo.id)

	gohelper.setActive(self._goSelected, isSelect)
end

function CustomPickChoiceItem:onDestroy()
	if not self._isDisposed then
		self._simageicon:UnLoadImage()
		self:removeEvents()

		self._isDisposed = true
	end
end

return CustomPickChoiceItem
