-- chunkname: @modules/logic/fight/view/FightStatItem.lua

module("modules.logic.fight.view.FightStatItem", package.seeall)

local FightStatItem = class("FightStatItem", ListScrollCell)

function FightStatItem:init(go)
	self._heroIcon = gohelper.findChildSingleImage(go, "heroinfo/hero/icon")
	self._heroIconImage = self._heroIcon:GetComponent(gohelper.Type_Image)
	self._career = gohelper.findChildImage(go, "heroinfo/career")
	self._rare = gohelper.findChildImage(go, "heroinfo/rare")
	self._front = gohelper.findChildImage(go, "heroinfo/front")
	self.goLayout = gohelper.findChild(go, "heroinfo/layout")
	self.goRare = gohelper.findChild(go, "heroinfo/rare")
	self.goCareer = gohelper.findChild(go, "heroinfo/career")
	self._gorankobj = gohelper.findChild(go, "heroinfo/layout/rankobj")
	self._rankGOs = self:getUserDataTb_()

	for i = 1, 3 do
		self._rankGOs[i] = gohelper.findChildImage(self._gorankobj, "rank" .. tostring(i))
	end

	self._txtLv = gohelper.findChildText(go, "heroinfo/layout/txtLv")
	self._txtName = gohelper.findChildText(go, "heroinfo/txtName")
	self._txtHarm = gohelper.findChildText(go, "data/txtHarm")
	self._txtHurt = gohelper.findChildText(go, "data/txtHurt")
	self._txtHeal = gohelper.findChildText(go, "data/txtHeal")
	self._txtHarmRate = gohelper.findChildText(go, "data/txtHarmRate")
	self._txtHurtRate = gohelper.findChildText(go, "data/txtHurtRate")
	self._txtHealRate = gohelper.findChildText(go, "data/txtHealRate")
	self._imgProgressHarm = gohelper.findChildImage(go, "data/progressHarm/progress")
	self._imgProgressHurt = gohelper.findChildImage(go, "data/progressHurt/progress")
	self._imgProgressHeal = gohelper.findChildImage(go, "data/progressHeal/progress")
	self._godata = gohelper.findChild(go, "data")
	self._goskill = gohelper.findChild(go, "skill")
	self._scrollUseSkill = gohelper.findChild(go, "skill/scroll_useskill"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goskillContent = gohelper.findChild(go, "skill/scroll_useskill/Viewport/Content")
	self._goskillItem = gohelper.findChild(go, "skill/scroll_useskill/Viewport/Content/skillItem")
	self._goscrolluseskill = gohelper.findChild(go, "skill/scroll_useskill")
	self._goskillempty = gohelper.findChild(go, "skill/go_skillempty")
	self._skillItems = self:getUserDataTb_()

	gohelper.setActive(self._goskillItem, false)

	self._statType = FightEnum.FightStatType.DataView
end

function FightStatItem:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.SwitchInfoState, self._refreshInfoUI, self)
end

function FightStatItem:removeEventListeners()
	self.removeEventCb(self, FightController.instance, FightEvent.SwitchInfoState, self._refreshInfoUI, self)
end

