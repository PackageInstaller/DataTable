-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroGroupView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupView", package.seeall)

local Act191HeroGroupView = class("Act191HeroGroupView", BaseView)

function Act191HeroGroupView:onInitView()
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "container/btnContain/horizontal/#btn_Start")
	self._scrollInfo = gohelper.findChildScrollRect(self.viewGO, "container/#scroll_Info")
	self._imageRank = gohelper.findChildImage(self.viewGO, "container/#scroll_Info/infocontain/enemyrank/bg/txt_Name/#image_Rank")
	self._btnEnemy = gohelper.findChildButtonWithAudio(self.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemytitle/txten/#btn_Enemy")
	self._goEnemyTeam = gohelper.findChild(self.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemyList/#go_EnemyTeam")
	self._goSelectedBg = gohelper.findChild(self.viewGO, "container/#scroll_Info/infocontain/autofight/#go_SelectedBg")
	self._goUnSelectBg = gohelper.findChild(self.viewGO, "container/#scroll_Info/infocontain/autofight/#go_UnSelectBg")
	self._goRewardList = gohelper.findChild(self.viewGO, "container/#scroll_Info/infocontain/autofight/#go_RewardList")
	self._goRewardItem = gohelper.findChild(self.viewGO, "container/#scroll_Info/infocontain/autofight/#go_RewardList/#go_RewardItem")
	self._toggleAutoFight = gohelper.findChildToggle(self.viewGO, "container/#scroll_Info/infocontain/autofight/bg/#toggle_AutoFight")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#btn_Detail")
	self._goDetail = gohelper.findChild(self.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#go_Detail")
	self._btnCloseDetail = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#go_Detail/#btn_CloseDetail")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191HeroGroupView:addEvents()
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnEnemy:AddClickListener(self._btnEnemyOnClick, self)
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
	self._btnCloseDetail:AddClickListener(self._btnCloseDetailOnClick, self)
end

function Act191HeroGroupView:removeEvents()
	self._btnStart:RemoveClickListener()
	self._btnEnemy:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnCloseDetail:RemoveClickListener()
end

function Act191HeroGroupView:_btnDetailOnClick()
	gohelper.setActive(self._goDetail, true)
end

function Act191HeroGroupView:_btnCloseDetailOnClick()
	gohelper.setActive(self._goDetail, false)
end

function Act191HeroGroupView:_btnStartOnClick()
	if self.fighting then
		return
	end

	if not self.gameInfo:teamHasMainHero() then
		GameFacade.showToast(ToastEnum.Act191StartFightTip)

		return
	end

	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local battleId = episodeCo.battleId
	local fightParam = FightController.instance:setFightParamByEpisodeAndBattle(episodeId, battleId)

	fightParam:setDungeon(episodeCo.chapterId, episodeId)
	DungeonRpc.instance:sendStartDungeonRequest(episodeCo.chapterId, episodeId)

	self.fighting = true
end

function Act191HeroGroupView:_btnEnemyOnClick()
	if not self.isPvp then
		local fight_param = FightModel.instance:getFightParam()

		EnemyInfoController.instance:openAct191EnemyInfoView(fight_param.battleId)
	else
		ViewMgr.instance:openView(ViewName.Act191EnemyInfoView, self.nodeDetailMo)
	end
end

function Act191HeroGroupView:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._monsterGroupItemList = {}
	self.actId = Activity191Model.instance:getCurActId()
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	local teamInfo = self.gameInfo:getTeamInfo()

	if teamInfo then
		self._toggleAutoFight.isOn = teamInfo.auto or false
	end

	self._toggleAutoFight:AddOnValueChanged(self.onToggleValueChanged, self)

	self.goAutoFight = gohelper.findChild(self._goRewardList, "mask/#autofight")

	gohelper.setActive(self.goAutoFight, self._toggleAutoFight.isOn)

	self.rewardItemList = {}
end

function Act191HeroGroupView:onUpdateParam()
	return
end

function Act191HeroGroupView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self.eventClose, self)

	self.nodeDetailMo = self.gameInfo:getNodeDetailMo()

	self:refreshUI()
end

function Act191HeroGroupView:refreshUI()
	self.isPvp = Activity191Helper.isPvpBattle(self.nodeDetailMo.type)

	local fightLevel

	if not self.isPvp then
		local fightEventId = self.nodeDetailMo.fightEventId
		local eventCo = lua_activity191_fight_event.configDict[fightEventId]

		fightLevel = eventCo.fightLevel
	else
		local rank = self.nodeDetailMo.matchInfo.rank
		local rankCo = lua_activity191_match_rank.configDict[rank]

		fightLevel = rankCo.fightLevel
	end

	UISpriteSetMgr.instance:setAct174Sprite(self._imageRank, "act191_level_" .. string.lower(fightLevel))
	self:showEnemyList()
	self:refreshReward()
end

function Act191HeroGroupView:onClose()
	local isManual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, isManual)
end

function Act191HeroGroupView:onDestroyView()
	self._toggleAutoFight:RemoveOnValueChanged()
end

function Act191HeroGroupView:onToggleValueChanged()
	local isOn = self._toggleAutoFight.isOn

	self.gameInfo:setAutoFight(isOn)
	gohelper.setActive(self.goAutoFight, isOn)

	if isOn then
		AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_reward_increase)
	end

	self:refreshReward()
	Act191StatController.instance:statButtonClick(self.viewName, "onToggleValueChanged")
