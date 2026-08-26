-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174FightReadyView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyView", package.seeall)

local Act174FightReadyView = class("Act174FightReadyView", BaseView)

function Act174FightReadyView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Left")
	self._btnEnemyBuff = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Left/enemy/txt_enemy/#btn_EnemyBuff")
	self._goFrame = gohelper.findChild(self.viewGO, "#go_Frame")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._btnPlayerBuff = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/player/txt_player/#btn_PlayerBuff")
	self._txtRound = gohelper.findChildText(self.viewGO, "go_top/tips/#txt_Round")
	self._imageHpPercent = gohelper.findChildImage(self.viewGO, "go_top/hp/bg/#image_HpPercent")
	self._btnBet = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Bet")
	self._btnBetCancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_BetCancel")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Start")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Right/tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174FightReadyView:addEvents()
	self._btnEnemyBuff:AddClickListener(self._btnEnemyBuffOnClick, self)
	self._btnPlayerBuff:AddClickListener(self._btnPlayerBuffOnClick, self)
	self._btnBet:AddClickListener(self._btnBetOnClick, self)
	self._btnBetCancel:AddClickListener(self._btnBetCancelOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
end

function Act174FightReadyView:removeEvents()
	self._btnEnemyBuff:RemoveClickListener()
	self._btnPlayerBuff:RemoveClickListener()
	self._btnBet:RemoveClickListener()
	self._btnBetCancel:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function Act174FightReadyView:_btnEnemyBuffOnClick()
	Activity174Controller.instance:openBuffTipView(true, Vector2.New(-450, 80))
end

function Act174FightReadyView:_btnPlayerBuffOnClick()
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(475, 80))
end

function Act174FightReadyView:_btnBetOnClick()
	Activity174Rpc.instance:sendBetHpBeforeAct174FightRequest(self.actId, true, self.betReply, self)
end

function Act174FightReadyView:_btnBetCancelOnClick()
	Activity174Rpc.instance:sendBetHpBeforeAct174FightRequest(self.actId, false, self.betReply, self)
end

function Act174FightReadyView:_btnStartOnClick()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174FightReadyView")
	self._animatorPlayer:Play(UIAnimationName.Close, self._starFight, self)
end

function Act174FightReadyView:_starFight()
	Activity174Rpc.instance:sendStartAct174FightRequest(self.actId, self._fightReply, self)
end

function Act174FightReadyView:_fightReply()
	Activity174Controller.instance:playFight()
	UIBlockMgr.instance:endBlock("Act174FightReadyView")
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:closeThis()
end