function FightStatItem:onUpdateMO(mo)
	self._mo = mo
	self.entityMO = mo.entityMO or FightDataHelper.entityMgr:getById(mo.entityId)

	if self._mo then
		local isTowerCompose = self._mo.isTowerCompose

		if not isTowerCompose and mo.entityId == FightASFDDataMgr.EmitterId then
			self.entityMO = FightDataHelper.ASFDDataMgr:getEmitterEmitterMo()
		end

		local isAct174Fight = ViewMgr.instance:isOpen(ViewName.Act174FightResultView)
		local isAct191Fight = ViewMgr.instance:isOpen(ViewName.Act191FightSuccView)
		local isFromOtherFight = self._mo.fromOtherFight
		local heroCO = lua_character.configDict[self.entityMO.modelId]

		gohelper.setActive(self.goLayout, true)
		gohelper.setActive(self.goRare, true)
		gohelper.setActive(self.goCareer, true)

		if self.entityMO:isAssistBoss() then
			if self._mo.isTowerCompose or FightDataHelper.paTaMgr:checkIsAssistRole() then
				self:refreshAssistRole()
			elseif FightDataHelper.paTaMgr:checkIsRouge3_3() then
				self:refreshAssistRouge3_3()
			else
				self:refreshAssistBossInfo()
			end
		elseif self.entityMO:isVorpalith() then
			self:refreshVorpalithInfo()
		elseif self.entityMO:isASFDEmitter() then
			self:refreshASFDInfo()
		elseif self.entityMO:isRouge2Music() then
			self:refreshRouge2MusicInfo()
		elseif isAct174Fight then
			self:refreshAct174Info()
		elseif isAct191Fight then
			self:refreshAct191Info()
		elseif not heroCO then
			local monsterConfig = lua_monster.configDict[self.entityMO.modelId]

			if FightConfig.instance:getNewMonsterConfig(monsterConfig) then
				self._txtName.text = monsterConfig.highPriorityName or monsterConfig.name
			end

			if monsterConfig then
				local showLevel, rank = HeroConfig.instance:getShowLevel(monsterConfig.level)

				self._txtLv.text = string.format("<size=20>LV.</size>%d", showLevel)

				gohelper.setActive(self._gorankobj, rank > 1)

				for i = 1, 3 do
					gohelper.setActive(self._rankGOs[i], rank > 1 and i == rank - 1 or false)
				end

				local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

				self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
				UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(monsterConfig.career))
				UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. 1)
			end
		else
			local trialAttrCo = self.entityMO:getTrialAttrCo()

			if heroCO then
				self._txtName.text = heroCO.name or ""
			end

			if trialAttrCo then
				self._txtName.text = trialAttrCo.name
			end

			if not isFromOtherFight and FightDataHelper.stateMgr.isReplay then
				local showLevel, rank = HeroConfig.instance:getShowLevel(self.entityMO.level)

				self._txtLv.text = string.format("<size=20>LV.</size>%d", showLevel)

				gohelper.setActive(self._gorankobj, rank > 1)

				for i = 1, 3 do
					gohelper.setActive(self._rankGOs[i], rank > 1 and i == rank - 1 or false)
				end

				local skinConfig = FightConfig.instance:getSkinCO(self.entityMO.skin)

				self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
				UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(heroCO.career))
				UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. CharacterEnum.Star[heroCO.rare])
			else
				local heroMO = HeroModel.instance:getByHeroId(self.entityMO.modelId)

				if not heroMO and heroCO or tonumber(self.entityMO.uid) < 0 or isFromOtherFight then
					heroMO = HeroMo.New()

					heroMO:initFromConfig(heroCO)

					heroMO.level = self.entityMO.level
					heroMO.skin = self.entityMO.skin
				end

				if heroMO then
					local balanceLv = HeroGroupBalanceHelper.getHeroBalanceLv(heroMO.heroId)
					local isBalance

					if balanceLv and balanceLv > heroMO.level and not isFromOtherFight then
						isBalance = true

						for i = 1, 3 do
							SLFramework.UGUI.GuiHelper.SetColor(self._rankGOs[i], "#547a99")
						end
					else
						for i = 1, 3 do
							SLFramework.UGUI.GuiHelper.SetColor(self._rankGOs[i], "#342929")
						end
					end

					if self.entityMO then
						if not self.entityMO.level then
							local level = heroMO.level
							local showLevel, rank = HeroConfig.instance:getShowLevel(isBalance and balanceLv or level)

							self._txtLv.text = (isBalance and "<color=#547a99>" or "") .. string.format("<size=20>LV.</size>%d", showLevel)

							gohelper.setActive(self._gorankobj, rank > 1)

							for i = 1, 3 do
								gohelper.setActive(self._rankGOs[i], rank > 1 and i == rank - 1 or false)
							end

							if self.entityMO then
								if not self.entityMO.skin then
									local skinId = heroMO.skin
									local skinConfig = FightConfig.instance:getSkinCO(skinId)

									self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
									UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(heroMO.config.career))
									UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. CharacterEnum.Star[heroMO.config.rare])
								end
							end
						end
					end
				end
			end
		end

		self._txtHarm.text = mo.harm
		self._txtHurt.text = mo.hurt
		self._txtHeal.text = mo.heal

		local totalHarm = FightStatModel.instance:getTotalHarm()
		local totalHurt = FightStatModel.instance:getTotalHurt()
		local totalHeal = FightStatModel.instance:getTotalHeal()

		if totalHarm > 0 then
			if not (mo.harm / totalHarm) then
				local harmRate = 0

				if totalHurt > 0 then
					if not (mo.hurt / totalHurt) then
						local hurtRate = 0

						if totalHeal > 0 then
							if not (mo.heal / totalHeal) then
								local healRate = 0

								self._txtHarmRate.text = string.format("%.2f%%", harmRate * 100)
								self._txtHurtRate.text = string.format("%.2f%%", hurtRate * 100)
								self._txtHealRate.text = string.format("%.2f%%", healRate * 100)

								if not self._tweenHarm then
									self._tweenHarm = ZProj.TweenHelper.DOFillAmount(self._imgProgressHarm, harmRate, harmRate * 2)
									self._tweenHurt = ZProj.TweenHelper.DOFillAmount(self._imgProgressHurt, hurtRate, hurtRate * 2)
									self._tweenHeal = ZProj.TweenHelper.DOFillAmount(self._imgProgressHeal, healRate, healRate * 2)
								else
									self._imgProgressHarm.fillAmount = harmRate
									self._imgProgressHurt.fillAmount = hurtRate
									self._imgProgressHeal.fillAmount = healRate
								end

								self:_refreshInfoUI(self._statType)
							end
						end
					end
				end
			end
		end
	end
