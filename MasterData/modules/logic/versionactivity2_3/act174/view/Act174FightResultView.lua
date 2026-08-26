-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174FightResultView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174FightResultView", package.seeall)

local Act174FightResultView = class("Act174FightResultView", BaseView)

function Act174FightResultView:onInitView()
	self._btnEnemyBuff = gohelper.findChildButtonWithAudio(self.viewGO, "enemy/txt_enemy/#btn_EnemyBuff")
	self._btnPlayerBuff = gohelper.findChildButtonWithAudio(self.viewGO, "player/txt_player/#btn_PlayerBuff")
	self._goresultitem = gohelper.findChild(self.viewGO, "Group/#go_resultitem")
	self._txtRound = gohelper.findChildText(self.viewGO, "go_top/tips/#txt_Round")
	self._imageHpPercent = gohelper.findChildImage(self.viewGO, "go_top/hp/bg/#image_HpPercent")
	self._gowin = gohelper.findChild(self.viewGO, "go_top/result/#go_win")
	self._godraw = gohelper.findChild(self.viewGO, "go_top/result/#go_draw")
	self._golose = gohelper.findChild(self.viewGO, "go_top/result/#go_lose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174FightResultView:addEvents()
	self._btnEnemyBuff:AddClickListener(self._btnEnemyBuffOnClick, self)
	self._btnPlayerBuff:AddClickListener(self._btnPlayerBuffOnClick, self)
end

function Act174FightResultView:removeEvents()
	self._btnEnemyBuff:RemoveClickListener()
	self._btnPlayerBuff:RemoveClickListener()
end

function Act174FightResultView:onClickModalMask()
	Activity174Rpc.instance:sendEnterNextAct174FightRequest(self.actId, self.enterReply, self)
end

function Act174FightResultView:enterReply(cmd, resultCode, msg)
	if resultCode == 0 then
		if msg.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Controller.instance:dispatchEvent(Activity174Event.EndGame)
		else
			Activity174Controller.instance:dispatchEvent(Activity174Event.EnterNextAct174FightReply)
		end

		FightController.instance:dispatchEvent(FightEvent.DouQuQuSettlementFinish)
		self:closeThis()
	end
end

function Act174FightResultView:_btnEnemyBuffOnClick()
	Activity174Controller.instance:openBuffTipView(true, Vector2.New(-450, 80))
end

function Act174FightResultView:_btnPlayerBuffOnClick()
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(450, 80))
end

function Act174FightResultView:_editableInitView()
	return
end

function Act174FightResultView:onUpdateParam()
	return
end

