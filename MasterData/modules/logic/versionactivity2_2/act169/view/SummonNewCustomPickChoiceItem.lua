-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickChoiceItem.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceItem", package.seeall)

local SummonNewCustomPickChoiceItem = class("SummonNewCustomPickChoiceItem", LuaCompBase)

function SummonNewCustomPickChoiceItem:init(go)
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

function SummonNewCustomPickChoiceItem:setClickCallBack(callBack)
	self._callBack = callBack
end

SummonNewCustomPickChoiceItem.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function SummonNewCustomPickChoiceItem:addEvents()
	self._btnClick:AddClickListener(self.onClickSelf, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function SummonNewCustomPickChoiceItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()

	self._callBack = nil
end

function SummonNewCustomPickChoiceItem:_onLongClickItem()
	if not self._mo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self._mo.id
	})
end

function SummonNewCustomPickChoiceItem:onClickSelf()
	logNormal("onClickChoice id = " .. tostring(self._mo.id))

	if self._callBack then
		self._callBack(self._mo.id)
	end
end

function SummonNewCustomPickChoiceItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
	self:refreshSelect()
end

function SummonNewCustomPickChoiceItem:refreshUI()
	local heroCo = HeroConfig.instance:getHeroCO(self._mo.id)

	if not heroCo then
		logError("SummonNewCustomPickChoiceItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(self._mo.id))

		return
	end

	self:refreshBaseInfo(heroCo)
	self:refreshExSkill()
end

function SummonNewCustomPickChoiceItem:refreshBaseInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("SummonNewCustomPickChoiceItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name
end

function SummonNewCustomPickChoiceItem:refreshExSkill()
	if not self._mo:hasHero() or self._mo:getSkillLevel() <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = self.exSkillFillAmount[self._mo:getSkillLevel()] or 1
end

function SummonNewCustomPickChoiceItem:refreshSelect()
	local isSelect = SummonNewCustomPickChoiceListModel.instance:isHeroIdSelected(self._mo.id)

	gohelper.setActive(self._goSelected, isSelect)
end

function SummonNewCustomPickChoiceItem:onDestroy()
	if not self._isDisposed then
		self._simageicon:UnLoadImage()
		self:removeEvents()

		self._callBack = nil
		self._isDisposed = true
	end
end

return SummonNewCustomPickChoiceItem
