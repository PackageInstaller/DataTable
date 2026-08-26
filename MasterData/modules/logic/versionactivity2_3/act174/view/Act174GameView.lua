-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameView", package.seeall)

local Act174GameView = class("Act174GameView", BaseView)

function Act174GameView:onInitView()
	self._goShop = gohelper.findChild(self.viewGO, "#go_Shop")
	self._goEditTeam = gohelper.findChild(self.viewGO, "#go_EditTeam")
	self._goLeftBtn = gohelper.findChild(self.viewGO, "BtnGroup/#go_LeftBtn")
	self._goUnlockTeamTip = gohelper.findChild(self.viewGO, "BtnGroup/#go_LeftBtn/go_tips")
	self._btnEditTeam = gohelper.findChildButton(self.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam")
	self._btnShop = gohelper.findChildButton(self.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop")
	self._btnBuff = gohelper.findChildButtonWithAudio(self.viewGO, "BtnGroup/#btn_Buff")
	self._btnMatch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Match")
	self._goCoin1 = gohelper.findChild(self.viewGO, "go_topright/#go_Coin1")
	self._txtCoinCnt1 = gohelper.findChildText(self.viewGO, "go_topright/#go_Coin1/#txt_CoinCnt1")
	self._goEndlessDetail = gohelper.findChild(self.viewGO, "go_topright/btn_detail")
	self._btnEndlessDetail = gohelper.findChildClickWithDefaultAudio(self.viewGO, "go_topright/btn_detail/clickarea")
	self._goCoin2 = gohelper.findChild(self.viewGO, "go_topright/#go_Coin2")
	self._txtCoinCnt2 = gohelper.findChildText(self.viewGO, "go_topright/#go_Coin2/#txt_CoinCnt2")
	self._goEndlessMultiple = gohelper.findChild(self.viewGO, "go_topright/go_tips")
	self._txtEndlessMultiple = gohelper.findChildText(self.viewGO, "go_topright/go_tips/txt_tips")
	self._btnCloseEndlessTips = gohelper.findChildClickWithDefaultAudio(self.viewGO, "go_topright/go_tips/#btn_closetip")
	self._txtRound = gohelper.findChildText(self.viewGO, "go_top/tips/#txt_Round")
	self._goHp = gohelper.findChild(self.viewGO, "go_top/#go_Hp")
	self._imageHpPercent = gohelper.findChildImage(self.viewGO, "go_top/#go_Hp/bg/#image_HpPercent")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174GameView:addEvents()
	self._btnEditTeam:AddClickListener(self._btnEditTeamOnClick, self)
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnBuff:AddClickListener(self._btnBuffOnClick, self)
	self._btnMatch:AddClickListener(self._btnMatchOnClick, self)
	self._btnEndlessDetail:AddClickListener(self._onOpenEndlessTips, self)
	self._btnCloseEndlessTips:AddClickListener(self._onCloseEndlessTips, self)
end

function Act174GameView:removeEvents()
	self._btnEditTeam:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnMatch:RemoveClickListener()
	self._btnEndlessDetail:RemoveClickListener()
	self._btnCloseEndlessTips:RemoveClickListener()
end

function Act174GameView:_btnBuffOnClick()
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(-600, -698), true)
end

function Act174GameView:_btnMatchOnClick()
	if Activity174Controller.instance:checkTeamDataWrong(self.actId) then
		GameFacade.showToast(ToastEnum.Act174TeamGroupEmpty)

		return
	end

	Activity174Controller.instance:syncLocalTeam2Server(self.actId)
	ViewMgr.instance:openView(ViewName.Act174MatchView)
end

function Act174GameView:_btnEditTeamOnClick(manully)
	self:closeUnlockTeamTip(true)

	if not manully and self._goEditTeam.activeInHierarchy then
		return
	end

	self.anim:Play("switch_editteam", 0, 0)
	gohelper.setActive(self._goEditTeam, true)
	gohelper.setActive(self._goShop, false)
	gohelper.setActive(self._goBtnEditTeamS, true)
	gohelper.setActive(self._goBtnEditTeamU, false)
	gohelper.setActive(self._goBtnShopS, false)
	gohelper.setActive(self._goBtnShopU, true)
	gohelper.setActive(self._btnMatch, true)

	if not manully then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.SwitchShopTeam)
