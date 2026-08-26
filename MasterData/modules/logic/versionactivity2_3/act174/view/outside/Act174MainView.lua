-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174MainView.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174MainView", package.seeall)

local Act174MainView = class("Act174MainView", BaseView)

function Act174MainView:onInitView()
	self._goachieve = gohelper.findChild(self.viewGO, "#go_achieve")
	self.badgeGoParent = gohelper.findChild(self.viewGO, "#go_achieve/scroll_achieve/viewport/content")
	self.badgeGo = gohelper.findChild(self.viewGO, "#go_achieve/scroll_achieve/viewport/content/go_achievementicon")
	self._btnBadge = gohelper.findChildButtonWithAudio(self.viewGO, "#go_achieve/scroll_achieve/#btn_Badge")
	self._gorule = gohelper.findChild(self.viewGO, "#go_rule")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rule/#btn_rule")
	self._btnEndGame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_EndGame")
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_Shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "layout/#btn_Shop/#txt_num")
	self._goprogress = gohelper.findChild(self.viewGO, "layout/#go_progress")
	self._txtRound = gohelper.findChildText(self.viewGO, "layout/#go_progress/#txt_Round")
	self._goHp = gohelper.findChild(self.viewGO, "layout/#go_progress/#go_Hp")
	self._imageHpPercent = gohelper.findChildImage(self.viewGO, "layout/#go_progress/#go_Hp/bg/#image_HpPercent")
	self._btnEnterGame = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_EnterGame")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174MainView:addEvents()
	self._btnBadge:AddClickListener(self._btnBadgeOnClick, self)
	self._btnrule:AddClickListener(self._btnruleOnClick, self)
	self._btnEndGame:AddClickListener(self._btnEndGameOnClick, self)
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnEnterGame:AddClickListener(self._btnEnterGameOnClick, self)
end

function Act174MainView:removeEvents()
	self._btnBadge:RemoveClickListener()
	self._btnrule:RemoveClickListener()
	self._btnEndGame:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnEnterGame:RemoveClickListener()
end

function Act174MainView:_btnEndGameOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndGameConfirm, MsgBoxEnum.BoxType.Yes_No, self.endGame, nil, nil, self)
end

function Act174MainView:_btnBadgeOnClick()
	ViewMgr.instance:openView(ViewName.Act174BadgeWallView)
end

function Act174MainView:_btnruleOnClick()
	ViewMgr.instance:openView(ViewName.Act174RotationView)
end

function Act174MainView:_btnShopOnClick()
	Activity174Controller.instance:openStoreView(VersionActivity2_3Enum.ActivityId.Act174Store)
end

function Act174MainView:_btnEnterGameOnClick(manually)
	local gameInfo = self.actInfo:getGameInfo()

	if gameInfo and gameInfo:isInGame() then
		local state = gameInfo.state

		if state == Activity174Enum.GameState.ForceSelect then
			Activity174Controller.instance:openForcePickView(gameInfo:getForceBagsInfo())
		elseif state == Activity174Enum.GameState.BeforeFight then
			Activity174Controller.instance:openFightReadyView()
		elseif state == Activity174Enum.GameState.Free then
			Activity174Controller.instance:openGameView()
		elseif state == Activity174Enum.GameState.AfterFight then
			Activity174Controller.instance:openFightResultView()
		elseif state == Activity174Enum.GameState.EnterEndless then
			Activity174Controller.instance:openEndLessView()
		else
			logError("GameState need do" .. state)
		end

		if not manually and (state == Activity174Enum.GameState.Free or state == Activity174Enum.GameState.BeforeFight) then
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_match_start)
		end
	else
		Activity174Rpc.instance:sendStart174GameRequest(self.actId, self.enterGameCallback, self)
	end
end

function Act174MainView:_editableInitView()
	return
end

function Act174MainView:onUpdateParam()
	return
end

function Act174MainView:onOpen()
	self.actId = self.viewParam.actId

	if self.viewParam.exitFromFight then
		self:_onOpen()
	else
		Activity174Rpc.instance:sendGetAct174InfoRequest(self.actId, self._onOpen, self)
	end
end

function Act174MainView:_onOpen()
	self.actInfo = Activity174Model.instance:getActInfo()

	if not self:checkGameEndInfo() then
		if self.viewParam and self.viewParam.exitFromFight then
			self:_nextReply()
		else
			AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
		end
	end

	self:checkSeason()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.UpdateBadgeMo, self.refreshBadge, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.refreshUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.EndGame, self.checkGameEndInfo, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.ClickStartGame, self._btnEnterGameOnClick, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.EnterNextAct174FightReply, self._nextReply, self)
end

function Act174MainView:onClose()
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.refreshUI, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.EndGame, self.refreshUI, self)
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.EnterNextAct174FightReply, self._nextReply, self)
end

function Act174MainView:onDestroyView()
	for _, icon in ipairs(self.ruleHeroIconList) do
		icon:UnLoadImage()
	end

	for _, badgeItem in pairs(self.badgeItemDic) do
		badgeItem.simageIcon:UnLoadImage()
	end
end

function Act174MainView:checkGameEndInfo()
	local gameEndInfo = self.actInfo:getGameEndInfo()

	if gameEndInfo then
		Activity174Controller.instance:openSettlementView()
		self:refreshUI()

		return true
	end
end

