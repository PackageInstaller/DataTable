-- chunkname: @modules/logic/lifecircle/view/LifeCirclePickChoiceItem.lua

module("modules.logic.lifecircle.view.LifeCirclePickChoiceItem", package.seeall)

local LifeCirclePickChoiceItem = class("LifeCirclePickChoiceItem", RougeSimpleItemBase)

function LifeCirclePickChoiceItem:onInitView()
	self._imagerare = gohelper.findChildImage(self.viewGO, "role/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "role/#simage_icon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "role/#image_career")
	self._txtname = gohelper.findChildText(self.viewGO, "role/#txt_name")
	self._goexskill = gohelper.findChild(self.viewGO, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "role/#go_exskill/#image_exskill")
	self._goRank = gohelper.findChild(self.viewGO, "role/#go_Rank")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LifeCirclePickChoiceItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function LifeCirclePickChoiceItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

local csUILongPressListener = SLFramework.UGUI.UILongPressListener
local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function LifeCirclePickChoiceItem:ctor(...)
	self:__onInit()
	LifeCirclePickChoiceItem.super.ctor(self, ...)
end

function LifeCirclePickChoiceItem:onDestroyView()
	LifeCirclePickChoiceItem.super.onDestroyView(self)
	self:__onDispose()
end

function LifeCirclePickChoiceItem:_btnclickOnClick()
	if self:_isCustomSelect() then
		self:setSelected(not self:isSelected())
	else
		self:_showSummonHeroDetailView()
	end
end

function LifeCirclePickChoiceItem:_onLongClickItem()
	self:_showSummonHeroDetailView()
end

function LifeCirclePickChoiceItem:_showSummonHeroDetailView()
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self:heroId()
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
end

function LifeCirclePickChoiceItem:_isCustomSelect()
	return self:parent():isCustomSelect()
end

function LifeCirclePickChoiceItem:_editableInitView()
	LifeCirclePickChoiceItem.super._editableInitView(self)

	self._btnLongPress = csUILongPressListener.Get(self._btnclick.gameObject)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChild(self._goRank, "rank" .. i)
	end

	self:setSelected(false)
end

function LifeCirclePickChoiceItem:setSelected(isSelected)
	if self:isSelected() == isSelected then
		return
	end

	self._staticData.isSelected = isSelected

	self:onSelect(isSelected)
end

function LifeCirclePickChoiceItem:onSelect(isSelected)
	self:_setActive_goselect(isSelected)
	self:parent():onItemSelected(self, isSelected)
end

function LifeCirclePickChoiceItem:setData(mo)
	LifeCirclePickChoiceItem.super.setData(self, mo)
	self:_refreshHero()
	self:_refreshSkin()
	self:_refreshRank()
	self:_refreshExSkill()
end

function LifeCirclePickChoiceItem:_refreshHero()
	local heroCO = self:_heroCO()

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCO.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCO.rare]))

	self._txtname.text = heroCO.name
end

function LifeCirclePickChoiceItem:_refreshSkin()
	local skinCO = self:_skinCO()

	GameUtil.loadSImage(self._simageicon, ResUrl.getRoomHeadIcon(skinCO.headIcon))
end

function LifeCirclePickChoiceItem:_refreshExSkill()
	if not self._mo:hasHero() or self._mo:getSkillLevel() <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = exSkillFillAmount[self._mo:getSkillLevel()] or 1
end

function LifeCirclePickChoiceItem:_refreshRank()
	local rank = self._mo.rank
	local rankIconIndex = rank - 1
	local isShowRanIcon = false

	for i = 1, 3 do
		local isCurRanIcon = i == rankIconIndex

		gohelper.setActive(self._goranks[i], isCurRanIcon)

		isShowRanIcon = isShowRanIcon or isCurRanIcon
	end

	gohelper.setActive(self._goRank, isShowRanIcon)
end

function LifeCirclePickChoiceItem:_heroCO()
	return HeroConfig.instance:getHeroCO(self:heroId())
end

function LifeCirclePickChoiceItem:_skinCO()
	local CO = self:_heroCO()

	return SkinConfig.instance:getSkinCo(CO.skinId)
end

function LifeCirclePickChoiceItem:_setActive_goselect(isActive)
	gohelper.setActive(self._goselect, isActive)
end

function LifeCirclePickChoiceItem:heroId()
	local mo = self._mo

	return mo.id
end

return LifeCirclePickChoiceItem
