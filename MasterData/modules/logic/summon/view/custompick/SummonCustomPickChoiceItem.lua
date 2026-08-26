-- chunkname: @modules/logic/summon/view/custompick/SummonCustomPickChoiceItem.lua

module("modules.logic.summon.view.custompick.SummonCustomPickChoiceItem", package.seeall)

local SummonCustomPickChoiceItem = class("SummonCustomPickChoiceItem", LuaCompBase)

function SummonCustomPickChoiceItem:init(go)
	self._go = go
	self._goclick = gohelper.findChild(self._go, "go_click")
	self._btnClick = gohelper.findChildClickWithAudio(self._go, "go_click", AudioEnum.UI.UI_vertical_first_tabs_click)
	self._goSelected = gohelper.findChild(self._go, "select")
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goclick)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	self._imagerare = gohelper.findChildImage(self._go, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(self._go, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(self._go, "role/career")
	self._txtname = gohelper.findChildText(self._go, "role/name")
	self._goexskill = gohelper.findChild(go, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(go, "role/#go_exskill/#image_exskill")
	self._goRank = gohelper.findChild(go, "role/Rank")

	gohelper.setActive(self._goRank, false)
	self:addEvents()
end

SummonCustomPickChoiceItem.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function SummonCustomPickChoiceItem:addEvents()
	self._btnClick:AddClickListener(self.onClickSelf, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function SummonCustomPickChoiceItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function SummonCustomPickChoiceItem:_onLongClickItem()
	if not self._mo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		showHome = false,
		heroId = self._mo.id
	})
end

function SummonCustomPickChoiceItem:onClickSelf()
	logNormal("onClickChoice id = " .. tostring(self._mo.id))
	SummonCustomPickChoiceController.instance:setSelect(self._mo.id)
end

function SummonCustomPickChoiceItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
	self:refreshSelect()
end

function SummonCustomPickChoiceItem:refreshUI()
	local heroCo = HeroConfig.instance:getHeroCO(self._mo.id)

	if not heroCo then
		logError("SummonCustomPickChoiceItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(self._mo.id))

		return
	end

	self:refreshBaseInfo(heroCo)
	self:refreshExSkill()
end

function SummonCustomPickChoiceItem:refreshBaseInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("SummonCustomPickChoiceItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name
end

function SummonCustomPickChoiceItem:refreshExSkill()
	if not self._mo:hasHero() or self._mo:getSkillLevel() <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[self._mo:getSkillLevel()] or 1
end

function SummonCustomPickChoiceItem:refreshSelect()
	local isSelect = SummonCustomPickChoiceListModel.instance:isHeroIdSelected(self._mo.id)

	gohelper.setActive(self._goSelected, isSelect)
end

function SummonCustomPickChoiceItem:onDestroy()
	if not self._isDisposed then
		self._simageicon:UnLoadImage()
		self:removeEvents()

		self._isDisposed = true
	end
end

return SummonCustomPickChoiceItem
