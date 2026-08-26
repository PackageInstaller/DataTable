-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5SettlementHeroItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5SettlementHeroItem", package.seeall)

local Season123_3_5SettlementHeroItem = class("Season123_3_5SettlementHeroItem", BaseViewExtended)

function Season123_3_5SettlementHeroItem:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#go_hero/#simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_hero/#image_career")
	self._gocard1 = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards/#go_card1")
	self._gocard2 = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards/#go_card2")
	self._gosingle = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards/#go_single")
	self._goequip = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_equip")
	self._imageequipicon = gohelper.findChildImage(self.viewGO, "#go_hero/layout/#go_equip/#image_equipicon")
	self._imageequiprare = gohelper.findChildImage(self.viewGO, "#go_hero/layout/#go_equip/#image_equiprare")
	self._gocards = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards")
	self._equipPart = gohelper.findChild(self.viewGO, "#go_hero/layout")
	self._commonHeroCard = CommonHeroCard.create(self._simageheroicon.gameObject, self.viewName)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5SettlementHeroItem:addEvents()
	return
end

function Season123_3_5SettlementHeroItem:removeEvents()
	return
end

function Season123_3_5SettlementHeroItem:onRefreshViewParam(is_replay, hero, equip, equip_104, replay_data, trail)
	self._is_replay = is_replay
	self._hero = hero
	self._equip = equip
	self._equip_123 = equip_104
	self._replay_data = replay_data
	self._trail = trail
end

function Season123_3_5SettlementHeroItem:onOpen()
	self.actId = Season123Model.instance:getCurSeasonId()

	self:setViewVisibleInternal(false)

	if self._is_replay then
		self:_showReplayData()
	else
		self:_showNormalData()
	end

	if self._no123Equip and self._noEquip then
		gohelper.setActive(self._equipPart, false)
	end

	gohelper.setActive(self._gocards, not self._no123Equip)
end

function Season123_3_5SettlementHeroItem:_showNormalData()
	if self._equip then
		local equip_data = EquipModel.instance:getEquip(self._equip[1])
		local equip_id = equip_data and equip_data.equipId

		self:_showEquipIcon(equip_id)

		if self._trail then
			self:_showTrailHeroIcon(self._trail)
		else
			self:_showHeroIcon(self._hero)
		end

		if self._equip_123 then
			local totalEquipCount = #self._equip_123

			self._no123Equip = totalEquipCount == 0

			for i, v in ipairs(self._equip_123) do
				self:_showEquip123(i, nil, totalEquipCount, v)
			end
		end
	end
end

function Season123_3_5SettlementHeroItem:_showTrailHeroIcon(trail)
	if not trail then
		return
	end

	local trailCo = lua_hero_trial.configDict[trail.trialId][0]
	local heroCo = HeroConfig.instance:getHeroCO(trailCo.heroId)
	local skinConfig = trailCo.skin > 0 and SkinConfig.instance:getSkinCo(trailCo.skin) or SkinConfig.instance:getSkinCo(heroCo.skinId)
	local career = heroCo.career

	if skinConfig then
		self._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
	else
		gohelper.setActive(self.viewGO.transform.parent.gameObject, false)
	end

	if career then
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(career))
	end

	if skinConfig then
		self._commonHeroCard:onUpdateMO(skinConfig)
	end

	if trailCo.equipId > 0 then
		self:_showEquipIcon(trailCo.equipId)
	end
end

function Season123_3_5SettlementHeroItem:_showHeroIcon(heroId, skinId)
	local hero_mo = HeroModel.instance:getById(heroId)

	hero_mo = self:checkAssist(heroId, hero_mo)

	local career, skinConfig

	if hero_mo then
		skinId = skinId or hero_mo.skin
		career = hero_mo.config.career
	else
		local entityMo = FightDataHelper.entityMgr:getById(heroId)

		if entityMo then
			local monCo = lua_monster.configDict[entityMo.modelId]

			if monCo then
				skinId = skinId or monCo.skinId
				skinConfig = FightConfig.instance:getSkinCO(skinId)
				career = monCo.career
			end
		end
	end

	if skinId then
		skinConfig = FightConfig.instance:getSkinCO(skinId)

		if skinConfig then
			self._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
		end
	else
		gohelper.setActive(self.viewGO.transform.parent.gameObject, false)
	end

	if career then
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(career))
	end

	if skinConfig then
		self._commonHeroCard:onUpdateMO(skinConfig)
	end
end

function Season123_3_5SettlementHeroItem:checkAssist(heroUid, heroMO)
	if not heroMO then
		local context = Season123Model.instance:getBattleContext()

		if context.stage ~= nil then
			heroMO = Season123HeroUtils.getHeroMO(context.actId, heroUid, context.stage)
		end
	end

	return heroMO
end

function Season123_3_5SettlementHeroItem:_showEquipIcon(equip_id)
	if equip_id and equip_id ~= 0 then
		local equip_config = EquipConfig.instance:getEquipCo(equip_id)

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equip_config.icon)
		UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, "bianduixingxian_" .. equip_config.rare)
		gohelper.setActive(self._goequip, true)
	else
		gohelper.setActive(self._goequip, false)

		self._noEquip = true
	end
end

function Season123_3_5SettlementHeroItem:_showEquip123(index, uid, totalEquipCount, equipId)
	if equipId == 0 then
		return
	end

	if totalEquipCount <= 1 then
		if not self._gosingle then
			local parentTran = self["_gocard" .. index]

			self:openSubView(Season123_3_5CelebrityCardGetItem, Season123_3_5CelebrityCardItem.AssetPath, parentTran, uid, nil, equipId)
		end
	end
end

function Season123_3_5SettlementHeroItem:_showReplayData()
	local hero_uid = self._hero

	self:_showHeroIcon(hero_uid, self._replay_data and self._replay_data.skin)
	self:_showEquipIcon(self._equip and self._equip.equipId)

	if hero_uid ~= "0" and hero_uid ~= "-100000" and self._equip_123 then
		local totalEquipCount = #self._equip_123

		self._no123Equip = totalEquipCount == 0

		for i = 1, totalEquipCount do
			self:_showEquip123(i, nil, totalEquipCount, self._equip_123[i])
		end
	end
end

function Season123_3_5SettlementHeroItem:_refreshEquipPos()
	return
end

function Season123_3_5SettlementHeroItem:onClose()
	return
end

function Season123_3_5SettlementHeroItem:onDestroyView()
	self._simageheroicon:UnLoadImage()
end

return Season123_3_5SettlementHeroItem