function Act174MainView:refreshUI()
	local gameInfo = self.actInfo:getGameInfo()
	local inGmae = gameInfo:isInGame()

	gohelper.setActive(self._btnEndGame, inGmae)
	gohelper.setActive(self._goprogress, inGmae)

	if inGmae then
		local maxRound, isEndless = Activity174Config.instance:getMaxRound(self.actId, gameInfo.gameCount)

		self._txtRound.text = string.format("%s/%s", gameInfo.gameCount, maxRound)

		local maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

		self._imageHpPercent.fillAmount = gameInfo.hp / maxHp

		gohelper.setActive(self._goHp, not isEndless)
	end

	self:initRule()
	self:refreshBadge()
	self:refreshCurrency()
end

function Act174MainView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3DouQuQu)

	self._txtnum.text = currencyMo.quantity
end

function Act174MainView:enterGameCallback()
	Activity174Model.instance:clearUnlockNewTeamTipCache()

	local gameInfo = self.actInfo:getGameInfo()

	Activity174Controller.instance:openForcePickView(gameInfo.forceBagInfo)
end

function Act174MainView:endGame()
	Activity174Rpc.instance:sendEndAct174GameRequest(self.actId, self.endGameCallback, self)
end

function Act174MainView:endGameCallback()
	local gameEndInfo = self.actInfo:getGameEndInfo()

	if gameEndInfo then
		Activity174Controller.instance:openSettlementView()

		local changeBadgeDic = self.actInfo:getBadgeScoreChangeDic()

		for id, _ in pairs(changeBadgeDic) do
			local badgeMo = self.actInfo:getBadgeMo(id)

			self:refreshBadgeItem(id, badgeMo)
		end

		self:refreshUI()
	else
		logError("gameEndInfo is nil")
	end
end

function Act174MainView:refreshBadge()
	self.badgeItemDic = {}

	local badgeMoList = self.actInfo:getBadgeMoList()

	gohelper.CreateObjList(self, self._onSetBadgeItem, badgeMoList, self.badgeGoParent, self.badgeGo)
end

function Act174MainView:_onSetBadgeItem(go, badgeMo, index)
	local badgeItem = self:getUserDataTb_()
	local id = badgeMo.id

	badgeItem.simageIcon = gohelper.findChildSingleImage(go, "root/image_icon")
	badgeItem.txtNum = gohelper.findChildText(go, "root/txt_num")
	self.badgeItemDic[id] = badgeItem

	self:refreshBadgeItem(id, badgeMo)
end

function Act174MainView:refreshBadgeItem(badgeId, badgeMo)
	local badgeItem = self.badgeItemDic[badgeId]
	local state = badgeMo:getState()
	local path = ResUrl.getAct174BadgeIcon(badgeMo.config.icon, state)

	badgeItem.simageIcon:LoadImage(path)

	badgeItem.txtNum.text = badgeMo.count
end

function Act174MainView:initRule()
	local heroCoList = self.actInfo:getRuleHeroCoList()
	local count = #heroCoList
	local showCoList = {}

	for i = 0, 2 do
		table.insert(showCoList, heroCoList[count - i])
	end

	table.sort(showCoList, Activity174Helper.sortActivity174RoleCo)

	self.ruleHeroIconList = {}

	for i, heroCo in ipairs(showCoList) do
		local roleGo = gohelper.findChild(self._gorule, "role/" .. i)
		local imageRare = gohelper.findChildImage(roleGo, "rare")
		local heroIcon = gohelper.findChildSingleImage(roleGo, "heroicon")
		local imageCareer = gohelper.findChildImage(roleGo, "career")
		local name = gohelper.findChildText(roleGo, "name")

		heroIcon:LoadImage(ResUrl.getHeadIconSmall(heroCo.skinId))
		UISpriteSetMgr.instance:setCommonSprite(imageRare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))
		UISpriteSetMgr.instance:setCommonSprite(imageCareer, "lssx_" .. tostring(heroCo.career))

		name.text = heroCo.name
		self.ruleHeroIconList[i] = heroIcon
	end
end

function Act174MainView:dailyRefresh()
	Activity174Rpc.instance:sendGetAct174InfoRequest(self.actId, self.checkSeason, self)
end

function Act174MainView:checkSeason()
	self:refreshUI()

	local gameInfo = self.actInfo:getGameInfo()
	local inGame = gameInfo:isInGame()

	if not inGame then
		return
	end

	local seasonIdA = self.actInfo.season
	local seasonIdB = gameInfo.season

	if seasonIdA ~= seasonIdB then
		Activity174Rpc.instance:sendChangeSeasonEndAct174Request(self.actId, self.seasonChangeEnd, self)
	end
end

function Act174MainView:seasonChangeEnd(cmd, resultCode, msg)
	if resultCode == 0 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.SeasonChange)

		local actInfo = Activity174Model.instance:getActInfo()
		local gameEndInfo = actInfo:getGameEndInfo()

		if gameEndInfo then
			Activity174Controller.instance:openSettlementView()
		end
	end
end

function Act174MainView:_nextReply()
	local maxNormalRound = Activity174Config.instance:getMaxRound(self.actId, 1)
	local gameInfo = self.actInfo:getGameInfo()

	if gameInfo.gameCount > maxNormalRound + 1 then
		Activity174Controller.instance:openEndLessView({
			showScore = true
		})
	else
		self:_btnEnterGameOnClick(true)
	end
end

return Act174MainView
