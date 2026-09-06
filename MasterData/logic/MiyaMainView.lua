-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaMainView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaMainView", package.seeall)

local MiyaMainView = class("MiyaMainView", TimeLimitedMainView)

function MiyaMainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "",
			path = "fx_ui_miyatiaozhan/fx_ui_miyatiaozhan.prefab"
		},
		{
			goPath = "btnStart",
			path = "fx_ui_miyatiaozhan/fx_ui_anniu_miyataiozhan.prefab"
		}
	}
end

function MiyaMainView:unbindEvents()
	MiyaMainView.super.unbindEvents(self)
	self._btnGift:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnPlayStory:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnShop)
end

function MiyaMainView:bindEvents()
	MiyaMainView.super.bindEvents(self)
	self._btnGift:AddClickListener(self._onClickGift, self)
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnPlayStory:AddClickListener(self._onClickPlayStory, self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function MiyaMainView:buildUI()
	MiyaMainView.super.buildUI(self)

	self._challengeId = MiyaGameModel.instance:getChallengeId()
	self._btnGift = self:getBtn("btnGift")
	self._btnReceive = self:getBtn("dailyPrize/btnReceive")
	self._imgIcon = self:getGo("dailyPrize/imgIcon")
	self._txtNum = self:getTxt("dailyPrize/txtNum")
	self._imgReceived = self:getGo("dailyPrize/imgReceived")
	self._btnPlayStory = self:getBtn("topleft/btnVideo")
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function MiyaMainView:onExit()
	MiyaMainView.super.onExit(self)
	MaterialMgr.clearIcon(self.head)
end

function MiyaMainView:onEnter()
	MiyaMainView.super.onEnter(self)
	TimedChallengeMiYaAgent.instance:sendPM_TimedChallengeMiYaInfoReq(self._onMiyaInfoRes, self)

	local matType, matId, matNum = unpack(string.splitToNumber(MiyaGameConfig.instance:getConstantValue("DAILY_PRIZE"), ":"))

	MaterialMgr.setIcon(self._imgIcon, matType, matId)

	self._txtNum.text = "x" .. matNum
end

function MiyaMainView:_onMiyaInfoRes(msg)
	TLChallengeModel.instance:setFightInfo(self._challengeId, msg)
	MiyaGameModel.instance:setCurDifficulty(msg.curDifficulty)
	MiyaGameModel.instance:setCurModeId(msg.curModeId)
	MiyaGameModel.instance:setDailyPrizeReceived(msg.dailyPrizeHasGain)
	MiyaGameModel.instance:setRivalId(msg.rivalId)
	MiyaGameModel.instance:setBuyProcess(msg.awakenGoodsBuyProcess)
	MiyaGameModel.instance:setWorldZdl(msg.worldZdl)

	self._info = TLChallengeModel.instance:getFightInfo(self._challengeId)

	self:_updateRankTip(self._info.hasGainPet, self._info.petRankSize)
	self:_updateLeftTimes()
	self:_updateDailyPrize()
	self:updateGoShop()
end

function MiyaMainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function MiyaMainView:onClickShop()
	local goodsId = MiyaGameConfig.instance:getConstantValue("GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function MiyaMainView:_updateLeftTimes()
	local hasCurModeId = checknumber(self._info.curDifficulty) > 0

	self._dailyTimes = MiyaGameConfig.instance:getConstantValue("DAILY_CHALLENGE_TIMES")
	self._vipDailyTimes = checknumber(MiyaGameConfig.instance:getConstantValue("VIP_DAILY_TIMES"))

	if VipModel.instance:getCurVipLv() < 1 then
		self._totalTimes = self._dailyTimes or self._vipDailyTimes
	end

	self._leftTimes = self._totalTimes - self._info.hasChallengeTimes
	self._txtLeftChallengeCount.text = string.format("今天剩余次数：<color=#FFFFFFFF>%d/%d</color>", self._leftTimes, self._totalTimes)
	self._txtStart.text = hasCurModeId and "继续\n对弈" or self._leftTimes == 0 and "明日\n再来" or "开始\n对弈"
	self._vipAddTimes = self._vipDailyTimes - self._dailyTimes
	self._txtVip.text = string.format("VIP1用户每天额外多<color=#4FEA91FF>%s</color>次", self._vipAddTimes)
end

function MiyaMainView:_updateRankTip(hasGainPet, petRankSize)
	self._tipExchange.gameObject:SetActive(not hasGainPet)

	local petRankThreshold = checknumber(MiyaGameConfig.instance:getConstantValue("PET_RANK_THRESHOLD"))
	local petRankPrize = MiyaGameConfig.instance:getConstantValue("PET_RANK_PRIZE")

	self._tipRank.gameObject:SetActive(petRankSize < petRankThreshold)

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(petRankPrize, self._pointRankItem)
	GameUtil.SetActive(self._btnGift, false)
end

function MiyaMainView:_updateDailyPrize()
	local isReceived = MiyaGameModel.instance:getDailyPrizeReceived()

	self._btnReceive.gameObject:SetActive(not isReceived)
	self._imgReceived:SetActive(isReceived)
end

function MiyaMainView:_onClickReceive()
	TimedChallengeMiYaAgent.instance:sendPM_TimedChallengeMiYaGainDailyPrizeReq(self._onGainPrizeRes, self)
end

function MiyaMainView:_onGainPrizeRes()
	MiyaGameModel.instance:setDailyPrizeReceived(true)
	self:_updateDailyPrize()
end

function MiyaMainView:_onClickGift()
	UIStateManager.instance:push(ViewName.MiyaGiftView)
end

function MiyaMainView:_onClickStart()
	if self._leftTimes == 0 and MiyaGameModel.instance:getCurDifficulty() == 0 then
		FloatWordMgr.instance:show("今天的对弈次数已经用光了，明天再来吧")
	else
		UIStateManager.instance:push(ViewName.MiyaDetailView)
	end
end

function MiyaMainView:_onClickPlayStory()
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, 5020001)
end

return MiyaMainView