end

function FightStatItem:_refreshInfoUI(argsStatType)
	local statType = argsStatType
	local fightStatViewStatType = self._view.viewContainer.fightStatView:getStatType()

	if fightStatViewStatType and fightStatViewStatType ~= statType then
		statType = fightStatViewStatType
	end

	self._scrollUseSkill.parentGameObject = self._view._csListScroll.gameObject
	self._statType = statType or self._statType

	gohelper.setActive(self._godata, statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(self._goskill, statType == FightEnum.FightStatType.SkillView)
	gohelper.setActive(self._goscrolluseskill, GameUtil.getTabLen(self._mo.cards) > 0)
	gohelper.setActive(self._goskillempty, GameUtil.getTabLen(self._mo.cards) == 0)

	local cardsLen = GameUtil.getTabLen(self._mo.cards)
	local skillItemLen = GameUtil.getTabLen(self._skillItems)

	if cardsLen > 0 and statType == FightEnum.FightStatType.SkillView then
		self:_sortCard()

		for index, cardmo in ipairs(self._mo.cards) do
			local skillItem = self._skillItems[index]

			if not skillItem then
				skillItem = self:getUserDataTb_()
				skillItem.go = gohelper.clone(self._goskillItem, self._goskillContent, "skillitem" .. index)
				skillItem.skillIconGo = self:getUserDataTb_()

				for i = 0, 4 do
					local item = gohelper.findChild(skillItem.go, "skillicon" .. i)
					local o = self:getUserDataTb_()

					o.go = item
					o.imgIcon = gohelper.findChildSingleImage(item, "imgIcon")
					o.tag = gohelper.findChildSingleImage(item, "tag/tagIcon")
					o.count = gohelper.findChildText(item, "count/txt_count")
					o.goStar = gohelper.findChildText(item, "star")
					skillItem.skillIconGo[i + 1] = o
				end

				table.insert(self._skillItems, skillItem)
			end

			for _, o in ipairs(skillItem.skillIconGo) do
				o.isBigSkill = FightCardDataHelper.isBigSkill(cardmo.skillId)

				if lua_skill_next.configDict[cardmo.skillId] then
					o.isBigSkill = false
				end

				gohelper.setActive(o.goStar, true)
			end

			gohelper.setActive(skillItem.go, true)
			self:_setSkillCardInfo(skillItem, cardmo)
		end
	end

	if cardsLen < skillItemLen then
		for i = cardsLen + 1, skillItemLen do
			local skillItem = self._skillItems[i]

			gohelper.setActive(skillItem and skillItem.go, false)
		end
	end
end

function FightStatItem:_sortCard()
	local sortRule = {}

	for index, cardmo in ipairs(self._mo.cards) do
		for k, skillid in ipairs(self.entityMO.skillGroup1) do
			if skillid == cardmo.skillId then
				sortRule[skillid] = 1
			end
		end

		for k, skillid in ipairs(self.entityMO.skillGroup2) do
			if skillid == cardmo.skillId then
				sortRule[skillid] = 2
			end
		end

		if FightCardDataHelper.isBigSkill(cardmo.skillId) then
			sortRule[cardmo.skillId] = 0
		end
	end

	table.sort(self._mo.cards, function(a, b)
		if sortRule[a.skillId] ~= sortRule[b.skillId] then
			local aSortRule = sortRule[a.skillId]
			local bSortRule = sortRule[b.skillId]

			if aSortRule and bSortRule then
				return aSortRule < bSortRule
			else
				return not not aSortRule
			end
		else
			return self.entityMO:getSkillLv(a.skillId) < self.entityMO:getSkillLv(b.skillId)
		end

		return false
	end)
end

function FightStatItem:_setSkillCardInfo(skillItem, cardmo)
	if FightHelper.isASFDSkill(cardmo.skillId) then
		return self:refreshASFDSkill(skillItem, cardmo)
	end

	if cardmo.skillId == 31560181 then
		return self:refreshHeDuoNieCard(skillItem, cardmo)
	end

	local skillLv = self.entityMO:getSkillLv(cardmo.skillId)
	local skillConfig = lua_skill.configDict[cardmo.skillId]

	for index, cardinfo in ipairs(skillItem.skillIconGo) do
		local lv = index - 1

		gohelper.setActive(cardinfo.go, lv == skillLv)

		if lv == skillLv then
			local skillIcon = ResUrl.getSkillIcon(skillConfig.icon)

			cardinfo.imgIcon:LoadImage(skillIcon)

			if not cardinfo.isBigSkill then
				cardinfo.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))
			end

			cardinfo.count.text = cardmo.useCount

			gohelper.setActive(skillItem.goStar, false)
		end
	end
