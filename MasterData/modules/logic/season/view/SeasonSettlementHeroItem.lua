-- chunkname: @modules/logic/season/view/SeasonSettlementHeroItem.lua

module("modules.logic.season.view.SeasonSettlementHeroItem", package.seeall)

local SeasonSettlementHeroItem = class("SeasonSettlementHeroItem", BaseViewExtended)

function SeasonSettlementHeroItem:onInitView()
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonSettlementHeroItem:addEvents()
	return
end

function SeasonSettlementHeroItem:removeEvents()
	return
end

function SeasonSettlementHeroItem:onRefreshViewParam(is_replay, hero, equip, equip_104)
	self._is_replay = is_replay
	self._hero = hero
	self._equip = equip
	self._equip_104 = equip_104
end

function SeasonSettlementHeroItem:onOpen()
	self:setViewVisibleInternal(false)

	if self._is_replay then
		self:_showReplayData()
	else
		self:_showNormalData()
	end

	if self._no104Equip and self._noEquip then
		gohelper.setActive(self._equipPart, false)
	end

	gohelper.setActive(self._gocards, not self._no104Equip)
end

function SeasonSettlementHeroItem:_showNormalData()
	self:_showHeroIcon(self._hero)

	if self._equip then
		local equip_data = EquipModel.instance:getEquip(self._equip[1])
		local equip_id = equip_data and equip_data.equipId

		self:_showEquipIcon(equip_id)

		if self._equip_104 then
			local tar_equip_104 = Activity104Model.instance:getAllItemMo()
			local uidTab = {}

			for i, v in ipairs(self._equip_104) do
				if tar_equip_104[v] then
					table.insert(uidTab, tar_equip_104[v].uid)
				end
			end

			local totalEquipCount = #uidTab

			self._no104Equip = totalEquipCount == 0

			for i, v in ipairs(uidTab) do
				self:_showEquip104(i, v, totalEquipCount)
			end
		end
	end
end

function SeasonSettlementHeroItem:_showHeroIcon(heroId)
	local hero_mo = HeroModel.instance:getById(heroId)

	if hero_mo then
		local skinConfig = FightConfig.instance:getSkinCO(hero_mo.skin)

		self._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(hero_mo.config.career))
	else
		gohelper.setActive(self.viewGO.transform.parent.gameObject, false)
	end
end

function SeasonSettlementHeroItem:_showEquipIcon(equip_id)
	if equip_id and equip_id ~= 0 then
		local equip_config = EquipConfig.instance:getEquipCo(equip_id)

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equip_config.icon)
		UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, "bianduixingxian_" .. equip_config.rare)
	else
		gohelper.setActive(self._goequip, false)

		self._noEquip = true
	end
end

function SeasonSettlementHeroItem:_showEquip104(index, uid, totalEquipCount, equipId)
	if equipId == 0 then
		return
	end

	if totalEquipCount <= 1 then
		if not self._gosingle then
			local parentTran = self["_gocard" .. index]

			self:openSubView(SeasonCelebrityCardGetItem, "ui/viewres/season/seasoncelebritycarditem.prefab", parentTran, uid, nil, equipId)
		end
	end
end

function SeasonSettlementHeroItem:_showReplayData()
	local hero_uid = self._hero

	self:_showHeroIcon(hero_uid)
	self:_showEquipIcon(self._equip and self._equip.equipId)

	if hero_uid ~= "0" and hero_uid ~= "-100000" and self._equip_104 then
		local totalEquipCount = #self._equip_104

		self._no104Equip = totalEquipCount == 0

		for i = 1, totalEquipCount do
			self:_showEquip104(i, self._equip_104[i].equipUid, totalEquipCount, self._equip_104[i].equipId)
		end
	end
end

function SeasonSettlementHeroItem:_refreshEquipPos()
	return
end

function SeasonSettlementHeroItem:onClose()
	return
end

function SeasonSettlementHeroItem:onDestroyView()
	self._simageheroicon:UnLoadImage()
end

return SeasonSettlementHeroItem
