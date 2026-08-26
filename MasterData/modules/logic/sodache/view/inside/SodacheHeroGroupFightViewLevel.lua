-- chunkname: @modules/logic/sodache/view/inside/SodacheHeroGroupFightViewLevel.lua

module("modules.logic.sodache.view.inside.SodacheHeroGroupFightViewLevel", package.seeall)

local SodacheHeroGroupFightViewLevel = class("SodacheHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function SodacheHeroGroupFightViewLevel:onOpen()
	self._insideMo = SodacheModel.instance:getInsideMo()
	self._battleInfo = self._insideMo.prop.battleInfo
	self._attrRestraintIcons = self:getUserDataTb_()

	SodacheHeroGroupFightViewLevel.super.onOpen(self)
	self:_refreshInfo()
end

function SodacheHeroGroupFightViewLevel:addEvents()
	SodacheHeroGroupFightViewLevel.super.addEvents(self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdateBattleInfo, self._refreshInfo, self)
end

function SodacheHeroGroupFightViewLevel:removeEvents()
	SodacheHeroGroupFightViewLevel.super.removeEvents(self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdateBattleInfo, self._refreshInfo, self)
end

function SodacheHeroGroupFightViewLevel:_onRecommendCareerItemShow(obj, data, index)
	local restraint = gohelper.findChild(obj, "#go_kezhi")
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)

	self._attrRestraintIcons[data] = restraint
end

function SodacheHeroGroupFightViewLevel:_refreshInfo()
	local cardMo = self._battleInfo.itemId > 0 and SodacheCardMo.Create(self._battleInfo.itemId)

	if cardMo then
		local dict = cardMo.serverMo:getRefrainDict() or {}

		for i, v in pairs(self._attrRestraintIcons) do
			if dict[i] then
				gohelper.setActive(v, true)
			else
				gohelper.setActive(v, false)
			end
		end
	else
		for i, v in pairs(self._attrRestraintIcons) do
			gohelper.setActive(v, false)
		end
	end
end

function SodacheHeroGroupFightViewLevel:_btnenemyOnClick()
	local hpFixRate = 0
	local insideMo = self._insideMo
	local fixCo = GameUtil.getTbValue(lua_sodache_difficulty.configDict, insideMo.copyCo.type, SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue))

	if fixCo then
		local arr = GameUtil.splitString2(fixCo.stepAttr)

		for i, v in ipairs(arr) do
			if v[1] == "hp" then
				hpFixRate = tonumber(v[2]) or 0
			end
		end
	end

	EnemyInfoController.instance:openSodacheEnemyInfoView(self._battleId, self._battleInfo.careerIds, hpFixRate / 1000)
end

function SodacheHeroGroupFightViewLevel:_refreshTarget()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	gohelper.setActive(self._gotargetlist, true)

	local isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(self._gohardEffect, isHardMode)
	gohelper.setActive(self._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	self._isHardMode = isHardMode

	local normalEpisodeId, hardEpisodeId

	normalEpisodeId = self._episodeId

	if self._episodeId then
		::label_7_0::

		local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(normalEpisodeId)

		hardEpisodeId = hardEpisodeConfig and hardEpisodeConfig.id

		if normalEpisodeId then
			::label_7_1::

			local normalEpisodeInfo = DungeonModel.instance:getEpisodeInfo(normalEpisodeId)

			if normalEpisodeId then
				::label_7_2::

				local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)
				local isOnlyShowOneTarget = true

				gohelper.setActive(self._gonormalcondition, true)

				self._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(normalEpisodeId)

				local passNormal = false
				local passAdvanced = false
				local passUltra = false

				gohelper.setActive(self._gonormalfinish, passNormal)
				gohelper.setActive(self._gonormalunfinish, not passNormal)
				ZProj.UGUIHelper.SetColorAlpha(self._txtnormalcondition, passNormal and 1 or 0.63)

				self._starNum = 1

				gohelper.setActive(self._goplatinumcondition, not self._isSimple and not string.nilorempty(advancedConditionText))

				if not string.nilorempty(advancedConditionText) then
					self._txtplatinumcondition.text = advancedConditionText

					gohelper.setActive(self._goplatinumfinish, passAdvanced)
					gohelper.setActive(self._goplatinumunfinish, not passAdvanced)
					ZProj.UGUIHelper.SetColorAlpha(self._txtplatinumcondition, passAdvanced and 1 or 0.63)

					isOnlyShowOneTarget = false
					self._starNum = 2
				end

				if normalEpisodeId then
					::label_7_3::

					local advancedCondition2Text = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(normalEpisodeId)

					gohelper.setActive(self._goplatinumcondition2, not string.nilorempty(advancedCondition2Text))

					if not string.nilorempty(advancedCondition2Text) then
						self._txtplatinumcondition2.text = advancedCondition2Text

						gohelper.setActive(self._goplatinumfinish2, passUltra)
						gohelper.setActive(self._goplatinumunfinish2, not passUltra)
						ZProj.UGUIHelper.SetColorAlpha(self._txtplatinumcondition2, passUltra and 1 or 0.63)

						self._starNum = 3
					end

					gohelper.setActive(self._goplace, isOnlyShowOneTarget)
					self:_showStar(normalEpisodeInfo, advancedConditionText, passNormal, passAdvanced, passUltra)
				end
			end
		end
	end
end

function SodacheHeroGroupFightViewLevel:_initStars()
	if self._starList then
		return
	end

	local starNum = self._starNum

	gohelper.setActive(self._gostar1, starNum == 1)
	gohelper.setActive(self._gostar2, starNum == 2)
	gohelper.setActive(self._gostar3, starNum == 3)

	if starNum == 1 then
		local var_8_0 = self._gostar1

		if not self._gostar1 then
			if starNum == 2 then
				var_8_0 = self._gostar2

				if not self._gostar2 then
					local starGo = self._gostar3

					self._starList = self:getUserDataTb_()

					for i = 1, starNum do
						local star = gohelper.findChildImage(starGo, "star" .. i)

						table.insert(self._starList, star)
					end
				end
			end
		end
	end
end

return SodacheHeroGroupFightViewLevel