end

function FightStatItem:refreshASFDSkill(skillItem, cardMo)
	local skillLv = 1

	for index, cardinfo in ipairs(skillItem.skillIconGo) do
		gohelper.setActive(cardinfo.go, index == skillLv)

		if index == skillLv then
			local skillIcon = ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon)

			cardinfo.imgIcon:LoadImage(skillIcon)
			cardinfo.tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

			cardinfo.count.text = cardMo.useCount
		end
	end
end

function FightStatItem:refreshHeDuoNieCard(skillItem, cardMo)
	local skillLv = 0

	for index, cardinfo in ipairs(skillItem.skillIconGo) do
		index = index - 1

		gohelper.setActive(cardinfo.go, index == skillLv)

		if index == skillLv then
			if self.entityMO then
				if not self.entityMO.exSkillLevel then
					local exSkillLv = 0

					if self.entityMO then
						if not self.entityMO.modelId then
							local heroId = 0
							local co = lua_heduonie_specialcard_client.configDict[heroId]

							co = co and co[exSkillLv]

							if co then
								local skillId = tonumber(co.skillcard)
								local skillConfig = skillId and lua_skill.configDict[skillId]

								if skillConfig then
									local skillIcon = ResUrl.getSkillIcon(skillConfig.icon)

									cardinfo.imgIcon:LoadImage(skillIcon)
									cardinfo.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

									cardinfo.count.text = cardMo.useCount
								end
							end
						end
					end
				end
			end
		end
	end
end