function Act174FightResultView:onOpen()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.SeasonChange, self.closeThis, self)

	self.actId = Activity174Model.instance:getCurActId()
	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	self.fightInfo = self.gameInfo:getFightInfo()
	self.fightResInfos = self.fightInfo.fightResInfo
	self.entityId2HeroIdDicList = cjson.decode(self.fightInfo.param)
	self.playerTeamInfos = self.gameInfo:getTeamMoList()
	self.enemyTeamInfos = self.fightInfo.matchInfo.teamInfo

	local gameCount = self.gameInfo.gameCount
	local maxRound = Activity174Config.instance:getMaxRound(self.actId, gameCount)

	self._txtRound.text = gameCount .. "/" .. maxRound

	local wareHouseMo = self.gameInfo:getWarehouseInfo()
	local enemyEnhanceList = self.fightInfo.matchInfo.enhanceId

	gohelper.setActive(self._btnPlayerBuff, #wareHouseMo.enhanceId ~= 0)
	gohelper.setActive(self._btnEnemyBuff, #enemyEnhanceList ~= 0)

	if self.fightInfo.state == Activity174Enum.FightResult.Lose then
		self.gameInfo.hp = self.fightInfo.betHp and self.gameInfo.hp - 2 or self.gameInfo.hp - 1
	end

	local maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

	self._imageHpPercent.fillAmount = self.gameInfo.hp / maxHp

	local state = self.fightInfo.state
	local isWin = state == Activity174Enum.FightResult.Win
	local isLose = state == Activity174Enum.FightResult.Lose
	local isDraw = state == Activity174Enum.FightResult.Draw

	gohelper.setActive(self._gowin, isWin)
	gohelper.setActive(self._golose, isLose)
	gohelper.setActive(self._godraw, isDraw)

	local resultAudio

	if isWin then
		resultAudio = AudioEnum.Act174.play_ui_shenghuo_dqq_win
	elseif isLose then
		resultAudio = AudioEnum.Act174.play_ui_shenghuo_dqq_lose
	elseif isDraw then
		resultAudio = AudioEnum.Act174.play_ui_shenghuo_dqq_draw
	end

	if resultAudio then
		AudioMgr.instance:trigger(resultAudio)
	end

	local turnConfig = Activity174Config.instance:getTurnCo(self.actId, self.gameInfo.gameCount)

	self.teamCnt = turnConfig.groupNum
	self.resultItemList = {}

	for i = 1, self.teamCnt do
		local go = gohelper.cloneInPlace(self._goresultitem, "resultItem" .. i)

		self:initResultItem(go, i)
	end

	gohelper.setActive(self._goresultitem, false)
	self:playEndAnim()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_result)
end

function Act174FightResultView:onDestroyView()
	return
end

function Act174FightResultView:initResultItem(go, teamIndex)
	local resultItem = self:getUserDataTb_()
	local enemyGroupGo = gohelper.findChild(go, "EnemyGroup")

	resultItem.goEnemyWin = gohelper.findChild(go, "simage_enemywin")
	resultItem.goEnemyMask = gohelper.findChild(enemyGroupGo, "go_mask")

	local imageNum = gohelper.findChildImage(enemyGroupGo, "numbg/image_Num")

	UISpriteSetMgr.instance:setAct174Sprite(imageNum, "act174_ready_num_0" .. teamIndex)

	local enemyTeamInfo = Activity174Helper.MatchKeyInArray(self.enemyTeamInfos, teamIndex, "index")

	for i = 4, 1, -1 do
		local fightHeroGo = self:getResInst(Activity174Enum.PrefabPath.BattleHero, enemyGroupGo)
		local battleHeroItem = MonoHelper.addNoUpdateLuaComOnceToGo(fightHeroGo, Act174BattleHeroItem)
		local info = Activity174Helper.MatchKeyInArray(enemyTeamInfo.battleHeroInfo, i, "index")

		battleHeroItem:setIndex(i)
		battleHeroItem:setData(info, teamIndex, true)
	end

	gohelper.setAsLastSibling(resultItem.goEnemyMask)

	local playerGroupGo = gohelper.findChild(go, "PlayerGroup")

	resultItem.goPlayerWin = gohelper.findChild(go, "simage_playerwin")
	resultItem.goPlayerMask = gohelper.findChild(playerGroupGo, "go_mask")

	local imageNum1 = gohelper.findChildImage(playerGroupGo, "numbg/image_Num")

	UISpriteSetMgr.instance:setAct174Sprite(imageNum1, "act174_ready_num_0" .. teamIndex)

	local playerTeamInfo = Activity174Helper.MatchKeyInArray(self.playerTeamInfos, teamIndex, "index")

	for i = 1, 4 do
		local fightHeroGo = self:getResInst(Activity174Enum.PrefabPath.BattleHero, playerGroupGo)
		local battleHeroItem = MonoHelper.addNoUpdateLuaComOnceToGo(fightHeroGo, Act174BattleHeroItem)
		local info = Activity174Helper.MatchKeyInArray(playerTeamInfo.battleHeroInfo, i, "index")

		battleHeroItem:setIndex(i)
		battleHeroItem:setData(info, teamIndex, false)
	end

	gohelper.setAsLastSibling(resultItem.goPlayerMask)

	local btnReplay = gohelper.findChildButtonWithAudio(go, "btn_replay")
	local btnDetail = gohelper.findChildButtonWithAudio(go, "btn_detail")

	self.addClickCb(self, btnReplay, self.onClickReplay, self, teamIndex)
	self.addClickCb(self, btnDetail, self.onClickDetail, self, teamIndex)

	self.resultItemList[#self.resultItemList + 1] = resultItem
end

function Act174FightResultView:onClickDetail(index)
	local fightResInfo = Activity174Helper.MatchKeyInArray(self.fightResInfos, index, "index")

	if fightResInfo then
		local attackStatistics = fightResInfo.attackStatistics
		local heroUidDict = self.entityId2HeroIdDicList[tostring(index)]

		if heroUidDict then
			local result = Activity174Model.instance:geAttackStatisticsByServerData(attackStatistics, heroUidDict)

			FightStatModel.instance:setAtkStatInfo(result)
			ViewMgr.instance:openView(ViewName.FightStatView)
		end
	else
		logError("dont exist fightResInfo")
	end
end

function Act174FightResultView:onClickReplay(index)
	local fightResInfo = Activity174Helper.MatchKeyInArray(self.fightResInfos, index, "index")

	if fightResInfo then
		Activity174Controller.instance:playFight({
			index
		}, true)
		self:closeThis()
	end
end

function Act174FightResultView:playEndAnim()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174FightResultView_endAnim")

	self.curTeam = 1

	TaskDispatcher.runRepeat(self.lightBg, self, 0.5)
end

function Act174FightResultView:lightBg()
	local resultItem = self.resultItemList[self.curTeam]
	local fightResInfo = Activity174Helper.MatchKeyInArray(self.fightResInfos, self.curTeam, "index")

	if fightResInfo then
		gohelper.setActive(resultItem.goPlayerWin, fightResInfo.win)
		gohelper.setActive(resultItem.goEnemyWin, not fightResInfo.win)
		gohelper.setActive(resultItem.goPlayerMask, not fightResInfo.win)
		gohelper.setActive(resultItem.goEnemyMask, fightResInfo.win)
	end

	self.curTeam = self.curTeam + 1

	if self.curTeam > self.teamCnt then
		TaskDispatcher.cancelTask(self.lightBg, self)
		UIBlockMgr.instance:endBlock("Act174FightResultView_endAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return Act174FightResultView