end

function Act174GameView:_btnShopOnClick(manully)
	if not manully and self._goShop.activeInHierarchy then
		return
	end

	self.anim:Play("switch_shop", 0, 0)
	gohelper.setActive(self._goEditTeam, false)
	gohelper.setActive(self._goShop, true)
	gohelper.setActive(self._goBtnEditTeamS, false)
	gohelper.setActive(self._goBtnEditTeamU, true)
	gohelper.setActive(self._goBtnShopS, true)
	gohelper.setActive(self._goBtnShopU, false)
	gohelper.setActive(self._btnMatch, false)

	if not manully then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.SwitchShopTeam)

	local actInfo = Activity174Model.instance:getActInfo()
	local gameInfo = actInfo:getGameInfo()
	local gameCount = gameInfo.gameCount

	if gameCount > 1 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.EnterGameStore)
	end
end

function Act174GameView:_onOpenEndlessTips()
	gohelper.setActive(self._goEndlessMultiple, true)
end

function Act174GameView:_onCloseEndlessTips()
	gohelper.setActive(self._goEndlessMultiple, false)
end

function Act174GameView:_editableInitView()
	self._goBtnEditTeamS = gohelper.findChild(self.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam/select")
	self._goBtnEditTeamU = gohelper.findChild(self.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam/unselect")
	self._goBtnShopS = gohelper.findChild(self.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop/select")
	self._goBtnShopU = gohelper.findChild(self.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop/unselect")
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goCoinAdd = gohelper.findChild(self._goCoin1, "#add")
	self.goCoinSubtract = gohelper.findChild(self._goCoin1, "#subtract")
	self.goHpAdd = gohelper.findChild(self._goHp, "bg/#recover_hp")
	self.goHpSubtract = gohelper.findChild(self._goHp, "bg/#lose_hp")
	self.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

	self:_btnShopOnClick(true)
end

function Act174GameView:onUpdateParam()
	return
end

function Act174GameView:onOpen()
	self.actId = Activity174Model.instance:getCurActId()
	self.actInfo = Activity174Model.instance:getActInfo()

	self:refreshUI()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.refreshUI, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.FreshShopReply, self.refreshUI, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.BuyInShopReply, self.refreshUI, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.SeasonChange, self.closeThis, self)
end

function Act174GameView:checkUnlockTeamTipShow()
	local isShowUnlockNewTeam = false

	if self.actInfo then
		local gameInfo = self.actInfo:getGameInfo()
		local gameCount = gameInfo and gameInfo.gameCount

		if gameCount then
			isShowUnlockNewTeam = Activity174Model.instance:getIsShowUnlockNewTeamTip(gameCount)
		end

		gohelper.setActive(self._goUnlockTeamTip, isShowUnlockNewTeam)

		if isShowUnlockNewTeam then
			Activity174Model.instance:setHasShowUnlockNewTeamTip(gameCount)
			TaskDispatcher.runDelay(self.closeUnlockTeamTip, self, 3)
		end
	end
end

function Act174GameView:closeUnlockTeamTip(forceClose)
	gohelper.setActive(self._goUnlockTeamTip, false)

	if forceClose then
		TaskDispatcher.cancelTask(self.closeUnlockTeamTip, self)
	end
end

function Act174GameView:onClose()
	self:closeUnlockTeamTip(true)
end

function Act174GameView:onDestroyView()
	return
end

function Act174GameView:refreshUI()
	local gameInfo = self.actInfo:getGameInfo()

	self._txtCoinCnt1.text = gameInfo.coin
	self._txtCoinCnt2.text = gameInfo.score

	local gameCount = gameInfo.gameCount
	local maxRound, isEndless = Activity174Config.instance:getMaxRound(self.actId, gameCount)

	self._txtRound.text = string.format("%s/%s", gameInfo.gameCount, maxRound)
	self._imageHpPercent.fillAmount = gameInfo.hp / self.maxHp

	if isEndless or gameCount == 1 then
		if isEndless then
			local betScore = gameInfo:getBetScore()
			local turnCo = Activity174Config.instance:getTurnCo(self.actId, gameCount)
			local multiplePoint = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multiple_1"), turnCo.point / 1000)

			self._txtEndlessMultiple.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act174_endless_multiple"), betScore, multiplePoint)

			gohelper.setActive(self._goCoin1, false)
			gohelper.setActive(self._goHp, false)
		end

		gohelper.setActive(self._goLeftBtn, false)
		self:_btnEditTeamOnClick(true)
	end

	self:_onCloseEndlessTips()
	gohelper.setActive(self._goEndlessDetail, isEndless)
	self:checkUnlockTeamTipShow()

	local wareHouseMo = gameInfo:getWarehouseInfo()

	gohelper.setActive(self._btnBuff, #wareHouseMo.enhanceId ~= 0)
	self:checkTriggerEffect()
end

function Act174GameView:checkTriggerEffect()
	local hpChange = 0
	local coinChange = 0
	local triggerEffectList = self.actInfo:getTriggerList()

	for _, tbl in ipairs(triggerEffectList) do
		for _, id in ipairs(tbl.effectId) do
			local effectCo = lua_activity174_effect.configDict[id]
			local params = string.splitToNumber(effectCo.typeParam, "#")

			if effectCo.type == Activity174Enum.EffectType.AddHp then
				hpChange = hpChange + params[1]
			elseif effectCo.type == Activity174Enum.EffectType.Rebirth then
				hpChange = hpChange + 1
				coinChange = coinChange - params[2]
			elseif effectCo.type == Activity174Enum.EffectType.DirectAddCoin then
				coinChange = coinChange + params[1]
			elseif effectCo.type == Activity174Enum.EffectType.DelayAddCoin then
				coinChange = coinChange + params[2]
			elseif effectCo.type == Activity174Enum.EffectType.BuyAddCoin then
				coinChange = coinChange + params[3]
			elseif effectCo.type == Activity174Enum.EffectType.ReduceHpAddCoin then
				coinChange = coinChange + params[1]
			elseif effectCo.type == Activity174Enum.EffectType.MaybeAddCoin then
				local param = tonumber(tbl.param)

				if param then
					coinChange = coinChange + param
				end
			end
		end
	end

	self.actInfo:cleanTriggerEffect()

	if hpChange ~= 0 then
		self:playHpAnim(hpChange)
	end

	if coinChange ~= 0 then
		self:playCoinAnim(coinChange)
	end
end

function Act174GameView:playHpAnim(count)
	local gameInfo = self.actInfo:getGameInfo()
	local endValue = self._imageHpPercent.fillAmount
	local startValue

	if count > 0 then
		startValue = (gameInfo.hp - count) / self.maxHp
	else
		startValue = (gameInfo.hp + count) / self.maxHp

		if (gameInfo.hp + count) / self.maxHp > 1 then
			return
		end
	end

	self._imageHpPercent.fillAmount = startValue

	if count > 0 then
		gohelper.setActive(self.goHpAdd, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_home_door_effect_move)
	else
		gohelper.setActive(self.goHpSubtract, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_home_door_effect_put)
	end

	ZProj.TweenHelper.DOFillAmount(self._imageHpPercent, endValue, 1, self.hpAnimEnd, self)
end

function Act174GameView:hpAnimEnd()
	gohelper.setActive(self.goHpAdd, false)
	gohelper.setActive(self.goHpSubtract, false)
end

function Act174GameView:playCoinAnim(count)
	local gameInfo = self.actInfo:getGameInfo()
	local endValue = gameInfo.coin

	if count > 0 then
		if not (gameInfo.coin - count) then
			local startValue = gameInfo.coin + count

			if count > 0 then
				gohelper.setActive(self.goCoinAdd, true)
				AudioMgr.instance:trigger(AudioEnum.Act174.play_artificial_buff_curses_up)
			else
				gohelper.setActive(self.goCoinSubtract, true)
				AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_down)
			end

			ZProj.TweenHelper.DOTweenFloat(startValue, endValue, 1, self.coinAnimFrame, self.coinAnimEnd, self)
		end
	end
end

function Act174GameView:coinAnimFrame(value, param)
	self._txtCoinCnt1.text = math.floor(value)
end

function Act174GameView:coinAnimEnd()
	gohelper.setActive(self.goCoinAdd, false)
	gohelper.setActive(self.goCoinSubtract, false)
end

return Act174GameView