function Act174FightReadyView:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	self.hpEffList = self:getUserDataTb_()

	for i = 1, self.maxHp do
		self.hpEffList[#self.hpEffList + 1] = gohelper.findChild(self.viewGO, "go_top/hp/bg/#hp0" .. i)
	end
end

function Act174FightReadyView:onUpdateParam()
	return
end

function Act174FightReadyView:onOpen()
	self.actId = Activity174Model.instance:getCurActId()
	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	local gameCount = self.gameInfo.gameCount
	local turnConfig = Activity174Config.instance:getTurnCo(self.actId, gameCount)

	self.unLockTeamCnt = turnConfig.groupNum

	self:initLeftArea()
	self:initMiddleArea()
	self:initRightArea()

	local wareHouseMo = self.gameInfo:getWarehouseInfo()
	local fightInfo = self.gameInfo:getFightInfo()
	local enemyEnhanceList = fightInfo.matchInfo.enhanceId

	gohelper.setActive(self._btnPlayerBuff, #wareHouseMo.enhanceId ~= 0)
	gohelper.setActive(self._btnEnemyBuff, #enemyEnhanceList ~= 0)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.SeasonChange, self.closeThis, self)
end

function Act174FightReadyView:onOpenFinish()
	local gameCount = self.gameInfo.gameCount

	Activity174Controller.instance:dispatchEvent(Activity174Event.FightReadyViewLevelCount, gameCount)
end

function Act174FightReadyView:onClose()
	return
end

function Act174FightReadyView:onDestroyView()
	return
end

function Act174FightReadyView:initLeftArea()
	local teamGroup = gohelper.findChild(self.viewGO, "#go_Left/EnemyGroup")
	local teamInfo = self.gameInfo:getFightInfo().matchInfo.teamInfo

	for i = 1, self.unLockTeamCnt do
		local go = gohelper.cloneInPlace(teamGroup, "EnemyGroup" .. i)
		local readyItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act174FightReadyItem, self)

		readyItem:setData(teamInfo[i], true)
	end

	gohelper.setActive(teamGroup, false)
end

function Act174FightReadyView:initMiddleArea()
	local maxRound = Activity174Config.instance:getMaxRound(self.actId, self.gameInfo.gameCount)

	self._txtRound.text = string.format("%s/%s", self.gameInfo.gameCount, maxRound)
	self.maxHp = lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value
	self._imageHpPercent.fillAmount = self.gameInfo.hp / self.maxHp

	self:refreshBetStatus()
end

function Act174FightReadyView:refreshBetStatus()
	local turnCo = Activity174Config.instance:getTurnCo(self.actId, self.gameInfo.gameCount)
	local winCoin = turnCo.winCoin
	local isBet = self.gameInfo.fightInfo.betHp

	if winCoin == 0 or self.gameInfo.hp <= 1 then
		for i = 1, self.maxHp do
			gohelper.setActive(self.hpEffList[i], false)
		end

		gohelper.setActive(self._btnBet, false)
		gohelper.setActive(self._btnBetCancel, false)
	else
		self.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

		for i = 1, self.maxHp do
			gohelper.setActive(self.hpEffList[i], isBet and i == self.gameInfo.hp)
		end

		gohelper.setActive(self._btnBet, not isBet)
		gohelper.setActive(self._btnBetCancel, isBet)
	end
end

function Act174FightReadyView:initRightArea()
	local unLockTeamCnt = self.unLockTeamCnt

	gohelper.setActive(self._goTips, unLockTeamCnt > 1)

	self.frameTrList = {}

	local frameGo = gohelper.findChild(self.viewGO, "#go_Frame/frame")

	for i = 1, unLockTeamCnt do
		local go = gohelper.cloneInPlace(frameGo)

		self.frameTrList[i] = go.transform
	end

	gohelper.setActive(frameGo, false)
	ZProj.UGUIHelper.RebuildLayout(frameGo.transform.parent)

	local height = 211 * unLockTeamCnt + 65

	recthelper.setHeight(self._goRight.transform, height)

	self.readyItemList = {}

	local teamGroup = gohelper.findChild(self.viewGO, "#go_Right/PlayerGroup")
	local teamInfo = self.gameInfo:getTeamMoList()

	for i = 1, unLockTeamCnt do
		local go = gohelper.cloneInPlace(teamGroup, "PlayerGroup" .. i)
		local anchorPos = recthelper.rectToRelativeAnchorPos(self.frameTrList[i].position, self._goRight.transform)

		recthelper.setAnchor(go.transform, anchorPos.x, anchorPos.y)

		local readyItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act174FightReadyItem, self)

		readyItem:setData(teamInfo[i], false)

		self.readyItemList[i] = readyItem
	end

	gohelper.setActive(teamGroup, false)
end

function Act174FightReadyView:exchangeItem(from, to)
	self.readyItemList[from] = self.readyItemList[to]
	self.readyItemList[to] = self.readyItemList[from]

	Activity174Rpc.instance:sendSwitchAct174TeamRequest(self.actId, from, to, self.switchReply, self)
end

function Act174FightReadyView:switchReply()
	local teamInfo = self.gameInfo:getTeamMoList()

	for i = 1, #self.readyItemList do
		local readyItem = self.readyItemList[i]

		if teamInfo[i] then
			readyItem:setData(teamInfo[i], false)
		else
			logError("dont esixt teamInfo" .. i)
		end
	end
end

function Act174FightReadyView:betReply(cmd, resultCode, msg)
	if resultCode == 0 then
		if msg.bet then
			ViewMgr.instance:openView(ViewName.Act174BetSuccessView)
		end

		self:refreshBetStatus()
	end
end

return Act174FightReadyView