end

function Act191HeroGroupView:showEnemyList()
	local boss_career_dic = {}
	local enemy_career_dic = {}

	if self.isPvp then
		local matchInfo = self.nodeDetailMo.matchInfo

		for _, info in pairs(matchInfo.heroMap) do
			local roleCo = matchInfo:getRoleCo(info.heroId)

			if roleCo then
				local enemy_career = roleCo.career

				enemy_career_dic[enemy_career] = (enemy_career_dic[enemy_career] or 0) + 1
			end
		end

		for _, heroId in pairs(matchInfo.subHeroMap) do
			local roleCo = matchInfo:getRoleCo(heroId)

			if roleCo then
				local enemy_career = roleCo.career

				enemy_career_dic[enemy_career] = (enemy_career_dic[enemy_career] or 0) + 1
			end
		end
	else
		local fight_param = FightModel.instance:getFightParam()

		for _, v in ipairs(fight_param.monsterGroupIds) do
			local boss_id = lua_monster_group.configDict[v].bossId
			local ids = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[v].monster, "#")

			for _, id in ipairs(ids) do
				local enemy_career = lua_monster.configDict[id].career

				if FightHelper.isBossId(boss_id, id) then
					boss_career_dic[enemy_career] = (boss_career_dic[enemy_career] or 0) + 1
				else
					enemy_career_dic[enemy_career] = (enemy_career_dic[enemy_career] or 0) + 1
				end
			end
		end
	end

	local enemy_career_list = {}

	for k, v in pairs(boss_career_dic) do
		table.insert(enemy_career_list, {
			career = k,
			count = v
		})
	end

	self._enemy_boss_end_index = #enemy_career_list

	for k, v in pairs(enemy_career_dic) do
		table.insert(enemy_career_list, {
			career = k,
			count = v
		})
	end

	gohelper.CreateObjList(self, self._onEnemyItemShow, enemy_career_list, gohelper.findChild(self._goEnemyTeam, "enemyList"), gohelper.findChild(self._goEnemyTeam, "enemyList/go_enemyitem"))
end

function Act191HeroGroupView:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = data.count > 1 and luaLang("multiple") .. data.count or ""

	gohelper.setActive(kingIcon, index <= self._enemy_boss_end_index)
end

function Act191HeroGroupView:refreshReward()
	local rewardKey = self._toggleAutoFight.isOn and "autoRewardView" or "rewardView"
	local rewardList

	if self.isPvp then
		local typeKey = Activity191Enum.NodeType2Key[self.nodeDetailMo.type]
		local matchCo = lua_activity191_pvp_match.configDict[typeKey]

		rewardList = GameUtil.splitString2(matchCo[rewardKey], true)
	else
		local eventCo = lua_activity191_fight_event.configDict[self.nodeDetailMo.fightEventId]

		rewardList = GameUtil.splitString2(eventCo[rewardKey], true)
	end

	for _, item in ipairs(self.rewardItemList) do
		gohelper.setActive(item.parent, false)
	end

	for k, v in ipairs(rewardList) do
		local item = self.rewardItemList[k]

		if not item then
			item = self:getUserDataTb_()
			item.parent = gohelper.cloneInPlace(self._goRewardItem)

			local rewardGo = self:getResInst(Activity191Enum.PrefabPath.RewardItem, item.parent)

			item.item = MonoHelper.addNoUpdateLuaComOnceToGo(rewardGo, Act191RewardItem)
			self.rewardItemList[k] = item
		end

		item.item:showAutoEff(false)
		item.item:setData(v[1], v[2])
		item.item:setExtraParam({
			fromView = self.viewName,
			index = k
		})
		gohelper.setActive(item.parent, true)

		if self._toggleAutoFight.isOn then
			item.item:showAutoEff(true)
		end
	end

	gohelper.setActive(self._goSelectedBg, self._toggleAutoFight.isOn)
	gohelper.setActive(self._goUnSelectBg, not self._toggleAutoFight.isOn)
end

function Act191HeroGroupView:eventClose()
	ViewMgr.instance:closeView(self.viewName)
end

return Act191HeroGroupView
