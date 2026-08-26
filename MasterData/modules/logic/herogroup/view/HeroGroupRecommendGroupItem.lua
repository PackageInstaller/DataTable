-- chunkname: @modules/logic/herogroup/view/HeroGroupRecommendGroupItem.lua

module("modules.logic.herogroup.view.HeroGroupRecommendGroupItem", package.seeall)

local HeroGroupRecommendGroupItem = class("HeroGroupRecommendGroupItem", ListScrollCell)

function HeroGroupRecommendGroupItem:init(go)
	self._txtrank = gohelper.findChildText(go, "#go_info/rankhead/#txt_rank")
	self._txtnum = gohelper.findChildText(go, "#go_info/#txt_num")
	self._txtherogrouprate = gohelper.findChildText(go, "#go_info/#txt_herogrouprate")
	self._goherogrouplist = gohelper.findChild(go, "#go_info/herogrouplist")
	self._goheroitem = gohelper.findChild(go, "#go_info/herogrouplist/#go_heroitem")
	self._simagecloth = gohelper.findChildSingleImage(go, "#go_info/#simage_cloth")
	self._btnuse = gohelper.findChildButtonWithAudio(go, "#go_info/#btn_use")
	self._goinfo = gohelper.findChild(go, "#go_info")
	self._gonull = gohelper.findChild(go, "#go_null")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._simagebg = gohelper.findChildSingleImage(go, "#simage_bg")
	self._gobossItem = gohelper.findChild(go, "#go_info/#go_bossitem")
	self._gobossEmpty = gohelper.findChild(go, "#go_info/#go_bossitem/go_empty")
	self._gobossContainer = gohelper.findChild(go, "#go_info/#go_bossitem/go_container")
	self._simageBossIcon = gohelper.findChildSingleImage(go, "#go_info/#go_bossitem/go_container/simage_bossicon")
	self._imageBossCareer = gohelper.findChildImage(go, "#go_info/#go_bossitem/go_container/image_career")
	self._imageAbyssSkill = gohelper.findChildImage(go, "#go_info/#go_abyssSkill/#image_abyssSkill")
	self._goAbyssSkill = gohelper.findChild(go, "#go_info/#go_abyssSkill")
	self._goAbyssSkillEmpty = gohelper.findChild(go, "#go_info/#go_abyssSkill/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupRecommendGroupItem:addEventListeners()
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
end

function HeroGroupRecommendGroupItem:removeEventListeners()
	self._btnuse:RemoveClickListener()
end

function HeroGroupRecommendGroupItem:_btnuseOnClick()
	local curEpisodeId = HeroGroupRecommendGroupListModel.instance:getCurEpisodeId()
	local hideMessageBox = not HeroGroupModel.instance:getAfterUpdateRecommendState()

	HeroGroupController.instance:useRecommendGroup(self._mo, curEpisodeId, hideMessageBox)
end

function HeroGroupRecommendGroupItem:onTowerUse(info, heroGroupMO, ...)
	local towerFightParam = TowerModel.instance:getRecordFightParam()

	if towerFightParam and towerFightParam.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	local assistBossId = self._mo.assistBossId

	if assistBossId and assistBossId > 0 and towerFightParam and not towerFightParam.isHeroGroupLock and not TowerModel.instance:isBossBan(assistBossId) and not TowerModel.instance:isLimitTowerBossBan(towerFightParam.towerType, towerFightParam.towerId, assistBossId) then
		local bossMo = TowerAssistBossModel.instance:getById(assistBossId)

		if bossMo then
			local bossIsOpen = TowerController.instance:isBossTowerOpen()

			if bossIsOpen then
				info.assistBossId = assistBossId
			end
		end
	end

	for i, v in ipairs(info.heroList) do
		local mo = HeroModel.instance:getById(v)

		if mo and TowerModel.instance:isHeroBan(mo.heroId) then
			info.heroList[i] = tostring(0)
		end
	end

	heroGroupMO:initWithBattle(info, ...)
	HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function HeroGroupRecommendGroupItem:onAbyssUse(info, heroGroupMO, ...)
	local stageMo = AbyssModel.instance:getCurStageMo()

	if stageMo and stageMo:isChallenged() then
		GameFacade.showToast(ToastEnum.AbyssHeroGroupCannotEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	for i, v in ipairs(info.heroList) do
		local mo = HeroModel.instance:getById(v)

		if mo and AbyssModel.instance:isCurHeroLocked(mo.heroId) then
			info.heroList[i] = tostring(0)
		end
	end

	heroGroupMO:initWithBattle(info, ...)
	HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function HeroGroupRecommendGroupItem:_editableInitView()
	gohelper.setActive(self._goheroitem, false)

	self._heroItemList = {}

	self._simagebg:LoadImage(ResUrl.getHeroGroupBg("biandui_youdi"))

	self._imagebg = self._simagebg:GetComponent(gohelper.Type_Image)
	self._isFiveHeroEpisode = DungeonController.checkEpisodeFiveHero(HeroGroupModel.instance.episodeId)

	if self._isFiveHeroEpisode then
		recthelper.setAnchorX(self._goherogrouplist.transform, -97.5)

		local layoutGroup = self._goherogrouplist:GetComponent(gohelper.Type_HorizontalLayoutGroup)

		layoutGroup.spacing = -40
	end
end

function HeroGroupRecommendGroupItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._gonull, self._mo.isEmpty)
	gohelper.setActive(self._goinfo, not self._mo.isEmpty)
	ZProj.UGUIHelper.SetColorAlpha(self._imagebg, self._mo.isEmpty and 0.5 or 1)

	if self._mo.isEmpty then
		return
	end

	self._txtrank.text = string.format("%d", self._index)
	self._txtherogrouprate.text = string.format("%s%%", math.floor(self._mo.rate * 10000) / 100)

	local clothConfig = true

	goto label_8_0

	::label_8_0::

	gohelper.setActive(self._simagecloth.gameObject, clothConfig)

	if clothConfig then
		self._simagecloth:LoadImage(ResUrl.getPlayerClothIcon(clothConfig.icon))
	end

	self:_refreshHeroItem()

	self._txtnum.text = GameUtil.getEnglishOrderNumber(self._index)

	self:refreshTowerBossUI()
	self:refreshAbyssUI()
end

function HeroGroupRecommendGroupItem:_refreshHeroItem()
	local heroDataList = self._mo.heroDataList

	if self._isFiveHeroEpisode then
		if not ModuleEnum.FiveHeroEnum.MaxHeroNum then
			local num = ModuleEnum.MaxHeroCountInGroup

			for i = 1, num do
				local heroData = heroDataList[i]
				local heroItem = self._heroItemList[i]

				if not heroItem then
					heroItem = self:getUserDataTb_()
					heroItem.go = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
					heroItem.gocontainer = gohelper.findChild(heroItem.go, "go_container")
					heroItem.simageheroicon = gohelper.findChildSingleImage(heroItem.go, "go_container/simage_heroicon")
					heroItem.imagecareer = gohelper.findChildImage(heroItem.go, "go_container/image_career")
					heroItem.goaidtag = gohelper.findChild(heroItem.go, "go_container/go_aidtag")
					heroItem.gostorytag = gohelper.findChild(heroItem.go, "go_container/go_storytag")
					heroItem.imageinsight = gohelper.findChildImage(heroItem.go, "go_container/level/layout/image_insight")
					heroItem.txtlevel = gohelper.findChildText(heroItem.go, "go_container/level/layout/txt_level")
					heroItem.goempty = gohelper.findChild(heroItem.go, "go_empty")

					table.insert(self._heroItemList, heroItem)
				end

				gohelper.setActive(heroItem.gocontainer, heroData)
				gohelper.setActive(heroItem.goempty, not heroData)

				if heroData then
					gohelper.setActive(heroItem.gostorytag, false)
					gohelper.setActive(heroItem.goaidtag, false)

					local heroId = heroData.heroId
					local showLevel, rankLevel = HeroConfig.instance:getShowLevel(heroDataList[i].level)

					heroItem.txtlevel.text = self:getShowLevelText(showLevel)

					if rankLevel > 1 then
						UISpriteSetMgr.instance:setHeroGroupSprite(heroItem.imageinsight, "biandui_dongxi_" .. tostring(rankLevel - 1))
						gohelper.setActive(heroItem.imageinsight.gameObject, true)
					else
						gohelper.setActive(heroItem.imageinsight.gameObject, false)
					end

					local heroConfig = HeroConfig.instance:getHeroCO(heroId)
					local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

					heroItem.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
					UISpriteSetMgr.instance:setCommonSprite(heroItem.imagecareer, "lssx_" .. tostring(heroConfig.career))

					local heroMO = HeroModel.instance:getByHeroId(heroId)

					ZProj.UGUIHelper.SetGrayscale(heroItem.simageheroicon.gameObject, not heroMO)
					ZProj.UGUIHelper.SetGrayscale(heroItem.imagecareer.gameObject, not heroMO)
				end

				gohelper.setActive(heroItem.go, true)
			end
		end
	end
end

function HeroGroupRecommendGroupItem:refreshTowerBossUI()
	local clothConfig = true

	goto label_10_0

	::label_10_0::

	local hasCloth = clothConfig ~= nil
	local isInTowerBattle = TowerModel.instance:isInTowerBattle()
	local bossId = self._mo.assistBossId
	local hasAssistBoss = bossId and bossId > 0

	gohelper.setActive(self._simagecloth.gameObject, clothConfig and not isInTowerBattle)
	gohelper.setActive(self._gobossItem, isInTowerBattle)
	gohelper.setActive(self._gobossEmpty, isInTowerBattle and not hasAssistBoss)
	gohelper.setActive(self._gobossContainer, isInTowerBattle and hasAssistBoss)

	if isInTowerBattle and hasAssistBoss then
		local bossConfig = TowerConfig.instance:getAssistBossConfig(bossId)

		UISpriteSetMgr.instance:setCommonSprite(self._imageBossCareer, string.format("lssx_%s", bossConfig.career))

		local skinConfig = FightConfig.instance:getSkinCO(bossConfig.skinId)

		self._simageBossIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))
	end
