-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_HeroGroupItem1.lua

module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroupItem1", package.seeall)

local V1a4_BossRush_HeroGroupItem1 = class("V1a4_BossRush_HeroGroupItem1", V1a4_BossRush_HeroGroupItemBase)

function V1a4_BossRush_HeroGroupItem1:init(go)
	self._gohero = gohelper.findChild(go, "#go_hero")
	self._simageheroicon = gohelper.findChildSingleImage(go, "#go_hero/#simage_heroicon")
	self._imagecareer = gohelper.findChildImage(go, "#go_hero/#image_career")
	self._gorank1 = gohelper.findChild(go, "#go_hero/layout/vertical/layout/rankobj/#go_rank1")
	self._gorank2 = gohelper.findChild(go, "#go_hero/layout/vertical/layout/rankobj/#go_rank2")
	self._gorank3 = gohelper.findChild(go, "#go_hero/layout/vertical/layout/rankobj/#go_rank3")
	self._txtlv = gohelper.findChildText(go, "#go_hero/layout/vertical/layout/level/#txt_lv")
	self._gostar1 = gohelper.findChild(go, "#go_hero/layout/vertical/go_starList/#go_star1")
	self._gostar2 = gohelper.findChild(go, "#go_hero/layout/vertical/go_starList/#go_star2")
	self._gostar3 = gohelper.findChild(go, "#go_hero/layout/vertical/go_starList/#go_star3")
	self._gostar4 = gohelper.findChild(go, "#go_hero/layout/vertical/go_starList/#go_star4")
	self._gostar5 = gohelper.findChild(go, "#go_hero/layout/vertical/go_starList/#go_star5")
	self._gostar6 = gohelper.findChild(go, "#go_hero/layout/vertical/go_starList/#go_star6")
	self._goequip = gohelper.findChild(go, "#go_hero/layout/#go_equip")
	self._goTrialTag = gohelper.findChild(go, "#go_hero/trialTag")
	self._imageequiprare = gohelper.findChildImage(go, "#go_hero/layout/#go_equip/#image_equiprare")
	self._imageequipicon = gohelper.findChildImage(go, "#go_hero/layout/#go_equip/#image_equipicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_HeroGroupItem1:_editableInitView()
	self._starList = self:_initGoList("_gostar")
	self._rankList = self:_initGoList("_gorank")
end

function V1a4_BossRush_HeroGroupItem1:onSetData()
	self:_refreshHeroByDefault()
	self:_refreshEquip()
	self:refreshLevelList(self._rankList)
	self:refreshShowLevel(self._txtlv)
	self:refreshStarList(self._starList)
end

function V1a4_BossRush_HeroGroupItem1:_refreshEquip()
	local equipMo = self._equipMo

	if not equipMo then
		gohelper.setActive(self._goequip, false)

		return
	end

	local equipIconSpriteName = self:getEquipIconSpriteName()

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equipIconSpriteName)

	local equipRareSprite = self:getEquipRareSprite()

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, equipRareSprite)
end

function V1a4_BossRush_HeroGroupItem1:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return V1a4_BossRush_HeroGroupItem1
