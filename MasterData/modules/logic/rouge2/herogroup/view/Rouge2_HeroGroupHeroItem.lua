-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupHeroItem.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupHeroItem", package.seeall)

local Rouge2_HeroGroupHeroItem = class("Rouge2_HeroGroupHeroItem", HeroGroupHeroItem)

function Rouge2_HeroGroupHeroItem:onUpdateMO(mo)
	Rouge2_HeroGroupHeroItem.super.onUpdateMO(self, mo)
	self:balanceHero()
end

function Rouge2_HeroGroupHeroItem:initEquips(equipIndex)
	self._equipType = -1

	if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not self.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(self._equipGO, false)
		gohelper.setActive(self._fakeEquipGO, false)
		gohelper.setActive(self._emptyEquipGo, false)
	else
		gohelper.setActive(self._equipGO, true)
		gohelper.setActive(self._fakeEquipGO, true)
		gohelper.setActive(self._emptyEquipGo, true)

		if not self._equip then
			self._equip = self:getUserDataTb_()
			self._equip.moveContainer = gohelper.findChild(self._equipGO, "moveContainer")
			self._equip.equipIcon = gohelper.findChildImage(self._equipGO, "moveContainer/equipIcon")
			self._equip.equipRare = gohelper.findChildImage(self._equipGO, "moveContainer/equiprare")
			self._equip.equiptxten = gohelper.findChildText(self._equipGO, "equiptxten")
			self._equip.equiptxtlv = gohelper.findChildText(self._equipGO, "moveContainer/equiplv/txtequiplv")
			self._equip.equipGolv = gohelper.findChild(self._equipGO, "moveContainer/equiplv")

			self:_equipIconAddDrag(self._equip.moveContainer, self._equip.equipIcon)
		end

		local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
		local equips = curGroupMO:getPosEquips(self.mo.id - 1).equipUid
		local equipId = equips[1]

		self._equipMO = EquipModel.instance:getEquip(equipId) or HeroGroupTrialModel.instance:getEquipMo(equipId)

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			self._equipMO = nil

			local equip_data = HeroGroupModel.instance:getCurGroupMO().replay_equip_data[self.mo.heroUid]

			if equip_data then
				local tar_config = EquipConfig.instance:getEquipCo(equip_data.equipId)

				if tar_config then
					self._equipMO = {}
					self._equipMO.config = tar_config
					self._equipMO.refineLv = equip_data.refineLv
					self._equipMO.level = equip_data.equipLv
				end
			end
		end

		local trialEquipCO

		if self.trialCO and self.trialCO.equipId > 0 then
			trialEquipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)
		end

		if self._equipMO then
			self._equipType = self._equipMO.config.rare - 2
		elseif trialEquipCO then
			self._equipType = trialEquipCO.rare - 2
		end

		gohelper.setActive(self._equip.equipIcon.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipRare.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipAddGO, not self._equipMO and not trialEquipCO)
		gohelper.setActive(self._equip.equipGolv, self._equipMO or trialEquipCO)
		ZProj.UGUIHelper.SetColorAlpha(self._equip.equiptxten, (self._equipMO or trialEquipCO) and 0.15 or 0.06)

		if self._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, self._equipMO.config.icon)

			local _, _, equipLv = Rouge2_HeroGroupBalanceHelper.getBalanceLv()

			self._equip.equiptxtlv.text = equipLv and equipLv > self._equipMO.level and self._equipMO.equipType == EquipEnum.ClientEquipType.Normal and "<color=" .. Rouge2_HeroGroupBalanceHelper.BalanceColor .. ">LV." .. equipLv or "LV." .. self._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. self._equipMO.config.rare)
			self:_showEquipParticleEffect(equipIndex)
		elseif trialEquipCO then
			local equipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, equipCO.icon)

			self._equip.equiptxtlv.text = "LV." .. self.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. equipCO.rare)
			self:_showEquipParticleEffect(equipIndex)
		end
	end

	self.last_equip = self._equipMO and self._equipMO.uid

	if self._heroMO then
		self.last_hero = self._heroMO.heroId or 0
	end
end

function Rouge2_HeroGroupHeroItem:balanceHero()
	if self._heroMO then
		local replay_data

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			replay_data = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[self.mo.heroUid]
		end

		if replay_data then
			if not replay_data.level then
				local lv = self._heroMO.level
				local roleLv = Rouge2_HeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
				local isBalanceLv

				if lv < roleLv then
					lv = roleLv
					isBalanceLv = true
				end

				local hero_level, hero_rank = HeroConfig.instance:getShowLevel(lv)

				if isBalanceLv then
					SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, Rouge2_HeroGroupBalanceHelper.BalanceColor)

					self._lvnum.text = "<color=" .. Rouge2_HeroGroupBalanceHelper.BalanceColor .. ">" .. hero_level

					for i = 1, 3 do
						SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], Rouge2_HeroGroupBalanceHelper.BalanceIconColor)
					end
				else
					self._lvnum.text = hero_level
				end

				for i = 1, 3 do
					local rankGO = self._goRankList[i]

					gohelper.setActive(rankGO, i == hero_rank - 1)
				end

				gohelper.setActive(self._goStars, true)

				for i = 1, 6 do
					local starGO = self._goStarList[i]

					gohelper.setActive(starGO, i <= CharacterEnum.Star[self._heroMO.config.rare])
				end
			end
		end
	end
end

return Rouge2_HeroGroupHeroItem
