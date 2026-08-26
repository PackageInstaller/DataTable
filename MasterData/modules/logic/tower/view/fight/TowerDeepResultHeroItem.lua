-- chunkname: @modules/logic/tower/view/fight/TowerDeepResultHeroItem.lua

module("modules.logic.tower.view.fight.TowerDeepResultHeroItem", package.seeall)

local TowerDeepResultHeroItem = class("TowerDeepResultHeroItem", LuaCompBase)

function TowerDeepResultHeroItem:init(go)
	self.go = go
	self._gohero = gohelper.findChild(go, "heroitemani")
	self._simageheroicon = gohelper.findChildSingleImage(go, "heroitemani/hero/charactericon")
	self._imagecareer = gohelper.findChildImage(go, "heroitemani/hero/career")
	self._gorank1 = gohelper.findChild(go, "heroitemani/hero/vertical/layout/rankobj/rank1")
	self._gorank2 = gohelper.findChild(go, "heroitemani/hero/vertical/layout/rankobj/rank2")
	self._gorank3 = gohelper.findChild(go, "heroitemani/hero/vertical/layout/rankobj/rank3")
	self._txtlv = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/lv/lvnum")
	self._gostar1 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star1")
	self._gostar2 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star2")
	self._gostar3 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star3")
	self._gostar4 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star4")
	self._gostar5 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star5")
	self._gostar6 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star6")
	self._goequip = gohelper.findChild(go, "heroitemani/equip")
	self._imageequiprare = gohelper.findChildImage(go, "heroitemani/equip/equiprare")
	self._imageequipicon = gohelper.findChildImage(go, "heroitemani/equip/equipicon")
	self._txtequiplvl = gohelper.findChildText(go, "heroitemani/equip/equiplv/txtequiplv")
	self._goEmpty = gohelper.findChild(go, "empty")
	self._emptyEquipGo = gohelper.findChild(go, "heroitemani/emptyequip")
	self._goFakeEquip = gohelper.findChild(go, "heroitemani/hero/vertical/fakeequip")
end

function TowerDeepResultHeroItem:setData(heroMo, equipMo)
	gohelper.setActive(self.go, true)

	self.heroMo = heroMo
	self.equipMo = equipMo

	self:_refreshHero()
	self:_refreshEquip()
	gohelper.setActive(self._gohero, heroMo ~= nil)
	gohelper.setActive(self._goEmpty, heroMo == nil)
	gohelper.setActive(self._emptyEquipGo, false)
end

function TowerDeepResultHeroItem:_refreshHero()
	local heroMo = self.heroMo

	if not heroMo then
		return
	end

	local skinCO = FightConfig.instance:getSkinCO(heroMo.skin)
	local headIconMiddleResUrl = ResUrl.getHeadIconMiddle(skinCO.retangleIcon)

	self._simageheroicon:LoadImage(headIconMiddleResUrl)

	local careerSpriteName = "lssx_" .. tostring(heroMo.config.career)

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, careerSpriteName)

	if not heroMo.level then
		local level = 0
		local showLevel, _ = HeroConfig.instance:getShowLevel(level)

		self._txtlv.text = showLevel

		self:_refreshLevelList()
		self:_refreshStarList()
	end
end

function TowerDeepResultHeroItem:_refreshEquip()
	local equipMo = self.equipMo

	gohelper.setActive(self._goequip, equipMo ~= nil)
	gohelper.setActive(self._goFakeEquip, equipMo ~= nil)

	if not equipMo then
		return
	end

	local config = equipMo.config
	local equipIconSpriteName = config.icon

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equipIconSpriteName)

	local equipRareSprite = "bianduixingxian_" .. tostring(config.rare)

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, equipRareSprite)

	self._txtequiplvl.text = equipMo.level
end

function TowerDeepResultHeroItem:_refreshLevelList()
	local heroMo = self.heroMo

	if heroMo then
		if not heroMo.level then
			local level = 0
			local _, rank = HeroConfig.instance:getShowLevel(level)

			for i = 1, 3 do
				local key = "_gorank" .. i

				gohelper.setActive(self[key], i == rank - 1)
			end
		end
	end
end

function TowerDeepResultHeroItem:_refreshStarList()
	local heroMo = self.heroMo

	if heroMo.config then
		if not heroMo.config.rare then
			local rare = -1

			for i = 1, 6 do
				local key = "_gostar" .. i

				gohelper.setActive(self[key], i <= rare + 1)
			end
		end
	end
end

function TowerDeepResultHeroItem:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return TowerDeepResultHeroItem
