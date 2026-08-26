-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroItem", package.seeall)

local V3a9_BossRush_HeroItem = class("V3a9_BossRush_HeroItem", ListScrollCellExtend)

function V3a9_BossRush_HeroItem:onInitView()
	self._goAdd = gohelper.findChild(self.viewGO, "#go_Add")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._goHas = gohelper.findChild(self.viewGO, "#go_Has")
	self._goban = gohelper.findChild(self.viewGO, "#go_Has/#go_ban")
	self._goequip = gohelper.findChild(self.viewGO, "#go_Has/#go_equip")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_Click")
	self._simageHeadIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Has/heroicon")
	self._imageHeadIcon = gohelper.findChildImage(self.viewGO, "#go_Has/heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_Has/career")
	self._goexskill = gohelper.findChild(self.viewGO, "#go_Has/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#go_Has/#go_exskill/#image_exskill")
	self._goAssist = gohelper.findChild(self.viewGO, "#go_Has/#go_assist")

	if self._editableInitView then
		self:_editableInitView()
	end
end

local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function V3a9_BossRush_HeroItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function V3a9_BossRush_HeroItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function V3a9_BossRush_HeroItem:_btnClickOnClick()
	if self._clickCb then
		self._clickCb(self._cbobj, self._index)
	end
end

function V3a9_BossRush_HeroItem:_editableInitView()
	gohelper.setActive(self._goAdd.gameObject, false)
	gohelper.setActive(self._goEmpty.gameObject, false)
	gohelper.setActive(self._goHas.gameObject, false)
	gohelper.setActive(self._goequip.gameObject, false)
	gohelper.setActive(self._goban.gameObject, false)

	self._isAssist = false
end

function V3a9_BossRush_HeroItem:_editableAddEvents()
	return
end

function V3a9_BossRush_HeroItem:_editableRemoveEvents()
	return
end

function V3a9_BossRush_HeroItem:onUpdateHeroId(index, heroId)
	self._index = index
	self._info = nil
	self._heroId = heroId
	self._isHasHero = self._heroId and self._heroId ~= 0

	self:refreshHero()
end

function V3a9_BossRush_HeroItem:onUpdateMO(index, stage)
	self._index = index
	self._heroMo, self._isAssist = V3a9_BossRushModel.instance:getTeamHeroMo(index, stage)
	self._heroId = self._heroMo and self._heroMo.heroId
	self._isHasHero = self._heroMo ~= nil

	self:refreshHero()
end

function V3a9_BossRush_HeroItem:setParam(isShowExSkill)
	self._isShowExSkill = isShowExSkill
end

function V3a9_BossRush_HeroItem:getHeroId()
	return self._heroId
end

function V3a9_BossRush_HeroItem:setClickCb(cb, cbobj)
	self._clickCb = cb
	self._cbobj = cbobj
end

function V3a9_BossRush_HeroItem:refreshHero()
	if self._isHasHero then
		local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)

		if self._heroMo then
			if not self._heroMo.skin then
				local skin = heroConfig.skinId

				if self._heroMo then
					if not self._heroMo.exSkillLevel then
						local exSkill = 0
						local skinConfig = SkinConfig.instance:getSkinCo(skin)

						self._simageHeadIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))

						local careerSpriteName = "lssx_" .. tostring(heroConfig.career)

						UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, careerSpriteName)

						if self._isShowExSkill then
							self._imageexskill.fillAmount = exSkillFillAmount[exSkill] or 0
						end

						gohelper.setActive(self._goexskill, self._isShowExSkill and exSkill > 0)
					end
				end
			end
		end
	end

	gohelper.setActive(self._goAssist, self._isHasHero and self._isAssist)
	self:_refreshState()
end

function V3a9_BossRush_HeroItem:_refreshState()
	gohelper.setActive(self._goAdd.gameObject, not self._isHasHero)
	gohelper.setActive(self._goEmpty.gameObject, not self._isHasHero)
	gohelper.setActive(self._goHas.gameObject, self._isHasHero)
end

function V3a9_BossRush_HeroItem:onDestroyView()
	self._simageHeadIcon:UnLoadImage()
end

return V3a9_BossRush_HeroItem