function FightStatItem:refreshAssistBossInfo()
	local assistBossConfig = TowerConfig.instance:getAssistBossConfig(self.entityMO.modelId)

	if not assistBossConfig then
		return
	end

	self._txtName.text = assistBossConfig.name

	local towerParam = TowerModel.instance:getFightFinishParam()

	if towerParam then
		if not towerParam.teamLevel then
			local level = 0
			local showLevel, rank = HeroConfig.instance:getShowLevel(level)

			self._txtLv.text = string.format("<size=20>LV.</size>%d", showLevel)

			gohelper.setActive(self._gorankobj, rank > 1)

			for i = 1, 3 do
				gohelper.setActive(self._rankGOs[i], rank > 1 and i == rank - 1 or false)
			end

			local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

			self._heroIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(assistBossConfig.career))
			UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. 6)
		end
	end
end

function FightStatItem:refreshAssistRouge3_3()
	local skin = self.entityMO.skin
	local summonerCo = lua_fight_rouge2_summoner.configList[1]

	for _, co in ipairs(lua_fight_rouge2_summoner.configList) do
		if co.skinId == skin then
			summonerCo = co

			break
		end
	end

	if not summonerCo then
		logError(string.format("召唤师表未找到皮肤id : %s 的配置", skin))

		return
	end

	self._txtName.text = summonerCo.name

	local level = summonerCo.teamLevel
	local showLevel, rank = HeroConfig.instance:getShowLevel(level)

	self._txtLv.text = string.format("<size=20>LV.</size>%d", showLevel)

	gohelper.setActive(self._gorankobj, rank > 1)

	for i = 1, 3 do
		gohelper.setActive(self._rankGOs[i], rank > 1 and i == rank - 1 or false)
	end

	self._heroIcon:LoadImage(ResUrl.monsterHeadIcon(summonerCo.monsterIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(summonerCo.career))
	UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. 6)
end

function FightStatItem:refreshAssistRole()
	local assistBossConfig = TowerComposeConfig.instance:getSupportCo(self.entityMO.modelId)

	if not assistBossConfig then
		return
	end

	local heroCo = HeroConfig.instance:getHeroCO(assistBossConfig.heroId)

	if not heroCo then
		return
	end

	self._txtName.text = heroCo.name

	local heroMo = HeroModel.instance:getByHeroId(heroCo.id)

	if heroMo then
		if not heroMo.level then
			local level = 1
			local showLevel, rank = HeroConfig.instance:getShowLevel(level)

			self._txtLv.text = string.format("<size=20>LV.</size>%d", showLevel)

			gohelper.setActive(self._gorankobj, rank > 1)

			for i = 1, 3 do
				gohelper.setActive(self._rankGOs[i], rank > 1 and i == rank - 1 or false)
			end

			local skinConfig = FightConfig.instance:getSkinCO(self.entityMO.skin)

			self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(self.entityMO.career))
			UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. CharacterEnum.Star[heroCo.rare])
		end
	end
end

function FightStatItem:refreshASFDInfo()
	self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(FightASFDConfig.instance.headIcon))

	local asfdSkillCo = FightASFDConfig.instance:getSkillCo()

	self._txtName.text = asfdSkillCo.name

	gohelper.setActive(self.goLayout, false)
	gohelper.setActive(self.goRare, false)
	gohelper.setActive(self.goCareer, false)
end

function FightStatItem:refreshRouge2MusicInfo()
	local iconDict = {
		[FightEnum.Rouge2Career.Strings] = "77008117",
		[FightEnum.Rouge2Career.TubularBell] = "77008118",
		[FightEnum.Rouge2Career.Cymbal] = "77008119",
		[FightEnum.Rouge2Career.Slapstick] = "77008120"
	}
	local career = FightHelper.getRouge2Career()
	local careerCo = career and lua_rouge2_career.configDict[career]

	if not careerCo then
		logError("rouge2 career id not exist : " .. tostring(career))

		careerCo = lua_rouge2_career.configList[1]
	end

	if not iconDict[career] then
		local headIcon = "77008118"

		self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(headIcon))

		self._txtName.text = careerCo.name

		gohelper.setActive(self.goLayout, false)
		gohelper.setActive(self.goRare, false)
		gohelper.setActive(self.goCareer, false)
	end
