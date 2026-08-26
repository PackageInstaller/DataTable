-- chunkname: @modules/logic/survival/view/shelter/ShelterHeroGroupHeroItem.lua

module("modules.logic.survival.view.shelter.ShelterHeroGroupHeroItem", package.seeall)

local ShelterHeroGroupHeroItem = class("ShelterHeroGroupHeroItem", HeroGroupHeroItem)

function ShelterHeroGroupHeroItem:init(go)
	local root = gohelper.findChild(go, "heroitemani")

	self._gohp = gohelper.findChild(go, "heroitemani/#go_hp")
	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(root, SurvivalHeroHealthPart)

	ShelterHeroGroupHeroItem.super.init(self, go)
end

function ShelterHeroGroupHeroItem:onUpdateMO(mo)
	self._commonHeroCard:setGrayScale(false)

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	self.mo = mo
	self._posIndex = self.mo.id - 1
	self._heroMO = mo:getHeroMO()
	self.monsterCO = mo:getMonsterCO()
	self.trialCO = mo:getTrialCO()

	gohelper.setActive(self._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local replay_data

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		replay_data = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[self.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, "#E9E9E9")

	for i = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], "#F6F3EC")
	end

	gohelper.setActive(self._gohp, self._heroMO)

	if self._heroMO then
		self._healthPart:setHeroId(self._heroMO.heroId)
	end

	if self._heroMO then
		local heroSkin = HeroModel.instance:getByHeroId(self._heroMO.heroId)

		if replay_data then
			local skinConfig = FightConfig.instance:getSkinCO(replay_data.skin or heroSkin.skin)

			self._commonHeroCard:onUpdateMO(skinConfig)

			if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
				recthelper.setHeight(self._goblackmask.transform, 125)
			else
				recthelper.setHeight(self._goblackmask.transform, 300)
			end

			UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self._heroMO.config.career))

			if replay_data then
				if not replay_data.level then
					local lv = self._heroMO.level
					local roleLv = SurvivalBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
					local isBalanceLv

					if lv < roleLv then
						lv = roleLv
						isBalanceLv = true
					end

					local hero_level, hero_rank = HeroConfig.instance:getShowLevel(lv)

					if isBalanceLv then
						SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, SurvivalBalanceHelper.BalanceColor)

						self._lvnum.text = "<color=" .. SurvivalBalanceHelper.BalanceColor .. ">" .. hero_level

						for i = 1, 3 do
							SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], SurvivalBalanceHelper.BalanceIconColor)
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
	elseif self.monsterCO then
		local skinConfig = FightConfig.instance:getSkinCO(self.monsterCO.skinId)

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self.monsterCO.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.monsterCO.level)

		self._lvnum.text = showLevel

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == rank - 1)
		end

		gohelper.setActive(self._goStars, false)
	elseif self.trialCO then
		local heroCo = HeroConfig.instance:getHeroCO(self.trialCO.heroId)
		local skinConfig = self.trialCO.skin > 0 and SkinConfig.instance:getSkinCo(self.trialCO.skin) or SkinConfig.instance:getSkinCo(heroCo.skinId)

		if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(self._goblackmask.transform, 125)
		else
			recthelper.setHeight(self._goblackmask.transform, 300)
		end

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(heroCo.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.trialCO.level)

		self._lvnum.text = showLevel

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == rank - 1)
		end

		gohelper.setActive(self._goStars, true)

		for i = 1, 6 do
			local starGO = self._goStarList[i]

			gohelper.setActive(starGO, i <= CharacterEnum.Star[heroCo.rare])
		end
	end

	if self._heroItemContainer then
		self._heroItemContainer.compColor[self._lvnumen] = self._lvnumen.color

		for i = 1, 3 do
			self._heroItemContainer.compColor[self._goRankList[i]] = self._goRankList[i].color
		end
	end

	self.isLock = false
	self.isAidLock = self.mo.aid and self.mo.aid == -1
	self.isAid = self.mo.aid ~= nil
	self.isTrialLock = (self.mo.trial and self.mo.trialPos) ~= nil

	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	self.isRoleNumLock = false
	self.isEmpty = mo:isEmpty()

	gohelper.setActive(self._heroGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and not self.isLock and not self.isRoleNumLock)
	gohelper.setActive(self._noneGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and (self.isLock or self.isAidLock or self.isRoleNumLock) or true)
	gohelper.setActive(self._addGO, self._heroMO == nil and self.monsterCO == nil and self.trialCO == nil and not self.isLock and not self.isAidLock and not self.isRoleNumLock)
	gohelper.setActive(self._lockGO, self:selfIsLock())
	gohelper.setActive(self._aidGO, self.mo.aid and self.mo.aid ~= -1)

	if battleCO then
		gohelper.setActive(self._subGO, not self.isLock and not self.isAidLock and not self.isRoleNumLock and self.mo.id > battleCO.playerMax)
	else
		gohelper.setActive(self._subGO, not self.isLock and not self.isAidLock and not self.isRoleNumLock and self.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(self._tagTr, 36.3, self._subGO.activeSelf and 144.1 or 212.1)

	if self.trialCO then
		gohelper.setActive(self._trialTagGO, true)

		self._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(self._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and self.isRoleNumLock and self._heroMO ~= nil and self.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(self._heroMO.id)
	end

	self:initEquips()
	self:showCounterSign()

	if self._playDeathAnim then
		self._playDeathAnim = nil

		self:playAnim(UIAnimationName.Open)
	end

	self:_showMojingTip()

	if self._gorecommended.activeSelf or self._gocounter.activeSelf then
		recthelper.setAnchorY(self._gohp.transform, -288)
	else
		recthelper.setAnchorY(self._gohp.transform, -275)
	end
end

function ShelterHeroGroupHeroItem:selfIsLock()
	return false
end

function ShelterHeroGroupHeroItem:setScale(scaleX, scaleY, scaleZ)
	self._scaleX = scaleX or 1
	self._scaleY = scaleY or 1
	self._scaleZ = scaleZ or 1

	transformhelper.setLocalScale(self.go.transform, self._scaleX, self._scaleY, self._scaleZ)
end

function ShelterHeroGroupHeroItem:onItemEndDrag(index, dragToIndex)
	ZProj.TweenHelper.DOScale(self.go.transform, self._scaleX, self._scaleY, self._scaleZ, 0.2, nil, nil, nil, EaseType.Linear)
	self:_setHeroItemPressState(false)
end

return ShelterHeroGroupHeroItem
