-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleHeroGroupItem2.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleHeroGroupItem2", package.seeall)

local Rouge2_BossBattleHeroGroupItem2 = class("Rouge2_BossBattleHeroGroupItem2", Rouge2_BossBattleHeroGroupItemBase)

function Rouge2_BossBattleHeroGroupItem2:init(go)
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BossBattleHeroGroupItem2:_editableInitView()
	self._starList = self:_initGoList("_gostar")
	self._rankList = self:_initGoList("_gorank")
end

function Rouge2_BossBattleHeroGroupItem2:onSetData()
	self:_refreshHeroByDefault()
	self:refreshLevelList(self._rankList)
	self:refreshShowLevel(self._txtlv)
	self:refreshStarList(self._starList)
end

function Rouge2_BossBattleHeroGroupItem2:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return Rouge2_BossBattleHeroGroupItem2
