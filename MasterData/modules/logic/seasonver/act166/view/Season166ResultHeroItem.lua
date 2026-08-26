-- chunkname: @modules/logic/seasonver/act166/view/Season166ResultHeroItem.lua

module("modules.logic.seasonver.act166.view.Season166ResultHeroItem", package.seeall)

local Season166ResultHeroItem = class("Season166ResultHeroItem", LuaCompBase)

function Season166ResultHeroItem:init(go)
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
end

function Season166ResultHeroItem:setData(heroMo, equipMo)
	self.heroMo = heroMo
	self.equipMo = equipMo

	self:_refreshHero()
	self:_refreshEquip()
	gohelper.setActive(self._gohero, true)
	gohelper.setActive(self._goEmpty, false)
end

function Season166ResultHeroItem:_refreshHero()
	local heroMo = self.heroMo

	if not heroMo then
		logError("heroMo is nil")

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

function Season166ResultHeroItem:_refreshEquip()
	local equipMo = self.equipMo

	if not equipMo then
		gohelper.setActive(self._goequip, false)

		return
	end

	local config = equipMo.config
	local equipIconSpriteName = config.icon

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equipIconSpriteName)

	local equipRareSprite = "bianduixingxian_" .. tostring(config.rare)

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, equipRareSprite)

	self._txtequiplvl.text = equipMo.level
end

function Season166ResultHeroItem:_refreshLevelList()
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

function Season166ResultHeroItem:_refreshStarList()
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

function Season166ResultHeroItem:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return Season166ResultHeroItem