end

function FightStatItem:refreshVorpalithInfo()
	if FightDataHelper.fieldMgr.customData then
		local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]
		local tagId = customData and customData.equipMaxTagId
		local tagCo = tagId and lua_survival_equip_found.configDict[tagId]

		if tagCo then
			if not tagCo.icon3 then
				local icon = 76008111

				self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(icon), self.onImageLoaded, self)

				self._txtName.text = lua_survival_const.configDict[3001].value2

				gohelper.setActive(self.goLayout, false)
				gohelper.setActive(self.goRare, false)
				gohelper.setActive(self.goCareer, false)
			end
		end
	end
end

function FightStatItem:onImageLoaded()
	self._heroIconImage:SetNativeSize()
end

function FightStatItem:onDestroy()
	if self._tweenHarm then
		ZProj.TweenHelper.KillById(self._tweenHarm)
		ZProj.TweenHelper.KillById(self._tweenHurt)
		ZProj.TweenHelper.KillById(self._tweenHeal)
	end

	self._tweenHarm = nil
	self._tweenHurt = nil
	self._tweenHeal = nil

	for index, card in pairs(self._skillItems) do
		if card then
			for key, cardinfo in pairs(card.skillIconGo) do
				cardinfo.imgIcon:UnLoadImage()

				if not cardinfo.isBigSkill then
					cardinfo.tag:UnLoadImage()
				end
			end
		end
	end

	self._heroIcon:UnLoadImage()
end

function FightStatItem:refreshAct174Info()
	gohelper.setActive(self.goLayout, false)
	recthelper.setAnchorY(self._txtName.gameObject.transform, 0)

	local heroId = self.entityMO.modelId

	if heroId then
		local roleCo = Activity174Config.instance:getRoleCoByHeroId(heroId)

		UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(roleCo.career))
		UISpriteSetMgr.instance:setCommonSprite(self._rare, "bgequip" .. CharacterEnum.Color[roleCo.rare])
		self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(roleCo.skinId))

		self._txtName.text = roleCo.name
	end
end

function FightStatItem:refreshAct191Info()
	gohelper.setActive(self.goLayout, false)
	recthelper.setAnchorY(self._txtName.gameObject.transform, 0)

	local heroId = self.entityMO.modelId

	if heroId then
		UISpriteSetMgr.instance:setAct174Sprite(self._rare, "act191_collection_rolebg")
		transformhelper.setLocalScale(self._rare.gameObject.transform, 0.8, 0.8, 1)

		if self.entityMO:isAct191Boss() then
			local bossCo

			for _, config in ipairs(lua_activity191_assist_boss.configList) do
				if config.skinId == heroId then
					bossCo = config

					break
				end
			end

			if bossCo then
				local summonCo = Activity191Config.instance:getSummonCfg(bossCo.bossId)

				if summonCo then
					UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(summonCo.career))
					self._heroIcon:LoadImage(ResUrl.monsterHeadIcon(summonCo.headIcon))

					self._txtName.text = summonCo.name
				end
			else
				logError(string.format("斗蛐蛐协战Boss表 skinId : %s 找不到对应配置", heroId))
			end
		else
			local roleCo = Activity191Config.instance:getRoleCoByNativeId(heroId, 1, true)

			if roleCo then
				UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(roleCo.career))
				UISpriteSetMgr.instance:setAct174Sprite(self._front, "act174_roleframe_" .. roleCo.quality)
				gohelper.setActive(self._front, true)
				self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(roleCo.skinId))

				self._txtName.text = roleCo.name
			else
				local summonCo

				for _, config in ipairs(lua_activity191_summon.configList) do
					if config.monsterId == heroId then
						summonCo = config

						break
					end
				end

				if summonCo then
					UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(summonCo.career))
					self._heroIcon:LoadImage(ResUrl.getHeadIconSmall(summonCo.headIcon))

					self._txtName.text = summonCo.name
				else
					logError(string.format("斗蛐蛐召唤物表 monsterId : %s 找不到对应配置", heroId))
				end
			end
		end
	end
end

return FightStatItem