end

function HeroGroupRecommendGroupItem:refreshAbyssUI()
	local curEpisodeId = HeroGroupRecommendGroupListModel.instance:getCurEpisodeId()
	local episodeCO = curEpisodeId and lua_episode.configDict[curEpisodeId]
	local episodeType = episodeCO and episodeCO.type
	local isAbyss = episodeType == DungeonEnum.EpisodeType.Abyss or AbyssModel.instance:isInAbyssBattle()
	local skillId, stageId
	local actId = AbyssConfig.instance:getActivityId()

	stageId = curEpisodeId ~= nil and AbyssConfig.instance:getStageIdByEpisodeId(actId, curEpisodeId) or AbyssModel.instance:getCurStageId()

	if not string.nilorempty(self._mo.extString) then
		local skillIds = string.splitToNumber(self._mo.extString, "#")

		skillId = AbyssHelper.getValidSkill(stageId, skillIds[1])
	end

	local haveSkill = skillId ~= nil and skillId ~= 0

	gohelper.setActive(self._goAbyssSkill, isAbyss)
	gohelper.setActive(self._imageAbyssSkill.gameObject, haveSkill)
	gohelper.setActive(self._goAbyssSkillEmpty, not haveSkill)

	if haveSkill then
		local skillConfig = AbyssConfig.instance:getSkillConfig(skillId)

		if skillConfig and not string.nilorempty(skillConfig.icon) then
			UISpriteSetMgr.instance:setAbyssSprite(self._imageAbyssSkill, "jdsh_" .. skillConfig.icon)
		end
	end
end

function HeroGroupRecommendGroupItem:getShowLevelText(showLevel)
	return "<size=12>LV.</size>" .. tostring(showLevel)
end

function HeroGroupRecommendGroupItem:getAnimator()
	return self._anim
end

function HeroGroupRecommendGroupItem:onDestroy()
	self._simagecloth:UnLoadImage()
	self._simagebg:UnLoadImage()
	self._simageBossIcon:UnLoadImage()

	for i, heroItem in ipairs(self._heroItemList) do
		heroItem.simageheroicon:UnLoadImage()
	end
end

return HeroGroupRecommendGroupItem
